import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sr_language_tool/locator.dart';
import 'package:sr_language_tool/models/database.dart';
import 'package:sr_language_tool/services/database_service.dart';

void main() {
  late AppDatabase db;
  late DatabaseService dbService;

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    await locator.reset();
    db = AppDatabase.forTesting(NativeDatabase.memory());
    locator.registerSingleton<AppDatabase>(db);
    dbService = DatabaseService();
    locator.registerSingleton<DatabaseService>(dbService);
  });

  tearDown(() async {
    await db.close();
  });

  test('Genders can be shared across multiple languages without duplication',
      () async {
    // 1. Create two languages
    await dbService.createLangCat('French');
    await dbService.createLangCat('Spanish');

    final frenchId = await dbService.getLangID('French');
    final spanishId = await dbService.getLangID('Spanish');

    // 2. Create genders (with deduplication check)
    final masc = await dbService.getOrCreateGender('Masculine');
    final mascDup = await dbService.getOrCreateGender('  masculine  ');
    final fem = await dbService.getOrCreateGender('Feminine');

    expect(masc.id, equals(mascDup.id));
    final allGenders = await dbService.getAllGenders();
    expect(allGenders.length, equals(2));

    // 3. Link both genders to French and Spanish
    await dbService.setGendersForLang(frenchId, {masc.id, fem.id});
    await dbService.setGendersForLang(spanishId, {masc.id, fem.id});

    final frenchGenders = await dbService.getGendersOfLang('French');
    final spanishGenders = await dbService.getGendersOfLang('Spanish');

    expect(frenchGenders.map((g) => g.gender).toSet(), equals({'Masculine', 'Feminine'}));
    expect(spanishGenders.map((g) => g.gender).toSet(), equals({'Masculine', 'Feminine'}));

    // Both languages share the exact same gender IDs
    expect(frenchGenders.map((g) => g.id).toSet(), equals(spanishGenders.map((g) => g.id).toSet()));

    // 4. Deleting French removes its links, but preserves Spanish and the Genders table
    await dbService.deleteLang(frenchId);

    final remainingAllGenders = await dbService.getAllGenders();
    expect(remainingAllGenders.length, equals(2));

    final spanishGendersAfterDelete = await dbService.getGendersOfLang('Spanish');
    expect(spanishGendersAfterDelete.length, equals(2));

    // 5. Updating Spanish genders to only Masculine
    await dbService.setGendersForLang(spanishId, {masc.id});
    final spanishGendersUpdated = await dbService.getGendersOfLang('Spanish');
    expect(spanishGendersUpdated.length, equals(1));
    expect(spanishGendersUpdated.first.gender, equals('Masculine'));
  });
}
