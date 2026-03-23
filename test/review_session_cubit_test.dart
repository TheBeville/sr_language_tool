import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sr_language_tool/locator.dart';
import 'package:sr_language_tool/services/review_session_cubit.dart';
import 'package:sr_language_tool/services/database_service.dart';
import 'package:sr_language_tool/models/database.dart' as database_model;
import 'package:sr_language_tool/constants.dart';

class MockDatabaseService extends Mock implements DatabaseService {}

void main() {
  setUp(() async {
    await locator.reset();
  });

  test('updateCardReviewStatus schedules next review correctly for incorrect',
      () async {
    final mock = MockDatabaseService();
    when(() => mock.getDueCards())
        .thenAnswer((_) async => <database_model.Card>[]);
    when(() => mock.updateLastReview(any(), any())).thenAnswer((_) async {});
    when(() => mock.updateNextReviewDue(any(), any())).thenAnswer((_) async {});

    locator.registerSingleton<DatabaseService>(mock);

    final cubit = ReviewSessionCubit();

    final lastReview = DateTime.now().subtract(const Duration(days: 2));
    final nextReviewDue = DateTime.now();

    await cubit.updateCardReviewStatus(
      cardId: 1,
      lastReview: lastReview,
      nextReviewDue: nextReviewDue,
      difficulty: ReviewRecallDifficulty.incorrect,
    );

    verify(() => mock.updateLastReview(1, any())).called(1);
    final captured =
        verify(() => mock.updateNextReviewDue(1, captureAny())).captured;
    expect(captured.length, 1);
    final DateTime scheduled = captured.first as DateTime;
    final diffMinutes = scheduled.difference(DateTime.now()).inMinutes;
    expect(diffMinutes, inInclusiveRange(0, 10));
  });

  test(
      'updateCardReviewStatus schedules next review correctly for difficult/reasonable/easy',
      () async {
    final mock = MockDatabaseService();
    when(() => mock.getDueCards())
        .thenAnswer((_) async => <database_model.Card>[]);
    when(() => mock.updateLastReview(any(), any())).thenAnswer((_) async {});
    when(() => mock.updateNextReviewDue(any(), any())).thenAnswer((_) async {});

    locator.registerSingleton<DatabaseService>(mock);

    final cubit = ReviewSessionCubit();

    final lastReview = DateTime.now().subtract(const Duration(days: 2));
    final nextReviewDue = DateTime.now();

    // difficult -> + timeBetweenReviews days (2 days)
    await cubit.updateCardReviewStatus(
      cardId: 2,
      lastReview: lastReview,
      nextReviewDue: nextReviewDue,
      difficulty: ReviewRecallDifficulty.difficult,
    );
    final cap1 =
        verify(() => mock.updateNextReviewDue(2, captureAny())).captured;
    expect(cap1.length, 1);
    final DateTime scheduled1 = cap1.first as DateTime;
    final diffDays1 = scheduled1.difference(DateTime.now()).inDays;
    expect(diffDays1, inInclusiveRange(1, 3));

    // reasonable -> + timeBetweenReviews * 3 days (6 days)
    await cubit.updateCardReviewStatus(
      cardId: 3,
      lastReview: lastReview,
      nextReviewDue: nextReviewDue,
      difficulty: ReviewRecallDifficulty.reasonable,
    );
    final cap2 =
        verify(() => mock.updateNextReviewDue(3, captureAny())).captured;
    expect(cap2.length, 1);
    final DateTime scheduled2 = cap2.first as DateTime;
    final diffDays2 = scheduled2.difference(DateTime.now()).inDays;
    expect(diffDays2, inInclusiveRange(4, 8));

    // easy -> + timeBetweenReviews * 6 days (12 days)
    await cubit.updateCardReviewStatus(
      cardId: 4,
      lastReview: lastReview,
      nextReviewDue: nextReviewDue,
      difficulty: ReviewRecallDifficulty.easy,
    );
    final cap3 =
        verify(() => mock.updateNextReviewDue(4, captureAny())).captured;
    expect(cap3.length, 1);
    final DateTime scheduled3 = cap3.first as DateTime;
    final diffDays3 = scheduled3.difference(DateTime.now()).inDays;
    expect(diffDays3, inInclusiveRange(9, 15));
  });
}
