// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fnb_collections.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetRestaurantFloorCollectionCollection on Isar {
  IsarCollection<RestaurantFloorCollection> get restaurantFloorCollections =>
      this.collection();
}

const RestaurantFloorCollectionSchema = CollectionSchema(
  name: r'RestaurantFloorCollection',
  id: (3838010049610 * 1000000 + 36186),
  properties: {
    r'isActive': PropertySchema(
      id: 0,
      name: r'isActive',
      type: IsarType.bool,
    ),
    r'name': PropertySchema(
      id: 1,
      name: r'name',
      type: IsarType.string,
    ),
    r'sortOrder': PropertySchema(
      id: 2,
      name: r'sortOrder',
      type: IsarType.long,
    ),
    r'uuid': PropertySchema(
      id: 3,
      name: r'uuid',
      type: IsarType.string,
    )
  },
  estimateSize: _restaurantFloorCollectionEstimateSize,
  serialize: _restaurantFloorCollectionSerialize,
  deserialize: _restaurantFloorCollectionDeserialize,
  deserializeProp: _restaurantFloorCollectionDeserializeProp,
  idName: r'id',
  indexes: {
    r'uuid': IndexSchema(
      id: (2134397340427 * 1000000 + 724972),
      name: r'uuid',
      unique: true,
      replace: true,
      properties: [
        IndexPropertySchema(
          name: r'uuid',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    ),
    r'name': IndexSchema(
      id: (879695947855 * 1000000 + 722453),
      name: r'name',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'name',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _restaurantFloorCollectionGetId,
  getLinks: _restaurantFloorCollectionGetLinks,
  attach: _restaurantFloorCollectionAttach,
  version: '3.1.0+1',
);

int _restaurantFloorCollectionEstimateSize(
  RestaurantFloorCollection object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.name.length * 3;
  bytesCount += 3 + object.uuid.length * 3;
  return bytesCount;
}

void _restaurantFloorCollectionSerialize(
  RestaurantFloorCollection object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeBool(offsets[0], object.isActive);
  writer.writeString(offsets[1], object.name);
  writer.writeLong(offsets[2], object.sortOrder);
  writer.writeString(offsets[3], object.uuid);
}

RestaurantFloorCollection _restaurantFloorCollectionDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = RestaurantFloorCollection();
  object.id = id;
  object.isActive = reader.readBool(offsets[0]);
  object.name = reader.readString(offsets[1]);
  object.sortOrder = reader.readLong(offsets[2]);
  object.uuid = reader.readString(offsets[3]);
  return object;
}

P _restaurantFloorCollectionDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readBool(offset)) as P;
    case 1:
      return (reader.readString(offset)) as P;
    case 2:
      return (reader.readLong(offset)) as P;
    case 3:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _restaurantFloorCollectionGetId(RestaurantFloorCollection object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _restaurantFloorCollectionGetLinks(
    RestaurantFloorCollection object) {
  return [];
}

void _restaurantFloorCollectionAttach(
    IsarCollection<dynamic> col, Id id, RestaurantFloorCollection object) {
  object.id = id;
}

extension RestaurantFloorCollectionByIndex
    on IsarCollection<RestaurantFloorCollection> {
  Future<RestaurantFloorCollection?> getByUuid(String uuid) {
    return getByIndex(r'uuid', [uuid]);
  }

  RestaurantFloorCollection? getByUuidSync(String uuid) {
    return getByIndexSync(r'uuid', [uuid]);
  }

  Future<bool> deleteByUuid(String uuid) {
    return deleteByIndex(r'uuid', [uuid]);
  }

  bool deleteByUuidSync(String uuid) {
    return deleteByIndexSync(r'uuid', [uuid]);
  }

  Future<List<RestaurantFloorCollection?>> getAllByUuid(
      List<String> uuidValues) {
    final values = uuidValues.map((e) => [e]).toList();
    return getAllByIndex(r'uuid', values);
  }

  List<RestaurantFloorCollection?> getAllByUuidSync(List<String> uuidValues) {
    final values = uuidValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'uuid', values);
  }

  Future<int> deleteAllByUuid(List<String> uuidValues) {
    final values = uuidValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'uuid', values);
  }

  int deleteAllByUuidSync(List<String> uuidValues) {
    final values = uuidValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'uuid', values);
  }

  Future<Id> putByUuid(RestaurantFloorCollection object) {
    return putByIndex(r'uuid', object);
  }

  Id putByUuidSync(RestaurantFloorCollection object, {bool saveLinks = true}) {
    return putByIndexSync(r'uuid', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByUuid(List<RestaurantFloorCollection> objects) {
    return putAllByIndex(r'uuid', objects);
  }

  List<Id> putAllByUuidSync(List<RestaurantFloorCollection> objects,
      {bool saveLinks = true}) {
    return putAllByIndexSync(r'uuid', objects, saveLinks: saveLinks);
  }
}

extension RestaurantFloorCollectionQueryWhereSort on QueryBuilder<
    RestaurantFloorCollection, RestaurantFloorCollection, QWhere> {
  QueryBuilder<RestaurantFloorCollection, RestaurantFloorCollection,
      QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension RestaurantFloorCollectionQueryWhere on QueryBuilder<
    RestaurantFloorCollection, RestaurantFloorCollection, QWhereClause> {
  QueryBuilder<RestaurantFloorCollection, RestaurantFloorCollection,
      QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<RestaurantFloorCollection, RestaurantFloorCollection,
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

  QueryBuilder<RestaurantFloorCollection, RestaurantFloorCollection,
      QAfterWhereClause> idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<RestaurantFloorCollection, RestaurantFloorCollection,
      QAfterWhereClause> idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<RestaurantFloorCollection, RestaurantFloorCollection,
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

  QueryBuilder<RestaurantFloorCollection, RestaurantFloorCollection,
      QAfterWhereClause> uuidEqualTo(String uuid) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'uuid',
        value: [uuid],
      ));
    });
  }

  QueryBuilder<RestaurantFloorCollection, RestaurantFloorCollection,
      QAfterWhereClause> uuidNotEqualTo(String uuid) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'uuid',
              lower: [],
              upper: [uuid],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'uuid',
              lower: [uuid],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'uuid',
              lower: [uuid],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'uuid',
              lower: [],
              upper: [uuid],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<RestaurantFloorCollection, RestaurantFloorCollection,
      QAfterWhereClause> nameEqualTo(String name) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'name',
        value: [name],
      ));
    });
  }

  QueryBuilder<RestaurantFloorCollection, RestaurantFloorCollection,
      QAfterWhereClause> nameNotEqualTo(String name) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'name',
              lower: [],
              upper: [name],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'name',
              lower: [name],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'name',
              lower: [name],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'name',
              lower: [],
              upper: [name],
              includeUpper: false,
            ));
      }
    });
  }
}

extension RestaurantFloorCollectionQueryFilter on QueryBuilder<
    RestaurantFloorCollection, RestaurantFloorCollection, QFilterCondition> {
  QueryBuilder<RestaurantFloorCollection, RestaurantFloorCollection,
      QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<RestaurantFloorCollection, RestaurantFloorCollection,
      QAfterFilterCondition> idGreaterThan(
    Id value, {
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

  QueryBuilder<RestaurantFloorCollection, RestaurantFloorCollection,
      QAfterFilterCondition> idLessThan(
    Id value, {
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

  QueryBuilder<RestaurantFloorCollection, RestaurantFloorCollection,
      QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
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

  QueryBuilder<RestaurantFloorCollection, RestaurantFloorCollection,
      QAfterFilterCondition> isActiveEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isActive',
        value: value,
      ));
    });
  }

  QueryBuilder<RestaurantFloorCollection, RestaurantFloorCollection,
      QAfterFilterCondition> nameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RestaurantFloorCollection, RestaurantFloorCollection,
      QAfterFilterCondition> nameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RestaurantFloorCollection, RestaurantFloorCollection,
      QAfterFilterCondition> nameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RestaurantFloorCollection, RestaurantFloorCollection,
      QAfterFilterCondition> nameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'name',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RestaurantFloorCollection, RestaurantFloorCollection,
      QAfterFilterCondition> nameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RestaurantFloorCollection, RestaurantFloorCollection,
      QAfterFilterCondition> nameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RestaurantFloorCollection, RestaurantFloorCollection,
          QAfterFilterCondition>
      nameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RestaurantFloorCollection, RestaurantFloorCollection,
          QAfterFilterCondition>
      nameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'name',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RestaurantFloorCollection, RestaurantFloorCollection,
      QAfterFilterCondition> nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<RestaurantFloorCollection, RestaurantFloorCollection,
      QAfterFilterCondition> nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<RestaurantFloorCollection, RestaurantFloorCollection,
      QAfterFilterCondition> sortOrderEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'sortOrder',
        value: value,
      ));
    });
  }

  QueryBuilder<RestaurantFloorCollection, RestaurantFloorCollection,
      QAfterFilterCondition> sortOrderGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'sortOrder',
        value: value,
      ));
    });
  }

  QueryBuilder<RestaurantFloorCollection, RestaurantFloorCollection,
      QAfterFilterCondition> sortOrderLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'sortOrder',
        value: value,
      ));
    });
  }

  QueryBuilder<RestaurantFloorCollection, RestaurantFloorCollection,
      QAfterFilterCondition> sortOrderBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'sortOrder',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<RestaurantFloorCollection, RestaurantFloorCollection,
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

  QueryBuilder<RestaurantFloorCollection, RestaurantFloorCollection,
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

  QueryBuilder<RestaurantFloorCollection, RestaurantFloorCollection,
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

  QueryBuilder<RestaurantFloorCollection, RestaurantFloorCollection,
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

  QueryBuilder<RestaurantFloorCollection, RestaurantFloorCollection,
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

  QueryBuilder<RestaurantFloorCollection, RestaurantFloorCollection,
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

  QueryBuilder<RestaurantFloorCollection, RestaurantFloorCollection,
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

  QueryBuilder<RestaurantFloorCollection, RestaurantFloorCollection,
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

  QueryBuilder<RestaurantFloorCollection, RestaurantFloorCollection,
      QAfterFilterCondition> uuidIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'uuid',
        value: '',
      ));
    });
  }

  QueryBuilder<RestaurantFloorCollection, RestaurantFloorCollection,
      QAfterFilterCondition> uuidIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'uuid',
        value: '',
      ));
    });
  }
}

extension RestaurantFloorCollectionQueryObject on QueryBuilder<
    RestaurantFloorCollection, RestaurantFloorCollection, QFilterCondition> {}

extension RestaurantFloorCollectionQueryLinks on QueryBuilder<
    RestaurantFloorCollection, RestaurantFloorCollection, QFilterCondition> {}

