// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'emotion_isar.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetEmotionRecorderEventIsarCollection on Isar {
  IsarCollection<EmotionRecorderEventIsar> get emotionRecorderEventIsars =>
      this.collection();
}

const EmotionRecorderEventIsarSchema = CollectionSchema(
  name: r'EmotionRecorderEventIsar',
  id: 815374189098223854,
  properties: {
    r'dateTime': PropertySchema(
      id: 0,
      name: r'dateTime',
      type: IsarType.dateTime,
    ),
    r'emoji': PropertySchema(
      id: 1,
      name: r'emoji',
      type: IsarType.string,
    ),
    r'emotionName': PropertySchema(
      id: 2,
      name: r'emotionName',
      type: IsarType.string,
    ),
    r'uuid': PropertySchema(
      id: 3,
      name: r'uuid',
      type: IsarType.string,
    )
  },
  estimateSize: _emotionRecorderEventIsarEstimateSize,
  serialize: _emotionRecorderEventIsarSerialize,
  deserialize: _emotionRecorderEventIsarDeserialize,
  deserializeProp: _emotionRecorderEventIsarDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _emotionRecorderEventIsarGetId,
  getLinks: _emotionRecorderEventIsarGetLinks,
  attach: _emotionRecorderEventIsarAttach,
  version: '3.1.0+1',
);

int _emotionRecorderEventIsarEstimateSize(
  EmotionRecorderEventIsar object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.emoji.length * 3;
  bytesCount += 3 + object.emotionName.length * 3;
  bytesCount += 3 + object.uuid.length * 3;
  return bytesCount;
}

void _emotionRecorderEventIsarSerialize(
  EmotionRecorderEventIsar object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDateTime(offsets[0], object.dateTime);
  writer.writeString(offsets[1], object.emoji);
  writer.writeString(offsets[2], object.emotionName);
  writer.writeString(offsets[3], object.uuid);
}

EmotionRecorderEventIsar _emotionRecorderEventIsarDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = EmotionRecorderEventIsar(
    reader.readString(offsets[1]),
    reader.readString(offsets[2]),
    reader.readDateTime(offsets[0]),
    reader.readString(offsets[3]),
  );
  object.id = id;
  return object;
}

P _emotionRecorderEventIsarDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDateTime(offset)) as P;
    case 1:
      return (reader.readString(offset)) as P;
    case 2:
      return (reader.readString(offset)) as P;
    case 3:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _emotionRecorderEventIsarGetId(EmotionRecorderEventIsar object) {
  return object.id ?? Isar.autoIncrement;
}

List<IsarLinkBase<dynamic>> _emotionRecorderEventIsarGetLinks(
    EmotionRecorderEventIsar object) {
  return [];
}

void _emotionRecorderEventIsarAttach(
    IsarCollection<dynamic> col, Id id, EmotionRecorderEventIsar object) {
  object.id = id;
}

