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
  DateTimeColumn get lastReview => dateTime().nullable()();
  DateTimeColumn get nextReviewDue => dateTime().nullable()();
}

class Languages extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get language => text()();
}

class Categories extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get category => text()();
}

@DriftDatabase(tables: [Cards, Languages, Categories])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  static QueryExecutor _openConnection() => driftDatabase(name: 'app_database');
}
