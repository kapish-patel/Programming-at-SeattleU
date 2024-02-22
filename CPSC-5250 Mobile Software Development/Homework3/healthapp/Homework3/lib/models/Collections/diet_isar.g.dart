// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'diet_isar.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetDietRecorderEventIsarCollection on Isar {
  IsarCollection<DietRecorderEventIsar> get dietRecorderEventIsars =>
      this.collection();
}

const DietRecorderEventIsarSchema = CollectionSchema(
  name: r'DietRecorderEventIsar',
  id: -2311970921063456077,
  properties: {
    r'calories': PropertySchema(
      id: 0,
      name: r'calories',
      type: IsarType.long,
    ),
    r'dateTime': PropertySchema(
      id: 1,
      name: r'dateTime',
      type: IsarType.dateTime,
    ),
    r'mealname': PropertySchema(
      id: 2,
      name: r'mealname',
      type: IsarType.string,
    ),
    r'quantity': PropertySchema(
      id: 3,
      name: r'quantity',
      type: IsarType.long,
    ),
    r'uuid': PropertySchema(
      id: 4,
      name: r'uuid',
      type: IsarType.string,
    )
  },
  estimateSize: _dietRecorderEventIsarEstimateSize,
  serialize: _dietRecorderEventIsarSerialize,
  deserialize: _dietRecorderEventIsarDeserialize,
  deserializeProp: _dietRecorderEventIsarDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _dietRecorderEventIsarGetId,
  getLinks: _dietRecorderEventIsarGetLinks,
  attach: _dietRecorderEventIsarAttach,
  version: '3.1.0+1',
);

int _dietRecorderEventIsarEstimateSize(
  DietRecorderEventIsar object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.mealname.length * 3;
  bytesCount += 3 + object.uuid.length * 3;
  return bytesCount;
}

void _dietRecorderEventIsarSerialize(
  DietRecorderEventIsar object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.calories);
  writer.writeDateTime(offsets[1], object.dateTime);
  writer.writeString(offsets[2], object.mealname);
  writer.writeLong(offsets[3], object.quantity);
  writer.writeString(offsets[4], object.uuid);
}

DietRecorderEventIsar _dietRecorderEventIsarDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = DietRecorderEventIsar(
    reader.readString(offsets[2]),
    reader.readLong(offsets[3]),
    reader.readLong(offsets[0]),
    reader.readDateTime(offsets[1]),
    reader.readString(offsets[4]),
  );
  object.id = id;
  return object;
}

