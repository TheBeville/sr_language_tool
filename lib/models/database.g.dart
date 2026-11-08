// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $LanguagesTable extends Languages
    with TableInfo<$LanguagesTable, Language> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LanguagesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _languageMeta =
      const VerificationMeta('language');
  @override
  late final GeneratedColumn<String> language = GeneratedColumn<String>(
      'language', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _syncIdMeta = const VerificationMeta('syncId');
  @override
  late final GeneratedColumn<String> syncId = GeneratedColumn<String>(
      'sync_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _lastModifiedMeta =
      const VerificationMeta('lastModified');
  @override
  late final GeneratedColumn<DateTime> lastModified = GeneratedColumn<DateTime>(
      'last_modified', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [id, language, syncId, lastModified];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'languages';
  @override
  VerificationContext validateIntegrity(Insertable<Language> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('language')) {
      context.handle(_languageMeta,
          language.isAcceptableOrUnknown(data['language']!, _languageMeta));
    } else if (isInserting) {
      context.missing(_languageMeta);
    }
    if (data.containsKey('sync_id')) {
      context.handle(_syncIdMeta,
          syncId.isAcceptableOrUnknown(data['sync_id']!, _syncIdMeta));
    }
    if (data.containsKey('last_modified')) {
      context.handle(
          _lastModifiedMeta,
          lastModified.isAcceptableOrUnknown(
              data['last_modified']!, _lastModifiedMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Language map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Language(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      language: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}language'])!,
      syncId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}sync_id']),
      lastModified: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}last_modified']),
    );
  }

  @override
  $LanguagesTable createAlias(String alias) {
    return $LanguagesTable(attachedDatabase, alias);
  }
}

class Language extends DataClass implements Insertable<Language> {
  final int id;
  final String language;
  final String? syncId;
  final DateTime? lastModified;
  const Language(
      {required this.id,
      required this.language,
      this.syncId,
      this.lastModified});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['language'] = Variable<String>(language);
    if (!nullToAbsent || syncId != null) {
      map['sync_id'] = Variable<String>(syncId);
    }
    if (!nullToAbsent || lastModified != null) {
      map['last_modified'] = Variable<DateTime>(lastModified);
    }
    return map;
  }

  LanguagesCompanion toCompanion(bool nullToAbsent) {
    return LanguagesCompanion(
      id: Value(id),
      language: Value(language),
      syncId:
          syncId == null && nullToAbsent ? const Value.absent() : Value(syncId),
      lastModified: lastModified == null && nullToAbsent
          ? const Value.absent()
          : Value(lastModified),
    );
  }

  factory Language.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Language(
      id: serializer.fromJson<int>(json['id']),
      language: serializer.fromJson<String>(json['language']),
      syncId: serializer.fromJson<String?>(json['syncId']),
      lastModified: serializer.fromJson<DateTime?>(json['lastModified']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'language': serializer.toJson<String>(language),
      'syncId': serializer.toJson<String?>(syncId),
      'lastModified': serializer.toJson<DateTime?>(lastModified),
    };
  }

  Language copyWith(
          {int? id,
          String? language,
          Value<String?> syncId = const Value.absent(),
          Value<DateTime?> lastModified = const Value.absent()}) =>
      Language(
        id: id ?? this.id,
        language: language ?? this.language,
        syncId: syncId.present ? syncId.value : this.syncId,
        lastModified:
            lastModified.present ? lastModified.value : this.lastModified,
      );
  Language copyWithCompanion(LanguagesCompanion data) {
    return Language(
      id: data.id.present ? data.id.value : this.id,
      language: data.language.present ? data.language.value : this.language,
      syncId: data.syncId.present ? data.syncId.value : this.syncId,
      lastModified: data.lastModified.present
          ? data.lastModified.value
          : this.lastModified,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Language(')
          ..write('id: $id, ')
          ..write('language: $language, ')
          ..write('syncId: $syncId, ')
          ..write('lastModified: $lastModified')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, language, syncId, lastModified);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Language &&
          other.id == this.id &&
          other.language == this.language &&
          other.syncId == this.syncId &&
          other.lastModified == this.lastModified);
}

class LanguagesCompanion extends UpdateCompanion<Language> {
  final Value<int> id;
  final Value<String> language;
  final Value<String?> syncId;
  final Value<DateTime?> lastModified;
  const LanguagesCompanion({
    this.id = const Value.absent(),
    this.language = const Value.absent(),
    this.syncId = const Value.absent(),
    this.lastModified = const Value.absent(),
  });
  LanguagesCompanion.insert({
    this.id = const Value.absent(),
    required String language,
    this.syncId = const Value.absent(),
    this.lastModified = const Value.absent(),
  }) : language = Value(language);
  static Insertable<Language> custom({
    Expression<int>? id,
    Expression<String>? language,
    Expression<String>? syncId,
    Expression<DateTime>? lastModified,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (language != null) 'language': language,
      if (syncId != null) 'sync_id': syncId,
      if (lastModified != null) 'last_modified': lastModified,
    });
  }

  LanguagesCompanion copyWith(
      {Value<int>? id,
      Value<String>? language,
      Value<String?>? syncId,
      Value<DateTime?>? lastModified}) {
    return LanguagesCompanion(
      id: id ?? this.id,
      language: language ?? this.language,
      syncId: syncId ?? this.syncId,
      lastModified: lastModified ?? this.lastModified,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (language.present) {
      map['language'] = Variable<String>(language.value);
    }
    if (syncId.present) {
      map['sync_id'] = Variable<String>(syncId.value);
    }
    if (lastModified.present) {
      map['last_modified'] = Variable<DateTime>(lastModified.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LanguagesCompanion(')
          ..write('id: $id, ')
          ..write('language: $language, ')
          ..write('syncId: $syncId, ')
          ..write('lastModified: $lastModified')
          ..write(')'))
        .toString();
  }
}

class $CategoriesTable extends Categories
    with TableInfo<$CategoriesTable, Category> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CategoriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _categoryMeta =
      const VerificationMeta('category');
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
      'category', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _syncIdMeta = const VerificationMeta('syncId');
  @override
  late final GeneratedColumn<String> syncId = GeneratedColumn<String>(
      'sync_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _lastModifiedMeta =
      const VerificationMeta('lastModified');
  @override
  late final GeneratedColumn<DateTime> lastModified = GeneratedColumn<DateTime>(
      'last_modified', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [id, category, syncId, lastModified];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'categories';
  @override
  VerificationContext validateIntegrity(Insertable<Category> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('category')) {
      context.handle(_categoryMeta,
          category.isAcceptableOrUnknown(data['category']!, _categoryMeta));
    } else if (isInserting) {
      context.missing(_categoryMeta);
    }
    if (data.containsKey('sync_id')) {
      context.handle(_syncIdMeta,
          syncId.isAcceptableOrUnknown(data['sync_id']!, _syncIdMeta));
    }
    if (data.containsKey('last_modified')) {
      context.handle(
          _lastModifiedMeta,
          lastModified.isAcceptableOrUnknown(
              data['last_modified']!, _lastModifiedMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Category map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Category(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      category: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}category'])!,
      syncId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}sync_id']),
      lastModified: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}last_modified']),
    );
  }

  @override
  $CategoriesTable createAlias(String alias) {
    return $CategoriesTable(attachedDatabase, alias);
  }
}

class Category extends DataClass implements Insertable<Category> {
  final int id;
  final String category;
  final String? syncId;
  final DateTime? lastModified;
  const Category(
      {required this.id,
      required this.category,
      this.syncId,
      this.lastModified});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['category'] = Variable<String>(category);
    if (!nullToAbsent || syncId != null) {
      map['sync_id'] = Variable<String>(syncId);
    }
    if (!nullToAbsent || lastModified != null) {
      map['last_modified'] = Variable<DateTime>(lastModified);
    }
    return map;
  }

  CategoriesCompanion toCompanion(bool nullToAbsent) {
    return CategoriesCompanion(
      id: Value(id),
      category: Value(category),
      syncId:
          syncId == null && nullToAbsent ? const Value.absent() : Value(syncId),
      lastModified: lastModified == null && nullToAbsent
          ? const Value.absent()
          : Value(lastModified),
    );
  }

  factory Category.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Category(
      id: serializer.fromJson<int>(json['id']),
      category: serializer.fromJson<String>(json['category']),
      syncId: serializer.fromJson<String?>(json['syncId']),
      lastModified: serializer.fromJson<DateTime?>(json['lastModified']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'category': serializer.toJson<String>(category),
      'syncId': serializer.toJson<String?>(syncId),
      'lastModified': serializer.toJson<DateTime?>(lastModified),
    };
  }

  Category copyWith(
          {int? id,
          String? category,
          Value<String?> syncId = const Value.absent(),
          Value<DateTime?> lastModified = const Value.absent()}) =>
      Category(
        id: id ?? this.id,
        category: category ?? this.category,
        syncId: syncId.present ? syncId.value : this.syncId,
        lastModified:
            lastModified.present ? lastModified.value : this.lastModified,
      );
  Category copyWithCompanion(CategoriesCompanion data) {
    return Category(
      id: data.id.present ? data.id.value : this.id,
      category: data.category.present ? data.category.value : this.category,
      syncId: data.syncId.present ? data.syncId.value : this.syncId,
      lastModified: data.lastModified.present
          ? data.lastModified.value
          : this.lastModified,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Category(')
          ..write('id: $id, ')
          ..write('category: $category, ')
          ..write('syncId: $syncId, ')
          ..write('lastModified: $lastModified')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, category, syncId, lastModified);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Category &&
          other.id == this.id &&
          other.category == this.category &&
          other.syncId == this.syncId &&
          other.lastModified == this.lastModified);
}

class CategoriesCompanion extends UpdateCompanion<Category> {
  final Value<int> id;
  final Value<String> category;
  final Value<String?> syncId;
  final Value<DateTime?> lastModified;
  const CategoriesCompanion({
    this.id = const Value.absent(),
    this.category = const Value.absent(),
    this.syncId = const Value.absent(),
    this.lastModified = const Value.absent(),
  });
  CategoriesCompanion.insert({
    this.id = const Value.absent(),
    required String category,
    this.syncId = const Value.absent(),
    this.lastModified = const Value.absent(),
  }) : category = Value(category);
  static Insertable<Category> custom({
    Expression<int>? id,
    Expression<String>? category,
    Expression<String>? syncId,
    Expression<DateTime>? lastModified,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (category != null) 'category': category,
      if (syncId != null) 'sync_id': syncId,
      if (lastModified != null) 'last_modified': lastModified,
    });
  }

  CategoriesCompanion copyWith(
      {Value<int>? id,
      Value<String>? category,
      Value<String?>? syncId,
      Value<DateTime?>? lastModified}) {
    return CategoriesCompanion(
      id: id ?? this.id,
      category: category ?? this.category,
      syncId: syncId ?? this.syncId,
      lastModified: lastModified ?? this.lastModified,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (syncId.present) {
      map['sync_id'] = Variable<String>(syncId.value);
    }
    if (lastModified.present) {
      map['last_modified'] = Variable<DateTime>(lastModified.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CategoriesCompanion(')
          ..write('id: $id, ')
          ..write('category: $category, ')
          ..write('syncId: $syncId, ')
          ..write('lastModified: $lastModified')
          ..write(')'))
        .toString();
  }
}

class $CardsTable extends Cards with TableInfo<$CardsTable, Card> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CardsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _languageMeta =
      const VerificationMeta('language');
  @override
  late final GeneratedColumn<int> language = GeneratedColumn<int>(
      'language', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES languages (id)'));
  static const VerificationMeta _categoryMeta =
      const VerificationMeta('category');
  @override
  late final GeneratedColumn<int> category = GeneratedColumn<int>(
      'category', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES categories (id)'));
  static const VerificationMeta _frontContentMeta =
      const VerificationMeta('frontContent');
  @override
  late final GeneratedColumn<String> frontContent = GeneratedColumn<String>(
      'front_content', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _revealContentMeta =
      const VerificationMeta('revealContent');
  @override
  late final GeneratedColumn<String> revealContent = GeneratedColumn<String>(
      'reveal_content', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _pronunciationMeta =
      const VerificationMeta('pronunciation');
  @override
  late final GeneratedColumn<String> pronunciation = GeneratedColumn<String>(
      'pronunciation', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _exampleUsageMeta =
      const VerificationMeta('exampleUsage');
  @override
  late final GeneratedColumn<String> exampleUsage = GeneratedColumn<String>(
      'example_usage', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _pluralFormMeta =
      const VerificationMeta('pluralForm');
  @override
  late final GeneratedColumn<String> pluralForm = GeneratedColumn<String>(
      'plural_form', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _genderMeta = const VerificationMeta('gender');
  @override
  late final GeneratedColumn<String> gender = GeneratedColumn<String>(
      'gender', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _lastReviewMeta =
      const VerificationMeta('lastReview');
  @override
  late final GeneratedColumn<DateTime> lastReview = GeneratedColumn<DateTime>(
      'last_review', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _nextReviewDueMeta =
      const VerificationMeta('nextReviewDue');
  @override
  late final GeneratedColumn<DateTime> nextReviewDue =
      GeneratedColumn<DateTime>('next_review_due', aliasedName, false,
          type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _syncIdMeta = const VerificationMeta('syncId');
  @override
  late final GeneratedColumn<String> syncId = GeneratedColumn<String>(
      'sync_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _lastModifiedMeta =
      const VerificationMeta('lastModified');
  @override
  late final GeneratedColumn<DateTime> lastModified = GeneratedColumn<DateTime>(
      'last_modified', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        language,
        category,
        frontContent,
        revealContent,
        pronunciation,
        exampleUsage,
        pluralForm,
        gender,
        lastReview,
        nextReviewDue,
        syncId,
        lastModified
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'cards';
  @override
  VerificationContext validateIntegrity(Insertable<Card> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('language')) {
      context.handle(_languageMeta,
          language.isAcceptableOrUnknown(data['language']!, _languageMeta));
    } else if (isInserting) {
      context.missing(_languageMeta);
    }
    if (data.containsKey('category')) {
      context.handle(_categoryMeta,
          category.isAcceptableOrUnknown(data['category']!, _categoryMeta));
    } else if (isInserting) {
      context.missing(_categoryMeta);
    }
    if (data.containsKey('front_content')) {
      context.handle(
          _frontContentMeta,
          frontContent.isAcceptableOrUnknown(
              data['front_content']!, _frontContentMeta));
    } else if (isInserting) {
      context.missing(_frontContentMeta);
    }
    if (data.containsKey('reveal_content')) {
      context.handle(
          _revealContentMeta,
          revealContent.isAcceptableOrUnknown(
              data['reveal_content']!, _revealContentMeta));
    } else if (isInserting) {
      context.missing(_revealContentMeta);
    }
    if (data.containsKey('pronunciation')) {
      context.handle(
          _pronunciationMeta,
          pronunciation.isAcceptableOrUnknown(
              data['pronunciation']!, _pronunciationMeta));
    }
    if (data.containsKey('example_usage')) {
      context.handle(
          _exampleUsageMeta,
          exampleUsage.isAcceptableOrUnknown(
              data['example_usage']!, _exampleUsageMeta));
    }
    if (data.containsKey('plural_form')) {
      context.handle(
          _pluralFormMeta,
          pluralForm.isAcceptableOrUnknown(
              data['plural_form']!, _pluralFormMeta));
    }
    if (data.containsKey('gender')) {
      context.handle(_genderMeta,
          gender.isAcceptableOrUnknown(data['gender']!, _genderMeta));
    }
    if (data.containsKey('last_review')) {
      context.handle(
          _lastReviewMeta,
          lastReview.isAcceptableOrUnknown(
              data['last_review']!, _lastReviewMeta));
    } else if (isInserting) {
      context.missing(_lastReviewMeta);
    }
    if (data.containsKey('next_review_due')) {
      context.handle(
          _nextReviewDueMeta,
          nextReviewDue.isAcceptableOrUnknown(
              data['next_review_due']!, _nextReviewDueMeta));
    } else if (isInserting) {
      context.missing(_nextReviewDueMeta);
    }
    if (data.containsKey('sync_id')) {
      context.handle(_syncIdMeta,
          syncId.isAcceptableOrUnknown(data['sync_id']!, _syncIdMeta));
    }
    if (data.containsKey('last_modified')) {
      context.handle(
          _lastModifiedMeta,
          lastModified.isAcceptableOrUnknown(
              data['last_modified']!, _lastModifiedMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Card map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Card(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      language: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}language'])!,
      category: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}category'])!,
      frontContent: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}front_content'])!,
      revealContent: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}reveal_content'])!,
      pronunciation: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}pronunciation']),
      exampleUsage: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}example_usage']),
      pluralForm: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}plural_form']),
      gender: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}gender']),
      lastReview: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}last_review'])!,
      nextReviewDue: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}next_review_due'])!,
      syncId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}sync_id']),
      lastModified: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}last_modified']),
    );
  }

  @override
  $CardsTable createAlias(String alias) {
    return $CardsTable(attachedDatabase, alias);
  }
}

class Card extends DataClass implements Insertable<Card> {
  final int id;
  final int language;
  final int category;
  final String frontContent;
  final String revealContent;
  final String? pronunciation;
  final String? exampleUsage;
  final String? pluralForm;
  final String? gender;
  final DateTime lastReview;
  final DateTime nextReviewDue;
  final String? syncId;
  final DateTime? lastModified;
  const Card(
      {required this.id,
      required this.language,
      required this.category,
      required this.frontContent,
      required this.revealContent,
      this.pronunciation,
      this.exampleUsage,
      this.pluralForm,
      this.gender,
      required this.lastReview,
      required this.nextReviewDue,
      this.syncId,
      this.lastModified});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['language'] = Variable<int>(language);
    map['category'] = Variable<int>(category);
    map['front_content'] = Variable<String>(frontContent);
    map['reveal_content'] = Variable<String>(revealContent);
    if (!nullToAbsent || pronunciation != null) {
      map['pronunciation'] = Variable<String>(pronunciation);
    }
    if (!nullToAbsent || exampleUsage != null) {
      map['example_usage'] = Variable<String>(exampleUsage);
    }
    if (!nullToAbsent || pluralForm != null) {
      map['plural_form'] = Variable<String>(pluralForm);
    }
    if (!nullToAbsent || gender != null) {
      map['gender'] = Variable<String>(gender);
    }
    map['last_review'] = Variable<DateTime>(lastReview);
    map['next_review_due'] = Variable<DateTime>(nextReviewDue);
    if (!nullToAbsent || syncId != null) {
      map['sync_id'] = Variable<String>(syncId);
    }
    if (!nullToAbsent || lastModified != null) {
      map['last_modified'] = Variable<DateTime>(lastModified);
    }
    return map;
  }

  CardsCompanion toCompanion(bool nullToAbsent) {
    return CardsCompanion(
      id: Value(id),
      language: Value(language),
      category: Value(category),
      frontContent: Value(frontContent),
      revealContent: Value(revealContent),
      pronunciation: pronunciation == null && nullToAbsent
          ? const Value.absent()
          : Value(pronunciation),
      exampleUsage: exampleUsage == null && nullToAbsent
          ? const Value.absent()
          : Value(exampleUsage),
      pluralForm: pluralForm == null && nullToAbsent
          ? const Value.absent()
          : Value(pluralForm),
      gender:
          gender == null && nullToAbsent ? const Value.absent() : Value(gender),
      lastReview: Value(lastReview),
      nextReviewDue: Value(nextReviewDue),
      syncId:
          syncId == null && nullToAbsent ? const Value.absent() : Value(syncId),
      lastModified: lastModified == null && nullToAbsent
          ? const Value.absent()
          : Value(lastModified),
    );
  }

  factory Card.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Card(
      id: serializer.fromJson<int>(json['id']),
      language: serializer.fromJson<int>(json['language']),
      category: serializer.fromJson<int>(json['category']),
      frontContent: serializer.fromJson<String>(json['frontContent']),
      revealContent: serializer.fromJson<String>(json['revealContent']),
      pronunciation: serializer.fromJson<String?>(json['pronunciation']),
      exampleUsage: serializer.fromJson<String?>(json['exampleUsage']),
      pluralForm: serializer.fromJson<String?>(json['pluralForm']),
      gender: serializer.fromJson<String?>(json['gender']),
      lastReview: serializer.fromJson<DateTime>(json['lastReview']),
      nextReviewDue: serializer.fromJson<DateTime>(json['nextReviewDue']),
      syncId: serializer.fromJson<String?>(json['syncId']),
      lastModified: serializer.fromJson<DateTime?>(json['lastModified']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'language': serializer.toJson<int>(language),
      'category': serializer.toJson<int>(category),
      'frontContent': serializer.toJson<String>(frontContent),
      'revealContent': serializer.toJson<String>(revealContent),
      'pronunciation': serializer.toJson<String?>(pronunciation),
      'exampleUsage': serializer.toJson<String?>(exampleUsage),
      'pluralForm': serializer.toJson<String?>(pluralForm),
      'gender': serializer.toJson<String?>(gender),
      'lastReview': serializer.toJson<DateTime>(lastReview),
      'nextReviewDue': serializer.toJson<DateTime>(nextReviewDue),
      'syncId': serializer.toJson<String?>(syncId),
      'lastModified': serializer.toJson<DateTime?>(lastModified),
    };
  }

  Card copyWith(
          {int? id,
          int? language,
          int? category,
          String? frontContent,
          String? revealContent,
          Value<String?> pronunciation = const Value.absent(),
          Value<String?> exampleUsage = const Value.absent(),
          Value<String?> pluralForm = const Value.absent(),
          Value<String?> gender = const Value.absent(),
          DateTime? lastReview,
          DateTime? nextReviewDue,
          Value<String?> syncId = const Value.absent(),
          Value<DateTime?> lastModified = const Value.absent()}) =>
      Card(
        id: id ?? this.id,
        language: language ?? this.language,
        category: category ?? this.category,
        frontContent: frontContent ?? this.frontContent,
        revealContent: revealContent ?? this.revealContent,
        pronunciation:
            pronunciation.present ? pronunciation.value : this.pronunciation,
        exampleUsage:
            exampleUsage.present ? exampleUsage.value : this.exampleUsage,
        pluralForm: pluralForm.present ? pluralForm.value : this.pluralForm,
        gender: gender.present ? gender.value : this.gender,
        lastReview: lastReview ?? this.lastReview,
        nextReviewDue: nextReviewDue ?? this.nextReviewDue,
        syncId: syncId.present ? syncId.value : this.syncId,
        lastModified:
            lastModified.present ? lastModified.value : this.lastModified,
      );
  Card copyWithCompanion(CardsCompanion data) {
    return Card(
      id: data.id.present ? data.id.value : this.id,
      language: data.language.present ? data.language.value : this.language,
      category: data.category.present ? data.category.value : this.category,
      frontContent: data.frontContent.present
          ? data.frontContent.value
          : this.frontContent,
      revealContent: data.revealContent.present
          ? data.revealContent.value
          : this.revealContent,
      pronunciation: data.pronunciation.present
          ? data.pronunciation.value
          : this.pronunciation,
      exampleUsage: data.exampleUsage.present
          ? data.exampleUsage.value
          : this.exampleUsage,
      pluralForm:
          data.pluralForm.present ? data.pluralForm.value : this.pluralForm,
      gender: data.gender.present ? data.gender.value : this.gender,
      lastReview:
          data.lastReview.present ? data.lastReview.value : this.lastReview,
      nextReviewDue: data.nextReviewDue.present
          ? data.nextReviewDue.value
          : this.nextReviewDue,
      syncId: data.syncId.present ? data.syncId.value : this.syncId,
      lastModified: data.lastModified.present
          ? data.lastModified.value
          : this.lastModified,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Card(')
          ..write('id: $id, ')
          ..write('language: $language, ')
          ..write('category: $category, ')
          ..write('frontContent: $frontContent, ')
          ..write('revealContent: $revealContent, ')
          ..write('pronunciation: $pronunciation, ')
          ..write('exampleUsage: $exampleUsage, ')
          ..write('pluralForm: $pluralForm, ')
          ..write('gender: $gender, ')
          ..write('lastReview: $lastReview, ')
          ..write('nextReviewDue: $nextReviewDue, ')
          ..write('syncId: $syncId, ')
          ..write('lastModified: $lastModified')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      language,
      category,
      frontContent,
      revealContent,
      pronunciation,
      exampleUsage,
      pluralForm,
      gender,
      lastReview,
      nextReviewDue,
      syncId,
      lastModified);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Card &&
          other.id == this.id &&
          other.language == this.language &&
          other.category == this.category &&
          other.frontContent == this.frontContent &&
          other.revealContent == this.revealContent &&
          other.pronunciation == this.pronunciation &&
          other.exampleUsage == this.exampleUsage &&
          other.pluralForm == this.pluralForm &&
          other.gender == this.gender &&
          other.lastReview == this.lastReview &&
          other.nextReviewDue == this.nextReviewDue &&
          other.syncId == this.syncId &&
          other.lastModified == this.lastModified);
}

class CardsCompanion extends UpdateCompanion<Card> {
  final Value<int> id;
  final Value<int> language;
  final Value<int> category;
  final Value<String> frontContent;
  final Value<String> revealContent;
  final Value<String?> pronunciation;
  final Value<String?> exampleUsage;
  final Value<String?> pluralForm;
  final Value<String?> gender;
  final Value<DateTime> lastReview;
  final Value<DateTime> nextReviewDue;
  final Value<String?> syncId;
  final Value<DateTime?> lastModified;
  const CardsCompanion({
    this.id = const Value.absent(),
    this.language = const Value.absent(),
    this.category = const Value.absent(),
    this.frontContent = const Value.absent(),
    this.revealContent = const Value.absent(),
    this.pronunciation = const Value.absent(),
    this.exampleUsage = const Value.absent(),
    this.pluralForm = const Value.absent(),
    this.gender = const Value.absent(),
    this.lastReview = const Value.absent(),
    this.nextReviewDue = const Value.absent(),
    this.syncId = const Value.absent(),
    this.lastModified = const Value.absent(),
  });
  CardsCompanion.insert({
    this.id = const Value.absent(),
    required int language,
    required int category,
    required String frontContent,
    required String revealContent,
    this.pronunciation = const Value.absent(),
    this.exampleUsage = const Value.absent(),
    this.pluralForm = const Value.absent(),
    this.gender = const Value.absent(),
    required DateTime lastReview,
    required DateTime nextReviewDue,
    this.syncId = const Value.absent(),
    this.lastModified = const Value.absent(),
  })  : language = Value(language),
        category = Value(category),
        frontContent = Value(frontContent),
        revealContent = Value(revealContent),
        lastReview = Value(lastReview),
        nextReviewDue = Value(nextReviewDue);
  static Insertable<Card> custom({
    Expression<int>? id,
    Expression<int>? language,
    Expression<int>? category,
    Expression<String>? frontContent,
    Expression<String>? revealContent,
    Expression<String>? pronunciation,
    Expression<String>? exampleUsage,
    Expression<String>? pluralForm,
    Expression<String>? gender,
    Expression<DateTime>? lastReview,
    Expression<DateTime>? nextReviewDue,
    Expression<String>? syncId,
    Expression<DateTime>? lastModified,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (language != null) 'language': language,
      if (category != null) 'category': category,
      if (frontContent != null) 'front_content': frontContent,
      if (revealContent != null) 'reveal_content': revealContent,
      if (pronunciation != null) 'pronunciation': pronunciation,
      if (exampleUsage != null) 'example_usage': exampleUsage,
      if (pluralForm != null) 'plural_form': pluralForm,
      if (gender != null) 'gender': gender,
      if (lastReview != null) 'last_review': lastReview,
      if (nextReviewDue != null) 'next_review_due': nextReviewDue,
      if (syncId != null) 'sync_id': syncId,
      if (lastModified != null) 'last_modified': lastModified,
    });
  }

  CardsCompanion copyWith(
      {Value<int>? id,
      Value<int>? language,
      Value<int>? category,
      Value<String>? frontContent,
      Value<String>? revealContent,
      Value<String?>? pronunciation,
      Value<String?>? exampleUsage,
      Value<String?>? pluralForm,
      Value<String?>? gender,
      Value<DateTime>? lastReview,
      Value<DateTime>? nextReviewDue,
      Value<String?>? syncId,
      Value<DateTime?>? lastModified}) {
    return CardsCompanion(
      id: id ?? this.id,
      language: language ?? this.language,
      category: category ?? this.category,
      frontContent: frontContent ?? this.frontContent,
      revealContent: revealContent ?? this.revealContent,
      pronunciation: pronunciation ?? this.pronunciation,
      exampleUsage: exampleUsage ?? this.exampleUsage,
      pluralForm: pluralForm ?? this.pluralForm,
      gender: gender ?? this.gender,
      lastReview: lastReview ?? this.lastReview,
      nextReviewDue: nextReviewDue ?? this.nextReviewDue,
      syncId: syncId ?? this.syncId,
      lastModified: lastModified ?? this.lastModified,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (language.present) {
      map['language'] = Variable<int>(language.value);
    }
    if (category.present) {
      map['category'] = Variable<int>(category.value);
    }
    if (frontContent.present) {
      map['front_content'] = Variable<String>(frontContent.value);
    }
    if (revealContent.present) {
      map['reveal_content'] = Variable<String>(revealContent.value);
    }
    if (pronunciation.present) {
      map['pronunciation'] = Variable<String>(pronunciation.value);
    }
    if (exampleUsage.present) {
      map['example_usage'] = Variable<String>(exampleUsage.value);
    }
    if (pluralForm.present) {
      map['plural_form'] = Variable<String>(pluralForm.value);
    }
    if (gender.present) {
      map['gender'] = Variable<String>(gender.value);
    }
    if (lastReview.present) {
      map['last_review'] = Variable<DateTime>(lastReview.value);
    }
    if (nextReviewDue.present) {
      map['next_review_due'] = Variable<DateTime>(nextReviewDue.value);
    }
    if (syncId.present) {
      map['sync_id'] = Variable<String>(syncId.value);
    }
    if (lastModified.present) {
      map['last_modified'] = Variable<DateTime>(lastModified.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CardsCompanion(')
          ..write('id: $id, ')
          ..write('language: $language, ')
          ..write('category: $category, ')
          ..write('frontContent: $frontContent, ')
          ..write('revealContent: $revealContent, ')
          ..write('pronunciation: $pronunciation, ')
          ..write('exampleUsage: $exampleUsage, ')
          ..write('pluralForm: $pluralForm, ')
          ..write('gender: $gender, ')
          ..write('lastReview: $lastReview, ')
          ..write('nextReviewDue: $nextReviewDue, ')
          ..write('syncId: $syncId, ')
          ..write('lastModified: $lastModified')
          ..write(')'))
        .toString();
  }
}

class $GendersTable extends Genders with TableInfo<$GendersTable, Gender> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $GendersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _genderMeta = const VerificationMeta('gender');
  @override
  late final GeneratedColumn<String> gender = GeneratedColumn<String>(
      'gender', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _syncIdMeta = const VerificationMeta('syncId');
  @override
  late final GeneratedColumn<String> syncId = GeneratedColumn<String>(
      'sync_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _lastModifiedMeta =
      const VerificationMeta('lastModified');
  @override
  late final GeneratedColumn<DateTime> lastModified = GeneratedColumn<DateTime>(
      'last_modified', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [id, gender, syncId, lastModified];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'genders';
  @override
  VerificationContext validateIntegrity(Insertable<Gender> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('gender')) {
      context.handle(_genderMeta,
          gender.isAcceptableOrUnknown(data['gender']!, _genderMeta));
    } else if (isInserting) {
      context.missing(_genderMeta);
    }
    if (data.containsKey('sync_id')) {
      context.handle(_syncIdMeta,
          syncId.isAcceptableOrUnknown(data['sync_id']!, _syncIdMeta));
    }
    if (data.containsKey('last_modified')) {
      context.handle(
          _lastModifiedMeta,
          lastModified.isAcceptableOrUnknown(
              data['last_modified']!, _lastModifiedMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Gender map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Gender(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      gender: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}gender'])!,
      syncId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}sync_id']),
      lastModified: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}last_modified']),
    );
  }

  @override
  $GendersTable createAlias(String alias) {
    return $GendersTable(attachedDatabase, alias);
  }
}

class Gender extends DataClass implements Insertable<Gender> {
  final int id;
  final String gender;
  final String? syncId;
  final DateTime? lastModified;
  const Gender(
      {required this.id, required this.gender, this.syncId, this.lastModified});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['gender'] = Variable<String>(gender);
    if (!nullToAbsent || syncId != null) {
      map['sync_id'] = Variable<String>(syncId);
    }
    if (!nullToAbsent || lastModified != null) {
      map['last_modified'] = Variable<DateTime>(lastModified);
    }
    return map;
  }

  GendersCompanion toCompanion(bool nullToAbsent) {
    return GendersCompanion(
      id: Value(id),
      gender: Value(gender),
      syncId:
          syncId == null && nullToAbsent ? const Value.absent() : Value(syncId),
      lastModified: lastModified == null && nullToAbsent
          ? const Value.absent()
          : Value(lastModified),
    );
  }

  factory Gender.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Gender(
      id: serializer.fromJson<int>(json['id']),
      gender: serializer.fromJson<String>(json['gender']),
      syncId: serializer.fromJson<String?>(json['syncId']),
      lastModified: serializer.fromJson<DateTime?>(json['lastModified']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'gender': serializer.toJson<String>(gender),
      'syncId': serializer.toJson<String?>(syncId),
      'lastModified': serializer.toJson<DateTime?>(lastModified),
    };
  }

  Gender copyWith(
          {int? id,
          String? gender,
          Value<String?> syncId = const Value.absent(),
          Value<DateTime?> lastModified = const Value.absent()}) =>
      Gender(
        id: id ?? this.id,
        gender: gender ?? this.gender,
        syncId: syncId.present ? syncId.value : this.syncId,
        lastModified:
            lastModified.present ? lastModified.value : this.lastModified,
      );
  Gender copyWithCompanion(GendersCompanion data) {
    return Gender(
      id: data.id.present ? data.id.value : this.id,
      gender: data.gender.present ? data.gender.value : this.gender,
      syncId: data.syncId.present ? data.syncId.value : this.syncId,
      lastModified: data.lastModified.present
          ? data.lastModified.value
          : this.lastModified,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Gender(')
          ..write('id: $id, ')
          ..write('gender: $gender, ')
          ..write('syncId: $syncId, ')
          ..write('lastModified: $lastModified')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, gender, syncId, lastModified);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Gender &&
          other.id == this.id &&
          other.gender == this.gender &&
          other.syncId == this.syncId &&
          other.lastModified == this.lastModified);
}

class GendersCompanion extends UpdateCompanion<Gender> {
  final Value<int> id;
  final Value<String> gender;
  final Value<String?> syncId;
  final Value<DateTime?> lastModified;
  const GendersCompanion({
    this.id = const Value.absent(),
    this.gender = const Value.absent(),
    this.syncId = const Value.absent(),
    this.lastModified = const Value.absent(),
  });
  GendersCompanion.insert({
    this.id = const Value.absent(),
    required String gender,
    this.syncId = const Value.absent(),
    this.lastModified = const Value.absent(),
  }) : gender = Value(gender);
  static Insertable<Gender> custom({
    Expression<int>? id,
    Expression<String>? gender,
    Expression<String>? syncId,
    Expression<DateTime>? lastModified,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (gender != null) 'gender': gender,
      if (syncId != null) 'sync_id': syncId,
      if (lastModified != null) 'last_modified': lastModified,
    });
  }

  GendersCompanion copyWith(
      {Value<int>? id,
      Value<String>? gender,
      Value<String?>? syncId,
      Value<DateTime?>? lastModified}) {
    return GendersCompanion(
      id: id ?? this.id,
      gender: gender ?? this.gender,
      syncId: syncId ?? this.syncId,
      lastModified: lastModified ?? this.lastModified,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (gender.present) {
      map['gender'] = Variable<String>(gender.value);
    }
    if (syncId.present) {
      map['sync_id'] = Variable<String>(syncId.value);
    }
    if (lastModified.present) {
      map['last_modified'] = Variable<DateTime>(lastModified.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('GendersCompanion(')
          ..write('id: $id, ')
          ..write('gender: $gender, ')
          ..write('syncId: $syncId, ')
          ..write('lastModified: $lastModified')
          ..write(')'))
        .toString();
  }
}

class $LanguageGendersTable extends LanguageGenders
    with TableInfo<$LanguageGendersTable, LanguageGender> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LanguageGendersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _languageMeta =
      const VerificationMeta('language');
  @override
  late final GeneratedColumn<int> language = GeneratedColumn<int>(
      'language', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES languages (id)'));
  static const VerificationMeta _genderMeta = const VerificationMeta('gender');
  @override
  late final GeneratedColumn<int> gender = GeneratedColumn<int>(
      'gender', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES genders (id)'));
  static const VerificationMeta _syncIdMeta = const VerificationMeta('syncId');
  @override
  late final GeneratedColumn<String> syncId = GeneratedColumn<String>(
      'sync_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _lastModifiedMeta =
      const VerificationMeta('lastModified');
  @override
  late final GeneratedColumn<DateTime> lastModified = GeneratedColumn<DateTime>(
      'last_modified', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns =>
      [id, language, gender, syncId, lastModified];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'language_genders';
  @override
  VerificationContext validateIntegrity(Insertable<LanguageGender> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('language')) {
      context.handle(_languageMeta,
          language.isAcceptableOrUnknown(data['language']!, _languageMeta));
    } else if (isInserting) {
      context.missing(_languageMeta);
    }
    if (data.containsKey('gender')) {
      context.handle(_genderMeta,
          gender.isAcceptableOrUnknown(data['gender']!, _genderMeta));
    } else if (isInserting) {
      context.missing(_genderMeta);
    }
    if (data.containsKey('sync_id')) {
      context.handle(_syncIdMeta,
          syncId.isAcceptableOrUnknown(data['sync_id']!, _syncIdMeta));
    }
    if (data.containsKey('last_modified')) {
      context.handle(
          _lastModifiedMeta,
          lastModified.isAcceptableOrUnknown(
              data['last_modified']!, _lastModifiedMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  LanguageGender map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LanguageGender(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      language: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}language'])!,
      gender: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}gender'])!,
      syncId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}sync_id']),
      lastModified: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}last_modified']),
    );
  }

  @override
  $LanguageGendersTable createAlias(String alias) {
    return $LanguageGendersTable(attachedDatabase, alias);
  }
}

class LanguageGender extends DataClass implements Insertable<LanguageGender> {
  final int id;
  final int language;
  final int gender;
  final String? syncId;
  final DateTime? lastModified;
  const LanguageGender(
      {required this.id,
      required this.language,
      required this.gender,
      this.syncId,
      this.lastModified});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['language'] = Variable<int>(language);
    map['gender'] = Variable<int>(gender);
    if (!nullToAbsent || syncId != null) {
      map['sync_id'] = Variable<String>(syncId);
    }
    if (!nullToAbsent || lastModified != null) {
      map['last_modified'] = Variable<DateTime>(lastModified);
    }
    return map;
  }

  LanguageGendersCompanion toCompanion(bool nullToAbsent) {
    return LanguageGendersCompanion(
      id: Value(id),
      language: Value(language),
      gender: Value(gender),
      syncId:
          syncId == null && nullToAbsent ? const Value.absent() : Value(syncId),
      lastModified: lastModified == null && nullToAbsent
          ? const Value.absent()
          : Value(lastModified),
    );
  }

  factory LanguageGender.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LanguageGender(
      id: serializer.fromJson<int>(json['id']),
      language: serializer.fromJson<int>(json['language']),
      gender: serializer.fromJson<int>(json['gender']),
      syncId: serializer.fromJson<String?>(json['syncId']),
      lastModified: serializer.fromJson<DateTime?>(json['lastModified']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'language': serializer.toJson<int>(language),
      'gender': serializer.toJson<int>(gender),
      'syncId': serializer.toJson<String?>(syncId),
      'lastModified': serializer.toJson<DateTime?>(lastModified),
    };
  }

  LanguageGender copyWith(
          {int? id,
          int? language,
          int? gender,
          Value<String?> syncId = const Value.absent(),
          Value<DateTime?> lastModified = const Value.absent()}) =>
      LanguageGender(
        id: id ?? this.id,
        language: language ?? this.language,
        gender: gender ?? this.gender,
        syncId: syncId.present ? syncId.value : this.syncId,
        lastModified:
            lastModified.present ? lastModified.value : this.lastModified,
      );
  LanguageGender copyWithCompanion(LanguageGendersCompanion data) {
    return LanguageGender(
      id: data.id.present ? data.id.value : this.id,
      language: data.language.present ? data.language.value : this.language,
      gender: data.gender.present ? data.gender.value : this.gender,
      syncId: data.syncId.present ? data.syncId.value : this.syncId,
      lastModified: data.lastModified.present
          ? data.lastModified.value
          : this.lastModified,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LanguageGender(')
          ..write('id: $id, ')
          ..write('language: $language, ')
          ..write('gender: $gender, ')
          ..write('syncId: $syncId, ')
          ..write('lastModified: $lastModified')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, language, gender, syncId, lastModified);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LanguageGender &&
          other.id == this.id &&
          other.language == this.language &&
          other.gender == this.gender &&
          other.syncId == this.syncId &&
          other.lastModified == this.lastModified);
}

class LanguageGendersCompanion extends UpdateCompanion<LanguageGender> {
  final Value<int> id;
  final Value<int> language;
  final Value<int> gender;
  final Value<String?> syncId;
  final Value<DateTime?> lastModified;
  const LanguageGendersCompanion({
    this.id = const Value.absent(),
    this.language = const Value.absent(),
    this.gender = const Value.absent(),
    this.syncId = const Value.absent(),
    this.lastModified = const Value.absent(),
  });
  LanguageGendersCompanion.insert({
    this.id = const Value.absent(),
    required int language,
    required int gender,
    this.syncId = const Value.absent(),
    this.lastModified = const Value.absent(),
  })  : language = Value(language),
        gender = Value(gender);
  static Insertable<LanguageGender> custom({
    Expression<int>? id,
    Expression<int>? language,
    Expression<int>? gender,
    Expression<String>? syncId,
    Expression<DateTime>? lastModified,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (language != null) 'language': language,
      if (gender != null) 'gender': gender,
      if (syncId != null) 'sync_id': syncId,
      if (lastModified != null) 'last_modified': lastModified,
    });
  }

  LanguageGendersCompanion copyWith(
      {Value<int>? id,
      Value<int>? language,
      Value<int>? gender,
      Value<String?>? syncId,
      Value<DateTime?>? lastModified}) {
    return LanguageGendersCompanion(
      id: id ?? this.id,
      language: language ?? this.language,
      gender: gender ?? this.gender,
      syncId: syncId ?? this.syncId,
      lastModified: lastModified ?? this.lastModified,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (language.present) {
      map['language'] = Variable<int>(language.value);
    }
    if (gender.present) {
      map['gender'] = Variable<int>(gender.value);
    }
    if (syncId.present) {
      map['sync_id'] = Variable<String>(syncId.value);
    }
    if (lastModified.present) {
      map['last_modified'] = Variable<DateTime>(lastModified.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LanguageGendersCompanion(')
          ..write('id: $id, ')
          ..write('language: $language, ')
          ..write('gender: $gender, ')
          ..write('syncId: $syncId, ')
          ..write('lastModified: $lastModified')
          ..write(')'))
        .toString();
  }
}

class $DeletedRecordsTable extends DeletedRecords
    with TableInfo<$DeletedRecordsTable, DeletedRecord> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DeletedRecordsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _recordTableMeta =
      const VerificationMeta('recordTable');
  @override
  late final GeneratedColumn<String> recordTable = GeneratedColumn<String>(
      'record_table', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _syncIdMeta = const VerificationMeta('syncId');
  @override
  late final GeneratedColumn<String> syncId = GeneratedColumn<String>(
      'sync_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _deletedAtMeta =
      const VerificationMeta('deletedAt');
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
      'deleted_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, recordTable, syncId, deletedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'deleted_records';
  @override
  VerificationContext validateIntegrity(Insertable<DeletedRecord> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('record_table')) {
      context.handle(
          _recordTableMeta,
          recordTable.isAcceptableOrUnknown(
              data['record_table']!, _recordTableMeta));
    } else if (isInserting) {
      context.missing(_recordTableMeta);
    }
    if (data.containsKey('sync_id')) {
      context.handle(_syncIdMeta,
          syncId.isAcceptableOrUnknown(data['sync_id']!, _syncIdMeta));
    } else if (isInserting) {
      context.missing(_syncIdMeta);
    }
    if (data.containsKey('deleted_at')) {
      context.handle(_deletedAtMeta,
          deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta));
    } else if (isInserting) {
      context.missing(_deletedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DeletedRecord map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DeletedRecord(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      recordTable: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}record_table'])!,
      syncId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}sync_id'])!,
      deletedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}deleted_at'])!,
    );
  }

  @override
  $DeletedRecordsTable createAlias(String alias) {
    return $DeletedRecordsTable(attachedDatabase, alias);
  }
}

class DeletedRecord extends DataClass implements Insertable<DeletedRecord> {
  final int id;
  final String recordTable;
  final String syncId;
  final DateTime deletedAt;
  const DeletedRecord(
      {required this.id,
      required this.recordTable,
      required this.syncId,
      required this.deletedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['record_table'] = Variable<String>(recordTable);
    map['sync_id'] = Variable<String>(syncId);
    map['deleted_at'] = Variable<DateTime>(deletedAt);
    return map;
  }

  DeletedRecordsCompanion toCompanion(bool nullToAbsent) {
    return DeletedRecordsCompanion(
      id: Value(id),
      recordTable: Value(recordTable),
      syncId: Value(syncId),
      deletedAt: Value(deletedAt),
    );
  }

  factory DeletedRecord.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DeletedRecord(
      id: serializer.fromJson<int>(json['id']),
      recordTable: serializer.fromJson<String>(json['recordTable']),
      syncId: serializer.fromJson<String>(json['syncId']),
      deletedAt: serializer.fromJson<DateTime>(json['deletedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'recordTable': serializer.toJson<String>(recordTable),
      'syncId': serializer.toJson<String>(syncId),
      'deletedAt': serializer.toJson<DateTime>(deletedAt),
    };
  }

  DeletedRecord copyWith(
          {int? id,
          String? recordTable,
          String? syncId,
          DateTime? deletedAt}) =>
      DeletedRecord(
        id: id ?? this.id,
        recordTable: recordTable ?? this.recordTable,
        syncId: syncId ?? this.syncId,
        deletedAt: deletedAt ?? this.deletedAt,
      );
  DeletedRecord copyWithCompanion(DeletedRecordsCompanion data) {
    return DeletedRecord(
      id: data.id.present ? data.id.value : this.id,
      recordTable:
          data.recordTable.present ? data.recordTable.value : this.recordTable,
      syncId: data.syncId.present ? data.syncId.value : this.syncId,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DeletedRecord(')
          ..write('id: $id, ')
          ..write('recordTable: $recordTable, ')
          ..write('syncId: $syncId, ')
          ..write('deletedAt: $deletedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, recordTable, syncId, deletedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DeletedRecord &&
          other.id == this.id &&
          other.recordTable == this.recordTable &&
          other.syncId == this.syncId &&
          other.deletedAt == this.deletedAt);
}

class DeletedRecordsCompanion extends UpdateCompanion<DeletedRecord> {
  final Value<int> id;
  final Value<String> recordTable;
  final Value<String> syncId;
  final Value<DateTime> deletedAt;
  const DeletedRecordsCompanion({
    this.id = const Value.absent(),
    this.recordTable = const Value.absent(),
    this.syncId = const Value.absent(),
    this.deletedAt = const Value.absent(),
  });
  DeletedRecordsCompanion.insert({
    this.id = const Value.absent(),
    required String recordTable,
    required String syncId,
    required DateTime deletedAt,
  })  : recordTable = Value(recordTable),
        syncId = Value(syncId),
        deletedAt = Value(deletedAt);
  static Insertable<DeletedRecord> custom({
    Expression<int>? id,
    Expression<String>? recordTable,
    Expression<String>? syncId,
    Expression<DateTime>? deletedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (recordTable != null) 'record_table': recordTable,
      if (syncId != null) 'sync_id': syncId,
      if (deletedAt != null) 'deleted_at': deletedAt,
    });
  }

  DeletedRecordsCompanion copyWith(
      {Value<int>? id,
      Value<String>? recordTable,
      Value<String>? syncId,
      Value<DateTime>? deletedAt}) {
    return DeletedRecordsCompanion(
      id: id ?? this.id,
      recordTable: recordTable ?? this.recordTable,
      syncId: syncId ?? this.syncId,
      deletedAt: deletedAt ?? this.deletedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (recordTable.present) {
      map['record_table'] = Variable<String>(recordTable.value);
    }
    if (syncId.present) {
      map['sync_id'] = Variable<String>(syncId.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DeletedRecordsCompanion(')
          ..write('id: $id, ')
          ..write('recordTable: $recordTable, ')
          ..write('syncId: $syncId, ')
          ..write('deletedAt: $deletedAt')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $LanguagesTable languages = $LanguagesTable(this);
  late final $CategoriesTable categories = $CategoriesTable(this);
  late final $CardsTable cards = $CardsTable(this);
  late final $GendersTable genders = $GendersTable(this);
  late final $LanguageGendersTable languageGenders =
      $LanguageGendersTable(this);
  late final $DeletedRecordsTable deletedRecords = $DeletedRecordsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [languages, categories, cards, genders, languageGenders, deletedRecords];
}

typedef $$LanguagesTableCreateCompanionBuilder = LanguagesCompanion Function({
  Value<int> id,
  required String language,
  Value<String?> syncId,
  Value<DateTime?> lastModified,
});
typedef $$LanguagesTableUpdateCompanionBuilder = LanguagesCompanion Function({
  Value<int> id,
  Value<String> language,
  Value<String?> syncId,
  Value<DateTime?> lastModified,
});

final class $$LanguagesTableReferences
    extends BaseReferences<_$AppDatabase, $LanguagesTable, Language> {
  $$LanguagesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$CardsTable, List<Card>> _cardsRefsTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.cards,
          aliasName: 'languages__id__cards__language');

  $$CardsTableProcessedTableManager get cardsRefs {
    final manager = $$CardsTableTableManager($_db, $_db.cards)
        .filter((f) => f.language.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_cardsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$LanguageGendersTable, List<LanguageGender>>
      _languageGendersRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.languageGenders,
              aliasName: 'languages__id__language_genders__language');

  $$LanguageGendersTableProcessedTableManager get languageGendersRefs {
    final manager =
        $$LanguageGendersTableTableManager($_db, $_db.languageGenders)
            .filter((f) => f.language.id.sqlEquals($_itemColumn<int>('id')!));

    final cache =
        $_typedResult.readTableOrNull(_languageGendersRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$LanguagesTableFilterComposer
    extends Composer<_$AppDatabase, $LanguagesTable> {
  $$LanguagesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get language => $composableBuilder(
      column: $table.language, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get syncId => $composableBuilder(
      column: $table.syncId, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get lastModified => $composableBuilder(
      column: $table.lastModified, builder: (column) => ColumnFilters(column));

  Expression<bool> cardsRefs(
      Expression<bool> Function($$CardsTableFilterComposer f) f) {
    final $$CardsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.cards,
        getReferencedColumn: (t) => t.language,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CardsTableFilterComposer(
              $db: $db,
              $table: $db.cards,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> languageGendersRefs(
      Expression<bool> Function($$LanguageGendersTableFilterComposer f) f) {
    final $$LanguageGendersTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.languageGenders,
        getReferencedColumn: (t) => t.language,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$LanguageGendersTableFilterComposer(
              $db: $db,
              $table: $db.languageGenders,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$LanguagesTableOrderingComposer
    extends Composer<_$AppDatabase, $LanguagesTable> {
  $$LanguagesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get language => $composableBuilder(
      column: $table.language, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get syncId => $composableBuilder(
      column: $table.syncId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get lastModified => $composableBuilder(
      column: $table.lastModified,
      builder: (column) => ColumnOrderings(column));
}

class $$LanguagesTableAnnotationComposer
    extends Composer<_$AppDatabase, $LanguagesTable> {
  $$LanguagesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get language =>
      $composableBuilder(column: $table.language, builder: (column) => column);

  GeneratedColumn<String> get syncId =>
      $composableBuilder(column: $table.syncId, builder: (column) => column);

  GeneratedColumn<DateTime> get lastModified => $composableBuilder(
      column: $table.lastModified, builder: (column) => column);

  Expression<T> cardsRefs<T extends Object>(
      Expression<T> Function($$CardsTableAnnotationComposer a) f) {
    final $$CardsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.cards,
        getReferencedColumn: (t) => t.language,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CardsTableAnnotationComposer(
              $db: $db,
              $table: $db.cards,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> languageGendersRefs<T extends Object>(
      Expression<T> Function($$LanguageGendersTableAnnotationComposer a) f) {
    final $$LanguageGendersTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.languageGenders,
        getReferencedColumn: (t) => t.language,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$LanguageGendersTableAnnotationComposer(
              $db: $db,
              $table: $db.languageGenders,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$LanguagesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $LanguagesTable,
    Language,
    $$LanguagesTableFilterComposer,
    $$LanguagesTableOrderingComposer,
    $$LanguagesTableAnnotationComposer,
    $$LanguagesTableCreateCompanionBuilder,
    $$LanguagesTableUpdateCompanionBuilder,
    (Language, $$LanguagesTableReferences),
    Language,
    PrefetchHooks Function({bool cardsRefs, bool languageGendersRefs})> {
  $$LanguagesTableTableManager(_$AppDatabase db, $LanguagesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LanguagesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LanguagesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LanguagesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> language = const Value.absent(),
            Value<String?> syncId = const Value.absent(),
            Value<DateTime?> lastModified = const Value.absent(),
          }) =>
              LanguagesCompanion(
            id: id,
            language: language,
            syncId: syncId,
            lastModified: lastModified,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String language,
            Value<String?> syncId = const Value.absent(),
            Value<DateTime?> lastModified = const Value.absent(),
          }) =>
              LanguagesCompanion.insert(
            id: id,
            language: language,
            syncId: syncId,
            lastModified: lastModified,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable<$LanguagesTable, Language>(table),
                    $$LanguagesTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: (
              {cardsRefs = false, languageGendersRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (cardsRefs) db.cards,
                if (languageGendersRefs) db.languageGenders
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (cardsRefs)
                    await $_getPrefetchedData<Language, $LanguagesTable, Card>(
                        currentTable: table,
                        referencedTable:
                            $$LanguagesTableReferences._cardsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$LanguagesTableReferences(db, table, p0).cardsRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.language == item.id),
                        typedResults: items),
                  if (languageGendersRefs)
                    await $_getPrefetchedData<Language, $LanguagesTable,
                            LanguageGender>(
                        currentTable: table,
                        referencedTable: $$LanguagesTableReferences
                            ._languageGendersRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$LanguagesTableReferences(db, table, p0)
                                .languageGendersRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.language == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$LanguagesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $LanguagesTable,
    Language,
    $$LanguagesTableFilterComposer,
    $$LanguagesTableOrderingComposer,
    $$LanguagesTableAnnotationComposer,
    $$LanguagesTableCreateCompanionBuilder,
    $$LanguagesTableUpdateCompanionBuilder,
    (Language, $$LanguagesTableReferences),
    Language,
    PrefetchHooks Function({bool cardsRefs, bool languageGendersRefs})>;
typedef $$CategoriesTableCreateCompanionBuilder = CategoriesCompanion Function({
  Value<int> id,
  required String category,
  Value<String?> syncId,
  Value<DateTime?> lastModified,
});
typedef $$CategoriesTableUpdateCompanionBuilder = CategoriesCompanion Function({
  Value<int> id,
  Value<String> category,
  Value<String?> syncId,
  Value<DateTime?> lastModified,
});

final class $$CategoriesTableReferences
    extends BaseReferences<_$AppDatabase, $CategoriesTable, Category> {
  $$CategoriesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$CardsTable, List<Card>> _cardsRefsTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.cards,
          aliasName: 'categories__id__cards__category');

  $$CardsTableProcessedTableManager get cardsRefs {
    final manager = $$CardsTableTableManager($_db, $_db.cards)
        .filter((f) => f.category.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_cardsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$CategoriesTableFilterComposer
    extends Composer<_$AppDatabase, $CategoriesTable> {
  $$CategoriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get category => $composableBuilder(
      column: $table.category, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get syncId => $composableBuilder(
      column: $table.syncId, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get lastModified => $composableBuilder(
      column: $table.lastModified, builder: (column) => ColumnFilters(column));

  Expression<bool> cardsRefs(
      Expression<bool> Function($$CardsTableFilterComposer f) f) {
    final $$CardsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.cards,
        getReferencedColumn: (t) => t.category,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CardsTableFilterComposer(
              $db: $db,
              $table: $db.cards,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$CategoriesTableOrderingComposer
    extends Composer<_$AppDatabase, $CategoriesTable> {
  $$CategoriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get category => $composableBuilder(
      column: $table.category, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get syncId => $composableBuilder(
      column: $table.syncId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get lastModified => $composableBuilder(
      column: $table.lastModified,
      builder: (column) => ColumnOrderings(column));
}

class $$CategoriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $CategoriesTable> {
  $$CategoriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<String> get syncId =>
      $composableBuilder(column: $table.syncId, builder: (column) => column);

  GeneratedColumn<DateTime> get lastModified => $composableBuilder(
      column: $table.lastModified, builder: (column) => column);

  Expression<T> cardsRefs<T extends Object>(
      Expression<T> Function($$CardsTableAnnotationComposer a) f) {
    final $$CardsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.cards,
        getReferencedColumn: (t) => t.category,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CardsTableAnnotationComposer(
              $db: $db,
              $table: $db.cards,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$CategoriesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $CategoriesTable,
    Category,
    $$CategoriesTableFilterComposer,
    $$CategoriesTableOrderingComposer,
    $$CategoriesTableAnnotationComposer,
    $$CategoriesTableCreateCompanionBuilder,
    $$CategoriesTableUpdateCompanionBuilder,
    (Category, $$CategoriesTableReferences),
    Category,
    PrefetchHooks Function({bool cardsRefs})> {
  $$CategoriesTableTableManager(_$AppDatabase db, $CategoriesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CategoriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CategoriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CategoriesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> category = const Value.absent(),
            Value<String?> syncId = const Value.absent(),
            Value<DateTime?> lastModified = const Value.absent(),
          }) =>
              CategoriesCompanion(
            id: id,
            category: category,
            syncId: syncId,
            lastModified: lastModified,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String category,
            Value<String?> syncId = const Value.absent(),
            Value<DateTime?> lastModified = const Value.absent(),
          }) =>
              CategoriesCompanion.insert(
            id: id,
            category: category,
            syncId: syncId,
            lastModified: lastModified,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable<$CategoriesTable, Category>(table),
                    $$CategoriesTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({cardsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (cardsRefs) db.cards],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (cardsRefs)
                    await $_getPrefetchedData<Category, $CategoriesTable, Card>(
                        currentTable: table,
                        referencedTable:
                            $$CategoriesTableReferences._cardsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$CategoriesTableReferences(db, table, p0)
                                .cardsRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.category == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$CategoriesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $CategoriesTable,
    Category,
    $$CategoriesTableFilterComposer,
    $$CategoriesTableOrderingComposer,
    $$CategoriesTableAnnotationComposer,
    $$CategoriesTableCreateCompanionBuilder,
    $$CategoriesTableUpdateCompanionBuilder,
    (Category, $$CategoriesTableReferences),
    Category,
    PrefetchHooks Function({bool cardsRefs})>;
typedef $$CardsTableCreateCompanionBuilder = CardsCompanion Function({
  Value<int> id,
  required int language,
  required int category,
  required String frontContent,
  required String revealContent,
  Value<String?> pronunciation,
  Value<String?> exampleUsage,
  Value<String?> pluralForm,
  Value<String?> gender,
  required DateTime lastReview,
  required DateTime nextReviewDue,
  Value<String?> syncId,
  Value<DateTime?> lastModified,
});
typedef $$CardsTableUpdateCompanionBuilder = CardsCompanion Function({
  Value<int> id,
  Value<int> language,
  Value<int> category,
  Value<String> frontContent,
  Value<String> revealContent,
  Value<String?> pronunciation,
  Value<String?> exampleUsage,
  Value<String?> pluralForm,
  Value<String?> gender,
  Value<DateTime> lastReview,
  Value<DateTime> nextReviewDue,
  Value<String?> syncId,
  Value<DateTime?> lastModified,
});

final class $$CardsTableReferences
    extends BaseReferences<_$AppDatabase, $CardsTable, Card> {
  $$CardsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $LanguagesTable _languageTable(_$AppDatabase db) =>
      db.languages.createAlias('cards__language__languages__id');

  $$LanguagesTableProcessedTableManager get language {
    final $_column = $_itemColumn<int>('language')!;

    final manager = $$LanguagesTableTableManager($_db, $_db.languages)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_languageTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $CategoriesTable _categoryTable(_$AppDatabase db) =>
      db.categories.createAlias('cards__category__categories__id');

  $$CategoriesTableProcessedTableManager get category {
    final $_column = $_itemColumn<int>('category')!;

    final manager = $$CategoriesTableTableManager($_db, $_db.categories)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_categoryTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$CardsTableFilterComposer extends Composer<_$AppDatabase, $CardsTable> {
  $$CardsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get frontContent => $composableBuilder(
      column: $table.frontContent, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get revealContent => $composableBuilder(
      column: $table.revealContent, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get pronunciation => $composableBuilder(
      column: $table.pronunciation, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get exampleUsage => $composableBuilder(
      column: $table.exampleUsage, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get pluralForm => $composableBuilder(
      column: $table.pluralForm, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get gender => $composableBuilder(
      column: $table.gender, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get lastReview => $composableBuilder(
      column: $table.lastReview, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get nextReviewDue => $composableBuilder(
      column: $table.nextReviewDue, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get syncId => $composableBuilder(
      column: $table.syncId, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get lastModified => $composableBuilder(
      column: $table.lastModified, builder: (column) => ColumnFilters(column));

  $$LanguagesTableFilterComposer get language {
    final $$LanguagesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.language,
        referencedTable: $db.languages,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$LanguagesTableFilterComposer(
              $db: $db,
              $table: $db.languages,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$CategoriesTableFilterComposer get category {
    final $$CategoriesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.category,
        referencedTable: $db.categories,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CategoriesTableFilterComposer(
              $db: $db,
              $table: $db.categories,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$CardsTableOrderingComposer
    extends Composer<_$AppDatabase, $CardsTable> {
  $$CardsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get frontContent => $composableBuilder(
      column: $table.frontContent,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get revealContent => $composableBuilder(
      column: $table.revealContent,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get pronunciation => $composableBuilder(
      column: $table.pronunciation,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get exampleUsage => $composableBuilder(
      column: $table.exampleUsage,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get pluralForm => $composableBuilder(
      column: $table.pluralForm, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get gender => $composableBuilder(
      column: $table.gender, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get lastReview => $composableBuilder(
      column: $table.lastReview, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get nextReviewDue => $composableBuilder(
      column: $table.nextReviewDue,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get syncId => $composableBuilder(
      column: $table.syncId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get lastModified => $composableBuilder(
      column: $table.lastModified,
      builder: (column) => ColumnOrderings(column));

  $$LanguagesTableOrderingComposer get language {
    final $$LanguagesTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.language,
        referencedTable: $db.languages,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$LanguagesTableOrderingComposer(
              $db: $db,
              $table: $db.languages,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$CategoriesTableOrderingComposer get category {
    final $$CategoriesTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.category,
        referencedTable: $db.categories,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CategoriesTableOrderingComposer(
              $db: $db,
              $table: $db.categories,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$CardsTableAnnotationComposer
    extends Composer<_$AppDatabase, $CardsTable> {
  $$CardsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get frontContent => $composableBuilder(
      column: $table.frontContent, builder: (column) => column);

  GeneratedColumn<String> get revealContent => $composableBuilder(
      column: $table.revealContent, builder: (column) => column);

  GeneratedColumn<String> get pronunciation => $composableBuilder(
      column: $table.pronunciation, builder: (column) => column);

  GeneratedColumn<String> get exampleUsage => $composableBuilder(
      column: $table.exampleUsage, builder: (column) => column);

  GeneratedColumn<String> get pluralForm => $composableBuilder(
      column: $table.pluralForm, builder: (column) => column);

  GeneratedColumn<String> get gender =>
      $composableBuilder(column: $table.gender, builder: (column) => column);

  GeneratedColumn<DateTime> get lastReview => $composableBuilder(
      column: $table.lastReview, builder: (column) => column);

  GeneratedColumn<DateTime> get nextReviewDue => $composableBuilder(
      column: $table.nextReviewDue, builder: (column) => column);

  GeneratedColumn<String> get syncId =>
      $composableBuilder(column: $table.syncId, builder: (column) => column);

  GeneratedColumn<DateTime> get lastModified => $composableBuilder(
      column: $table.lastModified, builder: (column) => column);

  $$LanguagesTableAnnotationComposer get language {
    final $$LanguagesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.language,
        referencedTable: $db.languages,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$LanguagesTableAnnotationComposer(
              $db: $db,
              $table: $db.languages,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$CategoriesTableAnnotationComposer get category {
    final $$CategoriesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.category,
        referencedTable: $db.categories,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CategoriesTableAnnotationComposer(
              $db: $db,
              $table: $db.categories,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$CardsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $CardsTable,
    Card,
    $$CardsTableFilterComposer,
    $$CardsTableOrderingComposer,
    $$CardsTableAnnotationComposer,
    $$CardsTableCreateCompanionBuilder,
    $$CardsTableUpdateCompanionBuilder,
    (Card, $$CardsTableReferences),
    Card,
    PrefetchHooks Function({bool language, bool category})> {
  $$CardsTableTableManager(_$AppDatabase db, $CardsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CardsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CardsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CardsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> language = const Value.absent(),
            Value<int> category = const Value.absent(),
            Value<String> frontContent = const Value.absent(),
            Value<String> revealContent = const Value.absent(),
            Value<String?> pronunciation = const Value.absent(),
            Value<String?> exampleUsage = const Value.absent(),
            Value<String?> pluralForm = const Value.absent(),
            Value<String?> gender = const Value.absent(),
            Value<DateTime> lastReview = const Value.absent(),
            Value<DateTime> nextReviewDue = const Value.absent(),
            Value<String?> syncId = const Value.absent(),
            Value<DateTime?> lastModified = const Value.absent(),
          }) =>
              CardsCompanion(
            id: id,
            language: language,
            category: category,
            frontContent: frontContent,
            revealContent: revealContent,
            pronunciation: pronunciation,
            exampleUsage: exampleUsage,
            pluralForm: pluralForm,
            gender: gender,
            lastReview: lastReview,
            nextReviewDue: nextReviewDue,
            syncId: syncId,
            lastModified: lastModified,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int language,
            required int category,
            required String frontContent,
            required String revealContent,
            Value<String?> pronunciation = const Value.absent(),
            Value<String?> exampleUsage = const Value.absent(),
            Value<String?> pluralForm = const Value.absent(),
            Value<String?> gender = const Value.absent(),
            required DateTime lastReview,
            required DateTime nextReviewDue,
            Value<String?> syncId = const Value.absent(),
            Value<DateTime?> lastModified = const Value.absent(),
          }) =>
              CardsCompanion.insert(
            id: id,
            language: language,
            category: category,
            frontContent: frontContent,
            revealContent: revealContent,
            pronunciation: pronunciation,
            exampleUsage: exampleUsage,
            pluralForm: pluralForm,
            gender: gender,
            lastReview: lastReview,
            nextReviewDue: nextReviewDue,
            syncId: syncId,
            lastModified: lastModified,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable<$CardsTable, Card>(table),
                    $$CardsTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({language = false, category = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (language) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.language,
                    referencedTable: $$CardsTableReferences._languageTable(db),
                    referencedColumn:
                        $$CardsTableReferences._languageTable(db).id,
                  ) as T;
                }
                if (category) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.category,
                    referencedTable: $$CardsTableReferences._categoryTable(db),
                    referencedColumn:
                        $$CardsTableReferences._categoryTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$CardsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $CardsTable,
    Card,
    $$CardsTableFilterComposer,
    $$CardsTableOrderingComposer,
    $$CardsTableAnnotationComposer,
    $$CardsTableCreateCompanionBuilder,
    $$CardsTableUpdateCompanionBuilder,
    (Card, $$CardsTableReferences),
    Card,
    PrefetchHooks Function({bool language, bool category})>;
typedef $$GendersTableCreateCompanionBuilder = GendersCompanion Function({
  Value<int> id,
  required String gender,
  Value<String?> syncId,
  Value<DateTime?> lastModified,
});
typedef $$GendersTableUpdateCompanionBuilder = GendersCompanion Function({
  Value<int> id,
  Value<String> gender,
  Value<String?> syncId,
  Value<DateTime?> lastModified,
});

final class $$GendersTableReferences
    extends BaseReferences<_$AppDatabase, $GendersTable, Gender> {
  $$GendersTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$LanguageGendersTable, List<LanguageGender>>
      _languageGendersRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.languageGenders,
              aliasName: 'genders__id__language_genders__gender');

  $$LanguageGendersTableProcessedTableManager get languageGendersRefs {
    final manager =
        $$LanguageGendersTableTableManager($_db, $_db.languageGenders)
            .filter((f) => f.gender.id.sqlEquals($_itemColumn<int>('id')!));

    final cache =
        $_typedResult.readTableOrNull(_languageGendersRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$GendersTableFilterComposer
    extends Composer<_$AppDatabase, $GendersTable> {
  $$GendersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get gender => $composableBuilder(
      column: $table.gender, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get syncId => $composableBuilder(
      column: $table.syncId, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get lastModified => $composableBuilder(
      column: $table.lastModified, builder: (column) => ColumnFilters(column));

  Expression<bool> languageGendersRefs(
      Expression<bool> Function($$LanguageGendersTableFilterComposer f) f) {
    final $$LanguageGendersTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.languageGenders,
        getReferencedColumn: (t) => t.gender,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$LanguageGendersTableFilterComposer(
              $db: $db,
              $table: $db.languageGenders,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$GendersTableOrderingComposer
    extends Composer<_$AppDatabase, $GendersTable> {
  $$GendersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get gender => $composableBuilder(
      column: $table.gender, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get syncId => $composableBuilder(
      column: $table.syncId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get lastModified => $composableBuilder(
      column: $table.lastModified,
      builder: (column) => ColumnOrderings(column));
}

class $$GendersTableAnnotationComposer
    extends Composer<_$AppDatabase, $GendersTable> {
  $$GendersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get gender =>
      $composableBuilder(column: $table.gender, builder: (column) => column);

  GeneratedColumn<String> get syncId =>
      $composableBuilder(column: $table.syncId, builder: (column) => column);

  GeneratedColumn<DateTime> get lastModified => $composableBuilder(
      column: $table.lastModified, builder: (column) => column);

  Expression<T> languageGendersRefs<T extends Object>(
      Expression<T> Function($$LanguageGendersTableAnnotationComposer a) f) {
    final $$LanguageGendersTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.languageGenders,
        getReferencedColumn: (t) => t.gender,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$LanguageGendersTableAnnotationComposer(
              $db: $db,
              $table: $db.languageGenders,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$GendersTableTableManager extends RootTableManager<
    _$AppDatabase,
    $GendersTable,
    Gender,
    $$GendersTableFilterComposer,
    $$GendersTableOrderingComposer,
    $$GendersTableAnnotationComposer,
    $$GendersTableCreateCompanionBuilder,
    $$GendersTableUpdateCompanionBuilder,
    (Gender, $$GendersTableReferences),
    Gender,
    PrefetchHooks Function({bool languageGendersRefs})> {
  $$GendersTableTableManager(_$AppDatabase db, $GendersTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$GendersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$GendersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$GendersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> gender = const Value.absent(),
            Value<String?> syncId = const Value.absent(),
            Value<DateTime?> lastModified = const Value.absent(),
          }) =>
              GendersCompanion(
            id: id,
            gender: gender,
            syncId: syncId,
            lastModified: lastModified,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String gender,
            Value<String?> syncId = const Value.absent(),
            Value<DateTime?> lastModified = const Value.absent(),
          }) =>
              GendersCompanion.insert(
            id: id,
            gender: gender,
            syncId: syncId,
            lastModified: lastModified,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable<$GendersTable, Gender>(table),
                    $$GendersTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({languageGendersRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (languageGendersRefs) db.languageGenders
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (languageGendersRefs)
                    await $_getPrefetchedData<Gender, $GendersTable,
                            LanguageGender>(
                        currentTable: table,
                        referencedTable: $$GendersTableReferences
                            ._languageGendersRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$GendersTableReferences(db, table, p0)
                                .languageGendersRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.gender == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$GendersTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $GendersTable,
    Gender,
    $$GendersTableFilterComposer,
    $$GendersTableOrderingComposer,
    $$GendersTableAnnotationComposer,
    $$GendersTableCreateCompanionBuilder,
    $$GendersTableUpdateCompanionBuilder,
    (Gender, $$GendersTableReferences),
    Gender,
    PrefetchHooks Function({bool languageGendersRefs})>;
typedef $$LanguageGendersTableCreateCompanionBuilder = LanguageGendersCompanion
    Function({
  Value<int> id,
  required int language,
  required int gender,
  Value<String?> syncId,
  Value<DateTime?> lastModified,
});
typedef $$LanguageGendersTableUpdateCompanionBuilder = LanguageGendersCompanion
    Function({
  Value<int> id,
  Value<int> language,
  Value<int> gender,
  Value<String?> syncId,
  Value<DateTime?> lastModified,
});

final class $$LanguageGendersTableReferences extends BaseReferences<
    _$AppDatabase, $LanguageGendersTable, LanguageGender> {
  $$LanguageGendersTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $LanguagesTable _languageTable(_$AppDatabase db) =>
      db.languages.createAlias('language_genders__language__languages__id');

  $$LanguagesTableProcessedTableManager get language {
    final $_column = $_itemColumn<int>('language')!;

    final manager = $$LanguagesTableTableManager($_db, $_db.languages)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_languageTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $GendersTable _genderTable(_$AppDatabase db) =>
      db.genders.createAlias('language_genders__gender__genders__id');

  $$GendersTableProcessedTableManager get gender {
    final $_column = $_itemColumn<int>('gender')!;

    final manager = $$GendersTableTableManager($_db, $_db.genders)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_genderTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$LanguageGendersTableFilterComposer
    extends Composer<_$AppDatabase, $LanguageGendersTable> {
  $$LanguageGendersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get syncId => $composableBuilder(
      column: $table.syncId, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get lastModified => $composableBuilder(
      column: $table.lastModified, builder: (column) => ColumnFilters(column));

  $$LanguagesTableFilterComposer get language {
    final $$LanguagesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.language,
        referencedTable: $db.languages,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$LanguagesTableFilterComposer(
              $db: $db,
              $table: $db.languages,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$GendersTableFilterComposer get gender {
    final $$GendersTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.gender,
        referencedTable: $db.genders,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$GendersTableFilterComposer(
              $db: $db,
              $table: $db.genders,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$LanguageGendersTableOrderingComposer
    extends Composer<_$AppDatabase, $LanguageGendersTable> {
  $$LanguageGendersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get syncId => $composableBuilder(
      column: $table.syncId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get lastModified => $composableBuilder(
      column: $table.lastModified,
      builder: (column) => ColumnOrderings(column));

  $$LanguagesTableOrderingComposer get language {
    final $$LanguagesTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.language,
        referencedTable: $db.languages,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$LanguagesTableOrderingComposer(
              $db: $db,
              $table: $db.languages,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$GendersTableOrderingComposer get gender {
    final $$GendersTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.gender,
        referencedTable: $db.genders,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$GendersTableOrderingComposer(
              $db: $db,
              $table: $db.genders,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$LanguageGendersTableAnnotationComposer
    extends Composer<_$AppDatabase, $LanguageGendersTable> {
  $$LanguageGendersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get syncId =>
      $composableBuilder(column: $table.syncId, builder: (column) => column);

  GeneratedColumn<DateTime> get lastModified => $composableBuilder(
      column: $table.lastModified, builder: (column) => column);

  $$LanguagesTableAnnotationComposer get language {
    final $$LanguagesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.language,
        referencedTable: $db.languages,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$LanguagesTableAnnotationComposer(
              $db: $db,
              $table: $db.languages,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$GendersTableAnnotationComposer get gender {
    final $$GendersTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.gender,
        referencedTable: $db.genders,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$GendersTableAnnotationComposer(
              $db: $db,
              $table: $db.genders,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$LanguageGendersTableTableManager extends RootTableManager<
    _$AppDatabase,
    $LanguageGendersTable,
    LanguageGender,
    $$LanguageGendersTableFilterComposer,
    $$LanguageGendersTableOrderingComposer,
    $$LanguageGendersTableAnnotationComposer,
    $$LanguageGendersTableCreateCompanionBuilder,
    $$LanguageGendersTableUpdateCompanionBuilder,
    (LanguageGender, $$LanguageGendersTableReferences),
    LanguageGender,
    PrefetchHooks Function({bool language, bool gender})> {
  $$LanguageGendersTableTableManager(
      _$AppDatabase db, $LanguageGendersTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LanguageGendersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LanguageGendersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LanguageGendersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> language = const Value.absent(),
            Value<int> gender = const Value.absent(),
            Value<String?> syncId = const Value.absent(),
            Value<DateTime?> lastModified = const Value.absent(),
          }) =>
              LanguageGendersCompanion(
            id: id,
            language: language,
            gender: gender,
            syncId: syncId,
            lastModified: lastModified,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int language,
            required int gender,
            Value<String?> syncId = const Value.absent(),
            Value<DateTime?> lastModified = const Value.absent(),
          }) =>
              LanguageGendersCompanion.insert(
            id: id,
            language: language,
            gender: gender,
            syncId: syncId,
            lastModified: lastModified,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable<$LanguageGendersTable, LanguageGender>(table),
                    $$LanguageGendersTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({language = false, gender = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (language) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.language,
                    referencedTable:
                        $$LanguageGendersTableReferences._languageTable(db),
                    referencedColumn:
                        $$LanguageGendersTableReferences._languageTable(db).id,
                  ) as T;
                }
                if (gender) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.gender,
                    referencedTable:
                        $$LanguageGendersTableReferences._genderTable(db),
                    referencedColumn:
                        $$LanguageGendersTableReferences._genderTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$LanguageGendersTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $LanguageGendersTable,
    LanguageGender,
    $$LanguageGendersTableFilterComposer,
    $$LanguageGendersTableOrderingComposer,
    $$LanguageGendersTableAnnotationComposer,
    $$LanguageGendersTableCreateCompanionBuilder,
    $$LanguageGendersTableUpdateCompanionBuilder,
    (LanguageGender, $$LanguageGendersTableReferences),
    LanguageGender,
    PrefetchHooks Function({bool language, bool gender})>;
typedef $$DeletedRecordsTableCreateCompanionBuilder = DeletedRecordsCompanion
    Function({
  Value<int> id,
  required String recordTable,
  required String syncId,
  required DateTime deletedAt,
});
typedef $$DeletedRecordsTableUpdateCompanionBuilder = DeletedRecordsCompanion
    Function({
  Value<int> id,
  Value<String> recordTable,
  Value<String> syncId,
  Value<DateTime> deletedAt,
});

class $$DeletedRecordsTableFilterComposer
    extends Composer<_$AppDatabase, $DeletedRecordsTable> {
  $$DeletedRecordsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get recordTable => $composableBuilder(
      column: $table.recordTable, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get syncId => $composableBuilder(
      column: $table.syncId, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
      column: $table.deletedAt, builder: (column) => ColumnFilters(column));
}

class $$DeletedRecordsTableOrderingComposer
    extends Composer<_$AppDatabase, $DeletedRecordsTable> {
  $$DeletedRecordsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get recordTable => $composableBuilder(
      column: $table.recordTable, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get syncId => $composableBuilder(
      column: $table.syncId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
      column: $table.deletedAt, builder: (column) => ColumnOrderings(column));
}

class $$DeletedRecordsTableAnnotationComposer
    extends Composer<_$AppDatabase, $DeletedRecordsTable> {
  $$DeletedRecordsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get recordTable => $composableBuilder(
      column: $table.recordTable, builder: (column) => column);

  GeneratedColumn<String> get syncId =>
      $composableBuilder(column: $table.syncId, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);
}

class $$DeletedRecordsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $DeletedRecordsTable,
    DeletedRecord,
    $$DeletedRecordsTableFilterComposer,
    $$DeletedRecordsTableOrderingComposer,
    $$DeletedRecordsTableAnnotationComposer,
    $$DeletedRecordsTableCreateCompanionBuilder,
    $$DeletedRecordsTableUpdateCompanionBuilder,
    (
      DeletedRecord,
      BaseReferences<_$AppDatabase, $DeletedRecordsTable, DeletedRecord>
    ),
    DeletedRecord,
    PrefetchHooks Function()> {
  $$DeletedRecordsTableTableManager(
      _$AppDatabase db, $DeletedRecordsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DeletedRecordsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DeletedRecordsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DeletedRecordsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> recordTable = const Value.absent(),
            Value<String> syncId = const Value.absent(),
            Value<DateTime> deletedAt = const Value.absent(),
          }) =>
              DeletedRecordsCompanion(
            id: id,
            recordTable: recordTable,
            syncId: syncId,
            deletedAt: deletedAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String recordTable,
            required String syncId,
            required DateTime deletedAt,
          }) =>
              DeletedRecordsCompanion.insert(
            id: id,
            recordTable: recordTable,
            syncId: syncId,
            deletedAt: deletedAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable<$DeletedRecordsTable, DeletedRecord>(table),
                    BaseReferences<_$AppDatabase, $DeletedRecordsTable,
                        DeletedRecord>(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$DeletedRecordsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $DeletedRecordsTable,
    DeletedRecord,
    $$DeletedRecordsTableFilterComposer,
    $$DeletedRecordsTableOrderingComposer,
    $$DeletedRecordsTableAnnotationComposer,
    $$DeletedRecordsTableCreateCompanionBuilder,
    $$DeletedRecordsTableUpdateCompanionBuilder,
    (
      DeletedRecord,
      BaseReferences<_$AppDatabase, $DeletedRecordsTable, DeletedRecord>
    ),
    DeletedRecord,
    PrefetchHooks Function()>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$LanguagesTableTableManager get languages =>
      $$LanguagesTableTableManager(_db, _db.languages);
  $$CategoriesTableTableManager get categories =>
      $$CategoriesTableTableManager(_db, _db.categories);
  $$CardsTableTableManager get cards =>
      $$CardsTableTableManager(_db, _db.cards);
  $$GendersTableTableManager get genders =>
      $$GendersTableTableManager(_db, _db.genders);
  $$LanguageGendersTableTableManager get languageGenders =>
      $$LanguageGendersTableTableManager(_db, _db.languageGenders);
  $$DeletedRecordsTableTableManager get deletedRecords =>
      $$DeletedRecordsTableTableManager(_db, _db.deletedRecords);
}
