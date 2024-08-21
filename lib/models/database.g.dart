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
  @override
  List<GeneratedColumn> get $columns => [id, language];
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
  const Language({required this.id, required this.language});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['language'] = Variable<String>(language);
    return map;
  }

  LanguagesCompanion toCompanion(bool nullToAbsent) {
    return LanguagesCompanion(
      id: Value(id),
      language: Value(language),
    );
  }

  factory Language.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Language(
      id: serializer.fromJson<int>(json['id']),
      language: serializer.fromJson<String>(json['language']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'language': serializer.toJson<String>(language),
    };
  }

  Language copyWith({int? id, String? language}) => Language(
        id: id ?? this.id,
        language: language ?? this.language,
      );
  Language copyWithCompanion(LanguagesCompanion data) {
    return Language(
      id: data.id.present ? data.id.value : this.id,
      language: data.language.present ? data.language.value : this.language,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Language(')
          ..write('id: $id, ')
          ..write('language: $language')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, language);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Language &&
          other.id == this.id &&
          other.language == this.language);
}

class LanguagesCompanion extends UpdateCompanion<Language> {
  final Value<int> id;
  final Value<String> language;
  const LanguagesCompanion({
    this.id = const Value.absent(),
    this.language = const Value.absent(),
  });
  LanguagesCompanion.insert({
    this.id = const Value.absent(),
    required String language,
  }) : language = Value(language);
  static Insertable<Language> custom({
    Expression<int>? id,
    Expression<String>? language,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (language != null) 'language': language,
    });
  }

  LanguagesCompanion copyWith({Value<int>? id, Value<String>? language}) {
    return LanguagesCompanion(
      id: id ?? this.id,
      language: language ?? this.language,
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
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LanguagesCompanion(')
          ..write('id: $id, ')
          ..write('language: $language')
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
  @override
  List<GeneratedColumn> get $columns => [id, category];
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
  const Category({required this.id, required this.category});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['category'] = Variable<String>(category);
    return map;
  }

  CategoriesCompanion toCompanion(bool nullToAbsent) {
    return CategoriesCompanion(
      id: Value(id),
      category: Value(category),
    );
  }

  factory Category.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Category(
      id: serializer.fromJson<int>(json['id']),
      category: serializer.fromJson<String>(json['category']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'category': serializer.toJson<String>(category),
    };
  }

  Category copyWith({int? id, String? category}) => Category(
        id: id ?? this.id,
        category: category ?? this.category,
      );
  Category copyWithCompanion(CategoriesCompanion data) {
    return Category(
      id: data.id.present ? data.id.value : this.id,
      category: data.category.present ? data.category.value : this.category,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Category(')
          ..write('id: $id, ')
          ..write('category: $category')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, category);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Category &&
          other.id == this.id &&
          other.category == this.category);
}

class CategoriesCompanion extends UpdateCompanion<Category> {
  final Value<int> id;
  final Value<String> category;
  const CategoriesCompanion({
    this.id = const Value.absent(),
    this.category = const Value.absent(),
  });
  CategoriesCompanion.insert({
    this.id = const Value.absent(),
    required String category,
  }) : category = Value(category);
  static Insertable<Category> custom({
    Expression<int>? id,
    Expression<String>? category,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (category != null) 'category': category,
    });
  }

  CategoriesCompanion copyWith({Value<int>? id, Value<String>? category}) {
    return CategoriesCompanion(
      id: id ?? this.id,
      category: category ?? this.category,
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
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CategoriesCompanion(')
          ..write('id: $id, ')
          ..write('category: $category')
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
  static const VerificationMeta _lastReviewMeta =
      const VerificationMeta('lastReview');
  @override
  late final GeneratedColumn<DateTime> lastReview = GeneratedColumn<DateTime>(
      'last_review', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _nextReviewDueMeta =
      const VerificationMeta('nextReviewDue');
  @override
  late final GeneratedColumn<DateTime> nextReviewDue =
      GeneratedColumn<DateTime>('next_review_due', aliasedName, true,
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
        lastReview,
        nextReviewDue
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
    if (data.containsKey('last_review')) {
      context.handle(
          _lastReviewMeta,
          lastReview.isAcceptableOrUnknown(
              data['last_review']!, _lastReviewMeta));
    }
    if (data.containsKey('next_review_due')) {
      context.handle(
          _nextReviewDueMeta,
          nextReviewDue.isAcceptableOrUnknown(
              data['next_review_due']!, _nextReviewDueMeta));
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
      lastReview: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}last_review']),
      nextReviewDue: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}next_review_due']),
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
  final DateTime? lastReview;
  final DateTime? nextReviewDue;
  const Card(
      {required this.id,
      required this.language,
      required this.category,
      required this.frontContent,
      required this.revealContent,
      this.pronunciation,
      this.exampleUsage,
      this.pluralForm,
      this.lastReview,
      this.nextReviewDue});
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
    if (!nullToAbsent || lastReview != null) {
      map['last_review'] = Variable<DateTime>(lastReview);
    }
    if (!nullToAbsent || nextReviewDue != null) {
      map['next_review_due'] = Variable<DateTime>(nextReviewDue);
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
      lastReview: lastReview == null && nullToAbsent
          ? const Value.absent()
          : Value(lastReview),
      nextReviewDue: nextReviewDue == null && nullToAbsent
          ? const Value.absent()
          : Value(nextReviewDue),
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
      lastReview: serializer.fromJson<DateTime?>(json['lastReview']),
      nextReviewDue: serializer.fromJson<DateTime?>(json['nextReviewDue']),
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
      'lastReview': serializer.toJson<DateTime?>(lastReview),
      'nextReviewDue': serializer.toJson<DateTime?>(nextReviewDue),
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
          Value<DateTime?> lastReview = const Value.absent(),
          Value<DateTime?> nextReviewDue = const Value.absent()}) =>
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
        lastReview: lastReview.present ? lastReview.value : this.lastReview,
        nextReviewDue:
            nextReviewDue.present ? nextReviewDue.value : this.nextReviewDue,
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
      lastReview:
          data.lastReview.present ? data.lastReview.value : this.lastReview,
      nextReviewDue: data.nextReviewDue.present
          ? data.nextReviewDue.value
          : this.nextReviewDue,
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
          ..write('lastReview: $lastReview, ')
          ..write('nextReviewDue: $nextReviewDue')
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
      lastReview,
      nextReviewDue);
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
          other.lastReview == this.lastReview &&
          other.nextReviewDue == this.nextReviewDue);
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
  final Value<DateTime?> lastReview;
  final Value<DateTime?> nextReviewDue;
  const CardsCompanion({
    this.id = const Value.absent(),
    this.language = const Value.absent(),
    this.category = const Value.absent(),
    this.frontContent = const Value.absent(),
    this.revealContent = const Value.absent(),
    this.pronunciation = const Value.absent(),
    this.exampleUsage = const Value.absent(),
    this.pluralForm = const Value.absent(),
    this.lastReview = const Value.absent(),
    this.nextReviewDue = const Value.absent(),
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
    this.lastReview = const Value.absent(),
    this.nextReviewDue = const Value.absent(),
  })  : language = Value(language),
        category = Value(category),
        frontContent = Value(frontContent),
        revealContent = Value(revealContent);
  static Insertable<Card> custom({
    Expression<int>? id,
    Expression<int>? language,
    Expression<int>? category,
    Expression<String>? frontContent,
    Expression<String>? revealContent,
    Expression<String>? pronunciation,
    Expression<String>? exampleUsage,
    Expression<String>? pluralForm,
    Expression<DateTime>? lastReview,
    Expression<DateTime>? nextReviewDue,
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
      if (lastReview != null) 'last_review': lastReview,
      if (nextReviewDue != null) 'next_review_due': nextReviewDue,
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
      Value<DateTime?>? lastReview,
      Value<DateTime?>? nextReviewDue}) {
    return CardsCompanion(
      id: id ?? this.id,
      language: language ?? this.language,
      category: category ?? this.category,
      frontContent: frontContent ?? this.frontContent,
      revealContent: revealContent ?? this.revealContent,
      pronunciation: pronunciation ?? this.pronunciation,
      exampleUsage: exampleUsage ?? this.exampleUsage,
      pluralForm: pluralForm ?? this.pluralForm,
      lastReview: lastReview ?? this.lastReview,
      nextReviewDue: nextReviewDue ?? this.nextReviewDue,
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
    if (lastReview.present) {
      map['last_review'] = Variable<DateTime>(lastReview.value);
    }
    if (nextReviewDue.present) {
      map['next_review_due'] = Variable<DateTime>(nextReviewDue.value);
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
          ..write('lastReview: $lastReview, ')
          ..write('nextReviewDue: $nextReviewDue')
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
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [languages, categories, cards];
}

typedef $$LanguagesTableCreateCompanionBuilder = LanguagesCompanion Function({
  Value<int> id,
  required String language,
});
typedef $$LanguagesTableUpdateCompanionBuilder = LanguagesCompanion Function({
  Value<int> id,
  Value<String> language,
});

final class $$LanguagesTableReferences
    extends BaseReferences<_$AppDatabase, $LanguagesTable, Language> {
  $$LanguagesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$CardsTable, List<Card>> _cardsRefsTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.cards,
          aliasName: $_aliasNameGenerator(db.languages.id, db.cards.language));

  $$CardsTableProcessedTableManager get cardsRefs {
    final manager = $$CardsTableTableManager($_db, $_db.cards)
        .filter((f) => f.language.id($_item.id));

    final cache = $_typedResult.readTableOrNull(_cardsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$LanguagesTableFilterComposer
    extends FilterComposer<_$AppDatabase, $LanguagesTable> {
  $$LanguagesTableFilterComposer(super.$state);
  ColumnFilters<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get language => $state.composableBuilder(
      column: $state.table.language,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ComposableFilter cardsRefs(
      ComposableFilter Function($$CardsTableFilterComposer f) f) {
    final $$CardsTableFilterComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $state.db.cards,
        getReferencedColumn: (t) => t.language,
        builder: (joinBuilder, parentComposers) => $$CardsTableFilterComposer(
            ComposerState(
                $state.db, $state.db.cards, joinBuilder, parentComposers)));
    return f(composer);
  }
}

class $$LanguagesTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $LanguagesTable> {
  $$LanguagesTableOrderingComposer(super.$state);
  ColumnOrderings<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get language => $state.composableBuilder(
      column: $state.table.language,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

class $$LanguagesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $LanguagesTable,
    Language,
    $$LanguagesTableFilterComposer,
    $$LanguagesTableOrderingComposer,
    $$LanguagesTableCreateCompanionBuilder,
    $$LanguagesTableUpdateCompanionBuilder,
    (Language, $$LanguagesTableReferences),
    Language,
    PrefetchHooks Function({bool cardsRefs})> {
  $$LanguagesTableTableManager(_$AppDatabase db, $LanguagesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$LanguagesTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$LanguagesTableOrderingComposer(ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> language = const Value.absent(),
          }) =>
              LanguagesCompanion(
            id: id,
            language: language,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String language,
          }) =>
              LanguagesCompanion.insert(
            id: id,
            language: language,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$LanguagesTableReferences(db, table, e)
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
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable:
                            $$LanguagesTableReferences._cardsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$LanguagesTableReferences(db, table, p0).cardsRefs,
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
    $$LanguagesTableCreateCompanionBuilder,
    $$LanguagesTableUpdateCompanionBuilder,
    (Language, $$LanguagesTableReferences),
    Language,
    PrefetchHooks Function({bool cardsRefs})>;
typedef $$CategoriesTableCreateCompanionBuilder = CategoriesCompanion Function({
  Value<int> id,
  required String category,
});
typedef $$CategoriesTableUpdateCompanionBuilder = CategoriesCompanion Function({
  Value<int> id,
  Value<String> category,
});

final class $$CategoriesTableReferences
    extends BaseReferences<_$AppDatabase, $CategoriesTable, Category> {
  $$CategoriesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$CardsTable, List<Card>> _cardsRefsTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.cards,
          aliasName: $_aliasNameGenerator(db.categories.id, db.cards.category));

  $$CardsTableProcessedTableManager get cardsRefs {
    final manager = $$CardsTableTableManager($_db, $_db.cards)
        .filter((f) => f.category.id($_item.id));

    final cache = $_typedResult.readTableOrNull(_cardsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$CategoriesTableFilterComposer
    extends FilterComposer<_$AppDatabase, $CategoriesTable> {
  $$CategoriesTableFilterComposer(super.$state);
  ColumnFilters<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get category => $state.composableBuilder(
      column: $state.table.category,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ComposableFilter cardsRefs(
      ComposableFilter Function($$CardsTableFilterComposer f) f) {
    final $$CardsTableFilterComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $state.db.cards,
        getReferencedColumn: (t) => t.category,
        builder: (joinBuilder, parentComposers) => $$CardsTableFilterComposer(
            ComposerState(
                $state.db, $state.db.cards, joinBuilder, parentComposers)));
    return f(composer);
  }
}

class $$CategoriesTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $CategoriesTable> {
  $$CategoriesTableOrderingComposer(super.$state);
  ColumnOrderings<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get category => $state.composableBuilder(
      column: $state.table.category,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

class $$CategoriesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $CategoriesTable,
    Category,
    $$CategoriesTableFilterComposer,
    $$CategoriesTableOrderingComposer,
    $$CategoriesTableCreateCompanionBuilder,
    $$CategoriesTableUpdateCompanionBuilder,
    (Category, $$CategoriesTableReferences),
    Category,
    PrefetchHooks Function({bool cardsRefs})> {
  $$CategoriesTableTableManager(_$AppDatabase db, $CategoriesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$CategoriesTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$CategoriesTableOrderingComposer(ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> category = const Value.absent(),
          }) =>
              CategoriesCompanion(
            id: id,
            category: category,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String category,
          }) =>
              CategoriesCompanion.insert(
            id: id,
            category: category,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
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
                    await $_getPrefetchedData(
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
  Value<DateTime?> lastReview,
  Value<DateTime?> nextReviewDue,
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
  Value<DateTime?> lastReview,
  Value<DateTime?> nextReviewDue,
});

final class $$CardsTableReferences
    extends BaseReferences<_$AppDatabase, $CardsTable, Card> {
  $$CardsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $LanguagesTable _languageTable(_$AppDatabase db) => db.languages
      .createAlias($_aliasNameGenerator(db.cards.language, db.languages.id));

  $$LanguagesTableProcessedTableManager? get language {
    if ($_item.language == null) return null;
    final manager = $$LanguagesTableTableManager($_db, $_db.languages)
        .filter((f) => f.id($_item.language!));
    final item = $_typedResult.readTableOrNull(_languageTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $CategoriesTable _categoryTable(_$AppDatabase db) => db.categories
      .createAlias($_aliasNameGenerator(db.cards.category, db.categories.id));

  $$CategoriesTableProcessedTableManager? get category {
    if ($_item.category == null) return null;
    final manager = $$CategoriesTableTableManager($_db, $_db.categories)
        .filter((f) => f.id($_item.category!));
    final item = $_typedResult.readTableOrNull(_categoryTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$CardsTableFilterComposer
    extends FilterComposer<_$AppDatabase, $CardsTable> {
  $$CardsTableFilterComposer(super.$state);
  ColumnFilters<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get frontContent => $state.composableBuilder(
      column: $state.table.frontContent,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get revealContent => $state.composableBuilder(
      column: $state.table.revealContent,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get pronunciation => $state.composableBuilder(
      column: $state.table.pronunciation,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get exampleUsage => $state.composableBuilder(
      column: $state.table.exampleUsage,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get pluralForm => $state.composableBuilder(
      column: $state.table.pluralForm,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get lastReview => $state.composableBuilder(
      column: $state.table.lastReview,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get nextReviewDue => $state.composableBuilder(
      column: $state.table.nextReviewDue,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  $$LanguagesTableFilterComposer get language {
    final $$LanguagesTableFilterComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.language,
        referencedTable: $state.db.languages,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, parentComposers) =>
            $$LanguagesTableFilterComposer(ComposerState(
                $state.db, $state.db.languages, joinBuilder, parentComposers)));
    return composer;
  }

  $$CategoriesTableFilterComposer get category {
    final $$CategoriesTableFilterComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.category,
        referencedTable: $state.db.categories,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, parentComposers) =>
            $$CategoriesTableFilterComposer(ComposerState($state.db,
                $state.db.categories, joinBuilder, parentComposers)));
    return composer;
  }
}

class $$CardsTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $CardsTable> {
  $$CardsTableOrderingComposer(super.$state);
  ColumnOrderings<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get frontContent => $state.composableBuilder(
      column: $state.table.frontContent,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get revealContent => $state.composableBuilder(
      column: $state.table.revealContent,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get pronunciation => $state.composableBuilder(
      column: $state.table.pronunciation,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get exampleUsage => $state.composableBuilder(
      column: $state.table.exampleUsage,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get pluralForm => $state.composableBuilder(
      column: $state.table.pluralForm,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get lastReview => $state.composableBuilder(
      column: $state.table.lastReview,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get nextReviewDue => $state.composableBuilder(
      column: $state.table.nextReviewDue,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  $$LanguagesTableOrderingComposer get language {
    final $$LanguagesTableOrderingComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.language,
        referencedTable: $state.db.languages,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, parentComposers) =>
            $$LanguagesTableOrderingComposer(ComposerState(
                $state.db, $state.db.languages, joinBuilder, parentComposers)));
    return composer;
  }

  $$CategoriesTableOrderingComposer get category {
    final $$CategoriesTableOrderingComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.category,
        referencedTable: $state.db.categories,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, parentComposers) =>
            $$CategoriesTableOrderingComposer(ComposerState($state.db,
                $state.db.categories, joinBuilder, parentComposers)));
    return composer;
  }
}

class $$CardsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $CardsTable,
    Card,
    $$CardsTableFilterComposer,
    $$CardsTableOrderingComposer,
    $$CardsTableCreateCompanionBuilder,
    $$CardsTableUpdateCompanionBuilder,
    (Card, $$CardsTableReferences),
    Card,
    PrefetchHooks Function({bool language, bool category})> {
  $$CardsTableTableManager(_$AppDatabase db, $CardsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$CardsTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$CardsTableOrderingComposer(ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> language = const Value.absent(),
            Value<int> category = const Value.absent(),
            Value<String> frontContent = const Value.absent(),
            Value<String> revealContent = const Value.absent(),
            Value<String?> pronunciation = const Value.absent(),
            Value<String?> exampleUsage = const Value.absent(),
            Value<String?> pluralForm = const Value.absent(),
            Value<DateTime?> lastReview = const Value.absent(),
            Value<DateTime?> nextReviewDue = const Value.absent(),
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
            lastReview: lastReview,
            nextReviewDue: nextReviewDue,
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
            Value<DateTime?> lastReview = const Value.absent(),
            Value<DateTime?> nextReviewDue = const Value.absent(),
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
            lastReview: lastReview,
            nextReviewDue: nextReviewDue,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$CardsTableReferences(db, table, e)))
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
    $$CardsTableCreateCompanionBuilder,
    $$CardsTableUpdateCompanionBuilder,
    (Card, $$CardsTableReferences),
    Card,
    PrefetchHooks Function({bool language, bool category})>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$LanguagesTableTableManager get languages =>
      $$LanguagesTableTableManager(_db, _db.languages);
  $$CategoriesTableTableManager get categories =>
      $$CategoriesTableTableManager(_db, _db.categories);
  $$CardsTableTableManager get cards =>
      $$CardsTableTableManager(_db, _db.cards);
}
