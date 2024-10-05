import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sr_language_tool/locator.dart';
import 'package:sr_language_tool/models/database.dart' as database_model;
import 'package:sr_language_tool/services/database_service.dart';

class ReviewSessionCubit extends Cubit<List<database_model.Card>> {
  ReviewSessionCubit() : super([]) {
    getDueCards();
  }

  final dB = locator.get<database_model.AppDatabase>();
  final dBService = locator.get<DatabaseService>();

  Future<void> getDueCards() async {
    final dueCards = await dBService.getDueCards();

    emit(dueCards);
  }

  Future<void> getDueCardsOfLang(String language) async {
    final dueCards = await dBService.getDueCardsOfLang(language);

    emit(dueCards);
  }

  Future<void> updateCardReviewStatus({
    required int cardId,
    required bool isCorrect,
  }) async {
    await dBService.updateLastReview(cardId, DateTime.now());
    isCorrect
        ? await dBService.updateNextReviewDue(
            cardId,
            DateTime.now().add(
              const Duration(days: 3),
            ),
          )
        : await dBService.updateNextReviewDue(
            cardId,
            DateTime.now().add(
              const Duration(hours: 1),
            ),
          );
  }
}
