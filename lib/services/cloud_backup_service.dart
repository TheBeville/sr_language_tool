import 'package:drift/drift.dart';
import 'package:sr_language_tool/locator.dart';
import 'package:sr_language_tool/models/database.dart' as db;
import 'package:sr_language_tool/services/database_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CloudBackupService {
  final supabase = Supabase.instance.client;
  final DatabaseService _dbService = locator.get<DatabaseService>();

  Future<AuthResponse> logInWithEmail({
    required String email,
    required String password,
  }) async {
    return await supabase.auth.signInWithPassword(
      email: email,
      password: password,
    );
  }

  Future<AuthResponse?> signUpWithEmail({
    required String email,
    required String password,
    required String username,
  }) async {
    final DateTime yesterday = DateTime.now().subtract(const Duration(days: 1));
    try {
      final response = await supabase.auth.signUp(
        email: email,
        password: password,
        data: {
          'username': username,
          'last_updated': yesterday.toIso8601String().split('T')[0],
        },
      );
      return response;
    } catch (e) {
      throw Exception('Error signing up: $e');
    }
  }

  /// Two-way sync with Supabase for the currently signed-in user.
  /// Uses sync_id for identity and last_modified for last-write-wins resolution.
  Future<void> syncData() async {
    final user = supabase.auth.currentUser;
    if (user == null) throw Exception('User not authenticated');

    final userId = user.id;
    final appDb = _dbService.dB;

    // Handle account switching so data from another user is not leaked/overwritten
    await _dbService.handleAccountSwitch(userId);

    // Check if remote has data and local only has initial placeholder seed data
    final remoteLangsCheck = await supabase
        .from('languages')
        .select('sync_id')
        .eq('user_id', userId)
        .limit(1);
    final hasRemoteData = (remoteLangsCheck as List).isNotEmpty;
    if (hasRemoteData && await _dbService.isDefaultSeededOnly()) {
      await _dbService.clearLocalRecords();
      await _dbService.markUserModified();
    }

    // Ensure all local rows have a valid syncId and lastModified, scoped by userId
    await _dbService.ensureSyncIds(userId);

    // ------------------------------------------------------------- //
    // 0. SYNCHRONIZE TOMBSTONES / DELETIONS
    // ------------------------------------------------------------- //
    // 0a. Upload local deletions to Supabase deleted_records
    final localDeletions = await _dbService.getAllDeletedRecords();
    if (localDeletions.isNotEmpty) {
      final deletionPayloads = [
        for (final d in localDeletions)
          {
            'sync_id': d.syncId,
            'user_id': userId,
            'table_name': d.recordTable,
            'deleted_at': d.deletedAt.toIso8601String(),
          }
      ];
      await supabase.from('deleted_records').upsert(
            deletionPayloads,
            onConflict: 'sync_id',
          );

      for (final d in localDeletions) {
        if (d.recordTable == 'cards') {
          await supabase
              .from('cards')
              .delete()
              .eq('sync_id', d.syncId)
              .eq('user_id', userId);
        } else if (d.recordTable == 'genders') {
          await supabase
              .from('genders')
              .delete()
              .eq('sync_id', d.syncId)
              .eq('user_id', userId);
        } else if (d.recordTable == 'categories') {
          await supabase
              .from('categories')
              .delete()
              .eq('sync_id', d.syncId)
              .eq('user_id', userId);
        } else if (d.recordTable == 'languages') {
          await supabase
              .from('languages')
              .delete()
              .eq('sync_id', d.syncId)
              .eq('user_id', userId);
        }
      }
    }

    // 0b. Download remote deletions and purge local records
    final remoteDeletionsRaw =
        await supabase.from('deleted_records').select().eq('user_id', userId);
    final remoteDeletions =
        List<Map<String, dynamic>>.from(remoteDeletionsRaw as List);
    for (final remoteDel in remoteDeletions) {
      final syncId = remoteDel['sync_id'] as String;
      final tableName = remoteDel['table_name'] as String;
      if (tableName == 'cards') {
        await (appDb.delete(appDb.cards)..where((t) => t.syncId.equals(syncId)))
            .go();
      } else if (tableName == 'genders') {
        await (appDb.delete(appDb.genders)
              ..where((t) => t.syncId.equals(syncId)))
            .go();
      } else if (tableName == 'categories') {
        await (appDb.delete(appDb.categories)
              ..where((t) => t.syncId.equals(syncId)))
            .go();
      } else if (tableName == 'languages') {
        await (appDb.delete(appDb.languages)
              ..where((t) => t.syncId.equals(syncId)))
            .go();
      }
    }

    // ------------------------------------------------------------- //
    // 1. LANGUAGES SYNC
    // ------------------------------------------------------------- //
    final remoteLangsRaw =
        await supabase.from('languages').select().eq('user_id', userId);
    final remoteLangs = List<Map<String, dynamic>>.from(remoteLangsRaw as List);
    final localLangs = await _dbService.getAllLanguages();

    final localLangBySyncId = {
      for (final l in localLangs)
        if (l.syncId != null) l.syncId!: l,
    };
    final remoteLangBySyncId = {
      for (final r in remoteLangs) r['sync_id'] as String: r,
    };

    // Upload new or updated local languages (server-side last-write-wins guard)
    final newLangsToInsert = <Map<String, dynamic>>[];
    for (final local in localLangs) {
      final remote = remoteLangBySyncId[local.syncId];
      if (remote == null) {
        newLangsToInsert.add({
          'sync_id': local.syncId,
          'id': local.id,
          'user_id': userId,
          'language': local.language,
          'last_modified': local.lastModified!.toIso8601String(),
        });
      } else {
        final remoteMod = DateTime.parse(remote['last_modified'] as String);
        if (local.lastModified!.isAfter(remoteMod)) {
          // Use server-side lt guard to prevent overwriting if another client updated in the interim
          await supabase
              .from('languages')
              .update({
                'language': local.language,
                'last_modified': local.lastModified!.toIso8601String(),
              })
              .eq('sync_id', local.syncId!)
              .eq('user_id', userId)
              .lt('last_modified', local.lastModified!.toIso8601String());
        }
      }
    }
    if (newLangsToInsert.isNotEmpty) {
      await supabase.from('languages').upsert(
            newLangsToInsert,
            onConflict: 'sync_id',
          );
    }

    // Download new/updated remote languages to local DB
    for (final remote in remoteLangs) {
      final syncId = remote['sync_id'] as String;
      final local = localLangBySyncId[syncId];
      final remoteMod = DateTime.parse(remote['last_modified'] as String);

      if (local == null) {
        await appDb.into(appDb.languages).insert(
              db.LanguagesCompanion.insert(
                language: remote['language'] as String,
                syncId: Value(syncId),
                lastModified: Value(remoteMod),
              ),
            );
      } else if (remoteMod.isAfter(local.lastModified!)) {
        await (appDb.update(appDb.languages)
              ..where((t) => t.syncId.equals(syncId)))
            .write(
          db.LanguagesCompanion(
            language: Value(remote['language'] as String),
            lastModified: Value(remoteMod),
          ),
        );
      }
    }

    // Refresh local cache for FK lookups
    final freshLocalLangs = await _dbService.getAllLanguages();
    final langIdBySyncId = {
      for (final l in freshLocalLangs)
        if (l.syncId != null) l.syncId!: l.id,
    };
    final langSyncIdById = {
      for (final l in freshLocalLangs)
        if (l.syncId != null) l.id: l.syncId!,
    };

    // ------------------------------------------------------------- //
    // 2. CATEGORIES SYNC
    // ------------------------------------------------------------- //
    final remoteCatsRaw =
        await supabase.from('categories').select().eq('user_id', userId);
    final remoteCats = List<Map<String, dynamic>>.from(remoteCatsRaw as List);
    final localCats = await _dbService.getAllCategories();

    final localCatBySyncId = {
      for (final c in localCats)
        if (c.syncId != null) c.syncId!: c,
    };
    final remoteCatBySyncId = {
      for (final r in remoteCats) r['sync_id'] as String: r,
    };

    final newCatsToInsert = <Map<String, dynamic>>[];
    for (final local in localCats) {
      final remote = remoteCatBySyncId[local.syncId];
      if (remote == null) {
        newCatsToInsert.add({
          'sync_id': local.syncId,
          'id': local.id,
          'user_id': userId,
          'category': local.category,
          'last_modified': local.lastModified!.toIso8601String(),
        });
      } else {
        final remoteMod = DateTime.parse(remote['last_modified'] as String);
        if (local.lastModified!.isAfter(remoteMod)) {
          await supabase
              .from('categories')
              .update({
                'category': local.category,
                'last_modified': local.lastModified!.toIso8601String(),
              })
              .eq('sync_id', local.syncId!)
              .eq('user_id', userId)
              .lt('last_modified', local.lastModified!.toIso8601String());
        }
      }
    }
    if (newCatsToInsert.isNotEmpty) {
      await supabase.from('categories').upsert(
            newCatsToInsert,
            onConflict: 'sync_id',
          );
    }

    for (final remote in remoteCats) {
      final syncId = remote['sync_id'] as String;
      final local = localCatBySyncId[syncId];
      final remoteMod = DateTime.parse(remote['last_modified'] as String);

      if (local == null) {
        await appDb.into(appDb.categories).insert(
              db.CategoriesCompanion.insert(
                category: remote['category'] as String,
                syncId: Value(syncId),
                lastModified: Value(remoteMod),
              ),
            );
      } else if (remoteMod.isAfter(local.lastModified!)) {
        await (appDb.update(appDb.categories)
              ..where((t) => t.syncId.equals(syncId)))
            .write(
          db.CategoriesCompanion(
            category: Value(remote['category'] as String),
            lastModified: Value(remoteMod),
          ),
        );
      }
    }

    final freshLocalCats = await _dbService.getAllCategories();
    final catIdBySyncId = {
      for (final c in freshLocalCats)
        if (c.syncId != null) c.syncId!: c.id,
    };
    final catSyncIdById = {
      for (final c in freshLocalCats)
        if (c.syncId != null) c.id: c.syncId!,
    };

    // ------------------------------------------------------------- //
    // 3. GENDERS SYNC
    // ------------------------------------------------------------- //
    final remoteGendersRaw =
        await supabase.from('genders').select().eq('user_id', userId);
    final remoteGenders =
        List<Map<String, dynamic>>.from(remoteGendersRaw as List);
    final localGenders = await _dbService.getAllGenders();

    final localGenderBySyncId = {
      for (final g in localGenders)
        if (g.syncId != null) g.syncId!: g,
    };
    final remoteGenderBySyncId = {
      for (final r in remoteGenders) r['sync_id'] as String: r,
    };

    final newGendersToInsert = <Map<String, dynamic>>[];
    for (final local in localGenders) {
      final remote = remoteGenderBySyncId[local.syncId];
      final langSyncId = langSyncIdById[local.language];
      if (langSyncId == null) continue;

      if (remote == null) {
        newGendersToInsert.add({
          'sync_id': local.syncId,
          'id': local.id,
          'user_id': userId,
          'language_sync_id': langSyncId,
          'gender': local.gender,
          'last_modified': local.lastModified!.toIso8601String(),
        });
      } else {
        final remoteMod = DateTime.parse(remote['last_modified'] as String);
        if (local.lastModified!.isAfter(remoteMod)) {
          await supabase
              .from('genders')
              .update({
                'gender': local.gender,
                'language_sync_id': langSyncId,
                'last_modified': local.lastModified!.toIso8601String(),
              })
              .eq('sync_id', local.syncId!)
              .eq('user_id', userId)
              .lt('last_modified', local.lastModified!.toIso8601String());
        }
      }
    }
    if (newGendersToInsert.isNotEmpty) {
      await supabase.from('genders').upsert(
            newGendersToInsert,
            onConflict: 'sync_id',
          );
    }

    for (final remote in remoteGenders) {
      final syncId = remote['sync_id'] as String;
      final local = localGenderBySyncId[syncId];
      final remoteMod = DateTime.parse(remote['last_modified'] as String);
      final localLangId = langIdBySyncId[remote['language_sync_id'] as String];
      if (localLangId == null) continue;

      if (local == null) {
        await appDb.into(appDb.genders).insert(
              db.GendersCompanion.insert(
                language: localLangId,
                gender: remote['gender'] as String,
                syncId: Value(syncId),
                lastModified: Value(remoteMod),
              ),
            );
      } else if (remoteMod.isAfter(local.lastModified!)) {
        await (appDb.update(appDb.genders)
              ..where((t) => t.syncId.equals(syncId)))
            .write(
          db.GendersCompanion(
            gender: Value(remote['gender'] as String),
            language: Value(localLangId),
            lastModified: Value(remoteMod),
          ),
        );
      }
    }

    // ------------------------------------------------------------- //
    // 4. CARDS SYNC
    // ------------------------------------------------------------- //
    final remoteCardsRaw =
        await supabase.from('cards').select().eq('user_id', userId);
    final remoteCards = List<Map<String, dynamic>>.from(remoteCardsRaw as List);
    final localCards = await _dbService.getAllCards();

    final localCardBySyncId = {
      for (final c in localCards)
        if (c.syncId != null) c.syncId!: c,
    };
    final remoteCardBySyncId = {
      for (final r in remoteCards) r['sync_id'] as String: r,
    };

    final newCardsToInsert = <Map<String, dynamic>>[];
    for (final local in localCards) {
      final remote = remoteCardBySyncId[local.syncId];
      final langSyncId = langSyncIdById[local.language];
      final catSyncId = catSyncIdById[local.category];
      if (langSyncId == null || catSyncId == null) continue;

      if (remote == null) {
        newCardsToInsert.add({
          'sync_id': local.syncId,
          'id': local.id,
          'user_id': userId,
          'language_sync_id': langSyncId,
          'category_sync_id': catSyncId,
          'front_content': local.frontContent,
          'reveal_content': local.revealContent,
          'pronunciation': local.pronunciation,
          'example_usage': local.exampleUsage,
          'plural_form': local.pluralForm,
          'gender': local.gender,
          'last_review': local.lastReview.toIso8601String(),
          'next_review_due': local.nextReviewDue.toIso8601String(),
          'last_modified': local.lastModified!.toIso8601String(),
        });
      } else {
        final remoteMod = DateTime.parse(remote['last_modified'] as String);
        if (local.lastModified!.isAfter(remoteMod)) {
          await supabase
              .from('cards')
              .update({
                'language_sync_id': langSyncId,
                'category_sync_id': catSyncId,
                'front_content': local.frontContent,
                'reveal_content': local.revealContent,
                'pronunciation': local.pronunciation,
                'example_usage': local.exampleUsage,
                'plural_form': local.pluralForm,
                'gender': local.gender,
                'last_review': local.lastReview.toIso8601String(),
                'next_review_due': local.nextReviewDue.toIso8601String(),
                'last_modified': local.lastModified!.toIso8601String(),
              })
              .eq('sync_id', local.syncId!)
              .eq('user_id', userId)
              .lt('last_modified', local.lastModified!.toIso8601String());
        }
      }
    }
    if (newCardsToInsert.isNotEmpty) {
      await supabase.from('cards').upsert(
            newCardsToInsert,
            onConflict: 'sync_id',
          );
    }

    for (final remote in remoteCards) {
      final syncId = remote['sync_id'] as String;
      final local = localCardBySyncId[syncId];
      final remoteMod = DateTime.parse(remote['last_modified'] as String);
      final localLangId = langIdBySyncId[remote['language_sync_id'] as String];
      final localCatId = catIdBySyncId[remote['category_sync_id'] as String];
      if (localLangId == null || localCatId == null) continue;

      if (local == null) {
        await appDb.into(appDb.cards).insert(
              db.CardsCompanion.insert(
                language: localLangId,
                category: localCatId,
                frontContent: remote['front_content'] as String,
                revealContent: remote['reveal_content'] as String,
                pronunciation: Value(remote['pronunciation'] as String?),
                exampleUsage: Value(remote['example_usage'] as String?),
                pluralForm: Value(remote['plural_form'] as String?),
                gender: Value(remote['gender'] as String?),
                lastReview: DateTime.parse(remote['last_review'] as String),
                nextReviewDue:
                    DateTime.parse(remote['next_review_due'] as String),
                syncId: Value(syncId),
                lastModified: Value(remoteMod),
              ),
            );
      } else if (remoteMod.isAfter(local.lastModified!)) {
        await (appDb.update(appDb.cards)..where((t) => t.syncId.equals(syncId)))
            .write(
          db.CardsCompanion(
            language: Value(localLangId),
            category: Value(localCatId),
            frontContent: Value(remote['front_content'] as String),
            revealContent: Value(remote['reveal_content'] as String),
            pronunciation: Value(remote['pronunciation'] as String?),
            exampleUsage: Value(remote['example_usage'] as String?),
            pluralForm: Value(remote['plural_form'] as String?),
            gender: Value(remote['gender'] as String?),
            lastReview: Value(DateTime.parse(remote['last_review'] as String)),
            nextReviewDue:
                Value(DateTime.parse(remote['next_review_due'] as String)),
            lastModified: Value(remoteMod),
          ),
        );
      }
    }
  }
}