extension EmotionRecorderEventIsarQueryWhereSort on QueryBuilder<
    EmotionRecorderEventIsar, EmotionRecorderEventIsar, QWhere> {
  QueryBuilder<EmotionRecorderEventIsar, EmotionRecorderEventIsar, QAfterWhere>
      anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension EmotionRecorderEventIsarQueryWhere on QueryBuilder<
    EmotionRecorderEventIsar, EmotionRecorderEventIsar, QWhereClause> {
  QueryBuilder<EmotionRecorderEventIsar, EmotionRecorderEventIsar,
      QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<EmotionRecorderEventIsar, EmotionRecorderEventIsar,
      QAfterWhereClause> idNotEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<EmotionRecorderEventIsar, EmotionRecorderEventIsar,
      QAfterWhereClause> idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<EmotionRecorderEventIsar, EmotionRecorderEventIsar,
      QAfterWhereClause> idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<EmotionRecorderEventIsar, EmotionRecorderEventIsar,
      QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension EmotionRecorderEventIsarQueryFilter on QueryBuilder<
    EmotionRecorderEventIsar, EmotionRecorderEventIsar, QFilterCondition> {
  QueryBuilder<EmotionRecorderEventIsar, EmotionRecorderEventIsar,
      QAfterFilterCondition> dateTimeEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'dateTime',
        value: value,
      ));
    });
  }

  QueryBuilder<EmotionRecorderEventIsar, EmotionRecorderEventIsar,
      QAfterFilterCondition> dateTimeGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'dateTime',
        value: value,
      ));
    });
  }

  QueryBuilder<EmotionRecorderEventIsar, EmotionRecorderEventIsar,
      QAfterFilterCondition> dateTimeLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'dateTime',
        value: value,
      ));
    });
  }

  QueryBuilder<EmotionRecorderEventIsar, EmotionRecorderEventIsar,
      QAfterFilterCondition> dateTimeBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'dateTime',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<EmotionRecorderEventIsar, EmotionRecorderEventIsar,
      QAfterFilterCondition> emojiEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'emoji',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmotionRecorderEventIsar, EmotionRecorderEventIsar,
      QAfterFilterCondition> emojiGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'emoji',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmotionRecorderEventIsar, EmotionRecorderEventIsar,
      QAfterFilterCondition> emojiLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'emoji',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmotionRecorderEventIsar, EmotionRecorderEventIsar,
      QAfterFilterCondition> emojiBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'emoji',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmotionRecorderEventIsar, EmotionRecorderEventIsar,
      QAfterFilterCondition> emojiStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'emoji',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmotionRecorderEventIsar, EmotionRecorderEventIsar,
      QAfterFilterCondition> emojiEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'emoji',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmotionRecorderEventIsar, EmotionRecorderEventIsar,
          QAfterFilterCondition>
      emojiContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'emoji',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmotionRecorderEventIsar, EmotionRecorderEventIsar,
          QAfterFilterCondition>
      emojiMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'emoji',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmotionRecorderEventIsar, EmotionRecorderEventIsar,
      QAfterFilterCondition> emojiIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'emoji',
        value: '',
      ));
    });
  }

  QueryBuilder<EmotionRecorderEventIsar, EmotionRecorderEventIsar,
      QAfterFilterCondition> emojiIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'emoji',
        value: '',
      ));
    });
  }

  QueryBuilder<EmotionRecorderEventIsar, EmotionRecorderEventIsar,
      QAfterFilterCondition> emotionNameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'emotionName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmotionRecorderEventIsar, EmotionRecorderEventIsar,
      QAfterFilterCondition> emotionNameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'emotionName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmotionRecorderEventIsar, EmotionRecorderEventIsar,
      QAfterFilterCondition> emotionNameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'emotionName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmotionRecorderEventIsar, EmotionRecorderEventIsar,
      QAfterFilterCondition> emotionNameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'emotionName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmotionRecorderEventIsar, EmotionRecorderEventIsar,
      QAfterFilterCondition> emotionNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'emotionName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmotionRecorderEventIsar, EmotionRecorderEventIsar,
      QAfterFilterCondition> emotionNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'emotionName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmotionRecorderEventIsar, EmotionRecorderEventIsar,
          QAfterFilterCondition>
      emotionNameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'emotionName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmotionRecorderEventIsar, EmotionRecorderEventIsar,
          QAfterFilterCondition>
      emotionNameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'emotionName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmotionRecorderEventIsar, EmotionRecorderEventIsar,
      QAfterFilterCondition> emotionNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'emotionName',
        value: '',
      ));
    });
  }

  QueryBuilder<EmotionRecorderEventIsar, EmotionRecorderEventIsar,
      QAfterFilterCondition> emotionNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'emotionName',
        value: '',
      ));
    });
  }

  QueryBuilder<EmotionRecorderEventIsar, EmotionRecorderEventIsar,
      QAfterFilterCondition> idIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'id',
      ));
    });
  }

  QueryBuilder<EmotionRecorderEventIsar, EmotionRecorderEventIsar,
      QAfterFilterCondition> idIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'id',
      ));
    });
  }

  QueryBuilder<EmotionRecorderEventIsar, EmotionRecorderEventIsar,
      QAfterFilterCondition> idEqualTo(Id? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<EmotionRecorderEventIsar, EmotionRecorderEventIsar,
      QAfterFilterCondition> idGreaterThan(
    Id? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<EmotionRecorderEventIsar, EmotionRecorderEventIsar,
      QAfterFilterCondition> idLessThan(
    Id? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<EmotionRecorderEventIsar, EmotionRecorderEventIsar,
      QAfterFilterCondition> idBetween(
    Id? lower,
    Id? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<EmotionRecorderEventIsar, EmotionRecorderEventIsar,
      QAfterFilterCondition> uuidEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'uuid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmotionRecorderEventIsar, EmotionRecorderEventIsar,
      QAfterFilterCondition> uuidGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'uuid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmotionRecorderEventIsar, EmotionRecorderEventIsar,
      QAfterFilterCondition> uuidLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'uuid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmotionRecorderEventIsar, EmotionRecorderEventIsar,
      QAfterFilterCondition> uuidBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'uuid',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmotionRecorderEventIsar, EmotionRecorderEventIsar,
      QAfterFilterCondition> uuidStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'uuid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmotionRecorderEventIsar, EmotionRecorderEventIsar,
      QAfterFilterCondition> uuidEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'uuid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmotionRecorderEventIsar, EmotionRecorderEventIsar,
          QAfterFilterCondition>
      uuidContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'uuid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmotionRecorderEventIsar, EmotionRecorderEventIsar,
          QAfterFilterCondition>
      uuidMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'uuid',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmotionRecorderEventIsar, EmotionRecorderEventIsar,
      QAfterFilterCondition> uuidIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'uuid',
        value: '',
      ));
    });
  }

  QueryBuilder<EmotionRecorderEventIsar, EmotionRecorderEventIsar,
      QAfterFilterCondition> uuidIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'uuid',
        value: '',
      ));
    });
  }
}