extension RestaurantFloorCollectionQuerySortBy on QueryBuilder<
    RestaurantFloorCollection, RestaurantFloorCollection, QSortBy> {
  QueryBuilder<RestaurantFloorCollection, RestaurantFloorCollection,
      QAfterSortBy> sortByIsActive() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isActive', Sort.asc);
    });
  }

  QueryBuilder<RestaurantFloorCollection, RestaurantFloorCollection,
      QAfterSortBy> sortByIsActiveDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isActive', Sort.desc);
    });
  }

  QueryBuilder<RestaurantFloorCollection, RestaurantFloorCollection,
      QAfterSortBy> sortByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<RestaurantFloorCollection, RestaurantFloorCollection,
      QAfterSortBy> sortByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<RestaurantFloorCollection, RestaurantFloorCollection,
      QAfterSortBy> sortBySortOrder() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sortOrder', Sort.asc);
    });
  }

  QueryBuilder<RestaurantFloorCollection, RestaurantFloorCollection,
      QAfterSortBy> sortBySortOrderDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sortOrder', Sort.desc);
    });
  }

  QueryBuilder<RestaurantFloorCollection, RestaurantFloorCollection,
      QAfterSortBy> sortByUuid() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uuid', Sort.asc);
    });
  }

  QueryBuilder<RestaurantFloorCollection, RestaurantFloorCollection,
      QAfterSortBy> sortByUuidDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uuid', Sort.desc);
    });
  }
}

extension RestaurantFloorCollectionQuerySortThenBy on QueryBuilder<
    RestaurantFloorCollection, RestaurantFloorCollection, QSortThenBy> {
  QueryBuilder<RestaurantFloorCollection, RestaurantFloorCollection,
      QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<RestaurantFloorCollection, RestaurantFloorCollection,
      QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<RestaurantFloorCollection, RestaurantFloorCollection,
      QAfterSortBy> thenByIsActive() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isActive', Sort.asc);
    });
  }

  QueryBuilder<RestaurantFloorCollection, RestaurantFloorCollection,
      QAfterSortBy> thenByIsActiveDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isActive', Sort.desc);
    });
  }

  QueryBuilder<RestaurantFloorCollection, RestaurantFloorCollection,
      QAfterSortBy> thenByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<RestaurantFloorCollection, RestaurantFloorCollection,
      QAfterSortBy> thenByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<RestaurantFloorCollection, RestaurantFloorCollection,
      QAfterSortBy> thenBySortOrder() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sortOrder', Sort.asc);
    });
  }

  QueryBuilder<RestaurantFloorCollection, RestaurantFloorCollection,
      QAfterSortBy> thenBySortOrderDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sortOrder', Sort.desc);
    });
  }

  QueryBuilder<RestaurantFloorCollection, RestaurantFloorCollection,
      QAfterSortBy> thenByUuid() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uuid', Sort.asc);
    });
  }

  QueryBuilder<RestaurantFloorCollection, RestaurantFloorCollection,
      QAfterSortBy> thenByUuidDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uuid', Sort.desc);
    });
  }
}

extension RestaurantFloorCollectionQueryWhereDistinct on QueryBuilder<
    RestaurantFloorCollection, RestaurantFloorCollection, QDistinct> {
  QueryBuilder<RestaurantFloorCollection, RestaurantFloorCollection, QDistinct>
      distinctByIsActive() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isActive');
    });
  }

  QueryBuilder<RestaurantFloorCollection, RestaurantFloorCollection, QDistinct>
      distinctByName({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'name', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<RestaurantFloorCollection, RestaurantFloorCollection, QDistinct>
      distinctBySortOrder() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'sortOrder');
    });
  }

  QueryBuilder<RestaurantFloorCollection, RestaurantFloorCollection, QDistinct>
      distinctByUuid({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'uuid', caseSensitive: caseSensitive);
    });
  }
}

extension RestaurantFloorCollectionQueryProperty on QueryBuilder<
    RestaurantFloorCollection, RestaurantFloorCollection, QQueryProperty> {
  QueryBuilder<RestaurantFloorCollection, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<RestaurantFloorCollection, bool, QQueryOperations>
      isActiveProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isActive');
    });
  }

  QueryBuilder<RestaurantFloorCollection, String, QQueryOperations>
      nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'name');
    });
  }

  QueryBuilder<RestaurantFloorCollection, int, QQueryOperations>
      sortOrderProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'sortOrder');
    });
  }

  QueryBuilder<RestaurantFloorCollection, String, QQueryOperations>
      uuidProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'uuid');
    });
  }
}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetRestaurantTableCollectionCollection on Isar {
  IsarCollection<RestaurantTableCollection> get restaurantTableCollections =>
      this.collection();
}

const RestaurantTableCollectionSchema = CollectionSchema(
  name: r'RestaurantTableCollection',
  id: -(156201911427 * 1000000 + 996851),
  properties: {
    r'activeOrderId': PropertySchema(
      id: 0,
      name: r'activeOrderId',
      type: IsarType.string,
    ),
    r'capacity': PropertySchema(
      id: 1,
      name: r'capacity',
      type: IsarType.long,
    ),
    r'currentGuestCount': PropertySchema(
      id: 2,
      name: r'currentGuestCount',
      type: IsarType.long,
    ),
    r'floorId': PropertySchema(
      id: 3,
      name: r'floorId',
      type: IsarType.string,
    ),
    r'isMergeable': PropertySchema(
      id: 4,
      name: r'isMergeable',
      type: IsarType.bool,
    ),
    r'posX': PropertySchema(
      id: 5,
      name: r'posX',
      type: IsarType.double,
    ),
    r'posY': PropertySchema(
      id: 6,
      name: r'posY',
      type: IsarType.double,
    ),
    r'section': PropertySchema(
      id: 7,
      name: r'section',
      type: IsarType.string,
    ),
    r'shape': PropertySchema(
      id: 8,
      name: r'shape',
      type: IsarType.string,
    ),
    r'status': PropertySchema(
      id: 9,
      name: r'status',
      type: IsarType.string,
    ),
    r'tableNumber': PropertySchema(
      id: 10,
      name: r'tableNumber',
      type: IsarType.string,
    ),
    r'uuid': PropertySchema(
      id: 11,
      name: r'uuid',
      type: IsarType.string,
    )
  },
  estimateSize: _restaurantTableCollectionEstimateSize,
  serialize: _restaurantTableCollectionSerialize,
  deserialize: _restaurantTableCollectionDeserialize,
  deserializeProp: _restaurantTableCollectionDeserializeProp,
  idName: r'id',
  indexes: {
    r'uuid': IndexSchema(
      id: (2134397340427 * 1000000 + 724972),
      name: r'uuid',
      unique: true,
      replace: true,
      properties: [
        IndexPropertySchema(
          name: r'uuid',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    ),
    r'tableNumber': IndexSchema(
      id: -(3323858932237 * 1000000 + 924188),
      name: r'tableNumber',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'tableNumber',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    ),
    r'floorId': IndexSchema(
      id: -(5614466107289 * 1000000 + 224596),
      name: r'floorId',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'floorId',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    ),
    r'status': IndexSchema(
      id: -(107785170620 * 1000000 + 420283),
      name: r'status',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'status',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _restaurantTableCollectionGetId,
  getLinks: _restaurantTableCollectionGetLinks,
  attach: _restaurantTableCollectionAttach,
  version: '3.1.0+1',
);

int _restaurantTableCollectionEstimateSize(
  RestaurantTableCollection object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.activeOrderId;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.floorId.length * 3;
  bytesCount += 3 + object.section.length * 3;
  bytesCount += 3 + object.shape.length * 3;
  bytesCount += 3 + object.status.length * 3;
  bytesCount += 3 + object.tableNumber.length * 3;
  bytesCount += 3 + object.uuid.length * 3;
  return bytesCount;
}

void _restaurantTableCollectionSerialize(
  RestaurantTableCollection object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.activeOrderId);
  writer.writeLong(offsets[1], object.capacity);
  writer.writeLong(offsets[2], object.currentGuestCount);
  writer.writeString(offsets[3], object.floorId);
  writer.writeBool(offsets[4], object.isMergeable);
  writer.writeDouble(offsets[5], object.posX);
  writer.writeDouble(offsets[6], object.posY);
  writer.writeString(offsets[7], object.section);
  writer.writeString(offsets[8], object.shape);
  writer.writeString(offsets[9], object.status);
  writer.writeString(offsets[10], object.tableNumber);
  writer.writeString(offsets[11], object.uuid);
}

RestaurantTableCollection _restaurantTableCollectionDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = RestaurantTableCollection();
  object.activeOrderId = reader.readStringOrNull(offsets[0]);
  object.capacity = reader.readLong(offsets[1]);
  object.currentGuestCount = reader.readLong(offsets[2]);
  object.floorId = reader.readString(offsets[3]);
  object.id = id;
  object.isMergeable = reader.readBool(offsets[4]);
  object.posX = reader.readDouble(offsets[5]);
  object.posY = reader.readDouble(offsets[6]);
  object.section = reader.readString(offsets[7]);
  object.shape = reader.readString(offsets[8]);
  object.status = reader.readString(offsets[9]);
  object.tableNumber = reader.readString(offsets[10]);
  object.uuid = reader.readString(offsets[11]);
  return object;
}

P _restaurantTableCollectionDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringOrNull(offset)) as P;
    case 1:
      return (reader.readLong(offset)) as P;
    case 2:
      return (reader.readLong(offset)) as P;
    case 3:
      return (reader.readString(offset)) as P;
    case 4:
      return (reader.readBool(offset)) as P;
    case 5:
      return (reader.readDouble(offset)) as P;
    case 6:
      return (reader.readDouble(offset)) as P;
    case 7:
      return (reader.readString(offset)) as P;
    case 8:
      return (reader.readString(offset)) as P;
    case 9:
      return (reader.readString(offset)) as P;
    case 10:
      return (reader.readString(offset)) as P;
    case 11:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _restaurantTableCollectionGetId(RestaurantTableCollection object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _restaurantTableCollectionGetLinks(
    RestaurantTableCollection object) {
  return [];
}

void _restaurantTableCollectionAttach(
    IsarCollection<dynamic> col, Id id, RestaurantTableCollection object) {
  object.id = id;
}

extension RestaurantTableCollectionByIndex
    on IsarCollection<RestaurantTableCollection> {
  Future<RestaurantTableCollection?> getByUuid(String uuid) {
    return getByIndex(r'uuid', [uuid]);
  }

  RestaurantTableCollection? getByUuidSync(String uuid) {
    return getByIndexSync(r'uuid', [uuid]);
  }

  Future<bool> deleteByUuid(String uuid) {
    return deleteByIndex(r'uuid', [uuid]);
  }

  bool deleteByUuidSync(String uuid) {
    return deleteByIndexSync(r'uuid', [uuid]);
  }

  Future<List<RestaurantTableCollection?>> getAllByUuid(
      List<String> uuidValues) {
    final values = uuidValues.map((e) => [e]).toList();
    return getAllByIndex(r'uuid', values);
  }

  List<RestaurantTableCollection?> getAllByUuidSync(List<String> uuidValues) {
    final values = uuidValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'uuid', values);
  }

  Future<int> deleteAllByUuid(List<String> uuidValues) {
    final values = uuidValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'uuid', values);
  }

  int deleteAllByUuidSync(List<String> uuidValues) {
    final values = uuidValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'uuid', values);
  }

  Future<Id> putByUuid(RestaurantTableCollection object) {
    return putByIndex(r'uuid', object);
  }

  Id putByUuidSync(RestaurantTableCollection object, {bool saveLinks = true}) {
    return putByIndexSync(r'uuid', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByUuid(List<RestaurantTableCollection> objects) {
    return putAllByIndex(r'uuid', objects);
  }

  List<Id> putAllByUuidSync(List<RestaurantTableCollection> objects,
      {bool saveLinks = true}) {
    return putAllByIndexSync(r'uuid', objects, saveLinks: saveLinks);
  }
}

extension RestaurantTableCollectionQueryWhereSort on QueryBuilder<
    RestaurantTableCollection, RestaurantTableCollection, QWhere> {
  QueryBuilder<RestaurantTableCollection, RestaurantTableCollection,
      QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension RestaurantTableCollectionQueryWhere on QueryBuilder<
    RestaurantTableCollection, RestaurantTableCollection, QWhereClause> {
  QueryBuilder<RestaurantTableCollection, RestaurantTableCollection,
      QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<RestaurantTableCollection, RestaurantTableCollection,
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

  QueryBuilder<RestaurantTableCollection, RestaurantTableCollection,
      QAfterWhereClause> idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<RestaurantTableCollection, RestaurantTableCollection,
      QAfterWhereClause> idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<RestaurantTableCollection, RestaurantTableCollection,
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

  QueryBuilder<RestaurantTableCollection, RestaurantTableCollection,
      QAfterWhereClause> uuidEqualTo(String uuid) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'uuid',
        value: [uuid],
      ));
    });
  }

  QueryBuilder<RestaurantTableCollection, RestaurantTableCollection,
      QAfterWhereClause> uuidNotEqualTo(String uuid) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'uuid',
              lower: [],
              upper: [uuid],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'uuid',
              lower: [uuid],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'uuid',
              lower: [uuid],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'uuid',
              lower: [],
              upper: [uuid],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<RestaurantTableCollection, RestaurantTableCollection,
      QAfterWhereClause> tableNumberEqualTo(String tableNumber) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'tableNumber',
        value: [tableNumber],
      ));
    });
  }

  QueryBuilder<RestaurantTableCollection, RestaurantTableCollection,
      QAfterWhereClause> tableNumberNotEqualTo(String tableNumber) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'tableNumber',
              lower: [],
              upper: [tableNumber],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'tableNumber',
              lower: [tableNumber],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'tableNumber',
              lower: [tableNumber],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'tableNumber',
              lower: [],
              upper: [tableNumber],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<RestaurantTableCollection, RestaurantTableCollection,
      QAfterWhereClause> floorIdEqualTo(String floorId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'floorId',
        value: [floorId],
      ));
    });
  }

  QueryBuilder<RestaurantTableCollection, RestaurantTableCollection,
      QAfterWhereClause> floorIdNotEqualTo(String floorId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'floorId',
              lower: [],
              upper: [floorId],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'floorId',
              lower: [floorId],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'floorId',
              lower: [floorId],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'floorId',
              lower: [],
              upper: [floorId],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<RestaurantTableCollection, RestaurantTableCollection,
      QAfterWhereClause> statusEqualTo(String status) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'status',
        value: [status],
      ));
    });
  }

  QueryBuilder<RestaurantTableCollection, RestaurantTableCollection,
      QAfterWhereClause> statusNotEqualTo(String status) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'status',
              lower: [],
              upper: [status],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'status',
              lower: [status],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'status',
              lower: [status],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'status',
              lower: [],
              upper: [status],
              includeUpper: false,
            ));
      }
    });
  }
}

