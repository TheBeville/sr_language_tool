import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

part 'database.g.dart';

class Cards extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get language => integer().references(Languages, #id)();
  IntColumn get category => integer().references(Categories, #id)();
  TextColumn get frontContent => text()();
  TextColumn get revealContent => text()();
  TextColumn get pronunciation => text().nullable()();
  TextColumn get exampleUsage => text().nullable()();
  TextColumn get pluralForm => text().nullable()();
  TextColumn get gender => text().nullable()();
  DateTimeColumn get lastReview => dateTime()();
  DateTimeColumn get nextReviewDue => dateTime()();
}

class Languages extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get language => text()();
}

class Categories extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get category => text()();
}

class Genders extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get language => integer().references(Languages, #id)();
  TextColumn get gender => text()();
}

@DriftDatabase(tables: [Cards, Languages, Categories, Genders])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 2;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onUpgrade: (m, from, to) async {
          if (from < 2) {
            await m.createTable(genders);
          }
        },
      );

  static QueryExecutor _openConnection() => driftDatabase(name: 'app_database');
}