extension EmotionRecorderEventIsarQueryObject on QueryBuilder<
    EmotionRecorderEventIsar, EmotionRecorderEventIsar, QFilterCondition> {}

extension EmotionRecorderEventIsarQueryLinks on QueryBuilder<
    EmotionRecorderEventIsar, EmotionRecorderEventIsar, QFilterCondition> {}

extension EmotionRecorderEventIsarQuerySortBy on QueryBuilder<
    EmotionRecorderEventIsar, EmotionRecorderEventIsar, QSortBy> {
  QueryBuilder<EmotionRecorderEventIsar, EmotionRecorderEventIsar, QAfterSortBy>
      sortByDateTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dateTime', Sort.asc);
    });
  }

  QueryBuilder<EmotionRecorderEventIsar, EmotionRecorderEventIsar, QAfterSortBy>
      sortByDateTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dateTime', Sort.desc);
    });
  }

  QueryBuilder<EmotionRecorderEventIsar, EmotionRecorderEventIsar, QAfterSortBy>
      sortByEmoji() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'emoji', Sort.asc);
    });
  }

  QueryBuilder<EmotionRecorderEventIsar, EmotionRecorderEventIsar, QAfterSortBy>
      sortByEmojiDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'emoji', Sort.desc);
    });
  }

  QueryBuilder<EmotionRecorderEventIsar, EmotionRecorderEventIsar, QAfterSortBy>
      sortByEmotionName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'emotionName', Sort.asc);
    });
  }

  QueryBuilder<EmotionRecorderEventIsar, EmotionRecorderEventIsar, QAfterSortBy>
      sortByEmotionNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'emotionName', Sort.desc);
    });
  }

  QueryBuilder<EmotionRecorderEventIsar, EmotionRecorderEventIsar, QAfterSortBy>
      sortByUuid() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uuid', Sort.asc);
    });
  }

  QueryBuilder<EmotionRecorderEventIsar, EmotionRecorderEventIsar, QAfterSortBy>
      sortByUuidDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uuid', Sort.desc);
    });
  }
}