extension RestaurantTableCollectionQueryFilter on QueryBuilder<
    RestaurantTableCollection, RestaurantTableCollection, QFilterCondition> {
  QueryBuilder<RestaurantTableCollection, RestaurantTableCollection,
      QAfterFilterCondition> activeOrderIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'activeOrderId',
      ));
    });
  }

  QueryBuilder<RestaurantTableCollection, RestaurantTableCollection,
      QAfterFilterCondition> activeOrderIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'activeOrderId',
      ));
    });
  }

  QueryBuilder<RestaurantTableCollection, RestaurantTableCollection,
      QAfterFilterCondition> activeOrderIdEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'activeOrderId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RestaurantTableCollection, RestaurantTableCollection,
      QAfterFilterCondition> activeOrderIdGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'activeOrderId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RestaurantTableCollection, RestaurantTableCollection,
      QAfterFilterCondition> activeOrderIdLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'activeOrderId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RestaurantTableCollection, RestaurantTableCollection,
      QAfterFilterCondition> activeOrderIdBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'activeOrderId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RestaurantTableCollection, RestaurantTableCollection,
      QAfterFilterCondition> activeOrderIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'activeOrderId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RestaurantTableCollection, RestaurantTableCollection,
      QAfterFilterCondition> activeOrderIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'activeOrderId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RestaurantTableCollection, RestaurantTableCollection,
          QAfterFilterCondition>
      activeOrderIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'activeOrderId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RestaurantTableCollection, RestaurantTableCollection,
          QAfterFilterCondition>
      activeOrderIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'activeOrderId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RestaurantTableCollection, RestaurantTableCollection,
      QAfterFilterCondition> activeOrderIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'activeOrderId',
        value: '',
      ));
    });
  }

  QueryBuilder<RestaurantTableCollection, RestaurantTableCollection,
      QAfterFilterCondition> activeOrderIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'activeOrderId',
        value: '',
      ));
    });
  }

  QueryBuilder<RestaurantTableCollection, RestaurantTableCollection,
      QAfterFilterCondition> capacityEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'capacity',
        value: value,
      ));
    });
  }

  QueryBuilder<RestaurantTableCollection, RestaurantTableCollection,
      QAfterFilterCondition> capacityGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'capacity',
        value: value,
      ));
    });
  }

  QueryBuilder<RestaurantTableCollection, RestaurantTableCollection,
      QAfterFilterCondition> capacityLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'capacity',
        value: value,
      ));
    });
  }

  QueryBuilder<RestaurantTableCollection, RestaurantTableCollection,
      QAfterFilterCondition> capacityBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'capacity',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<RestaurantTableCollection, RestaurantTableCollection,
      QAfterFilterCondition> currentGuestCountEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'currentGuestCount',
        value: value,
      ));
    });
  }

  QueryBuilder<RestaurantTableCollection, RestaurantTableCollection,
      QAfterFilterCondition> currentGuestCountGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'currentGuestCount',
        value: value,
      ));
    });
  }

  QueryBuilder<RestaurantTableCollection, RestaurantTableCollection,
      QAfterFilterCondition> currentGuestCountLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'currentGuestCount',
        value: value,
      ));
    });
  }

  QueryBuilder<RestaurantTableCollection, RestaurantTableCollection,
      QAfterFilterCondition> currentGuestCountBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'currentGuestCount',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<RestaurantTableCollection, RestaurantTableCollection,
      QAfterFilterCondition> floorIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'floorId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RestaurantTableCollection, RestaurantTableCollection,
      QAfterFilterCondition> floorIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'floorId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RestaurantTableCollection, RestaurantTableCollection,
      QAfterFilterCondition> floorIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'floorId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RestaurantTableCollection, RestaurantTableCollection,
      QAfterFilterCondition> floorIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'floorId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RestaurantTableCollection, RestaurantTableCollection,
      QAfterFilterCondition> floorIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'floorId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RestaurantTableCollection, RestaurantTableCollection,
      QAfterFilterCondition> floorIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'floorId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RestaurantTableCollection, RestaurantTableCollection,
          QAfterFilterCondition>
      floorIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'floorId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RestaurantTableCollection, RestaurantTableCollection,
          QAfterFilterCondition>
      floorIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'floorId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RestaurantTableCollection, RestaurantTableCollection,
      QAfterFilterCondition> floorIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'floorId',
        value: '',
      ));
    });
  }

  QueryBuilder<RestaurantTableCollection, RestaurantTableCollection,
      QAfterFilterCondition> floorIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'floorId',
        value: '',
      ));
    });
  }

  QueryBuilder<RestaurantTableCollection, RestaurantTableCollection,
      QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<RestaurantTableCollection, RestaurantTableCollection,
      QAfterFilterCondition> idGreaterThan(
    Id value, {
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

  QueryBuilder<RestaurantTableCollection, RestaurantTableCollection,
      QAfterFilterCondition> idLessThan(
    Id value, {
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

  QueryBuilder<RestaurantTableCollection, RestaurantTableCollection,
      QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
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

  QueryBuilder<RestaurantTableCollection, RestaurantTableCollection,
      QAfterFilterCondition> isMergeableEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isMergeable',
        value: value,
      ));
    });
  }

  QueryBuilder<RestaurantTableCollection, RestaurantTableCollection,
      QAfterFilterCondition> posXEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'posX',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<RestaurantTableCollection, RestaurantTableCollection,
      QAfterFilterCondition> posXGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'posX',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<RestaurantTableCollection, RestaurantTableCollection,
      QAfterFilterCondition> posXLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'posX',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<RestaurantTableCollection, RestaurantTableCollection,
      QAfterFilterCondition> posXBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'posX',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<RestaurantTableCollection, RestaurantTableCollection,
      QAfterFilterCondition> posYEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'posY',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<RestaurantTableCollection, RestaurantTableCollection,
      QAfterFilterCondition> posYGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'posY',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<RestaurantTableCollection, RestaurantTableCollection,
      QAfterFilterCondition> posYLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'posY',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<RestaurantTableCollection, RestaurantTableCollection,
      QAfterFilterCondition> posYBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'posY',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<RestaurantTableCollection, RestaurantTableCollection,
      QAfterFilterCondition> sectionEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'section',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RestaurantTableCollection, RestaurantTableCollection,
      QAfterFilterCondition> sectionGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'section',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RestaurantTableCollection, RestaurantTableCollection,
      QAfterFilterCondition> sectionLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'section',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RestaurantTableCollection, RestaurantTableCollection,
      QAfterFilterCondition> sectionBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'section',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RestaurantTableCollection, RestaurantTableCollection,
      QAfterFilterCondition> sectionStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'section',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RestaurantTableCollection, RestaurantTableCollection,
      QAfterFilterCondition> sectionEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'section',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RestaurantTableCollection, RestaurantTableCollection,
          QAfterFilterCondition>
      sectionContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'section',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RestaurantTableCollection, RestaurantTableCollection,
          QAfterFilterCondition>
      sectionMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'section',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RestaurantTableCollection, RestaurantTableCollection,
      QAfterFilterCondition> sectionIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'section',
        value: '',
      ));
    });
  }

  QueryBuilder<RestaurantTableCollection, RestaurantTableCollection,
      QAfterFilterCondition> sectionIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'section',
        value: '',
      ));
    });
  }

  QueryBuilder<RestaurantTableCollection, RestaurantTableCollection,
      QAfterFilterCondition> shapeEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'shape',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RestaurantTableCollection, RestaurantTableCollection,
      QAfterFilterCondition> shapeGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'shape',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RestaurantTableCollection, RestaurantTableCollection,
      QAfterFilterCondition> shapeLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'shape',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RestaurantTableCollection, RestaurantTableCollection,
      QAfterFilterCondition> shapeBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'shape',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RestaurantTableCollection, RestaurantTableCollection,
      QAfterFilterCondition> shapeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'shape',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RestaurantTableCollection, RestaurantTableCollection,
      QAfterFilterCondition> shapeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'shape',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RestaurantTableCollection, RestaurantTableCollection,
          QAfterFilterCondition>
      shapeContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'shape',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RestaurantTableCollection, RestaurantTableCollection,
          QAfterFilterCondition>
      shapeMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'shape',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RestaurantTableCollection, RestaurantTableCollection,
      QAfterFilterCondition> shapeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'shape',
        value: '',
      ));
    });
  }

  QueryBuilder<RestaurantTableCollection, RestaurantTableCollection,
      QAfterFilterCondition> shapeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'shape',
        value: '',
      ));
    });
  }

  QueryBuilder<RestaurantTableCollection, RestaurantTableCollection,
      QAfterFilterCondition> statusEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'status',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RestaurantTableCollection, RestaurantTableCollection,
      QAfterFilterCondition> statusGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'status',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RestaurantTableCollection, RestaurantTableCollection,
      QAfterFilterCondition> statusLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'status',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RestaurantTableCollection, RestaurantTableCollection,
      QAfterFilterCondition> statusBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'status',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RestaurantTableCollection, RestaurantTableCollection,
      QAfterFilterCondition> statusStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'status',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RestaurantTableCollection, RestaurantTableCollection,
      QAfterFilterCondition> statusEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'status',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RestaurantTableCollection, RestaurantTableCollection,
          QAfterFilterCondition>
      statusContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'status',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RestaurantTableCollection, RestaurantTableCollection,
          QAfterFilterCondition>
      statusMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'status',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RestaurantTableCollection, RestaurantTableCollection,
      QAfterFilterCondition> statusIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'status',
        value: '',
      ));
    });
  }

  QueryBuilder<RestaurantTableCollection, RestaurantTableCollection,
      QAfterFilterCondition> statusIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'status',
        value: '',
      ));
    });
  }

  QueryBuilder<RestaurantTableCollection, RestaurantTableCollection,
      QAfterFilterCondition> tableNumberEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'tableNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RestaurantTableCollection, RestaurantTableCollection,
      QAfterFilterCondition> tableNumberGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'tableNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RestaurantTableCollection, RestaurantTableCollection,
      QAfterFilterCondition> tableNumberLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'tableNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RestaurantTableCollection, RestaurantTableCollection,
      QAfterFilterCondition> tableNumberBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'tableNumber',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RestaurantTableCollection, RestaurantTableCollection,
      QAfterFilterCondition> tableNumberStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'tableNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RestaurantTableCollection, RestaurantTableCollection,
      QAfterFilterCondition> tableNumberEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'tableNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RestaurantTableCollection, RestaurantTableCollection,
          QAfterFilterCondition>
      tableNumberContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'tableNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RestaurantTableCollection, RestaurantTableCollection,
          QAfterFilterCondition>
      tableNumberMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'tableNumber',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RestaurantTableCollection, RestaurantTableCollection,
      QAfterFilterCondition> tableNumberIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'tableNumber',
        value: '',
      ));
    });
  }

  QueryBuilder<RestaurantTableCollection, RestaurantTableCollection,
      QAfterFilterCondition> tableNumberIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'tableNumber',
        value: '',
      ));
    });
  }

  QueryBuilder<RestaurantTableCollection, RestaurantTableCollection,
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

  QueryBuilder<RestaurantTableCollection, RestaurantTableCollection,
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

  QueryBuilder<RestaurantTableCollection, RestaurantTableCollection,
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

  QueryBuilder<RestaurantTableCollection, RestaurantTableCollection,
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

  QueryBuilder<RestaurantTableCollection, RestaurantTableCollection,
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

  QueryBuilder<RestaurantTableCollection, RestaurantTableCollection,
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

  QueryBuilder<RestaurantTableCollection, RestaurantTableCollection,
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

  QueryBuilder<RestaurantTableCollection, RestaurantTableCollection,
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

  QueryBuilder<RestaurantTableCollection, RestaurantTableCollection,
      QAfterFilterCondition> uuidIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'uuid',
        value: '',
      ));
    });
  }

  QueryBuilder<RestaurantTableCollection, RestaurantTableCollection,
      QAfterFilterCondition> uuidIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'uuid',
        value: '',
      ));
    });
  }
}

