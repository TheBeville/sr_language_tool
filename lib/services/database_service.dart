import 'package:sr_language_tool/locator.dart';
import 'package:sr_language_tool/models/database.dart';

class DatabaseService {
  final database = locator.get<AppDatabase>();

  Future<List<Card>> getAllCards() async {
    return await database.select(database.cards).get();
  }

  void createCard(language, category, frontContent, revealContent) async {
    await database.into(database.cards).insert(
          CardsCompanion.insert(
            language: language,
            category: category,
            frontContent: frontContent,
            revealContent: revealContent,
          ),
        );
  }

  void deleteCard(int id) {
    database.delete(database.cards).where((card) => card.id.equals(id));
  }

  void updateCard(Card card) {
    database.update(database.cards).replace(card);
  }
}