extension EmotionRecorderEventIsarQuerySortThenBy on QueryBuilder<
    EmotionRecorderEventIsar, EmotionRecorderEventIsar, QSortThenBy> {
  QueryBuilder<EmotionRecorderEventIsar, EmotionRecorderEventIsar, QAfterSortBy>
      thenByDateTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dateTime', Sort.asc);
    });
  }

  QueryBuilder<EmotionRecorderEventIsar, EmotionRecorderEventIsar, QAfterSortBy>
      thenByDateTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dateTime', Sort.desc);
    });
  }

  QueryBuilder<EmotionRecorderEventIsar, EmotionRecorderEventIsar, QAfterSortBy>
      thenByEmoji() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'emoji', Sort.asc);
    });
  }

  QueryBuilder<EmotionRecorderEventIsar, EmotionRecorderEventIsar, QAfterSortBy>
      thenByEmojiDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'emoji', Sort.desc);
    });
  }

  QueryBuilder<EmotionRecorderEventIsar, EmotionRecorderEventIsar, QAfterSortBy>
      thenByEmotionName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'emotionName', Sort.asc);
    });
  }

  QueryBuilder<EmotionRecorderEventIsar, EmotionRecorderEventIsar, QAfterSortBy>
      thenByEmotionNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'emotionName', Sort.desc);
    });
  }

  QueryBuilder<EmotionRecorderEventIsar, EmotionRecorderEventIsar, QAfterSortBy>
      thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<EmotionRecorderEventIsar, EmotionRecorderEventIsar, QAfterSortBy>
      thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<EmotionRecorderEventIsar, EmotionRecorderEventIsar, QAfterSortBy>
      thenByUuid() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uuid', Sort.asc);
    });
  }

  QueryBuilder<EmotionRecorderEventIsar, EmotionRecorderEventIsar, QAfterSortBy>
      thenByUuidDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uuid', Sort.desc);
    });
  }
}

extension EmotionRecorderEventIsarQueryWhereDistinct on QueryBuilder<
    EmotionRecorderEventIsar, EmotionRecorderEventIsar, QDistinct> {
  QueryBuilder<EmotionRecorderEventIsar, EmotionRecorderEventIsar, QDistinct>
      distinctByDateTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'dateTime');
    });
  }

  QueryBuilder<EmotionRecorderEventIsar, EmotionRecorderEventIsar, QDistinct>
      distinctByEmoji({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'emoji', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<EmotionRecorderEventIsar, EmotionRecorderEventIsar, QDistinct>
      distinctByEmotionName({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'emotionName', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<EmotionRecorderEventIsar, EmotionRecorderEventIsar, QDistinct>
      distinctByUuid({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'uuid', caseSensitive: caseSensitive);
    });
  }
}

extension EmotionRecorderEventIsarQueryProperty on QueryBuilder<
    EmotionRecorderEventIsar, EmotionRecorderEventIsar, QQueryProperty> {
  QueryBuilder<EmotionRecorderEventIsar, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<EmotionRecorderEventIsar, DateTime, QQueryOperations>
      dateTimeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'dateTime');
    });
  }

  QueryBuilder<EmotionRecorderEventIsar, String, QQueryOperations>
      emojiProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'emoji');
    });
  }

  QueryBuilder<EmotionRecorderEventIsar, String, QQueryOperations>
      emotionNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'emotionName');
    });
  }

  QueryBuilder<EmotionRecorderEventIsar, String, QQueryOperations>
      uuidProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'uuid');
    });
  }
}