P _dietRecorderEventIsarDeserializeProp<P>(
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

Id _dietRecorderEventIsarGetId(DietRecorderEventIsar object) {
  return object.id ?? Isar.autoIncrement;
}

List<IsarLinkBase<dynamic>> _dietRecorderEventIsarGetLinks(
    DietRecorderEventIsar object) {
  return [];
}

void _dietRecorderEventIsarAttach(
    IsarCollection<dynamic> col, Id id, DietRecorderEventIsar object) {
  object.id = id;
}

extension DietRecorderEventIsarQueryWhereSort
    on QueryBuilder<DietRecorderEventIsar, DietRecorderEventIsar, QWhere> {
  QueryBuilder<DietRecorderEventIsar, DietRecorderEventIsar, QAfterWhere>
      anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension DietRecorderEventIsarQueryWhere on QueryBuilder<DietRecorderEventIsar,
    DietRecorderEventIsar, QWhereClause> {
  QueryBuilder<DietRecorderEventIsar, DietRecorderEventIsar, QAfterWhereClause>
      idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<DietRecorderEventIsar, DietRecorderEventIsar, QAfterWhereClause>
      idNotEqualTo(Id id) {
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

  QueryBuilder<DietRecorderEventIsar, DietRecorderEventIsar, QAfterWhereClause>
      idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<DietRecorderEventIsar, DietRecorderEventIsar, QAfterWhereClause>
      idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<DietRecorderEventIsar, DietRecorderEventIsar, QAfterWhereClause>
      idBetween(
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

extension DietRecorderEventIsarQueryFilter on QueryBuilder<
    DietRecorderEventIsar, DietRecorderEventIsar, QFilterCondition> {
  QueryBuilder<DietRecorderEventIsar, DietRecorderEventIsar,
      QAfterFilterCondition> caloriesEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'calories',
        value: value,
      ));
    });
  }

  QueryBuilder<DietRecorderEventIsar, DietRecorderEventIsar,
      QAfterFilterCondition> caloriesGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'calories',
        value: value,
      ));
    });
  }

  QueryBuilder<DietRecorderEventIsar, DietRecorderEventIsar,
      QAfterFilterCondition> caloriesLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'calories',
        value: value,
      ));
    });
  }

  QueryBuilder<DietRecorderEventIsar, DietRecorderEventIsar,
      QAfterFilterCondition> caloriesBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'calories',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<DietRecorderEventIsar, DietRecorderEventIsar,
      QAfterFilterCondition> dateTimeEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'dateTime',
        value: value,
      ));
    });
  }

  QueryBuilder<DietRecorderEventIsar, DietRecorderEventIsar,
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

  QueryBuilder<DietRecorderEventIsar, DietRecorderEventIsar,
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

  QueryBuilder<DietRecorderEventIsar, DietRecorderEventIsar,
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

  QueryBuilder<DietRecorderEventIsar, DietRecorderEventIsar,
      QAfterFilterCondition> idIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'id',
      ));
    });
  }

  QueryBuilder<DietRecorderEventIsar, DietRecorderEventIsar,
      QAfterFilterCondition> idIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'id',
      ));
    });
  }

  QueryBuilder<DietRecorderEventIsar, DietRecorderEventIsar,
      QAfterFilterCondition> idEqualTo(Id? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<DietRecorderEventIsar, DietRecorderEventIsar,
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

  QueryBuilder<DietRecorderEventIsar, DietRecorderEventIsar,
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

  QueryBuilder<DietRecorderEventIsar, DietRecorderEventIsar,
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

  QueryBuilder<DietRecorderEventIsar, DietRecorderEventIsar,
      QAfterFilterCondition> mealnameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'mealname',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DietRecorderEventIsar, DietRecorderEventIsar,
      QAfterFilterCondition> mealnameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'mealname',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DietRecorderEventIsar, DietRecorderEventIsar,
      QAfterFilterCondition> mealnameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'mealname',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DietRecorderEventIsar, DietRecorderEventIsar,
      QAfterFilterCondition> mealnameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'mealname',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DietRecorderEventIsar, DietRecorderEventIsar,
      QAfterFilterCondition> mealnameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'mealname',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DietRecorderEventIsar, DietRecorderEventIsar,
      QAfterFilterCondition> mealnameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'mealname',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DietRecorderEventIsar, DietRecorderEventIsar,
          QAfterFilterCondition>
      mealnameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'mealname',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DietRecorderEventIsar, DietRecorderEventIsar,
          QAfterFilterCondition>
      mealnameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'mealname',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DietRecorderEventIsar, DietRecorderEventIsar,
      QAfterFilterCondition> mealnameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'mealname',
        value: '',
      ));
    });
  }

  QueryBuilder<DietRecorderEventIsar, DietRecorderEventIsar,
      QAfterFilterCondition> mealnameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'mealname',
        value: '',
      ));
    });
  }

  QueryBuilder<DietRecorderEventIsar, DietRecorderEventIsar,
      QAfterFilterCondition> quantityEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'quantity',
        value: value,
      ));
    });
  }

  QueryBuilder<DietRecorderEventIsar, DietRecorderEventIsar,
      QAfterFilterCondition> quantityGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'quantity',
        value: value,
      ));
    });
  }

  QueryBuilder<DietRecorderEventIsar, DietRecorderEventIsar,
      QAfterFilterCondition> quantityLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'quantity',
        value: value,
      ));
    });
  }

  QueryBuilder<DietRecorderEventIsar, DietRecorderEventIsar,
      QAfterFilterCondition> quantityBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'quantity',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<DietRecorderEventIsar, DietRecorderEventIsar,
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

  QueryBuilder<DietRecorderEventIsar, DietRecorderEventIsar,
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

  QueryBuilder<DietRecorderEventIsar, DietRecorderEventIsar,
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

  QueryBuilder<DietRecorderEventIsar, DietRecorderEventIsar,
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

  QueryBuilder<DietRecorderEventIsar, DietRecorderEventIsar,
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

  QueryBuilder<DietRecorderEventIsar, DietRecorderEventIsar,
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

  QueryBuilder<DietRecorderEventIsar, DietRecorderEventIsar,
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

  QueryBuilder<DietRecorderEventIsar, DietRecorderEventIsar,
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

  QueryBuilder<DietRecorderEventIsar, DietRecorderEventIsar,
      QAfterFilterCondition> uuidIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'uuid',
        value: '',
      ));
    });
  }

  QueryBuilder<DietRecorderEventIsar, DietRecorderEventIsar,
      QAfterFilterCondition> uuidIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'uuid',
        value: '',
      ));
    });
  }
}

extension DietRecorderEventIsarQueryObject on QueryBuilder<
    DietRecorderEventIsar, DietRecorderEventIsar, QFilterCondition> {}

extension DietRecorderEventIsarQueryLinks on QueryBuilder<DietRecorderEventIsar,
    DietRecorderEventIsar, QFilterCondition> {}

