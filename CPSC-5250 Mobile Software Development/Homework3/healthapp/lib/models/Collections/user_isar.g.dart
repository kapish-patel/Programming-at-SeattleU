// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_isar.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetUserIsarCollection on Isar {
  IsarCollection<UserIsar> get userIsars => this.collection();
}

const UserIsarSchema = CollectionSchema(
  name: r'UserIsar',
  id: 1907786346797868586,
  properties: {
    r'decidationLevel': PropertySchema(
      id: 0,
      name: r'decidationLevel',
      type: IsarType.long,
    ),
    r'lastRecorded': PropertySchema(
      id: 1,
      name: r'lastRecorded',
      type: IsarType.dateTime,
    ),
    r'lastRecordedString': PropertySchema(
      id: 2,
      name: r'lastRecordedString',
      type: IsarType.string,
    ),
    r'recordingPoints': PropertySchema(
      id: 3,
      name: r'recordingPoints',
      type: IsarType.long,
    ),
    r'uuid': PropertySchema(
      id: 4,
      name: r'uuid',
      type: IsarType.string,
    )
  },
  estimateSize: _userIsarEstimateSize,
  serialize: _userIsarSerialize,
  deserialize: _userIsarDeserialize,
  deserializeProp: _userIsarDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _userIsarGetId,
  getLinks: _userIsarGetLinks,
  attach: _userIsarAttach,
  version: '3.1.0+1',
);

int _userIsarEstimateSize(
  UserIsar object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.lastRecordedString.length * 3;
  bytesCount += 3 + object.uuid.length * 3;
  return bytesCount;
}

void _userIsarSerialize(
  UserIsar object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.decidationLevel);
  writer.writeDateTime(offsets[1], object.lastRecorded);
  writer.writeString(offsets[2], object.lastRecordedString);
  writer.writeLong(offsets[3], object.recordingPoints);
  writer.writeString(offsets[4], object.uuid);
}

UserIsar _userIsarDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = UserIsar(
    reader.readLong(offsets[0]),
    reader.readLong(offsets[3]),
    reader.readDateTime(offsets[1]),
    reader.readString(offsets[2]),
    reader.readString(offsets[4]),
  );
  object.id = id;
  return object;
}

P _userIsarDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLong(offset)) as P;
    case 1:
      return (reader.readDateTime(offset)) as P;
    case 2:
      return (reader.readString(offset)) as P;
    case 3:
      return (reader.readLong(offset)) as P;
    case 4:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _userIsarGetId(UserIsar object) {
  return object.id ?? Isar.autoIncrement;
}

List<IsarLinkBase<dynamic>> _userIsarGetLinks(UserIsar object) {
  return [];
}

void _userIsarAttach(IsarCollection<dynamic> col, Id id, UserIsar object) {
  object.id = id;
}

