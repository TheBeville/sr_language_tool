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
  TextColumn get syncId => text().nullable()();
  DateTimeColumn get lastModified => dateTime().nullable()();
}

class Languages extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get language => text()();
  TextColumn get syncId => text().nullable()();
  DateTimeColumn get lastModified => dateTime().nullable()();
}

class Categories extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get category => text()();
  TextColumn get syncId => text().nullable()();
  DateTimeColumn get lastModified => dateTime().nullable()();
}

class Genders extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get language => integer().references(Languages, #id)();
  TextColumn get gender => text()();
  TextColumn get syncId => text().nullable()();
  DateTimeColumn get lastModified => dateTime().nullable()();
}

@DriftDatabase(tables: [Cards, Languages, Categories, Genders])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 3;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onUpgrade: (m, from, to) async {
          if (from < 2) {
            await m.createTable(genders);
          }
          if (from < 3) {
            await m.addColumn(cards, cards.syncId);
            await m.addColumn(cards, cards.lastModified);
            await m.addColumn(languages, languages.syncId);
            await m.addColumn(languages, languages.lastModified);
            await m.addColumn(categories, categories.syncId);
            await m.addColumn(categories, categories.lastModified);
            await m.addColumn(genders, genders.syncId);
            await m.addColumn(genders, genders.lastModified);
          }
        },
      );

  static QueryExecutor _openConnection() => driftDatabase(name: 'app_database');
}
