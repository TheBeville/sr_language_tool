import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sr_language_tool/locator.dart';
import 'package:sr_language_tool/models/database.dart' as database_model;
import 'package:sr_language_tool/services/database_service.dart';

class CardCubit extends Cubit<List<database_model.Card>> {
  CardCubit() : super([]) {
    getCardList();
  }

  final dB = locator.get<database_model.AppDatabase>();
  final dBService = locator.get<DatabaseService>();

  Future<void> getCardList() async {
    final cardList = await dBService.getAllCards();

    emit(cardList);
  }

  Future<void> getCardsOfLang(String language) async {
    final cardList = await dBService.getCardsOfLang(language);

    emit(cardList);
  }

  Future<bool> createCard({
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
    final bool cardMatch = await dBService.checkCardMatch(frontContent);

    !cardMatch
        ? await dBService.createCard(
            language: language,
            category: category,
            frontContent: frontContent,
            revealContent: revealContent,
            lastReview: lastReview,
            nextReviewDue: nextReviewDue,
            gender: gender,
            pluralForm: pluralForm,
            pronunciation: pronunciation,
            exampleUsage: exampleUsage,
          )
        : false;
    await getCardsOfLang(language);
    return !cardMatch;
  }

  Future<bool> modifyCard(card) async {
    await dBService.updateCard(card);
    return true;
  }

  Future<void> deleteCard(int id, String language) async {
    await dBService.deleteCard(id);
    await getCardsOfLang(language);
  }
}
