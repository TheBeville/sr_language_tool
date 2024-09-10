import 'package:sr_language_tool/locator.dart';
import 'package:sr_language_tool/models/database.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class DatabaseService {
  final database = locator.get<AppDatabase>();

  // @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ \\
  // @ CAUTION: DELETES DATABASE FILE @ \\
  // @  USE ONLY WHEN IT'S NECESSARY  @ \\
  // @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ \\
  Future<void> clearData() async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final dbPath =
          '${directory.path}/app_database.sqlite'; // Replace with your actual database name if different
      final dbFile = File(dbPath);

      if (await dbFile.exists()) {
        await dbFile.delete();
        print('Database file deleted');
      } else {
        print('Database file not found');
      }
    } catch (e) {
      print('Error deleting database: $e');
    }
  }

  // @@@@@@@@@@@@@@@@@@@@@@@@ \\
  // @ INITIALISATION STUFF @ \\
  // @@@@@@@@@@@@@@@@@@@@@@@@ \\

  void initialiseDB() async {
    final List<Card> cardlist = await getAllCards();
    final List<Language> langList = await getAllLanguages();
    final List<Category> catList = await getAllCategories();

    cardlist.isEmpty ? isEmptyFunctions() : print('database loaded');

    print(cardlist);
    print(langList);
    print(catList);
  }

  void isEmptyFunctions() {
    createLangCat('German');

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
      'German',
      'Phrase',
      'Example Card',
      'Example Reveal Content',
    );
  }

  // @@@@@@@@@@@@@@@@@@@@@@ \\
  // @ CARD-RELATED STUFF @ \\
  // @@@@@@@@@@@@@@@@@@@@@@ \\

  Future<List<Card>> getAllCards() async {
    return await database.select(database.cards).get();
  }

  Future<List<Card>> getCardsOfLang(language) async {
    final int? langID = await getLangID(language);
    final int langIDOrDefault = langID ?? 1;

    return await (database.select(database.cards)
          ..where((c) => c.language.equals(langIDOrDefault)))
        .get();
  }

  void createCard(language, category, frontContent, revealContent) async {
    final int? langID = await getLangID(language);
    final int langIDOrDefault = langID ?? 1;
    final int? catID = await getCatID(category);
    final int catIDOrDefault = catID ?? 1;

    category = database.select(database.categories)
      ..where((c) => c.category.equals(category));
    category.map((column) => column.id).get();
    await database.into(database.cards).insert(
          CardsCompanion.insert(
            language: langIDOrDefault,
            category: catIDOrDefault,
            frontContent: frontContent,
            revealContent: revealContent,
          ),
        );
  }

  Future deleteCard(int id) {
    return (database.delete(database.cards)
          ..where((card) => card.id.equals(id)))
        .go();
  }

  void updateCard(Card card) {
    database.update(database.cards).replace(card);
  }

  // @@@@@@@@@@@@@@@@@@@@@@@ \\
  // @ LANGUAGE CAT. STUFF @ \\
  // @@@@@@@@@@@@@@@@@@@@@@@ \\

  Future<List<Language>> getAllLanguages() async {
    return await database.select(database.languages).get();
  }

  // gets the id/primary key for given String in languages table
  Future<int?> getLangID(String language) async {
    final query = database.select(database.languages)
      ..where((tbl) => tbl.language.equals(language));
    final lang = await query.getSingleOrNull();

    return lang?.id;
  }

  void createLangCat(language) async {
    await database.into(database.languages).insert(
          LanguagesCompanion.insert(language: language),
        );
  }

  Future deleteLang(int id) {
    return (database.delete(database.languages)
          ..where((language) => language.id.equals(id)))
        .go();
  }

  // @@@@@@@@@@@@@@@@@@@@@@@ \\
  // @ WORD CATEGORY STUFF @ \\
  // @@@@@@@@@@@@@@@@@@@@@@@ \\

  Future<List<Category>> getAllCategories() async {
    return await database.select(database.categories).get();
  }

  // gets the id/primary key for given String in categories table
  Future<int?> getCatID(String category) async {
    final query = database.select(database.categories)
      ..where((tbl) => tbl.category.equals(category));
    final cat = await query.getSingleOrNull();

    return cat?.id;
  }

  void createCategory(category) async {
    await database.into(database.categories).insert(
          CategoriesCompanion.insert(category: category),
        );
  }

  Future deleteCategory(int id) {
    return (database.delete(database.categories)
          ..where((category) => category.id.equals(id)))
        .go();
  }
}
