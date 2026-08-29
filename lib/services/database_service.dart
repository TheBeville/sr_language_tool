import 'package:drift/drift.dart';
import 'package:sr_language_tool/locator.dart';
import 'package:sr_language_tool/models/database.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';
import 'dart:io';

class DatabaseService {
  final AppDatabase dB = locator.get<AppDatabase>();
  static const _uuid = Uuid();

  // @@@@@@@@@@@@@@@@@@@@@@@@@@ \\
  // @| INITIALISATION STUFF |@ \\
  // @@@@@@@@@@@@@@@@@@@@@@@@@@ \\

  void initialiseDB() async {
    final List<Card> cardlist = await getAllCards();
    if (cardlist.isEmpty) {
      isEmptyFunctions();
    }

    // cardlist.isEmpty ? isEmptyFunctions() : print('database loaded');
  }

  void isEmptyFunctions() {
    createLangCat('Example Language');

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
      createCategory(word);
    }

    createCard(
      language: 'Example Language',
      category: 'Phrase',
      frontContent: 'Example Card',
      revealContent: 'Example Reveal Content',
      lastReview: DateTime.now(),
      nextReviewDue: DateTime.now().add(const Duration(minutes: 15)),
    );
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

  Future<int> deleteCard(int id) {
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
    await (dB.update(dB.cards)..where((tbl) => tbl.id.equals(cardID))).write(
      CardsCompanion(
        lastReview: Value(newDate),
        lastModified: Value(DateTime.now()),
      ),
    );
  }

  Future<void> updateNextReviewDue(int cardID, DateTime newDate) async {
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
    await dB.into(dB.languages).insert(
          LanguagesCompanion.insert(
            language: language,
            syncId: Value(_uuid.v4()),
            lastModified: Value(DateTime.now()),
          ),
        );
  }

  Future<void> updateLangName(int id, String newName) async {
    await (dB.update(dB.languages)..where((l) => l.id.equals(id))).write(
      LanguagesCompanion(
        language: Value(newName),
        lastModified: Value(DateTime.now()),
      ),
    );
  }

  Future<int> deleteLang(int id) {
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
    await dB.into(dB.categories).insert(
          CategoriesCompanion.insert(
            category: category,
            syncId: Value(_uuid.v4()),
            lastModified: Value(DateTime.now()),
          ),
        );
  }

  Future<int> deleteCategory(int id) {
    return (dB.delete(dB.categories)
          ..where((category) => category.id.equals(id)))
        .go();
  }

  // @@@@@@@@@@@@@@@@@@@@@@@@@ \\
  // @|     GENDER STUFF     |@ \\
  // @@@@@@@@@@@@@@@@@@@@@@@@@ \\

  Future<void> replaceGendersForLang(int langId, List<String> genders) async {
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

  Future<int> deleteGender(int id) {
    return (dB.delete(dB.genders)..where((g) => g.id.equals(id))).go();
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