extension UserIsarQueryWhereSort on QueryBuilder<UserIsar, UserIsar, QWhere> {
  QueryBuilder<UserIsar, UserIsar, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension UserIsarQueryWhere on QueryBuilder<UserIsar, UserIsar, QWhereClause> {
  QueryBuilder<UserIsar, UserIsar, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<UserIsar, UserIsar, QAfterWhereClause> idNotEqualTo(Id id) {
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

  QueryBuilder<UserIsar, UserIsar, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<UserIsar, UserIsar, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<UserIsar, UserIsar, QAfterWhereClause> idBetween(
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

extension UserIsarQueryFilter
    on QueryBuilder<UserIsar, UserIsar, QFilterCondition> {
  QueryBuilder<UserIsar, UserIsar, QAfterFilterCondition>
      decidationLevelEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'decidationLevel',
        value: value,
      ));
    });
  }

  QueryBuilder<UserIsar, UserIsar, QAfterFilterCondition>
      decidationLevelGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'decidationLevel',
        value: value,
      ));
    });
  }

  QueryBuilder<UserIsar, UserIsar, QAfterFilterCondition>
      decidationLevelLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'decidationLevel',
        value: value,
      ));
    });
  }

  QueryBuilder<UserIsar, UserIsar, QAfterFilterCondition>
      decidationLevelBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'decidationLevel',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<UserIsar, UserIsar, QAfterFilterCondition> idIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'id',
      ));
    });
  }

  QueryBuilder<UserIsar, UserIsar, QAfterFilterCondition> idIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'id',
      ));
    });
  }

  QueryBuilder<UserIsar, UserIsar, QAfterFilterCondition> idEqualTo(Id? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<UserIsar, UserIsar, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<UserIsar, UserIsar, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<UserIsar, UserIsar, QAfterFilterCondition> idBetween(
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

  QueryBuilder<UserIsar, UserIsar, QAfterFilterCondition> lastRecordedEqualTo(
      DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lastRecorded',
        value: value,
      ));
    });
  }

  QueryBuilder<UserIsar, UserIsar, QAfterFilterCondition>
      lastRecordedGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'lastRecorded',
        value: value,
      ));
    });
  }

  QueryBuilder<UserIsar, UserIsar, QAfterFilterCondition> lastRecordedLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'lastRecorded',
        value: value,
      ));
    });
  }

  QueryBuilder<UserIsar, UserIsar, QAfterFilterCondition> lastRecordedBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'lastRecorded',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<UserIsar, UserIsar, QAfterFilterCondition>
      lastRecordedStringEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lastRecordedString',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserIsar, UserIsar, QAfterFilterCondition>
      lastRecordedStringGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'lastRecordedString',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserIsar, UserIsar, QAfterFilterCondition>
      lastRecordedStringLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'lastRecordedString',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserIsar, UserIsar, QAfterFilterCondition>
      lastRecordedStringBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'lastRecordedString',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserIsar, UserIsar, QAfterFilterCondition>
      lastRecordedStringStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'lastRecordedString',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserIsar, UserIsar, QAfterFilterCondition>
      lastRecordedStringEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'lastRecordedString',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserIsar, UserIsar, QAfterFilterCondition>
      lastRecordedStringContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'lastRecordedString',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserIsar, UserIsar, QAfterFilterCondition>
      lastRecordedStringMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'lastRecordedString',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserIsar, UserIsar, QAfterFilterCondition>
      lastRecordedStringIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lastRecordedString',
        value: '',
      ));
    });
  }

  QueryBuilder<UserIsar, UserIsar, QAfterFilterCondition>
      lastRecordedStringIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'lastRecordedString',
        value: '',
      ));
    });
  }

  QueryBuilder<UserIsar, UserIsar, QAfterFilterCondition>
      recordingPointsEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'recordingPoints',
        value: value,
      ));
    });
  }

  QueryBuilder<UserIsar, UserIsar, QAfterFilterCondition>
      recordingPointsGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'recordingPoints',
        value: value,
      ));
    });
  }

  QueryBuilder<UserIsar, UserIsar, QAfterFilterCondition>
      recordingPointsLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'recordingPoints',
        value: value,
      ));
    });
  }

  QueryBuilder<UserIsar, UserIsar, QAfterFilterCondition>
      recordingPointsBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'recordingPoints',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<UserIsar, UserIsar, QAfterFilterCondition> uuidEqualTo(
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

  QueryBuilder<UserIsar, UserIsar, QAfterFilterCondition> uuidGreaterThan(
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

  QueryBuilder<UserIsar, UserIsar, QAfterFilterCondition> uuidLessThan(
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

  QueryBuilder<UserIsar, UserIsar, QAfterFilterCondition> uuidBetween(
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

  QueryBuilder<UserIsar, UserIsar, QAfterFilterCondition> uuidStartsWith(
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

  QueryBuilder<UserIsar, UserIsar, QAfterFilterCondition> uuidEndsWith(
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

  QueryBuilder<UserIsar, UserIsar, QAfterFilterCondition> uuidContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'uuid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserIsar, UserIsar, QAfterFilterCondition> uuidMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'uuid',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserIsar, UserIsar, QAfterFilterCondition> uuidIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'uuid',
        value: '',
      ));
    });
  }

  QueryBuilder<UserIsar, UserIsar, QAfterFilterCondition> uuidIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'uuid',
        value: '',
      ));
    });
  }
}

extension UserIsarQueryObject
    on QueryBuilder<UserIsar, UserIsar, QFilterCondition> {}

extension UserIsarQueryLinks
    on QueryBuilder<UserIsar, UserIsar, QFilterCondition> {}