extension RestaurantTableCollectionQueryObject on QueryBuilder<
    RestaurantTableCollection, RestaurantTableCollection, QFilterCondition> {}

extension RestaurantTableCollectionQueryLinks on QueryBuilder<
    RestaurantTableCollection, RestaurantTableCollection, QFilterCondition> {}

extension RestaurantTableCollectionQuerySortBy on QueryBuilder<
    RestaurantTableCollection, RestaurantTableCollection, QSortBy> {
  QueryBuilder<RestaurantTableCollection, RestaurantTableCollection,
      QAfterSortBy> sortByActiveOrderId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'activeOrderId', Sort.asc);
    });
  }

  QueryBuilder<RestaurantTableCollection, RestaurantTableCollection,
      QAfterSortBy> sortByActiveOrderIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'activeOrderId', Sort.desc);
    });
  }

  QueryBuilder<RestaurantTableCollection, RestaurantTableCollection,
      QAfterSortBy> sortByCapacity() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'capacity', Sort.asc);
    });
  }

  QueryBuilder<RestaurantTableCollection, RestaurantTableCollection,
      QAfterSortBy> sortByCapacityDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'capacity', Sort.desc);
    });
  }

  QueryBuilder<RestaurantTableCollection, RestaurantTableCollection,
      QAfterSortBy> sortByCurrentGuestCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'currentGuestCount', Sort.asc);
    });
  }

  QueryBuilder<RestaurantTableCollection, RestaurantTableCollection,
      QAfterSortBy> sortByCurrentGuestCountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'currentGuestCount', Sort.desc);
    });
  }

  QueryBuilder<RestaurantTableCollection, RestaurantTableCollection,
      QAfterSortBy> sortByFloorId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'floorId', Sort.asc);
    });
  }

  QueryBuilder<RestaurantTableCollection, RestaurantTableCollection,
      QAfterSortBy> sortByFloorIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'floorId', Sort.desc);
    });
  }

  QueryBuilder<RestaurantTableCollection, RestaurantTableCollection,
      QAfterSortBy> sortByIsMergeable() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isMergeable', Sort.asc);
    });
  }

  QueryBuilder<RestaurantTableCollection, RestaurantTableCollection,
      QAfterSortBy> sortByIsMergeableDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isMergeable', Sort.desc);
    });
  }

  QueryBuilder<RestaurantTableCollection, RestaurantTableCollection,
      QAfterSortBy> sortByPosX() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'posX', Sort.asc);
    });
  }

  QueryBuilder<RestaurantTableCollection, RestaurantTableCollection,
      QAfterSortBy> sortByPosXDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'posX', Sort.desc);
    });
  }

  QueryBuilder<RestaurantTableCollection, RestaurantTableCollection,
      QAfterSortBy> sortByPosY() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'posY', Sort.asc);
    });
  }

  QueryBuilder<RestaurantTableCollection, RestaurantTableCollection,
      QAfterSortBy> sortByPosYDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'posY', Sort.desc);
    });
  }

  QueryBuilder<RestaurantTableCollection, RestaurantTableCollection,
      QAfterSortBy> sortBySection() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'section', Sort.asc);
    });
  }

  QueryBuilder<RestaurantTableCollection, RestaurantTableCollection,
      QAfterSortBy> sortBySectionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'section', Sort.desc);
    });
  }

  QueryBuilder<RestaurantTableCollection, RestaurantTableCollection,
      QAfterSortBy> sortByShape() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'shape', Sort.asc);
    });
  }

  QueryBuilder<RestaurantTableCollection, RestaurantTableCollection,
      QAfterSortBy> sortByShapeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'shape', Sort.desc);
    });
  }

  QueryBuilder<RestaurantTableCollection, RestaurantTableCollection,
      QAfterSortBy> sortByStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.asc);
    });
  }

  QueryBuilder<RestaurantTableCollection, RestaurantTableCollection,
      QAfterSortBy> sortByStatusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.desc);
    });
  }

  QueryBuilder<RestaurantTableCollection, RestaurantTableCollection,
      QAfterSortBy> sortByTableNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tableNumber', Sort.asc);
    });
  }

  QueryBuilder<RestaurantTableCollection, RestaurantTableCollection,
      QAfterSortBy> sortByTableNumberDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tableNumber', Sort.desc);
    });
  }

  QueryBuilder<RestaurantTableCollection, RestaurantTableCollection,
      QAfterSortBy> sortByUuid() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uuid', Sort.asc);
    });
  }

  QueryBuilder<RestaurantTableCollection, RestaurantTableCollection,
      QAfterSortBy> sortByUuidDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uuid', Sort.desc);
    });
  }
}

