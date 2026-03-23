import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sr_language_tool/locator.dart';
import 'package:sr_language_tool/services/card_cubit.dart';
import 'package:sr_language_tool/services/database_service.dart';
import 'package:sr_language_tool/models/database.dart' as database_model;

class MockDatabaseService extends Mock implements DatabaseService {}

void main() {
  setUp(() async {
    await locator.reset();
  });

  test('createCard calls create when no match and returns true', () async {
    final mock = MockDatabaseService();
    when(() => mock.getAllCards())
        .thenAnswer((_) async => <database_model.Card>[]);
    when(() => mock.checkCardMatch(any())).thenAnswer((_) async => false);
    when(
      () => mock.createCard(
        language: any(named: 'language'),
        category: any(named: 'category'),
        frontContent: any(named: 'frontContent'),
        revealContent: any(named: 'revealContent'),
        lastReview: any(named: 'lastReview'),
        nextReviewDue: any(named: 'nextReviewDue'),
        gender: any(named: 'gender'),
        pluralForm: any(named: 'pluralForm'),
        pronunciation: any(named: 'pronunciation'),
        exampleUsage: any(named: 'exampleUsage'),
      ),
    ).thenAnswer((_) async {});
    when(() => mock.getCardsOfLang(any()))
        .thenAnswer((_) async => <database_model.Card>[]);

    locator.registerSingleton<DatabaseService>(mock);

    final cubit = CardCubit();

    final result = await cubit.createCard(
      language: 'Lang',
      category: 'Cat',
      frontContent: 'front',
      revealContent: 'reveal',
      lastReview: DateTime.now(),
      nextReviewDue: DateTime.now().add(const Duration(days: 1)),
    );

    expect(result, isTrue);
    verify(
      () => mock.createCard(
        language: 'Lang',
        category: 'Cat',
        frontContent: 'front',
        revealContent: 'reveal',
        lastReview: any(named: 'lastReview'),
        nextReviewDue: any(named: 'nextReviewDue'),
        gender: any(named: 'gender'),
        pluralForm: any(named: 'pluralForm'),
        pronunciation: any(named: 'pronunciation'),
        exampleUsage: any(named: 'exampleUsage'),
      ),
    ).called(1);
  });

  test('createCard returns false when match exists and does not call create',
      () async {
    final mock = MockDatabaseService();
    when(() => mock.getAllCards())
        .thenAnswer((_) async => <database_model.Card>[]);
    when(() => mock.checkCardMatch(any())).thenAnswer((_) async => true);
    when(() => mock.getCardsOfLang(any()))
        .thenAnswer((_) async => <database_model.Card>[]);

    locator.registerSingleton<DatabaseService>(mock);

    final cubit = CardCubit();

    final result = await cubit.createCard(
      language: 'Lang',
      category: 'Cat',
      frontContent: 'front',
      revealContent: 'reveal',
      lastReview: DateTime.now(),
      nextReviewDue: DateTime.now().add(const Duration(days: 1)),
    );

    expect(result, isFalse);
    verifyNever(
      () => mock.createCard(
        language: any(named: 'language'),
        category: any(named: 'category'),
        frontContent: any(named: 'frontContent'),
        revealContent: any(named: 'revealContent'),
        lastReview: any(named: 'lastReview'),
        nextReviewDue: any(named: 'nextReviewDue'),
        gender: any(named: 'gender'),
        pluralForm: any(named: 'pluralForm'),
        pronunciation: any(named: 'pronunciation'),
        exampleUsage: any(named: 'exampleUsage'),
      ),
    );
  });
}
