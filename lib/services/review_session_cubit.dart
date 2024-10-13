import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sr_language_tool/locator.dart';
import 'package:sr_language_tool/models/database.dart' as database_model;
import 'package:sr_language_tool/services/database_service.dart';
import 'package:sr_language_tool/constants.dart';

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
    required DateTime lastReview,
    required DateTime nextReviewDue,
    required ReviewRecallDifficulty difficulty,
  }) async {
    int timeBetweenReviews = nextReviewDue.difference(lastReview).inDays;
    if (timeBetweenReviews == 0) timeBetweenReviews = 1;

    await dBService.updateLastReview(cardId, DateTime.now());

    switch (difficulty) {
      case ReviewRecallDifficulty.incorrect:
        await dBService.updateNextReviewDue(
          cardId,
          DateTime.now().add(
            const Duration(minutes: 5),
          ),
        );
        break;
      case ReviewRecallDifficulty.difficult:
        await dBService.updateNextReviewDue(
          cardId,
          DateTime.now().add(
            Duration(days: timeBetweenReviews),
          ),
        );
        break;
      case ReviewRecallDifficulty.reasonable:
        await dBService.updateNextReviewDue(
          cardId,
          DateTime.now().add(
            Duration(days: timeBetweenReviews * 3),
          ),
        );
        break;
      case ReviewRecallDifficulty.easy:
        await dBService.updateNextReviewDue(
          cardId,
          DateTime.now().add(
            Duration(days: timeBetweenReviews * 6),
          ),
        );
        break;
      default:
        await dBService.updateNextReviewDue(
          cardId,
          DateTime.now(),
        );
    }
  }
}
