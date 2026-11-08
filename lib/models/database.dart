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
  TextColumn get gender => text()();
  TextColumn get syncId => text().nullable()();
  DateTimeColumn get lastModified => dateTime().nullable()();
}

class LanguageGenders extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get language => integer().references(Languages, #id)();
  IntColumn get gender => integer().references(Genders, #id)();
  TextColumn get syncId => text().nullable()();
  DateTimeColumn get lastModified => dateTime().nullable()();
}

class DeletedRecords extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get recordTable => text()();
  TextColumn get syncId => text()();
  DateTimeColumn get deletedAt => dateTime()();
}

@DriftDatabase(
  tables: [Cards, Languages, Categories, Genders, LanguageGenders, DeletedRecords],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());
  AppDatabase.forTesting(super.e);

  @override
  int get schemaVersion => 5;

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
          if (from < 4) {
            await m.createTable(deletedRecords);
          }
          if (from < 5) {
            await m.createTable(languageGenders);

            final existingGenderCols = await customSelect(
              'PRAGMA table_info(genders)',
            ).get();
            final hasLangCol = existingGenderCols
                .any((row) => row.data['name'] == 'language');

            if (hasLangCol) {
              final oldRows = await customSelect(
                'SELECT id, language, gender, sync_id, last_modified FROM genders',
              ).get();

              final canonicalGenders = <String, Map<String, dynamic>>{};
              final rowIdToCanonicalId = <int, int>{};

              for (final row in oldRows) {
                final id = row.data['id'] as int;
                final genderText = (row.data['gender'] as String).trim();
                final key = genderText.toLowerCase();

                if (!canonicalGenders.containsKey(key)) {
                  canonicalGenders[key] = {
                    'id': id,
                    'gender': genderText,
                    'sync_id': row.data['sync_id'],
                    'last_modified': row.data['last_modified'],
                  };
                  rowIdToCanonicalId[id] = id;
                } else {
                  rowIdToCanonicalId[id] = canonicalGenders[key]!['id'] as int;
                }
              }

              await customStatement('DROP TABLE genders');
              await m.createTable(genders);

              for (final entry in canonicalGenders.values) {
                await customStatement(
                  'INSERT INTO genders (id, gender, sync_id, last_modified) VALUES (?, ?, ?, ?)',
                  [
                    entry['id'],
                    entry['gender'],
                    entry['sync_id'],
                    entry['last_modified'],
                  ],
                );
              }

              final seenPairs = <String>{};
              for (final row in oldRows) {
                final langId = row.data['language'] as int;
                final oldGenderId = row.data['id'] as int;
                final canonicalGenderId = rowIdToCanonicalId[oldGenderId]!;
                final pairKey = '$langId:$canonicalGenderId';

                if (!seenPairs.contains(pairKey)) {
                  seenPairs.add(pairKey);
                  await customStatement(
                    'INSERT INTO language_genders (language, gender, last_modified) VALUES (?, ?, ?)',
                    [
                      langId,
                      canonicalGenderId,
                      row.data['last_modified'] ??
                          DateTime.now().toIso8601String(),
                    ],
                  );
                }
              }
            }
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