extension RestaurantTableCollectionQuerySortThenBy on QueryBuilder<
    RestaurantTableCollection, RestaurantTableCollection, QSortThenBy> {
  QueryBuilder<RestaurantTableCollection, RestaurantTableCollection,
      QAfterSortBy> thenByActiveOrderId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'activeOrderId', Sort.asc);
    });
  }

  QueryBuilder<RestaurantTableCollection, RestaurantTableCollection,
      QAfterSortBy> thenByActiveOrderIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'activeOrderId', Sort.desc);
    });
  }

  QueryBuilder<RestaurantTableCollection, RestaurantTableCollection,
      QAfterSortBy> thenByCapacity() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'capacity', Sort.asc);
    });
  }

  QueryBuilder<RestaurantTableCollection, RestaurantTableCollection,
      QAfterSortBy> thenByCapacityDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'capacity', Sort.desc);
    });
  }

  QueryBuilder<RestaurantTableCollection, RestaurantTableCollection,
      QAfterSortBy> thenByCurrentGuestCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'currentGuestCount', Sort.asc);
    });
  }

  QueryBuilder<RestaurantTableCollection, RestaurantTableCollection,
      QAfterSortBy> thenByCurrentGuestCountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'currentGuestCount', Sort.desc);
    });
  }

  QueryBuilder<RestaurantTableCollection, RestaurantTableCollection,
      QAfterSortBy> thenByFloorId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'floorId', Sort.asc);
    });
  }

  QueryBuilder<RestaurantTableCollection, RestaurantTableCollection,
      QAfterSortBy> thenByFloorIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'floorId', Sort.desc);
    });
  }

  QueryBuilder<RestaurantTableCollection, RestaurantTableCollection,
      QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<RestaurantTableCollection, RestaurantTableCollection,
      QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<RestaurantTableCollection, RestaurantTableCollection,
      QAfterSortBy> thenByIsMergeable() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isMergeable', Sort.asc);
    });
  }

  QueryBuilder<RestaurantTableCollection, RestaurantTableCollection,
      QAfterSortBy> thenByIsMergeableDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isMergeable', Sort.desc);
    });
  }

  QueryBuilder<RestaurantTableCollection, RestaurantTableCollection,
      QAfterSortBy> thenByPosX() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'posX', Sort.asc);
    });
  }

  QueryBuilder<RestaurantTableCollection, RestaurantTableCollection,
      QAfterSortBy> thenByPosXDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'posX', Sort.desc);
    });
  }

  QueryBuilder<RestaurantTableCollection, RestaurantTableCollection,
      QAfterSortBy> thenByPosY() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'posY', Sort.asc);
    });
  }

  QueryBuilder<RestaurantTableCollection, RestaurantTableCollection,
      QAfterSortBy> thenByPosYDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'posY', Sort.desc);
    });
  }

  QueryBuilder<RestaurantTableCollection, RestaurantTableCollection,
      QAfterSortBy> thenBySection() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'section', Sort.asc);
    });
  }

  QueryBuilder<RestaurantTableCollection, RestaurantTableCollection,
      QAfterSortBy> thenBySectionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'section', Sort.desc);
    });
  }

  QueryBuilder<RestaurantTableCollection, RestaurantTableCollection,
      QAfterSortBy> thenByShape() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'shape', Sort.asc);
    });
  }

  QueryBuilder<RestaurantTableCollection, RestaurantTableCollection,
      QAfterSortBy> thenByShapeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'shape', Sort.desc);
    });
  }

  QueryBuilder<RestaurantTableCollection, RestaurantTableCollection,
      QAfterSortBy> thenByStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.asc);
    });
  }

  QueryBuilder<RestaurantTableCollection, RestaurantTableCollection,
      QAfterSortBy> thenByStatusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.desc);
    });
  }

  QueryBuilder<RestaurantTableCollection, RestaurantTableCollection,
      QAfterSortBy> thenByTableNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tableNumber', Sort.asc);
    });
  }

  QueryBuilder<RestaurantTableCollection, RestaurantTableCollection,
      QAfterSortBy> thenByTableNumberDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tableNumber', Sort.desc);
    });
  }

  QueryBuilder<RestaurantTableCollection, RestaurantTableCollection,
      QAfterSortBy> thenByUuid() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uuid', Sort.asc);
    });
  }

  QueryBuilder<RestaurantTableCollection, RestaurantTableCollection,
      QAfterSortBy> thenByUuidDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uuid', Sort.desc);
    });
  }
}

extension RestaurantTableCollectionQueryWhereDistinct on QueryBuilder<
    RestaurantTableCollection, RestaurantTableCollection, QDistinct> {
  QueryBuilder<RestaurantTableCollection, RestaurantTableCollection, QDistinct>
      distinctByActiveOrderId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'activeOrderId',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<RestaurantTableCollection, RestaurantTableCollection, QDistinct>
      distinctByCapacity() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'capacity');
    });
  }

  QueryBuilder<RestaurantTableCollection, RestaurantTableCollection, QDistinct>
      distinctByCurrentGuestCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'currentGuestCount');
    });
  }

  QueryBuilder<RestaurantTableCollection, RestaurantTableCollection, QDistinct>
      distinctByFloorId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'floorId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<RestaurantTableCollection, RestaurantTableCollection, QDistinct>
      distinctByIsMergeable() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isMergeable');
    });
  }

  QueryBuilder<RestaurantTableCollection, RestaurantTableCollection, QDistinct>
      distinctByPosX() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'posX');
    });
  }

  QueryBuilder<RestaurantTableCollection, RestaurantTableCollection, QDistinct>
      distinctByPosY() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'posY');
    });
  }

  QueryBuilder<RestaurantTableCollection, RestaurantTableCollection, QDistinct>
      distinctBySection({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'section', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<RestaurantTableCollection, RestaurantTableCollection, QDistinct>
      distinctByShape({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'shape', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<RestaurantTableCollection, RestaurantTableCollection, QDistinct>
      distinctByStatus({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'status', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<RestaurantTableCollection, RestaurantTableCollection, QDistinct>
      distinctByTableNumber({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'tableNumber', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<RestaurantTableCollection, RestaurantTableCollection, QDistinct>
      distinctByUuid({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'uuid', caseSensitive: caseSensitive);
    });
  }
}

extension RestaurantTableCollectionQueryProperty on QueryBuilder<
    RestaurantTableCollection, RestaurantTableCollection, QQueryProperty> {
  QueryBuilder<RestaurantTableCollection, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<RestaurantTableCollection, String?, QQueryOperations>
      activeOrderIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'activeOrderId');
    });
  }

  QueryBuilder<RestaurantTableCollection, int, QQueryOperations>
      capacityProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'capacity');
    });
  }

  QueryBuilder<RestaurantTableCollection, int, QQueryOperations>
      currentGuestCountProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'currentGuestCount');
    });
  }

  QueryBuilder<RestaurantTableCollection, String, QQueryOperations>
      floorIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'floorId');
    });
  }

  QueryBuilder<RestaurantTableCollection, bool, QQueryOperations>
      isMergeableProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isMergeable');
    });
  }

  QueryBuilder<RestaurantTableCollection, double, QQueryOperations>
      posXProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'posX');
    });
  }

  QueryBuilder<RestaurantTableCollection, double, QQueryOperations>
      posYProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'posY');
    });
  }

  QueryBuilder<RestaurantTableCollection, String, QQueryOperations>
      sectionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'section');
    });
  }

  QueryBuilder<RestaurantTableCollection, String, QQueryOperations>
      shapeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'shape');
    });
  }

  QueryBuilder<RestaurantTableCollection, String, QQueryOperations>
      statusProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'status');
    });
  }

  QueryBuilder<RestaurantTableCollection, String, QQueryOperations>
      tableNumberProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'tableNumber');
    });
  }

  QueryBuilder<RestaurantTableCollection, String, QQueryOperations>
      uuidProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'uuid');
    });
  }
}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetKotCollectionCollection on Isar {
  IsarCollection<KotCollection> get kotCollections => this.collection();
}