extension DietRecorderEventIsarQuerySortBy
    on QueryBuilder<DietRecorderEventIsar, DietRecorderEventIsar, QSortBy> {
  QueryBuilder<DietRecorderEventIsar, DietRecorderEventIsar, QAfterSortBy>
      sortByCalories() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'calories', Sort.asc);
    });
  }

  QueryBuilder<DietRecorderEventIsar, DietRecorderEventIsar, QAfterSortBy>
      sortByCaloriesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'calories', Sort.desc);
    });
  }

  QueryBuilder<DietRecorderEventIsar, DietRecorderEventIsar, QAfterSortBy>
      sortByDateTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dateTime', Sort.asc);
    });
  }

  QueryBuilder<DietRecorderEventIsar, DietRecorderEventIsar, QAfterSortBy>
      sortByDateTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dateTime', Sort.desc);
    });
  }

  QueryBuilder<DietRecorderEventIsar, DietRecorderEventIsar, QAfterSortBy>
      sortByMealname() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mealname', Sort.asc);
    });
  }

  QueryBuilder<DietRecorderEventIsar, DietRecorderEventIsar, QAfterSortBy>
      sortByMealnameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mealname', Sort.desc);
    });
  }

  QueryBuilder<DietRecorderEventIsar, DietRecorderEventIsar, QAfterSortBy>
      sortByQuantity() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'quantity', Sort.asc);
    });
  }

  QueryBuilder<DietRecorderEventIsar, DietRecorderEventIsar, QAfterSortBy>
      sortByQuantityDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'quantity', Sort.desc);
    });
  }

  QueryBuilder<DietRecorderEventIsar, DietRecorderEventIsar, QAfterSortBy>
      sortByUuid() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uuid', Sort.asc);
    });
  }

  QueryBuilder<DietRecorderEventIsar, DietRecorderEventIsar, QAfterSortBy>
      sortByUuidDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uuid', Sort.desc);
    });
  }
}

extension DietRecorderEventIsarQuerySortThenBy
    on QueryBuilder<DietRecorderEventIsar, DietRecorderEventIsar, QSortThenBy> {
  QueryBuilder<DietRecorderEventIsar, DietRecorderEventIsar, QAfterSortBy>
      thenByCalories() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'calories', Sort.asc);
    });
  }

  QueryBuilder<DietRecorderEventIsar, DietRecorderEventIsar, QAfterSortBy>
      thenByCaloriesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'calories', Sort.desc);
    });
  }

  QueryBuilder<DietRecorderEventIsar, DietRecorderEventIsar, QAfterSortBy>
      thenByDateTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dateTime', Sort.asc);
    });
  }

  QueryBuilder<DietRecorderEventIsar, DietRecorderEventIsar, QAfterSortBy>
      thenByDateTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dateTime', Sort.desc);
    });
  }

  QueryBuilder<DietRecorderEventIsar, DietRecorderEventIsar, QAfterSortBy>
      thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<DietRecorderEventIsar, DietRecorderEventIsar, QAfterSortBy>
      thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<DietRecorderEventIsar, DietRecorderEventIsar, QAfterSortBy>
      thenByMealname() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mealname', Sort.asc);
    });
  }

  QueryBuilder<DietRecorderEventIsar, DietRecorderEventIsar, QAfterSortBy>
      thenByMealnameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mealname', Sort.desc);
    });
  }

  QueryBuilder<DietRecorderEventIsar, DietRecorderEventIsar, QAfterSortBy>
      thenByQuantity() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'quantity', Sort.asc);
    });
  }

  QueryBuilder<DietRecorderEventIsar, DietRecorderEventIsar, QAfterSortBy>
      thenByQuantityDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'quantity', Sort.desc);
    });
  }

  QueryBuilder<DietRecorderEventIsar, DietRecorderEventIsar, QAfterSortBy>
      thenByUuid() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uuid', Sort.asc);
    });
  }

  QueryBuilder<DietRecorderEventIsar, DietRecorderEventIsar, QAfterSortBy>
      thenByUuidDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uuid', Sort.desc);
    });
  }
}

extension DietRecorderEventIsarQueryWhereDistinct
    on QueryBuilder<DietRecorderEventIsar, DietRecorderEventIsar, QDistinct> {
  QueryBuilder<DietRecorderEventIsar, DietRecorderEventIsar, QDistinct>
      distinctByCalories() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'calories');
    });
  }

  QueryBuilder<DietRecorderEventIsar, DietRecorderEventIsar, QDistinct>
      distinctByDateTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'dateTime');
    });
  }

  QueryBuilder<DietRecorderEventIsar, DietRecorderEventIsar, QDistinct>
      distinctByMealname({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'mealname', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<DietRecorderEventIsar, DietRecorderEventIsar, QDistinct>
      distinctByQuantity() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'quantity');
    });
  }

  QueryBuilder<DietRecorderEventIsar, DietRecorderEventIsar, QDistinct>
      distinctByUuid({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'uuid', caseSensitive: caseSensitive);
    });
  }
}

extension DietRecorderEventIsarQueryProperty on QueryBuilder<
    DietRecorderEventIsar, DietRecorderEventIsar, QQueryProperty> {
  QueryBuilder<DietRecorderEventIsar, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<DietRecorderEventIsar, int, QQueryOperations>
      caloriesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'calories');
    });
  }

  QueryBuilder<DietRecorderEventIsar, DateTime, QQueryOperations>
      dateTimeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'dateTime');
    });
  }

  QueryBuilder<DietRecorderEventIsar, String, QQueryOperations>
      mealnameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'mealname');
    });
  }

  QueryBuilder<DietRecorderEventIsar, int, QQueryOperations>
      quantityProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'quantity');
    });
  }

  QueryBuilder<DietRecorderEventIsar, String, QQueryOperations> uuidProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'uuid');
    });
  }
}