extension UserIsarQuerySortBy on QueryBuilder<UserIsar, UserIsar, QSortBy> {
  QueryBuilder<UserIsar, UserIsar, QAfterSortBy> sortByDecidationLevel() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'decidationLevel', Sort.asc);
    });
  }

  QueryBuilder<UserIsar, UserIsar, QAfterSortBy> sortByDecidationLevelDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'decidationLevel', Sort.desc);
    });
  }

  QueryBuilder<UserIsar, UserIsar, QAfterSortBy> sortByLastRecorded() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastRecorded', Sort.asc);
    });
  }

  QueryBuilder<UserIsar, UserIsar, QAfterSortBy> sortByLastRecordedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastRecorded', Sort.desc);
    });
  }

  QueryBuilder<UserIsar, UserIsar, QAfterSortBy> sortByLastRecordedString() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastRecordedString', Sort.asc);
    });
  }

  QueryBuilder<UserIsar, UserIsar, QAfterSortBy>
      sortByLastRecordedStringDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastRecordedString', Sort.desc);
    });
  }

  QueryBuilder<UserIsar, UserIsar, QAfterSortBy> sortByRecordingPoints() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'recordingPoints', Sort.asc);
    });
  }

  QueryBuilder<UserIsar, UserIsar, QAfterSortBy> sortByRecordingPointsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'recordingPoints', Sort.desc);
    });
  }

  QueryBuilder<UserIsar, UserIsar, QAfterSortBy> sortByUuid() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uuid', Sort.asc);
    });
  }

  QueryBuilder<UserIsar, UserIsar, QAfterSortBy> sortByUuidDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uuid', Sort.desc);
    });
  }
}

extension UserIsarQuerySortThenBy
    on QueryBuilder<UserIsar, UserIsar, QSortThenBy> {
  QueryBuilder<UserIsar, UserIsar, QAfterSortBy> thenByDecidationLevel() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'decidationLevel', Sort.asc);
    });
  }

  QueryBuilder<UserIsar, UserIsar, QAfterSortBy> thenByDecidationLevelDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'decidationLevel', Sort.desc);
    });
  }

  QueryBuilder<UserIsar, UserIsar, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<UserIsar, UserIsar, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<UserIsar, UserIsar, QAfterSortBy> thenByLastRecorded() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastRecorded', Sort.asc);
    });
  }

  QueryBuilder<UserIsar, UserIsar, QAfterSortBy> thenByLastRecordedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastRecorded', Sort.desc);
    });
  }

  QueryBuilder<UserIsar, UserIsar, QAfterSortBy> thenByLastRecordedString() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastRecordedString', Sort.asc);
    });
  }

  QueryBuilder<UserIsar, UserIsar, QAfterSortBy>
      thenByLastRecordedStringDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastRecordedString', Sort.desc);
    });
  }

  QueryBuilder<UserIsar, UserIsar, QAfterSortBy> thenByRecordingPoints() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'recordingPoints', Sort.asc);
    });
  }

  QueryBuilder<UserIsar, UserIsar, QAfterSortBy> thenByRecordingPointsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'recordingPoints', Sort.desc);
    });
  }

  QueryBuilder<UserIsar, UserIsar, QAfterSortBy> thenByUuid() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uuid', Sort.asc);
    });
  }

  QueryBuilder<UserIsar, UserIsar, QAfterSortBy> thenByUuidDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uuid', Sort.desc);
    });
  }
}

extension UserIsarQueryWhereDistinct
    on QueryBuilder<UserIsar, UserIsar, QDistinct> {
  QueryBuilder<UserIsar, UserIsar, QDistinct> distinctByDecidationLevel() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'decidationLevel');
    });
  }

  QueryBuilder<UserIsar, UserIsar, QDistinct> distinctByLastRecorded() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'lastRecorded');
    });
  }

  QueryBuilder<UserIsar, UserIsar, QDistinct> distinctByLastRecordedString(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'lastRecordedString',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UserIsar, UserIsar, QDistinct> distinctByRecordingPoints() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'recordingPoints');
    });
  }

  QueryBuilder<UserIsar, UserIsar, QDistinct> distinctByUuid(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'uuid', caseSensitive: caseSensitive);
    });
  }
}

extension UserIsarQueryProperty
    on QueryBuilder<UserIsar, UserIsar, QQueryProperty> {
  QueryBuilder<UserIsar, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<UserIsar, int, QQueryOperations> decidationLevelProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'decidationLevel');
    });
  }

  QueryBuilder<UserIsar, DateTime, QQueryOperations> lastRecordedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'lastRecorded');
    });
  }

  QueryBuilder<UserIsar, String, QQueryOperations>
      lastRecordedStringProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'lastRecordedString');
    });
  }

  QueryBuilder<UserIsar, int, QQueryOperations> recordingPointsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'recordingPoints');
    });
  }

  QueryBuilder<UserIsar, String, QQueryOperations> uuidProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'uuid');
    });
  }
}