const KotCollectionSchema = CollectionSchema(
  name: r'KotCollection',
  id: (7820154192914 * 1000000 + 925277),
  properties: {
    r'createdAt': PropertySchema(
      id: 0,
      name: r'createdAt',
      type: IsarType.dateTime,
    ),
    r'items': PropertySchema(
      id: 1,
      name: r'items',
      type: IsarType.objectList,
      target: r'KotItemEmbedded',
    ),
    r'notes': PropertySchema(
      id: 2,
      name: r'notes',
      type: IsarType.string,
    ),
    r'orderId': PropertySchema(
      id: 3,
      name: r'orderId',
      type: IsarType.string,
    ),
    r'orderType': PropertySchema(
      id: 4,
      name: r'orderType',
      type: IsarType.string,
    ),
    r'priority': PropertySchema(
      id: 5,
      name: r'priority',
      type: IsarType.long,
    ),
    r'station': PropertySchema(
      id: 6,
      name: r'station',
      type: IsarType.string,
    ),
    r'status': PropertySchema(
      id: 7,
      name: r'status',
      type: IsarType.string,
    ),
    r'tableId': PropertySchema(
      id: 8,
      name: r'tableId',
      type: IsarType.string,
    ),
    r'uuid': PropertySchema(
      id: 9,
      name: r'uuid',
      type: IsarType.string,
    )
  },
  estimateSize: _kotCollectionEstimateSize,
  serialize: _kotCollectionSerialize,
  deserialize: _kotCollectionDeserialize,
  deserializeProp: _kotCollectionDeserializeProp,
  idName: r'id',
  indexes: {
    r'uuid': IndexSchema(
      id: (2134397340427 * 1000000 + 724972),
      name: r'uuid',
      unique: true,
      replace: true,
      properties: [
        IndexPropertySchema(
          name: r'uuid',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    ),
    r'orderId': IndexSchema(
      id: -(6176610178429 * 1000000 + 382285),
      name: r'orderId',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'orderId',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    ),
    r'station': IndexSchema(
      id: -(1945757363763 * 1000000 + 444516),
      name: r'station',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'station',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    ),
    r'status': IndexSchema(
      id: -(107785170620 * 1000000 + 420283),
      name: r'status',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'status',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {r'KotItemEmbedded': KotItemEmbeddedSchema},
  getId: _kotCollectionGetId,
  getLinks: _kotCollectionGetLinks,
  attach: _kotCollectionAttach,
  version: '3.1.0+1',
);

int _kotCollectionEstimateSize(
  KotCollection object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.items.length * 3;
  {
    final offsets = allOffsets[KotItemEmbedded]!;
    for (var i = 0; i < object.items.length; i++) {
      final value = object.items[i];
      bytesCount +=
          KotItemEmbeddedSchema.estimateSize(value, offsets, allOffsets);
    }
  }
  {
    final value = object.notes;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.orderId.length * 3;
  bytesCount += 3 + object.orderType.length * 3;
  bytesCount += 3 + object.station.length * 3;
  bytesCount += 3 + object.status.length * 3;
  {
    final value = object.tableId;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.uuid.length * 3;
  return bytesCount;
}

void _kotCollectionSerialize(
  KotCollection object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDateTime(offsets[0], object.createdAt);
  writer.writeObjectList<KotItemEmbedded>(
    offsets[1],
    allOffsets,
    KotItemEmbeddedSchema.serialize,
    object.items,
  );
  writer.writeString(offsets[2], object.notes);
  writer.writeString(offsets[3], object.orderId);
  writer.writeString(offsets[4], object.orderType);
  writer.writeLong(offsets[5], object.priority);
  writer.writeString(offsets[6], object.station);
  writer.writeString(offsets[7], object.status);
  writer.writeString(offsets[8], object.tableId);
  writer.writeString(offsets[9], object.uuid);
}

KotCollection _kotCollectionDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = KotCollection();
  object.createdAt = reader.readDateTime(offsets[0]);
  object.id = id;
  object.items = reader.readObjectList<KotItemEmbedded>(
        offsets[1],
        KotItemEmbeddedSchema.deserialize,
        allOffsets,
        KotItemEmbedded(),
      ) ??
      [];
  object.notes = reader.readStringOrNull(offsets[2]);
  object.orderId = reader.readString(offsets[3]);
  object.orderType = reader.readString(offsets[4]);
  object.priority = reader.readLong(offsets[5]);
  object.station = reader.readString(offsets[6]);
  object.status = reader.readString(offsets[7]);
  object.tableId = reader.readStringOrNull(offsets[8]);
  object.uuid = reader.readString(offsets[9]);
  return object;
}

P _kotCollectionDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDateTime(offset)) as P;
    case 1:
      return (reader.readObjectList<KotItemEmbedded>(
            offset,
            KotItemEmbeddedSchema.deserialize,
            allOffsets,
            KotItemEmbedded(),
          ) ??
          []) as P;
    case 2:
      return (reader.readStringOrNull(offset)) as P;
    case 3:
      return (reader.readString(offset)) as P;
    case 4:
      return (reader.readString(offset)) as P;
    case 5:
      return (reader.readLong(offset)) as P;
    case 6:
      return (reader.readString(offset)) as P;
    case 7:
      return (reader.readString(offset)) as P;
    case 8:
      return (reader.readStringOrNull(offset)) as P;
    case 9:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _kotCollectionGetId(KotCollection object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _kotCollectionGetLinks(KotCollection object) {
  return [];
}

void _kotCollectionAttach(
    IsarCollection<dynamic> col, Id id, KotCollection object) {
  object.id = id;
}

extension KotCollectionByIndex on IsarCollection<KotCollection> {
  Future<KotCollection?> getByUuid(String uuid) {
    return getByIndex(r'uuid', [uuid]);
  }

  KotCollection? getByUuidSync(String uuid) {
    return getByIndexSync(r'uuid', [uuid]);
  }

  Future<bool> deleteByUuid(String uuid) {
    return deleteByIndex(r'uuid', [uuid]);
  }

  bool deleteByUuidSync(String uuid) {
    return deleteByIndexSync(r'uuid', [uuid]);
  }

  Future<List<KotCollection?>> getAllByUuid(List<String> uuidValues) {
    final values = uuidValues.map((e) => [e]).toList();
    return getAllByIndex(r'uuid', values);
  }

  List<KotCollection?> getAllByUuidSync(List<String> uuidValues) {
    final values = uuidValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'uuid', values);
  }

  Future<int> deleteAllByUuid(List<String> uuidValues) {
    final values = uuidValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'uuid', values);
  }

  int deleteAllByUuidSync(List<String> uuidValues) {
    final values = uuidValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'uuid', values);
  }

  Future<Id> putByUuid(KotCollection object) {
    return putByIndex(r'uuid', object);
  }

  Id putByUuidSync(KotCollection object, {bool saveLinks = true}) {
    return putByIndexSync(r'uuid', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByUuid(List<KotCollection> objects) {
    return putAllByIndex(r'uuid', objects);
  }

  List<Id> putAllByUuidSync(List<KotCollection> objects,
      {bool saveLinks = true}) {
    return putAllByIndexSync(r'uuid', objects, saveLinks: saveLinks);
  }
}

extension KotCollectionQueryWhereSort
    on QueryBuilder<KotCollection, KotCollection, QWhere> {
  QueryBuilder<KotCollection, KotCollection, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension KotCollectionQueryWhere
    on QueryBuilder<KotCollection, KotCollection, QWhereClause> {
  QueryBuilder<KotCollection, KotCollection, QAfterWhereClause> idEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<KotCollection, KotCollection, QAfterWhereClause> idNotEqualTo(
      Id id) {
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

  QueryBuilder<KotCollection, KotCollection, QAfterWhereClause> idGreaterThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<KotCollection, KotCollection, QAfterWhereClause> idLessThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<KotCollection, KotCollection, QAfterWhereClause> idBetween(
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

  QueryBuilder<KotCollection, KotCollection, QAfterWhereClause> uuidEqualTo(
      String uuid) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'uuid',
        value: [uuid],
      ));
    });
  }

  QueryBuilder<KotCollection, KotCollection, QAfterWhereClause> uuidNotEqualTo(
      String uuid) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'uuid',
              lower: [],
              upper: [uuid],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'uuid',
              lower: [uuid],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'uuid',
              lower: [uuid],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'uuid',
              lower: [],
              upper: [uuid],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<KotCollection, KotCollection, QAfterWhereClause> orderIdEqualTo(
      String orderId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'orderId',
        value: [orderId],
      ));
    });
  }

  QueryBuilder<KotCollection, KotCollection, QAfterWhereClause>
      orderIdNotEqualTo(String orderId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'orderId',
              lower: [],
              upper: [orderId],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'orderId',
              lower: [orderId],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'orderId',
              lower: [orderId],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'orderId',
              lower: [],
              upper: [orderId],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<KotCollection, KotCollection, QAfterWhereClause> stationEqualTo(
      String station) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'station',
        value: [station],
      ));
    });
  }

  QueryBuilder<KotCollection, KotCollection, QAfterWhereClause>
      stationNotEqualTo(String station) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'station',
              lower: [],
              upper: [station],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'station',
              lower: [station],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'station',
              lower: [station],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'station',
              lower: [],
              upper: [station],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<KotCollection, KotCollection, QAfterWhereClause> statusEqualTo(
      String status) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'status',
        value: [status],
      ));
    });
  }

  QueryBuilder<KotCollection, KotCollection, QAfterWhereClause>
      statusNotEqualTo(String status) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'status',
              lower: [],
              upper: [status],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'status',
              lower: [status],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'status',
              lower: [status],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'status',
              lower: [],
              upper: [status],
              includeUpper: false,
            ));
      }
    });
  }
}

