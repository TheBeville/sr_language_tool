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
            await _addColumnIfMissing(m, cards, cards.syncId);
            await _addColumnIfMissing(m, cards, cards.lastModified);
            await _addColumnIfMissing(m, languages, languages.syncId);
            await _addColumnIfMissing(m, languages, languages.lastModified);
            await _addColumnIfMissing(m, categories, categories.syncId);
            await _addColumnIfMissing(m, categories, categories.lastModified);
            await _addColumnIfMissing(m, genders, genders.syncId);
            await _addColumnIfMissing(m, genders, genders.lastModified);
          }
        },
      );

  // Guards against re-adding columns left over from a previously interrupted migration.
  Future<void> _addColumnIfMissing(
    Migrator m,
    TableInfo table,
    GeneratedColumn column,
  ) async {
    final existingColumns = await customSelect(
      'PRAGMA table_info(${table.actualTableName})',
    ).get();
    final hasColumn =
        existingColumns.any((row) => row.data['name'] == column.name);
    if (!hasColumn) {
      await m.addColumn(table, column);
    }
  }

  static QueryExecutor _openConnection() => driftDatabase(name: 'app_database');
}
