import 'package:drift/drift.dart';
import 'package:sr_language_tool/locator.dart';
import 'package:sr_language_tool/models/database.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';
import 'dart:io';

class DatabaseService {
  final AppDatabase dB = locator.get<AppDatabase>();
  static const _uuid = Uuid();
  static const _prefKeySeedUntouched = 'is_initial_seed_untouched';
  static const _prefKeyLastSyncedUserId = 'last_synced_user_id';

  // Deterministic namespace UUID for migrating existing legacy rows to sync IDs
  static const _namespaceMigration = '6ba7b810-9dad-11d1-80b4-00c04fd430c8';

  // @@@@@@@@@@@@@@@@@@@@@@@@@@ \\
  // @| INITIALISATION STUFF |@ \\
  // @@@@@@@@@@@@@@@@@@@@@@@@@@ \\

  Future<void> initialiseDB() async {
    final List<Card> cardlist = await getAllCards();
    if (cardlist.isEmpty) {
      await isEmptyFunctions();
    }

    // cardlist.isEmpty ? isEmptyFunctions() : print('database loaded');
  }

  Future<void> isEmptyFunctions() async {
    await createLangCat('Example Language');

    final List<String> defaultWordCats = [
      'Adj.',
      'Adverb',
      'Conjunc.',
      'Determiner',
      'Noun',
      'Phrase',
      'Prep.',
      'Pronoun',
      'Verb',
    ];

    for (String word in defaultWordCats) {
      await createCategory(word);
    }

    await createCard(
      language: 'Example Language',
      category: 'Phrase',
      frontContent: 'Example Card',
      revealContent: 'Example Reveal Content',
      lastReview: DateTime.now(),
      nextReviewDue: DateTime.now().add(const Duration(minutes: 15)),
    );

    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_prefKeySeedUntouched, true);
  }

  Future<void> markUserModified() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_prefKeySeedUntouched, false);
  }

  // @@@@@@@@@@@@@@@@@@@@@@@@ \\
  // @| CARD-RELATED STUFF |@ \\
  // @@@@@@@@@@@@@@@@@@@@@@@@ \\

  Future<List<Card>> getAllCards() async {
    return await dB.select(dB.cards).get();
  }

  Future<List<Card>> getCardsOfLang(String language) async {
    final int langID = await getLangID(language);

    return await (dB.select(dB.cards)..where((c) => c.language.equals(langID)))
        .get();
  }

  Future<List<Card>> getDueCards() async {
    final dateNow = DateTime.now();

    return await (dB.select(dB.cards)
          ..where(
            (c) => (c.nextReviewDue.equals(dateNow) |
                c.nextReviewDue.isSmallerThanValue(dateNow)),
          ))
        .get();
  }

  Future<List<Card>> getDueCardsOfLang(String language) async {
    final int langID = await getLangID(language);
    final dateNow = DateTime.now();

    return await (dB.select(dB.cards)
          ..where(
            (c) => (c.language.equals(langID) &
                (c.nextReviewDue.equals(dateNow) |
                    c.nextReviewDue.isSmallerThanValue(dateNow))),
          ))
        .get();
  }

  Future<bool> checkCardMatch(String frontContent, String language) async {
    final int langID = await getLangID(language);

    final Card? cardMatch = await (dB.select(dB.cards)
          ..where(
            (tbl) =>
                tbl.frontContent.equals(frontContent) &
                tbl.language.equals(langID),
          ))
        .getSingleOrNull();
    return cardMatch != null;
  }

  Future<void> createCard({
    required String language,
    required String category,
    required String frontContent,
    required String revealContent,
    required DateTime lastReview,
    required DateTime nextReviewDue,
    String? gender,
    String? pluralForm,
    String? pronunciation,
    String? exampleUsage,
  }) async {
    await markUserModified();
    final int langID = await getLangID(language);
    final int catID = await getCatID(category);
    await dB.into(dB.cards).insert(
          CardsCompanion.insert(
            language: langID,
            category: catID,
            frontContent: frontContent,
            revealContent: revealContent,
            gender: Value(gender),
            pluralForm: Value(pluralForm),
            pronunciation: Value(pronunciation),
            exampleUsage: Value(exampleUsage),
            lastReview: lastReview,
            nextReviewDue: nextReviewDue,
            syncId: Value(_uuid.v4()),
            lastModified: Value(DateTime.now()),
          ),
        );
  }

  Future<int> deleteCard(int id) async {
    await markUserModified();
    final card = await (dB.select(dB.cards)..where((c) => c.id.equals(id)))
        .getSingleOrNull();
    if (card != null && card.syncId != null) {
      await recordDeleted('cards', card.syncId!);
    }
    return (dB.delete(dB.cards)..where((card) => card.id.equals(id))).go();
  }

  Future<void> updateCard({
    required int id,
    required String language,
    required String category,
    required String frontContent,
    required String revealContent,
    required DateTime lastReview,
    required DateTime nextReviewDue,
    String? gender,
    String? pluralForm,
    String? pronunciation,
    String? exampleUsage,
  }) async {
    await markUserModified();
    final int langID = await getLangID(language);
    final int catID = await getCatID(category);

    await (dB.update(dB.cards)..where((tbl) => tbl.id.equals(id))).write(
      CardsCompanion(
        language: Value(langID),
        category: Value(catID),
        frontContent: Value(frontContent),
        revealContent: Value(revealContent),
        gender: Value(gender),
        pluralForm: Value(pluralForm),
        pronunciation: Value(pronunciation),
        exampleUsage: Value(exampleUsage),
        lastReview: Value(lastReview),
        nextReviewDue: Value(nextReviewDue),
        lastModified: Value(DateTime.now()),
      ),
    );
  }

  Future<void> updateLastReview(int cardID, DateTime newDate) async {
    await markUserModified();
    await (dB.update(dB.cards)..where((tbl) => tbl.id.equals(cardID))).write(
      CardsCompanion(
        lastReview: Value(newDate),
        lastModified: Value(DateTime.now()),
      ),
    );
  }

  Future<void> updateNextReviewDue(int cardID, DateTime newDate) async {
    await markUserModified();
    await (dB.update(dB.cards)..where((tbl) => tbl.id.equals(cardID))).write(
      CardsCompanion(
        nextReviewDue: Value(newDate),
        lastModified: Value(DateTime.now()),
      ),
    );
  }

  // @@@@@@@@@@@@@@@@@@@@@@@@@ \\
  // @| LANGUAGE CAT. STUFF |@ \\
  // @@@@@@@@@@@@@@@@@@@@@@@@@ \\

  Future<List<Language>> getAllLanguages() async {
    return await dB.select(dB.languages).get();
  }

  // gets the id/primary key for given String in languages table
  Future<int> getLangID(String language) async {
    final query = dB.select(dB.languages)
      ..where((tbl) => tbl.language.equals(language));
    final lang = await query.getSingleOrNull();

    return lang?.id ?? 1;
  }

  Future<String> getLangByID(int langID) async {
    final language = await (dB.select(dB.languages)
          ..where((tbl) => tbl.id.equals(langID)))
        .getSingleOrNull();

    return language?.language ?? 'Example Language';
  }

  Future<void> createLangCat(String language) async {
    await markUserModified();
    await dB.into(dB.languages).insert(
          LanguagesCompanion.insert(
            language: language,
            syncId: Value(_uuid.v4()),
            lastModified: Value(DateTime.now()),
          ),
        );
  }

  Future<void> updateLangName(int id, String newName) async {
    await markUserModified();
    await (dB.update(dB.languages)..where((l) => l.id.equals(id))).write(
      LanguagesCompanion(
        language: Value(newName),
        lastModified: Value(DateTime.now()),
      ),
    );
  }

  Future<int> deleteLang(int id) async {
    await markUserModified();
    final lang = await (dB.select(dB.languages)..where((l) => l.id.equals(id)))
        .getSingleOrNull();
    if (lang != null && lang.syncId != null) {
      // Record tombstones and delete associated cards and genders locally
      final cards = await (dB.select(dB.cards)
            ..where((c) => c.language.equals(id)))
          .get();
      for (final card in cards) {
        if (card.syncId != null) await recordDeleted('cards', card.syncId!);
      }
      await (dB.delete(dB.cards)..where((c) => c.language.equals(id))).go();

      final genders = await (dB.select(dB.genders)
            ..where((g) => g.language.equals(id)))
          .get();
      for (final gender in genders) {
        if (gender.syncId != null) {
          await recordDeleted('genders', gender.syncId!);
        }
      }
      await (dB.delete(dB.genders)..where((g) => g.language.equals(id))).go();

      await recordDeleted('languages', lang.syncId!);
    }
    return (dB.delete(dB.languages)
          ..where((language) => language.id.equals(id)))
        .go();
  }

  // @@@@@@@@@@@@@@@@@@@@@@@@@ \\
  // @| WORD CATEGORY STUFF |@ \\
  // @@@@@@@@@@@@@@@@@@@@@@@@@ \\

  Future<List<Category>> getAllCategories() async {
    return await dB.select(dB.categories).get();
  }

  Future<String?> getCatByID(int catID) async {
    final categoryRow = await (dB.select(dB.categories)
          ..where((tbl) => tbl.id.equals(catID)))
        .getSingleOrNull();

    return categoryRow?.category;
  }

  // gets the id/primary key for given String in categories table
  Future<int> getCatID(String category) async {
    final query = dB.select(dB.categories)
      ..where((tbl) => tbl.category.equals(category));
    final cat = await query.getSingleOrNull();

    return cat?.id ?? 1;
  }

  Future<void> createCategory(String category) async {
    await markUserModified();
    await dB.into(dB.categories).insert(
          CategoriesCompanion.insert(
            category: category,
            syncId: Value(_uuid.v4()),
            lastModified: Value(DateTime.now()),
          ),
        );
  }

  Future<int> deleteCategory(int id) async {
    await markUserModified();
    final cat = await (dB.select(dB.categories)..where((c) => c.id.equals(id)))
        .getSingleOrNull();
    if (cat != null && cat.syncId != null) {
      // Record tombstones and delete dependent cards locally
      final cards = await (dB.select(dB.cards)
            ..where((c) => c.category.equals(id)))
          .get();
      for (final card in cards) {
        if (card.syncId != null) await recordDeleted('cards', card.syncId!);
      }
      await (dB.delete(dB.cards)..where((c) => c.category.equals(id))).go();

      await recordDeleted('categories', cat.syncId!);
    }
    return (dB.delete(dB.categories)
          ..where((category) => category.id.equals(id)))
        .go();
  }

  // @@@@@@@@@@@@@@@@@@@@@@@@@ \\
  // @|     GENDER STUFF     |@ \\
  // @@@@@@@@@@@@@@@@@@@@@@@@@ \\

  Future<void> replaceGendersForLang(int langId, List<String> genders) async {
    await markUserModified();
    final existingGenders = await (dB.select(dB.genders)
          ..where((g) => g.language.equals(langId)))
        .get();
    for (final oldG in existingGenders) {
      if (oldG.syncId != null) {
        await recordDeleted('genders', oldG.syncId!);
      }
    }
    await (dB.delete(dB.genders)..where((g) => g.language.equals(langId))).go();
    for (final gender in genders) {
      await dB.into(dB.genders).insert(
            GendersCompanion.insert(
              language: langId,
              gender: gender,
              syncId: Value(_uuid.v4()),
              lastModified: Value(DateTime.now()),
            ),
          );
    }
  }

  Future<List<Gender>> getGendersOfLang(String language) async {
    final int langID = await getLangID(language);
    return await (dB.select(dB.genders)
          ..where((g) => g.language.equals(langID)))
        .get();
  }

  Future<void> createGender(String language, String gender) async {
    await markUserModified();
    final int langID = await getLangID(language);
    await dB.into(dB.genders).insert(
          GendersCompanion.insert(
            language: langID,
            gender: gender,
            syncId: Value(_uuid.v4()),
            lastModified: Value(DateTime.now()),
          ),
        );
  }

  Future<int> deleteGender(int id) async {
    await markUserModified();
    final g = await (dB.select(dB.genders)..where((row) => row.id.equals(id)))
        .getSingleOrNull();
    if (g != null && g.syncId != null) {
      await recordDeleted('genders', g.syncId!);
    }
    return (dB.delete(dB.genders)..where((g) => g.id.equals(id))).go();
  }

  Future<List<Gender>> getAllGenders() async {
    return await dB.select(dB.genders).get();
  }

  Future<void> recordDeleted(String tableName, String syncId) async {
    await dB.into(dB.deletedRecords).insert(
          DeletedRecordsCompanion.insert(
            recordTable: tableName,
            syncId: syncId,
            deletedAt: DateTime.now(),
          ),
        );
  }

  Future<List<DeletedRecord>> getAllDeletedRecords() async {
    return await dB.select(dB.deletedRecords).get();
  }

  Future<void> removeDeletedRecordBySyncId(String syncId) async {
    await (dB.delete(dB.deletedRecords)..where((t) => t.syncId.equals(syncId)))
        .go();
  }

  Future<void> ensureSyncIds([String? userId]) async {
    final now = DateTime.now();
    final userPrefix = userId != null ? '$userId:' : '';
    for (final l in await getAllLanguages()) {
      if (l.syncId == null || l.lastModified == null) {
        final deterministicSyncId = l.syncId ??
            _uuid.v5(_namespaceMigration,
                '${userPrefix}language:${l.id}:${l.language.trim().toLowerCase()}');
        await (dB.update(dB.languages)..where((t) => t.id.equals(l.id))).write(
          LanguagesCompanion(
            syncId: Value(deterministicSyncId),
            lastModified: Value(l.lastModified ?? now),
          ),
        );
      }
    }
    for (final c in await getAllCategories()) {
      if (c.syncId == null || c.lastModified == null) {
        final deterministicSyncId = c.syncId ??
            _uuid.v5(_namespaceMigration,
                '${userPrefix}category:${c.id}:${c.category.trim().toLowerCase()}');
        await (dB.update(dB.categories)..where((t) => t.id.equals(c.id))).write(
          CategoriesCompanion(
            syncId: Value(deterministicSyncId),
            lastModified: Value(c.lastModified ?? now),
          ),
        );
      }
    }
    for (final g in await getAllGenders()) {
      if (g.syncId == null || g.lastModified == null) {
        final lang = await (dB.select(dB.languages)
              ..where((l) => l.id.equals(g.language)))
            .getSingleOrNull();
        final langKey = lang?.syncId ??
            lang?.language.trim().toLowerCase() ??
            g.language.toString();
        final deterministicSyncId = g.syncId ??
            _uuid.v5(_namespaceMigration,
                '${userPrefix}gender:${g.id}:$langKey:${g.gender.trim().toLowerCase()}');
        await (dB.update(dB.genders)..where((t) => t.id.equals(g.id))).write(
          GendersCompanion(
            syncId: Value(deterministicSyncId),
            lastModified: Value(g.lastModified ?? now),
          ),
        );
      }
    }
    for (final card in await getAllCards()) {
      if (card.syncId == null || card.lastModified == null) {
        final deterministicSyncId = card.syncId ??
            _uuid.v5(_namespaceMigration,
                '${userPrefix}card:${card.id}:${card.language}:${card.category}:${card.frontContent.trim()}:${card.revealContent.trim()}');
        await (dB.update(dB.cards)..where((t) => t.id.equals(card.id))).write(
          CardsCompanion(
            syncId: Value(deterministicSyncId),
            lastModified: Value(card.lastModified ?? now),
          ),
        );
      }
    }
  }

  Future<bool> isDefaultSeededOnly() async {
    final prefs = await SharedPreferences.getInstance();
    final isUntouched = prefs.getBool(_prefKeySeedUntouched);
    // Explicitly check boolean flag: only disposable if confirmed untouched initial seed.
    // Avoid heuristics that could delete legitimate user-created records.
    return isUntouched == true;
  }

  Future<void> seedDefaultCategoriesOnly() async {
    final List<String> defaultWordCats = [
      'Adj.',
      'Adverb',
      'Conjunc.',
      'Determiner',
      'Noun',
      'Phrase',
      'Prep.',
      'Pronoun',
      'Verb',
    ];

    for (String word in defaultWordCats) {
      await createCategory(word);
    }
  }

  Future<void> handleAccountSwitch(String currentUserId) async {
    final prefs = await SharedPreferences.getInstance();
    final lastUserId = prefs.getString(_prefKeyLastSyncedUserId);
    if (lastUserId != null && lastUserId != currentUserId) {
      // Switched to a different user account - clear data belonging to previous account
      await clearLocalRecords();
      await prefs.setBool(_prefKeySeedUntouched, false);
    }
    await prefs.setString(_prefKeyLastSyncedUserId, currentUserId);
  }

  Future<void> clearLocalRecords() async {
    await dB.delete(dB.cards).go();
    await dB.delete(dB.genders).go();
    await dB.delete(dB.categories).go();
    await dB.delete(dB.languages).go();
    await dB.delete(dB.deletedRecords).go();
  }

  // @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ \\
  // @| CAUTION: DELETES DATABASE FILE |@ \\
  // @|  USE ONLY WHEN IT'S NECESSARY  |@ \\
  // @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ \\
  Future<void> clearData() async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final dbPath =
          '${directory.path}/app_database.sqlite'; // Replace with your actual database name if different
      final dbFile = File(dbPath);

      if (await dbFile.exists()) {
        await dbFile.delete();
        // print('Database file deleted');
      } else {
        throw Exception('Database file not found');
      }
    } catch (e) {
      throw Exception('Error deleting database: $e');
    }
  }
}