extension KotCollectionQueryFilter
    on QueryBuilder<KotCollection, KotCollection, QFilterCondition> {
  QueryBuilder<KotCollection, KotCollection, QAfterFilterCondition>
      createdAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<KotCollection, KotCollection, QAfterFilterCondition>
      createdAtGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<KotCollection, KotCollection, QAfterFilterCondition>
      createdAtLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<KotCollection, KotCollection, QAfterFilterCondition>
      createdAtBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'createdAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<KotCollection, KotCollection, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<KotCollection, KotCollection, QAfterFilterCondition>
      idGreaterThan(
    Id value, {
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

  QueryBuilder<KotCollection, KotCollection, QAfterFilterCondition> idLessThan(
    Id value, {
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

  QueryBuilder<KotCollection, KotCollection, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
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

  QueryBuilder<KotCollection, KotCollection, QAfterFilterCondition>
      itemsLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'items',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<KotCollection, KotCollection, QAfterFilterCondition>
      itemsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'items',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<KotCollection, KotCollection, QAfterFilterCondition>
      itemsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'items',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<KotCollection, KotCollection, QAfterFilterCondition>
      itemsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'items',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<KotCollection, KotCollection, QAfterFilterCondition>
      itemsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'items',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<KotCollection, KotCollection, QAfterFilterCondition>
      itemsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'items',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<KotCollection, KotCollection, QAfterFilterCondition>
      notesIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'notes',
      ));
    });
  }

  QueryBuilder<KotCollection, KotCollection, QAfterFilterCondition>
      notesIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'notes',
      ));
    });
  }

  QueryBuilder<KotCollection, KotCollection, QAfterFilterCondition>
      notesEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'notes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<KotCollection, KotCollection, QAfterFilterCondition>
      notesGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'notes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<KotCollection, KotCollection, QAfterFilterCondition>
      notesLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'notes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<KotCollection, KotCollection, QAfterFilterCondition>
      notesBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'notes',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<KotCollection, KotCollection, QAfterFilterCondition>
      notesStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'notes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<KotCollection, KotCollection, QAfterFilterCondition>
      notesEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'notes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<KotCollection, KotCollection, QAfterFilterCondition>
      notesContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'notes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<KotCollection, KotCollection, QAfterFilterCondition>
      notesMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'notes',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<KotCollection, KotCollection, QAfterFilterCondition>
      notesIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'notes',
        value: '',
      ));
    });
  }

  QueryBuilder<KotCollection, KotCollection, QAfterFilterCondition>
      notesIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'notes',
        value: '',
      ));
    });
  }

  QueryBuilder<KotCollection, KotCollection, QAfterFilterCondition>
      orderIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'orderId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<KotCollection, KotCollection, QAfterFilterCondition>
      orderIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'orderId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<KotCollection, KotCollection, QAfterFilterCondition>
      orderIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'orderId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<KotCollection, KotCollection, QAfterFilterCondition>
      orderIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'orderId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<KotCollection, KotCollection, QAfterFilterCondition>
      orderIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'orderId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<KotCollection, KotCollection, QAfterFilterCondition>
      orderIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'orderId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<KotCollection, KotCollection, QAfterFilterCondition>
      orderIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'orderId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<KotCollection, KotCollection, QAfterFilterCondition>
      orderIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'orderId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<KotCollection, KotCollection, QAfterFilterCondition>
      orderIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'orderId',
        value: '',
      ));
    });
  }

  QueryBuilder<KotCollection, KotCollection, QAfterFilterCondition>
      orderIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'orderId',
        value: '',
      ));
    });
  }

  QueryBuilder<KotCollection, KotCollection, QAfterFilterCondition>
      orderTypeEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'orderType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<KotCollection, KotCollection, QAfterFilterCondition>
      orderTypeGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'orderType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<KotCollection, KotCollection, QAfterFilterCondition>
      orderTypeLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'orderType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<KotCollection, KotCollection, QAfterFilterCondition>
      orderTypeBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'orderType',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<KotCollection, KotCollection, QAfterFilterCondition>
      orderTypeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'orderType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<KotCollection, KotCollection, QAfterFilterCondition>
      orderTypeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'orderType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<KotCollection, KotCollection, QAfterFilterCondition>
      orderTypeContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'orderType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<KotCollection, KotCollection, QAfterFilterCondition>
      orderTypeMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'orderType',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<KotCollection, KotCollection, QAfterFilterCondition>
      orderTypeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'orderType',
        value: '',
      ));
    });
  }

  QueryBuilder<KotCollection, KotCollection, QAfterFilterCondition>
      orderTypeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'orderType',
        value: '',
      ));
    });
  }

  QueryBuilder<KotCollection, KotCollection, QAfterFilterCondition>
      priorityEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'priority',
        value: value,
      ));
    });
  }

  QueryBuilder<KotCollection, KotCollection, QAfterFilterCondition>
      priorityGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'priority',
        value: value,
      ));
    });
  }

  QueryBuilder<KotCollection, KotCollection, QAfterFilterCondition>
      priorityLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'priority',
        value: value,
      ));
    });
  }

  QueryBuilder<KotCollection, KotCollection, QAfterFilterCondition>
      priorityBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'priority',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<KotCollection, KotCollection, QAfterFilterCondition>
      stationEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'station',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<KotCollection, KotCollection, QAfterFilterCondition>
      stationGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'station',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<KotCollection, KotCollection, QAfterFilterCondition>
      stationLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'station',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<KotCollection, KotCollection, QAfterFilterCondition>
      stationBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'station',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<KotCollection, KotCollection, QAfterFilterCondition>
      stationStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'station',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<KotCollection, KotCollection, QAfterFilterCondition>
      stationEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'station',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<KotCollection, KotCollection, QAfterFilterCondition>
      stationContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'station',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<KotCollection, KotCollection, QAfterFilterCondition>
      stationMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'station',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<KotCollection, KotCollection, QAfterFilterCondition>
      stationIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'station',
        value: '',
      ));
    });
  }

  QueryBuilder<KotCollection, KotCollection, QAfterFilterCondition>
      stationIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'station',
        value: '',
      ));
    });
  }

  QueryBuilder<KotCollection, KotCollection, QAfterFilterCondition>
      statusEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'status',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<KotCollection, KotCollection, QAfterFilterCondition>
      statusGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'status',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<KotCollection, KotCollection, QAfterFilterCondition>
      statusLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'status',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<KotCollection, KotCollection, QAfterFilterCondition>
      statusBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'status',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<KotCollection, KotCollection, QAfterFilterCondition>
      statusStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'status',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<KotCollection, KotCollection, QAfterFilterCondition>
      statusEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'status',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<KotCollection, KotCollection, QAfterFilterCondition>
      statusContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'status',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<KotCollection, KotCollection, QAfterFilterCondition>
      statusMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'status',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<KotCollection, KotCollection, QAfterFilterCondition>
      statusIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'status',
        value: '',
      ));
    });
  }

  QueryBuilder<KotCollection, KotCollection, QAfterFilterCondition>
      statusIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'status',
        value: '',
      ));
    });
  }

  QueryBuilder<KotCollection, KotCollection, QAfterFilterCondition>
      tableIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'tableId',
      ));
    });
  }

  QueryBuilder<KotCollection, KotCollection, QAfterFilterCondition>
      tableIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'tableId',
      ));
    });
  }

  QueryBuilder<KotCollection, KotCollection, QAfterFilterCondition>
      tableIdEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'tableId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<KotCollection, KotCollection, QAfterFilterCondition>
      tableIdGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'tableId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<KotCollection, KotCollection, QAfterFilterCondition>
      tableIdLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'tableId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<KotCollection, KotCollection, QAfterFilterCondition>
      tableIdBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'tableId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<KotCollection, KotCollection, QAfterFilterCondition>
      tableIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'tableId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<KotCollection, KotCollection, QAfterFilterCondition>
      tableIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'tableId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<KotCollection, KotCollection, QAfterFilterCondition>
      tableIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'tableId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<KotCollection, KotCollection, QAfterFilterCondition>
      tableIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'tableId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<KotCollection, KotCollection, QAfterFilterCondition>
      tableIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'tableId',
        value: '',
      ));
    });
  }

  QueryBuilder<KotCollection, KotCollection, QAfterFilterCondition>
      tableIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'tableId',
        value: '',
      ));
    });
  }

  QueryBuilder<KotCollection, KotCollection, QAfterFilterCondition> uuidEqualTo(
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

  QueryBuilder<KotCollection, KotCollection, QAfterFilterCondition>
      uuidGreaterThan(
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

  QueryBuilder<KotCollection, KotCollection, QAfterFilterCondition>
      uuidLessThan(
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

  QueryBuilder<KotCollection, KotCollection, QAfterFilterCondition> uuidBetween(
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

  QueryBuilder<KotCollection, KotCollection, QAfterFilterCondition>
      uuidStartsWith(
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

  QueryBuilder<KotCollection, KotCollection, QAfterFilterCondition>
      uuidEndsWith(
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

  QueryBuilder<KotCollection, KotCollection, QAfterFilterCondition>
      uuidContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'uuid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<KotCollection, KotCollection, QAfterFilterCondition> uuidMatches(
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

  QueryBuilder<KotCollection, KotCollection, QAfterFilterCondition>
      uuidIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'uuid',
        value: '',
      ));
    });
  }

  QueryBuilder<KotCollection, KotCollection, QAfterFilterCondition>
      uuidIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'uuid',
        value: '',
      ));
    });
  }
}

extension KotCollectionQueryObject
    on QueryBuilder<KotCollection, KotCollection, QFilterCondition> {
  QueryBuilder<KotCollection, KotCollection, QAfterFilterCondition>
      itemsElement(FilterQuery<KotItemEmbedded> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'items');
    });
  }
}

extension KotCollectionQueryLinks
    on QueryBuilder<KotCollection, KotCollection, QFilterCondition> {}

extension KotCollectionQuerySortBy
    on QueryBuilder<KotCollection, KotCollection, QSortBy> {
  QueryBuilder<KotCollection, KotCollection, QAfterSortBy> sortByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<KotCollection, KotCollection, QAfterSortBy>
      sortByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<KotCollection, KotCollection, QAfterSortBy> sortByNotes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notes', Sort.asc);
    });
  }

  QueryBuilder<KotCollection, KotCollection, QAfterSortBy> sortByNotesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notes', Sort.desc);
    });
  }

  QueryBuilder<KotCollection, KotCollection, QAfterSortBy> sortByOrderId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'orderId', Sort.asc);
    });
  }

  QueryBuilder<KotCollection, KotCollection, QAfterSortBy> sortByOrderIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'orderId', Sort.desc);
    });
  }

  QueryBuilder<KotCollection, KotCollection, QAfterSortBy> sortByOrderType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'orderType', Sort.asc);
    });
  }

  QueryBuilder<KotCollection, KotCollection, QAfterSortBy>
      sortByOrderTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'orderType', Sort.desc);
    });
  }

  QueryBuilder<KotCollection, KotCollection, QAfterSortBy> sortByPriority() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'priority', Sort.asc);
    });
  }

  QueryBuilder<KotCollection, KotCollection, QAfterSortBy>
      sortByPriorityDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'priority', Sort.desc);
    });
  }

  QueryBuilder<KotCollection, KotCollection, QAfterSortBy> sortByStation() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'station', Sort.asc);
    });
  }

  QueryBuilder<KotCollection, KotCollection, QAfterSortBy> sortByStationDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'station', Sort.desc);
    });
  }

  QueryBuilder<KotCollection, KotCollection, QAfterSortBy> sortByStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.asc);
    });
  }

  QueryBuilder<KotCollection, KotCollection, QAfterSortBy> sortByStatusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.desc);
    });
  }

  QueryBuilder<KotCollection, KotCollection, QAfterSortBy> sortByTableId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tableId', Sort.asc);
    });
  }

  QueryBuilder<KotCollection, KotCollection, QAfterSortBy> sortByTableIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tableId', Sort.desc);
    });
  }

  QueryBuilder<KotCollection, KotCollection, QAfterSortBy> sortByUuid() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uuid', Sort.asc);
    });
  }

  QueryBuilder<KotCollection, KotCollection, QAfterSortBy> sortByUuidDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uuid', Sort.desc);
    });
  }
}

extension KotCollectionQuerySortThenBy
    on QueryBuilder<KotCollection, KotCollection, QSortThenBy> {
  QueryBuilder<KotCollection, KotCollection, QAfterSortBy> thenByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<KotCollection, KotCollection, QAfterSortBy>
      thenByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<KotCollection, KotCollection, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<KotCollection, KotCollection, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<KotCollection, KotCollection, QAfterSortBy> thenByNotes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notes', Sort.asc);
    });
  }

  QueryBuilder<KotCollection, KotCollection, QAfterSortBy> thenByNotesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notes', Sort.desc);
    });
  }

  QueryBuilder<KotCollection, KotCollection, QAfterSortBy> thenByOrderId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'orderId', Sort.asc);
    });
  }

  QueryBuilder<KotCollection, KotCollection, QAfterSortBy> thenByOrderIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'orderId', Sort.desc);
    });
  }

  QueryBuilder<KotCollection, KotCollection, QAfterSortBy> thenByOrderType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'orderType', Sort.asc);
    });
  }

  QueryBuilder<KotCollection, KotCollection, QAfterSortBy>
      thenByOrderTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'orderType', Sort.desc);
    });
  }

  QueryBuilder<KotCollection, KotCollection, QAfterSortBy> thenByPriority() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'priority', Sort.asc);
    });
  }

  QueryBuilder<KotCollection, KotCollection, QAfterSortBy>
      thenByPriorityDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'priority', Sort.desc);
    });
  }

  QueryBuilder<KotCollection, KotCollection, QAfterSortBy> thenByStation() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'station', Sort.asc);
    });
  }

  QueryBuilder<KotCollection, KotCollection, QAfterSortBy> thenByStationDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'station', Sort.desc);
    });
  }

  QueryBuilder<KotCollection, KotCollection, QAfterSortBy> thenByStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.asc);
    });
  }

  QueryBuilder<KotCollection, KotCollection, QAfterSortBy> thenByStatusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.desc);
    });
  }

  QueryBuilder<KotCollection, KotCollection, QAfterSortBy> thenByTableId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tableId', Sort.asc);
    });
  }

  QueryBuilder<KotCollection, KotCollection, QAfterSortBy> thenByTableIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tableId', Sort.desc);
    });
  }

  QueryBuilder<KotCollection, KotCollection, QAfterSortBy> thenByUuid() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uuid', Sort.asc);
    });
  }

  QueryBuilder<KotCollection, KotCollection, QAfterSortBy> thenByUuidDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uuid', Sort.desc);
    });
  }
}

extension KotCollectionQueryWhereDistinct
    on QueryBuilder<KotCollection, KotCollection, QDistinct> {
  QueryBuilder<KotCollection, KotCollection, QDistinct> distinctByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'createdAt');
    });
  }

  QueryBuilder<KotCollection, KotCollection, QDistinct> distinctByNotes(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'notes', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<KotCollection, KotCollection, QDistinct> distinctByOrderId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'orderId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<KotCollection, KotCollection, QDistinct> distinctByOrderType(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'orderType', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<KotCollection, KotCollection, QDistinct> distinctByPriority() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'priority');
    });
  }

  QueryBuilder<KotCollection, KotCollection, QDistinct> distinctByStation(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'station', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<KotCollection, KotCollection, QDistinct> distinctByStatus(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'status', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<KotCollection, KotCollection, QDistinct> distinctByTableId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'tableId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<KotCollection, KotCollection, QDistinct> distinctByUuid(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'uuid', caseSensitive: caseSensitive);
    });
  }
}

extension KotCollectionQueryProperty
    on QueryBuilder<KotCollection, KotCollection, QQueryProperty> {
  QueryBuilder<KotCollection, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<KotCollection, DateTime, QQueryOperations> createdAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'createdAt');
    });
  }

  QueryBuilder<KotCollection, List<KotItemEmbedded>, QQueryOperations>
      itemsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'items');
    });
  }

  QueryBuilder<KotCollection, String?, QQueryOperations> notesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'notes');
    });
  }

  QueryBuilder<KotCollection, String, QQueryOperations> orderIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'orderId');
    });
  }

  QueryBuilder<KotCollection, String, QQueryOperations> orderTypeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'orderType');
    });
  }

  QueryBuilder<KotCollection, int, QQueryOperations> priorityProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'priority');
    });
  }

  QueryBuilder<KotCollection, String, QQueryOperations> stationProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'station');
    });
  }

  QueryBuilder<KotCollection, String, QQueryOperations> statusProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'status');
    });
  }

  QueryBuilder<KotCollection, String?, QQueryOperations> tableIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'tableId');
    });
  }

  QueryBuilder<KotCollection, String, QQueryOperations> uuidProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'uuid');
    });
  }
}

// **************************************************************************
// IsarEmbeddedGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const KotItemEmbeddedSchema = Schema(
  name: r'KotItemEmbedded',
  id: (7831128593729 * 1000000 + 68711),
  properties: {
    r'modifiers': PropertySchema(
      id: 0,
      name: r'modifiers',
      type: IsarType.string,
    ),
    r'name': PropertySchema(
      id: 1,
      name: r'name',
      type: IsarType.string,
    ),
    r'notes': PropertySchema(
      id: 2,
      name: r'notes',
      type: IsarType.string,
    ),
    r'productId': PropertySchema(
      id: 3,
      name: r'productId',
      type: IsarType.string,
    ),
    r'quantity': PropertySchema(
      id: 4,
      name: r'quantity',
      type: IsarType.double,
    )
  },
  estimateSize: _kotItemEmbeddedEstimateSize,
  serialize: _kotItemEmbeddedSerialize,
  deserialize: _kotItemEmbeddedDeserialize,
  deserializeProp: _kotItemEmbeddedDeserializeProp,
);

int _kotItemEmbeddedEstimateSize(
  KotItemEmbedded object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.modifiers;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.name.length * 3;
  {
    final value = object.notes;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.productId.length * 3;
  return bytesCount;
}

void _kotItemEmbeddedSerialize(
  KotItemEmbedded object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.modifiers);
  writer.writeString(offsets[1], object.name);
  writer.writeString(offsets[2], object.notes);
  writer.writeString(offsets[3], object.productId);
  writer.writeDouble(offsets[4], object.quantity);
}

KotItemEmbedded _kotItemEmbeddedDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = KotItemEmbedded();
  object.modifiers = reader.readStringOrNull(offsets[0]);
  object.name = reader.readString(offsets[1]);
  object.notes = reader.readStringOrNull(offsets[2]);
  object.productId = reader.readString(offsets[3]);
  object.quantity = reader.readDouble(offsets[4]);
  return object;
}

P _kotItemEmbeddedDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringOrNull(offset)) as P;
    case 1:
      return (reader.readString(offset)) as P;
    case 2:
      return (reader.readStringOrNull(offset)) as P;
    case 3:
      return (reader.readString(offset)) as P;
    case 4:
      return (reader.readDouble(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension KotItemEmbeddedQueryFilter
    on QueryBuilder<KotItemEmbedded, KotItemEmbedded, QFilterCondition> {
  QueryBuilder<KotItemEmbedded, KotItemEmbedded, QAfterFilterCondition>
      modifiersIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'modifiers',
      ));
    });
  }

  QueryBuilder<KotItemEmbedded, KotItemEmbedded, QAfterFilterCondition>
      modifiersIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'modifiers',
      ));
    });
  }

  QueryBuilder<KotItemEmbedded, KotItemEmbedded, QAfterFilterCondition>
      modifiersEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'modifiers',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<KotItemEmbedded, KotItemEmbedded, QAfterFilterCondition>
      modifiersGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'modifiers',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<KotItemEmbedded, KotItemEmbedded, QAfterFilterCondition>
      modifiersLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'modifiers',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<KotItemEmbedded, KotItemEmbedded, QAfterFilterCondition>
      modifiersBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'modifiers',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<KotItemEmbedded, KotItemEmbedded, QAfterFilterCondition>
      modifiersStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'modifiers',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<KotItemEmbedded, KotItemEmbedded, QAfterFilterCondition>
      modifiersEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'modifiers',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<KotItemEmbedded, KotItemEmbedded, QAfterFilterCondition>
      modifiersContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'modifiers',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<KotItemEmbedded, KotItemEmbedded, QAfterFilterCondition>
      modifiersMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'modifiers',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<KotItemEmbedded, KotItemEmbedded, QAfterFilterCondition>
      modifiersIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'modifiers',
        value: '',
      ));
    });
  }

  QueryBuilder<KotItemEmbedded, KotItemEmbedded, QAfterFilterCondition>
      modifiersIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'modifiers',
        value: '',
      ));
    });
  }

  QueryBuilder<KotItemEmbedded, KotItemEmbedded, QAfterFilterCondition>
      nameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<KotItemEmbedded, KotItemEmbedded, QAfterFilterCondition>
      nameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<KotItemEmbedded, KotItemEmbedded, QAfterFilterCondition>
      nameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<KotItemEmbedded, KotItemEmbedded, QAfterFilterCondition>
      nameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'name',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<KotItemEmbedded, KotItemEmbedded, QAfterFilterCondition>
      nameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<KotItemEmbedded, KotItemEmbedded, QAfterFilterCondition>
      nameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<KotItemEmbedded, KotItemEmbedded, QAfterFilterCondition>
      nameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<KotItemEmbedded, KotItemEmbedded, QAfterFilterCondition>
      nameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'name',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<KotItemEmbedded, KotItemEmbedded, QAfterFilterCondition>
      nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<KotItemEmbedded, KotItemEmbedded, QAfterFilterCondition>
      nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<KotItemEmbedded, KotItemEmbedded, QAfterFilterCondition>
      notesIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'notes',
      ));
    });
  }

  QueryBuilder<KotItemEmbedded, KotItemEmbedded, QAfterFilterCondition>
      notesIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'notes',
      ));
    });
  }

  QueryBuilder<KotItemEmbedded, KotItemEmbedded, QAfterFilterCondition>
      notesEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'notes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<KotItemEmbedded, KotItemEmbedded, QAfterFilterCondition>
      notesGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'notes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<KotItemEmbedded, KotItemEmbedded, QAfterFilterCondition>
      notesLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'notes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<KotItemEmbedded, KotItemEmbedded, QAfterFilterCondition>
      notesBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'notes',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<KotItemEmbedded, KotItemEmbedded, QAfterFilterCondition>
      notesStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'notes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<KotItemEmbedded, KotItemEmbedded, QAfterFilterCondition>
      notesEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'notes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<KotItemEmbedded, KotItemEmbedded, QAfterFilterCondition>
      notesContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'notes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<KotItemEmbedded, KotItemEmbedded, QAfterFilterCondition>
      notesMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'notes',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<KotItemEmbedded, KotItemEmbedded, QAfterFilterCondition>
      notesIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'notes',
        value: '',
      ));
    });
  }

  QueryBuilder<KotItemEmbedded, KotItemEmbedded, QAfterFilterCondition>
      notesIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'notes',
        value: '',
      ));
    });
  }

  QueryBuilder<KotItemEmbedded, KotItemEmbedded, QAfterFilterCondition>
      productIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'productId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<KotItemEmbedded, KotItemEmbedded, QAfterFilterCondition>
      productIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'productId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<KotItemEmbedded, KotItemEmbedded, QAfterFilterCondition>
      productIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'productId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<KotItemEmbedded, KotItemEmbedded, QAfterFilterCondition>
      productIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'productId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<KotItemEmbedded, KotItemEmbedded, QAfterFilterCondition>
      productIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'productId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<KotItemEmbedded, KotItemEmbedded, QAfterFilterCondition>
      productIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'productId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<KotItemEmbedded, KotItemEmbedded, QAfterFilterCondition>
      productIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'productId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<KotItemEmbedded, KotItemEmbedded, QAfterFilterCondition>
      productIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'productId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<KotItemEmbedded, KotItemEmbedded, QAfterFilterCondition>
      productIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'productId',
        value: '',
      ));
    });
  }

  QueryBuilder<KotItemEmbedded, KotItemEmbedded, QAfterFilterCondition>
      productIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'productId',
        value: '',
      ));
    });
  }

  QueryBuilder<KotItemEmbedded, KotItemEmbedded, QAfterFilterCondition>
      quantityEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'quantity',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<KotItemEmbedded, KotItemEmbedded, QAfterFilterCondition>
      quantityGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'quantity',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<KotItemEmbedded, KotItemEmbedded, QAfterFilterCondition>
      quantityLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'quantity',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<KotItemEmbedded, KotItemEmbedded, QAfterFilterCondition>
      quantityBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'quantity',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }
}

extension KotItemEmbeddedQueryObject
    on QueryBuilder<KotItemEmbedded, KotItemEmbedded, QFilterCondition> {}
