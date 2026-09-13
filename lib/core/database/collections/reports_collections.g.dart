// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reports_collections.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetReportDefinitionCollectionCollection on Isar {
  IsarCollection<ReportDefinitionCollection> get reportDefinitionCollections =>
      this.collection();
}

const ReportDefinitionCollectionSchema = CollectionSchema(
  name: r'ReportDefinitionCollection',
  id: 3684625589356244345,
  properties: {
    r'aggregationJson': PropertySchema(
      id: 0,
      name: r'aggregationJson',
      type: IsarType.string,
    ),
    r'createdAt': PropertySchema(
      id: 1,
      name: r'createdAt',
      type: IsarType.dateTime,
    ),
    r'dataSource': PropertySchema(
      id: 2,
      name: r'dataSource',
      type: IsarType.string,
    ),
    r'description': PropertySchema(
      id: 3,
      name: r'description',
      type: IsarType.string,
    ),
    r'filtersJson': PropertySchema(
      id: 4,
      name: r'filtersJson',
      type: IsarType.string,
    ),
    r'groupByField': PropertySchema(
      id: 5,
      name: r'groupByField',
      type: IsarType.string,
    ),
    r'isPredefined': PropertySchema(
      id: 6,
      name: r'isPredefined',
      type: IsarType.bool,
    ),
    r'module': PropertySchema(
      id: 7,
      name: r'module',
      type: IsarType.string,
    ),
    r'name': PropertySchema(
      id: 8,
      name: r'name',
      type: IsarType.string,
    ),
    r'ownerId': PropertySchema(
      id: 9,
      name: r'ownerId',
      type: IsarType.string,
    ),
    r'reportType': PropertySchema(
      id: 10,
      name: r'reportType',
      type: IsarType.string,
    ),
    r'selectedFields': PropertySchema(
      id: 11,
      name: r'selectedFields',
      type: IsarType.stringList,
    ),
    r'sharedWithRoleIds': PropertySchema(
      id: 12,
      name: r'sharedWithRoleIds',
      type: IsarType.stringList,
    ),
    r'sortByField': PropertySchema(
      id: 13,
      name: r'sortByField',
      type: IsarType.string,
    ),
    r'sortDescending': PropertySchema(
      id: 14,
      name: r'sortDescending',
      type: IsarType.bool,
    ),
    r'updatedAt': PropertySchema(
      id: 15,
      name: r'updatedAt',
      type: IsarType.dateTime,
    ),
    r'uuid': PropertySchema(
      id: 16,
      name: r'uuid',
      type: IsarType.string,
    ),
    r'visualSettingsJson': PropertySchema(
      id: 17,
      name: r'visualSettingsJson',
      type: IsarType.string,
    )
  },
  estimateSize: _reportDefinitionCollectionEstimateSize,
  serialize: _reportDefinitionCollectionSerialize,
  deserialize: _reportDefinitionCollectionDeserialize,
  deserializeProp: _reportDefinitionCollectionDeserializeProp,
  idName: r'id',
  indexes: {
    r'uuid': IndexSchema(
      id: 2134397340427724972,
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
      id: 879695947855722453,
      name: r'name',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'name',
          type: IndexType.hash,
          caseSensitive: false,
        )
      ],
    ),
    r'module': IndexSchema(
      id: -8372774152552671714,
      name: r'module',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'module',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    ),
    r'ownerId': IndexSchema(
      id: -7594796109721319539,
      name: r'ownerId',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'ownerId',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _reportDefinitionCollectionGetId,
  getLinks: _reportDefinitionCollectionGetLinks,
  attach: _reportDefinitionCollectionAttach,
  version: '3.1.0+1',
);

int _reportDefinitionCollectionEstimateSize(
  ReportDefinitionCollection object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.aggregationJson;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.dataSource.length * 3;
  bytesCount += 3 + object.description.length * 3;
  {
    final value = object.filtersJson;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.groupByField;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.module.length * 3;
  bytesCount += 3 + object.name.length * 3;
  bytesCount += 3 + object.ownerId.length * 3;
  bytesCount += 3 + object.reportType.length * 3;
  bytesCount += 3 + object.selectedFields.length * 3;
  {
    for (var i = 0; i < object.selectedFields.length; i++) {
      final value = object.selectedFields[i];
      bytesCount += value.length * 3;
    }
  }
  bytesCount += 3 + object.sharedWithRoleIds.length * 3;
  {
    for (var i = 0; i < object.sharedWithRoleIds.length; i++) {
      final value = object.sharedWithRoleIds[i];
      bytesCount += value.length * 3;
    }
  }
  {
    final value = object.sortByField;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.uuid.length * 3;
  {
    final value = object.visualSettingsJson;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _reportDefinitionCollectionSerialize(
  ReportDefinitionCollection object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.aggregationJson);
  writer.writeDateTime(offsets[1], object.createdAt);
  writer.writeString(offsets[2], object.dataSource);
  writer.writeString(offsets[3], object.description);
  writer.writeString(offsets[4], object.filtersJson);
  writer.writeString(offsets[5], object.groupByField);
  writer.writeBool(offsets[6], object.isPredefined);
  writer.writeString(offsets[7], object.module);
  writer.writeString(offsets[8], object.name);
  writer.writeString(offsets[9], object.ownerId);
  writer.writeString(offsets[10], object.reportType);
  writer.writeStringList(offsets[11], object.selectedFields);
  writer.writeStringList(offsets[12], object.sharedWithRoleIds);
  writer.writeString(offsets[13], object.sortByField);
  writer.writeBool(offsets[14], object.sortDescending);
  writer.writeDateTime(offsets[15], object.updatedAt);
  writer.writeString(offsets[16], object.uuid);
  writer.writeString(offsets[17], object.visualSettingsJson);
}

ReportDefinitionCollection _reportDefinitionCollectionDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = ReportDefinitionCollection();
  object.aggregationJson = reader.readStringOrNull(offsets[0]);
  object.createdAt = reader.readDateTime(offsets[1]);
  object.dataSource = reader.readString(offsets[2]);
  object.description = reader.readString(offsets[3]);
  object.filtersJson = reader.readStringOrNull(offsets[4]);
  object.groupByField = reader.readStringOrNull(offsets[5]);
  object.id = id;
  object.isPredefined = reader.readBool(offsets[6]);
  object.module = reader.readString(offsets[7]);
  object.name = reader.readString(offsets[8]);
  object.ownerId = reader.readString(offsets[9]);
  object.reportType = reader.readString(offsets[10]);
  object.selectedFields = reader.readStringList(offsets[11]) ?? [];
  object.sharedWithRoleIds = reader.readStringList(offsets[12]) ?? [];
  object.sortByField = reader.readStringOrNull(offsets[13]);
  object.sortDescending = reader.readBool(offsets[14]);
  object.updatedAt = reader.readDateTime(offsets[15]);
  object.uuid = reader.readString(offsets[16]);
  object.visualSettingsJson = reader.readStringOrNull(offsets[17]);
  return object;
}

P _reportDefinitionCollectionDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringOrNull(offset)) as P;
    case 1:
      return (reader.readDateTime(offset)) as P;
    case 2:
      return (reader.readString(offset)) as P;
    case 3:
      return (reader.readString(offset)) as P;
    case 4:
      return (reader.readStringOrNull(offset)) as P;
    case 5:
      return (reader.readStringOrNull(offset)) as P;
    case 6:
      return (reader.readBool(offset)) as P;
    case 7:
      return (reader.readString(offset)) as P;
    case 8:
      return (reader.readString(offset)) as P;
    case 9:
      return (reader.readString(offset)) as P;
    case 10:
      return (reader.readString(offset)) as P;
    case 11:
      return (reader.readStringList(offset) ?? []) as P;
    case 12:
      return (reader.readStringList(offset) ?? []) as P;
    case 13:
      return (reader.readStringOrNull(offset)) as P;
    case 14:
      return (reader.readBool(offset)) as P;
    case 15:
      return (reader.readDateTime(offset)) as P;
    case 16:
      return (reader.readString(offset)) as P;
    case 17:
      return (reader.readStringOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _reportDefinitionCollectionGetId(ReportDefinitionCollection object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _reportDefinitionCollectionGetLinks(
    ReportDefinitionCollection object) {
  return [];
}

void _reportDefinitionCollectionAttach(
    IsarCollection<dynamic> col, Id id, ReportDefinitionCollection object) {
  object.id = id;
}

extension ReportDefinitionCollectionByIndex
    on IsarCollection<ReportDefinitionCollection> {
  Future<ReportDefinitionCollection?> getByUuid(String uuid) {
    return getByIndex(r'uuid', [uuid]);
  }

  ReportDefinitionCollection? getByUuidSync(String uuid) {
    return getByIndexSync(r'uuid', [uuid]);
  }

  Future<bool> deleteByUuid(String uuid) {
    return deleteByIndex(r'uuid', [uuid]);
  }

  bool deleteByUuidSync(String uuid) {
    return deleteByIndexSync(r'uuid', [uuid]);
  }

  Future<List<ReportDefinitionCollection?>> getAllByUuid(
      List<String> uuidValues) {
    final values = uuidValues.map((e) => [e]).toList();
    return getAllByIndex(r'uuid', values);
  }

  List<ReportDefinitionCollection?> getAllByUuidSync(List<String> uuidValues) {
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

  Future<Id> putByUuid(ReportDefinitionCollection object) {
    return putByIndex(r'uuid', object);
  }

  Id putByUuidSync(ReportDefinitionCollection object, {bool saveLinks = true}) {
    return putByIndexSync(r'uuid', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByUuid(List<ReportDefinitionCollection> objects) {
    return putAllByIndex(r'uuid', objects);
  }

  List<Id> putAllByUuidSync(List<ReportDefinitionCollection> objects,
      {bool saveLinks = true}) {
    return putAllByIndexSync(r'uuid', objects, saveLinks: saveLinks);
  }
}

extension ReportDefinitionCollectionQueryWhereSort on QueryBuilder<
    ReportDefinitionCollection, ReportDefinitionCollection, QWhere> {
  QueryBuilder<ReportDefinitionCollection, ReportDefinitionCollection,
      QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension ReportDefinitionCollectionQueryWhere on QueryBuilder<
    ReportDefinitionCollection, ReportDefinitionCollection, QWhereClause> {
  QueryBuilder<ReportDefinitionCollection, ReportDefinitionCollection,
      QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<ReportDefinitionCollection, ReportDefinitionCollection,
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

  QueryBuilder<ReportDefinitionCollection, ReportDefinitionCollection,
      QAfterWhereClause> idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<ReportDefinitionCollection, ReportDefinitionCollection,
      QAfterWhereClause> idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<ReportDefinitionCollection, ReportDefinitionCollection,
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

  QueryBuilder<ReportDefinitionCollection, ReportDefinitionCollection,
      QAfterWhereClause> uuidEqualTo(String uuid) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'uuid',
        value: [uuid],
      ));
    });
  }

  QueryBuilder<ReportDefinitionCollection, ReportDefinitionCollection,
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

  QueryBuilder<ReportDefinitionCollection, ReportDefinitionCollection,
      QAfterWhereClause> nameEqualTo(String name) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'name',
        value: [name],
      ));
    });
  }

  QueryBuilder<ReportDefinitionCollection, ReportDefinitionCollection,
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

  QueryBuilder<ReportDefinitionCollection, ReportDefinitionCollection,
      QAfterWhereClause> moduleEqualTo(String module) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'module',
        value: [module],
      ));
    });
  }

  QueryBuilder<ReportDefinitionCollection, ReportDefinitionCollection,
      QAfterWhereClause> moduleNotEqualTo(String module) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'module',
              lower: [],
              upper: [module],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'module',
              lower: [module],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'module',
              lower: [module],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'module',
              lower: [],
              upper: [module],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<ReportDefinitionCollection, ReportDefinitionCollection,
      QAfterWhereClause> ownerIdEqualTo(String ownerId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'ownerId',
        value: [ownerId],
      ));
    });
  }

  QueryBuilder<ReportDefinitionCollection, ReportDefinitionCollection,
      QAfterWhereClause> ownerIdNotEqualTo(String ownerId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'ownerId',
              lower: [],
              upper: [ownerId],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'ownerId',
              lower: [ownerId],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'ownerId',
              lower: [ownerId],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'ownerId',
              lower: [],
              upper: [ownerId],
              includeUpper: false,
            ));
      }
    });
  }
}

extension ReportDefinitionCollectionQueryFilter on QueryBuilder<
    ReportDefinitionCollection, ReportDefinitionCollection, QFilterCondition> {
  QueryBuilder<ReportDefinitionCollection, ReportDefinitionCollection,
      QAfterFilterCondition> aggregationJsonIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'aggregationJson',
      ));
    });
  }

  QueryBuilder<ReportDefinitionCollection, ReportDefinitionCollection,
      QAfterFilterCondition> aggregationJsonIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'aggregationJson',
      ));
    });
  }

  QueryBuilder<ReportDefinitionCollection, ReportDefinitionCollection,
      QAfterFilterCondition> aggregationJsonEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'aggregationJson',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ReportDefinitionCollection, ReportDefinitionCollection,
      QAfterFilterCondition> aggregationJsonGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'aggregationJson',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ReportDefinitionCollection, ReportDefinitionCollection,
      QAfterFilterCondition> aggregationJsonLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'aggregationJson',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ReportDefinitionCollection, ReportDefinitionCollection,
      QAfterFilterCondition> aggregationJsonBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'aggregationJson',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ReportDefinitionCollection, ReportDefinitionCollection,
      QAfterFilterCondition> aggregationJsonStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'aggregationJson',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ReportDefinitionCollection, ReportDefinitionCollection,
      QAfterFilterCondition> aggregationJsonEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'aggregationJson',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ReportDefinitionCollection, ReportDefinitionCollection,
          QAfterFilterCondition>
      aggregationJsonContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'aggregationJson',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ReportDefinitionCollection, ReportDefinitionCollection,
          QAfterFilterCondition>
      aggregationJsonMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'aggregationJson',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ReportDefinitionCollection, ReportDefinitionCollection,
      QAfterFilterCondition> aggregationJsonIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'aggregationJson',
        value: '',
      ));
    });
  }

  QueryBuilder<ReportDefinitionCollection, ReportDefinitionCollection,
      QAfterFilterCondition> aggregationJsonIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'aggregationJson',
        value: '',
      ));
    });
  }

  QueryBuilder<ReportDefinitionCollection, ReportDefinitionCollection,
      QAfterFilterCondition> createdAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<ReportDefinitionCollection, ReportDefinitionCollection,
      QAfterFilterCondition> createdAtGreaterThan(
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

  QueryBuilder<ReportDefinitionCollection, ReportDefinitionCollection,
      QAfterFilterCondition> createdAtLessThan(
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

  QueryBuilder<ReportDefinitionCollection, ReportDefinitionCollection,
      QAfterFilterCondition> createdAtBetween(
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

  QueryBuilder<ReportDefinitionCollection, ReportDefinitionCollection,
      QAfterFilterCondition> dataSourceEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'dataSource',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ReportDefinitionCollection, ReportDefinitionCollection,
      QAfterFilterCondition> dataSourceGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'dataSource',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ReportDefinitionCollection, ReportDefinitionCollection,
      QAfterFilterCondition> dataSourceLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'dataSource',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ReportDefinitionCollection, ReportDefinitionCollection,
      QAfterFilterCondition> dataSourceBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'dataSource',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ReportDefinitionCollection, ReportDefinitionCollection,
      QAfterFilterCondition> dataSourceStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'dataSource',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ReportDefinitionCollection, ReportDefinitionCollection,
      QAfterFilterCondition> dataSourceEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'dataSource',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ReportDefinitionCollection, ReportDefinitionCollection,
          QAfterFilterCondition>
      dataSourceContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'dataSource',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ReportDefinitionCollection, ReportDefinitionCollection,
          QAfterFilterCondition>
      dataSourceMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'dataSource',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ReportDefinitionCollection, ReportDefinitionCollection,
      QAfterFilterCondition> dataSourceIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'dataSource',
        value: '',
      ));
    });
  }

  QueryBuilder<ReportDefinitionCollection, ReportDefinitionCollection,
      QAfterFilterCondition> dataSourceIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'dataSource',
        value: '',
      ));
    });
  }

  QueryBuilder<ReportDefinitionCollection, ReportDefinitionCollection,
      QAfterFilterCondition> descriptionEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ReportDefinitionCollection, ReportDefinitionCollection,
      QAfterFilterCondition> descriptionGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ReportDefinitionCollection, ReportDefinitionCollection,
      QAfterFilterCondition> descriptionLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ReportDefinitionCollection, ReportDefinitionCollection,
      QAfterFilterCondition> descriptionBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'description',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ReportDefinitionCollection, ReportDefinitionCollection,
      QAfterFilterCondition> descriptionStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ReportDefinitionCollection, ReportDefinitionCollection,
      QAfterFilterCondition> descriptionEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ReportDefinitionCollection, ReportDefinitionCollection,
          QAfterFilterCondition>
      descriptionContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ReportDefinitionCollection, ReportDefinitionCollection,
          QAfterFilterCondition>
      descriptionMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'description',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ReportDefinitionCollection, ReportDefinitionCollection,
      QAfterFilterCondition> descriptionIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'description',
        value: '',
      ));
    });
  }

  QueryBuilder<ReportDefinitionCollection, ReportDefinitionCollection,
      QAfterFilterCondition> descriptionIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'description',
        value: '',
      ));
    });
  }

  QueryBuilder<ReportDefinitionCollection, ReportDefinitionCollection,
      QAfterFilterCondition> filtersJsonIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'filtersJson',
      ));
    });
  }

  QueryBuilder<ReportDefinitionCollection, ReportDefinitionCollection,
      QAfterFilterCondition> filtersJsonIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'filtersJson',
      ));
    });
  }

  QueryBuilder<ReportDefinitionCollection, ReportDefinitionCollection,
      QAfterFilterCondition> filtersJsonEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'filtersJson',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ReportDefinitionCollection, ReportDefinitionCollection,
      QAfterFilterCondition> filtersJsonGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'filtersJson',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ReportDefinitionCollection, ReportDefinitionCollection,
      QAfterFilterCondition> filtersJsonLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'filtersJson',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ReportDefinitionCollection, ReportDefinitionCollection,
      QAfterFilterCondition> filtersJsonBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'filtersJson',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ReportDefinitionCollection, ReportDefinitionCollection,
      QAfterFilterCondition> filtersJsonStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'filtersJson',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ReportDefinitionCollection, ReportDefinitionCollection,
      QAfterFilterCondition> filtersJsonEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'filtersJson',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ReportDefinitionCollection, ReportDefinitionCollection,
          QAfterFilterCondition>
      filtersJsonContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'filtersJson',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ReportDefinitionCollection, ReportDefinitionCollection,
          QAfterFilterCondition>
      filtersJsonMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'filtersJson',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ReportDefinitionCollection, ReportDefinitionCollection,
      QAfterFilterCondition> filtersJsonIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'filtersJson',
        value: '',
      ));
    });
  }

  QueryBuilder<ReportDefinitionCollection, ReportDefinitionCollection,
      QAfterFilterCondition> filtersJsonIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'filtersJson',
        value: '',
      ));
    });
  }

  QueryBuilder<ReportDefinitionCollection, ReportDefinitionCollection,
      QAfterFilterCondition> groupByFieldIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'groupByField',
      ));
    });
  }

  QueryBuilder<ReportDefinitionCollection, ReportDefinitionCollection,
      QAfterFilterCondition> groupByFieldIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'groupByField',
      ));
    });
  }

  QueryBuilder<ReportDefinitionCollection, ReportDefinitionCollection,
      QAfterFilterCondition> groupByFieldEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'groupByField',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ReportDefinitionCollection, ReportDefinitionCollection,
      QAfterFilterCondition> groupByFieldGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'groupByField',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ReportDefinitionCollection, ReportDefinitionCollection,
      QAfterFilterCondition> groupByFieldLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'groupByField',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ReportDefinitionCollection, ReportDefinitionCollection,
      QAfterFilterCondition> groupByFieldBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'groupByField',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ReportDefinitionCollection, ReportDefinitionCollection,
      QAfterFilterCondition> groupByFieldStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'groupByField',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ReportDefinitionCollection, ReportDefinitionCollection,
      QAfterFilterCondition> groupByFieldEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'groupByField',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ReportDefinitionCollection, ReportDefinitionCollection,
          QAfterFilterCondition>
      groupByFieldContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'groupByField',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ReportDefinitionCollection, ReportDefinitionCollection,
          QAfterFilterCondition>
      groupByFieldMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'groupByField',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ReportDefinitionCollection, ReportDefinitionCollection,
      QAfterFilterCondition> groupByFieldIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'groupByField',
        value: '',
      ));
    });
  }

  QueryBuilder<ReportDefinitionCollection, ReportDefinitionCollection,
      QAfterFilterCondition> groupByFieldIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'groupByField',
        value: '',
      ));
    });
  }

  QueryBuilder<ReportDefinitionCollection, ReportDefinitionCollection,
      QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<ReportDefinitionCollection, ReportDefinitionCollection,
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

  QueryBuilder<ReportDefinitionCollection, ReportDefinitionCollection,
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

  QueryBuilder<ReportDefinitionCollection, ReportDefinitionCollection,
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

  QueryBuilder<ReportDefinitionCollection, ReportDefinitionCollection,
      QAfterFilterCondition> isPredefinedEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isPredefined',
        value: value,
      ));
    });
  }

  QueryBuilder<ReportDefinitionCollection, ReportDefinitionCollection,
      QAfterFilterCondition> moduleEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'module',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ReportDefinitionCollection, ReportDefinitionCollection,
      QAfterFilterCondition> moduleGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'module',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ReportDefinitionCollection, ReportDefinitionCollection,
      QAfterFilterCondition> moduleLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'module',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ReportDefinitionCollection, ReportDefinitionCollection,
      QAfterFilterCondition> moduleBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'module',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ReportDefinitionCollection, ReportDefinitionCollection,
      QAfterFilterCondition> moduleStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'module',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ReportDefinitionCollection, ReportDefinitionCollection,
      QAfterFilterCondition> moduleEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'module',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ReportDefinitionCollection, ReportDefinitionCollection,
          QAfterFilterCondition>
      moduleContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'module',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ReportDefinitionCollection, ReportDefinitionCollection,
          QAfterFilterCondition>
      moduleMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'module',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ReportDefinitionCollection, ReportDefinitionCollection,
      QAfterFilterCondition> moduleIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'module',
        value: '',
      ));
    });
  }

  QueryBuilder<ReportDefinitionCollection, ReportDefinitionCollection,
      QAfterFilterCondition> moduleIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'module',
        value: '',
      ));
    });
  }

  QueryBuilder<ReportDefinitionCollection, ReportDefinitionCollection,
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

  QueryBuilder<ReportDefinitionCollection, ReportDefinitionCollection,
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

  QueryBuilder<ReportDefinitionCollection, ReportDefinitionCollection,
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

  QueryBuilder<ReportDefinitionCollection, ReportDefinitionCollection,
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

  QueryBuilder<ReportDefinitionCollection, ReportDefinitionCollection,
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

  QueryBuilder<ReportDefinitionCollection, ReportDefinitionCollection,
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

  QueryBuilder<ReportDefinitionCollection, ReportDefinitionCollection,
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

  QueryBuilder<ReportDefinitionCollection, ReportDefinitionCollection,
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

  QueryBuilder<ReportDefinitionCollection, ReportDefinitionCollection,
      QAfterFilterCondition> nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<ReportDefinitionCollection, ReportDefinitionCollection,
      QAfterFilterCondition> nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<ReportDefinitionCollection, ReportDefinitionCollection,
      QAfterFilterCondition> ownerIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'ownerId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ReportDefinitionCollection, ReportDefinitionCollection,
      QAfterFilterCondition> ownerIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'ownerId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ReportDefinitionCollection, ReportDefinitionCollection,
      QAfterFilterCondition> ownerIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'ownerId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ReportDefinitionCollection, ReportDefinitionCollection,
      QAfterFilterCondition> ownerIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'ownerId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ReportDefinitionCollection, ReportDefinitionCollection,
      QAfterFilterCondition> ownerIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'ownerId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ReportDefinitionCollection, ReportDefinitionCollection,
      QAfterFilterCondition> ownerIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'ownerId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ReportDefinitionCollection, ReportDefinitionCollection,
          QAfterFilterCondition>
      ownerIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'ownerId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ReportDefinitionCollection, ReportDefinitionCollection,
          QAfterFilterCondition>
      ownerIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'ownerId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ReportDefinitionCollection, ReportDefinitionCollection,
      QAfterFilterCondition> ownerIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'ownerId',
        value: '',
      ));
    });
  }

  QueryBuilder<ReportDefinitionCollection, ReportDefinitionCollection,
      QAfterFilterCondition> ownerIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'ownerId',
        value: '',
      ));
    });
  }

  QueryBuilder<ReportDefinitionCollection, ReportDefinitionCollection,
      QAfterFilterCondition> reportTypeEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'reportType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ReportDefinitionCollection, ReportDefinitionCollection,
      QAfterFilterCondition> reportTypeGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'reportType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ReportDefinitionCollection, ReportDefinitionCollection,
      QAfterFilterCondition> reportTypeLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'reportType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ReportDefinitionCollection, ReportDefinitionCollection,
      QAfterFilterCondition> reportTypeBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'reportType',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ReportDefinitionCollection, ReportDefinitionCollection,
      QAfterFilterCondition> reportTypeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'reportType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ReportDefinitionCollection, ReportDefinitionCollection,
      QAfterFilterCondition> reportTypeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'reportType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ReportDefinitionCollection, ReportDefinitionCollection,
          QAfterFilterCondition>
      reportTypeContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'reportType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ReportDefinitionCollection, ReportDefinitionCollection,
          QAfterFilterCondition>
      reportTypeMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'reportType',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ReportDefinitionCollection, ReportDefinitionCollection,
      QAfterFilterCondition> reportTypeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'reportType',
        value: '',
      ));
    });
  }

  QueryBuilder<ReportDefinitionCollection, ReportDefinitionCollection,
      QAfterFilterCondition> reportTypeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'reportType',
        value: '',
      ));
    });
  }

  QueryBuilder<ReportDefinitionCollection, ReportDefinitionCollection,
      QAfterFilterCondition> selectedFieldsElementEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'selectedFields',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ReportDefinitionCollection, ReportDefinitionCollection,
      QAfterFilterCondition> selectedFieldsElementGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'selectedFields',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ReportDefinitionCollection, ReportDefinitionCollection,
      QAfterFilterCondition> selectedFieldsElementLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'selectedFields',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ReportDefinitionCollection, ReportDefinitionCollection,
      QAfterFilterCondition> selectedFieldsElementBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'selectedFields',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ReportDefinitionCollection, ReportDefinitionCollection,
      QAfterFilterCondition> selectedFieldsElementStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'selectedFields',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ReportDefinitionCollection, ReportDefinitionCollection,
      QAfterFilterCondition> selectedFieldsElementEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'selectedFields',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ReportDefinitionCollection, ReportDefinitionCollection,
          QAfterFilterCondition>
      selectedFieldsElementContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'selectedFields',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ReportDefinitionCollection, ReportDefinitionCollection,
          QAfterFilterCondition>
      selectedFieldsElementMatches(String pattern,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'selectedFields',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ReportDefinitionCollection, ReportDefinitionCollection,
      QAfterFilterCondition> selectedFieldsElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'selectedFields',
        value: '',
      ));
    });
  }

  QueryBuilder<ReportDefinitionCollection, ReportDefinitionCollection,
      QAfterFilterCondition> selectedFieldsElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'selectedFields',
        value: '',
      ));
    });
  }

  QueryBuilder<ReportDefinitionCollection, ReportDefinitionCollection,
      QAfterFilterCondition> selectedFieldsLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'selectedFields',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<ReportDefinitionCollection, ReportDefinitionCollection,
      QAfterFilterCondition> selectedFieldsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'selectedFields',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<ReportDefinitionCollection, ReportDefinitionCollection,
      QAfterFilterCondition> selectedFieldsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'selectedFields',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<ReportDefinitionCollection, ReportDefinitionCollection,
      QAfterFilterCondition> selectedFieldsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'selectedFields',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<ReportDefinitionCollection, ReportDefinitionCollection,
      QAfterFilterCondition> selectedFieldsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'selectedFields',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<ReportDefinitionCollection, ReportDefinitionCollection,
      QAfterFilterCondition> selectedFieldsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'selectedFields',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<ReportDefinitionCollection, ReportDefinitionCollection,
      QAfterFilterCondition> sharedWithRoleIdsElementEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'sharedWithRoleIds',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ReportDefinitionCollection, ReportDefinitionCollection,
      QAfterFilterCondition> sharedWithRoleIdsElementGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'sharedWithRoleIds',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ReportDefinitionCollection, ReportDefinitionCollection,
      QAfterFilterCondition> sharedWithRoleIdsElementLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'sharedWithRoleIds',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ReportDefinitionCollection, ReportDefinitionCollection,
      QAfterFilterCondition> sharedWithRoleIdsElementBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'sharedWithRoleIds',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ReportDefinitionCollection, ReportDefinitionCollection,
      QAfterFilterCondition> sharedWithRoleIdsElementStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'sharedWithRoleIds',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ReportDefinitionCollection, ReportDefinitionCollection,
      QAfterFilterCondition> sharedWithRoleIdsElementEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'sharedWithRoleIds',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ReportDefinitionCollection, ReportDefinitionCollection,
          QAfterFilterCondition>
      sharedWithRoleIdsElementContains(String value,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'sharedWithRoleIds',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ReportDefinitionCollection, ReportDefinitionCollection,
          QAfterFilterCondition>
      sharedWithRoleIdsElementMatches(String pattern,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'sharedWithRoleIds',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ReportDefinitionCollection, ReportDefinitionCollection,
      QAfterFilterCondition> sharedWithRoleIdsElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'sharedWithRoleIds',
        value: '',
      ));
    });
  }

  QueryBuilder<ReportDefinitionCollection, ReportDefinitionCollection,
      QAfterFilterCondition> sharedWithRoleIdsElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'sharedWithRoleIds',
        value: '',
      ));
    });
  }

  QueryBuilder<ReportDefinitionCollection, ReportDefinitionCollection,
      QAfterFilterCondition> sharedWithRoleIdsLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'sharedWithRoleIds',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<ReportDefinitionCollection, ReportDefinitionCollection,
      QAfterFilterCondition> sharedWithRoleIdsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'sharedWithRoleIds',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<ReportDefinitionCollection, ReportDefinitionCollection,
      QAfterFilterCondition> sharedWithRoleIdsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'sharedWithRoleIds',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<ReportDefinitionCollection, ReportDefinitionCollection,
      QAfterFilterCondition> sharedWithRoleIdsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'sharedWithRoleIds',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<ReportDefinitionCollection, ReportDefinitionCollection,
      QAfterFilterCondition> sharedWithRoleIdsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'sharedWithRoleIds',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<ReportDefinitionCollection, ReportDefinitionCollection,
      QAfterFilterCondition> sharedWithRoleIdsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'sharedWithRoleIds',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<ReportDefinitionCollection, ReportDefinitionCollection,
      QAfterFilterCondition> sortByFieldIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'sortByField',
      ));
    });
  }

  QueryBuilder<ReportDefinitionCollection, ReportDefinitionCollection,
      QAfterFilterCondition> sortByFieldIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'sortByField',
      ));
    });
  }

  QueryBuilder<ReportDefinitionCollection, ReportDefinitionCollection,
      QAfterFilterCondition> sortByFieldEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'sortByField',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ReportDefinitionCollection, ReportDefinitionCollection,
      QAfterFilterCondition> sortByFieldGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'sortByField',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ReportDefinitionCollection, ReportDefinitionCollection,
      QAfterFilterCondition> sortByFieldLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'sortByField',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ReportDefinitionCollection, ReportDefinitionCollection,
      QAfterFilterCondition> sortByFieldBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'sortByField',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ReportDefinitionCollection, ReportDefinitionCollection,
      QAfterFilterCondition> sortByFieldStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'sortByField',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ReportDefinitionCollection, ReportDefinitionCollection,
      QAfterFilterCondition> sortByFieldEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'sortByField',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ReportDefinitionCollection, ReportDefinitionCollection,
          QAfterFilterCondition>
      sortByFieldContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'sortByField',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ReportDefinitionCollection, ReportDefinitionCollection,
          QAfterFilterCondition>
      sortByFieldMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'sortByField',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ReportDefinitionCollection, ReportDefinitionCollection,
      QAfterFilterCondition> sortByFieldIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'sortByField',
        value: '',
      ));
    });
  }

  QueryBuilder<ReportDefinitionCollection, ReportDefinitionCollection,
      QAfterFilterCondition> sortByFieldIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'sortByField',
        value: '',
      ));
    });
  }

  QueryBuilder<ReportDefinitionCollection, ReportDefinitionCollection,
      QAfterFilterCondition> sortDescendingEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'sortDescending',
        value: value,
      ));
    });
  }

  QueryBuilder<ReportDefinitionCollection, ReportDefinitionCollection,
      QAfterFilterCondition> updatedAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'updatedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<ReportDefinitionCollection, ReportDefinitionCollection,
      QAfterFilterCondition> updatedAtGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'updatedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<ReportDefinitionCollection, ReportDefinitionCollection,
      QAfterFilterCondition> updatedAtLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'updatedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<ReportDefinitionCollection, ReportDefinitionCollection,
      QAfterFilterCondition> updatedAtBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'updatedAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ReportDefinitionCollection, ReportDefinitionCollection,
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

  QueryBuilder<ReportDefinitionCollection, ReportDefinitionCollection,
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

  QueryBuilder<ReportDefinitionCollection, ReportDefinitionCollection,
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

  QueryBuilder<ReportDefinitionCollection, ReportDefinitionCollection,
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

  QueryBuilder<ReportDefinitionCollection, ReportDefinitionCollection,
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

  QueryBuilder<ReportDefinitionCollection, ReportDefinitionCollection,
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

  QueryBuilder<ReportDefinitionCollection, ReportDefinitionCollection,
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

  QueryBuilder<ReportDefinitionCollection, ReportDefinitionCollection,
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

  QueryBuilder<ReportDefinitionCollection, ReportDefinitionCollection,
      QAfterFilterCondition> uuidIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'uuid',
        value: '',
      ));
    });
  }

  QueryBuilder<ReportDefinitionCollection, ReportDefinitionCollection,
      QAfterFilterCondition> uuidIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'uuid',
        value: '',
      ));
    });
  }

  QueryBuilder<ReportDefinitionCollection, ReportDefinitionCollection,
      QAfterFilterCondition> visualSettingsJsonIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'visualSettingsJson',
      ));
    });
  }

  QueryBuilder<ReportDefinitionCollection, ReportDefinitionCollection,
      QAfterFilterCondition> visualSettingsJsonIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'visualSettingsJson',
      ));
    });
  }

  QueryBuilder<ReportDefinitionCollection, ReportDefinitionCollection,
      QAfterFilterCondition> visualSettingsJsonEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'visualSettingsJson',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ReportDefinitionCollection, ReportDefinitionCollection,
      QAfterFilterCondition> visualSettingsJsonGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'visualSettingsJson',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ReportDefinitionCollection, ReportDefinitionCollection,
      QAfterFilterCondition> visualSettingsJsonLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'visualSettingsJson',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ReportDefinitionCollection, ReportDefinitionCollection,
      QAfterFilterCondition> visualSettingsJsonBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'visualSettingsJson',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ReportDefinitionCollection, ReportDefinitionCollection,
      QAfterFilterCondition> visualSettingsJsonStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'visualSettingsJson',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ReportDefinitionCollection, ReportDefinitionCollection,
      QAfterFilterCondition> visualSettingsJsonEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'visualSettingsJson',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ReportDefinitionCollection, ReportDefinitionCollection,
          QAfterFilterCondition>
      visualSettingsJsonContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'visualSettingsJson',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ReportDefinitionCollection, ReportDefinitionCollection,
          QAfterFilterCondition>
      visualSettingsJsonMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'visualSettingsJson',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ReportDefinitionCollection, ReportDefinitionCollection,
      QAfterFilterCondition> visualSettingsJsonIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'visualSettingsJson',
        value: '',
      ));
    });
  }

  QueryBuilder<ReportDefinitionCollection, ReportDefinitionCollection,
      QAfterFilterCondition> visualSettingsJsonIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'visualSettingsJson',
        value: '',
      ));
    });
  }
}

extension ReportDefinitionCollectionQueryObject on QueryBuilder<
    ReportDefinitionCollection, ReportDefinitionCollection, QFilterCondition> {}

extension ReportDefinitionCollectionQueryLinks on QueryBuilder<
    ReportDefinitionCollection, ReportDefinitionCollection, QFilterCondition> {}

extension ReportDefinitionCollectionQuerySortBy on QueryBuilder<
    ReportDefinitionCollection, ReportDefinitionCollection, QSortBy> {
  QueryBuilder<ReportDefinitionCollection, ReportDefinitionCollection,
      QAfterSortBy> sortByAggregationJson() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'aggregationJson', Sort.asc);
    });
  }

  QueryBuilder<ReportDefinitionCollection, ReportDefinitionCollection,
      QAfterSortBy> sortByAggregationJsonDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'aggregationJson', Sort.desc);
    });
  }

  QueryBuilder<ReportDefinitionCollection, ReportDefinitionCollection,
      QAfterSortBy> sortByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<ReportDefinitionCollection, ReportDefinitionCollection,
      QAfterSortBy> sortByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<ReportDefinitionCollection, ReportDefinitionCollection,
      QAfterSortBy> sortByDataSource() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dataSource', Sort.asc);
    });
  }

  QueryBuilder<ReportDefinitionCollection, ReportDefinitionCollection,
      QAfterSortBy> sortByDataSourceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dataSource', Sort.desc);
    });
  }

  QueryBuilder<ReportDefinitionCollection, ReportDefinitionCollection,
      QAfterSortBy> sortByDescription() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.asc);
    });
  }

  QueryBuilder<ReportDefinitionCollection, ReportDefinitionCollection,
      QAfterSortBy> sortByDescriptionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.desc);
    });
  }

  QueryBuilder<ReportDefinitionCollection, ReportDefinitionCollection,
      QAfterSortBy> sortByFiltersJson() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'filtersJson', Sort.asc);
    });
  }

  QueryBuilder<ReportDefinitionCollection, ReportDefinitionCollection,
      QAfterSortBy> sortByFiltersJsonDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'filtersJson', Sort.desc);
    });
  }

  QueryBuilder<ReportDefinitionCollection, ReportDefinitionCollection,
      QAfterSortBy> sortByGroupByField() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'groupByField', Sort.asc);
    });
  }

  QueryBuilder<ReportDefinitionCollection, ReportDefinitionCollection,
      QAfterSortBy> sortByGroupByFieldDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'groupByField', Sort.desc);
    });
  }

  QueryBuilder<ReportDefinitionCollection, ReportDefinitionCollection,
      QAfterSortBy> sortByIsPredefined() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isPredefined', Sort.asc);
    });
  }

  QueryBuilder<ReportDefinitionCollection, ReportDefinitionCollection,
      QAfterSortBy> sortByIsPredefinedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isPredefined', Sort.desc);
    });
  }

  QueryBuilder<ReportDefinitionCollection, ReportDefinitionCollection,
      QAfterSortBy> sortByModule() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'module', Sort.asc);
    });
  }

  QueryBuilder<ReportDefinitionCollection, ReportDefinitionCollection,
      QAfterSortBy> sortByModuleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'module', Sort.desc);
    });
  }

  QueryBuilder<ReportDefinitionCollection, ReportDefinitionCollection,
      QAfterSortBy> sortByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<ReportDefinitionCollection, ReportDefinitionCollection,
      QAfterSortBy> sortByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<ReportDefinitionCollection, ReportDefinitionCollection,
      QAfterSortBy> sortByOwnerId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ownerId', Sort.asc);
    });
  }

  QueryBuilder<ReportDefinitionCollection, ReportDefinitionCollection,
      QAfterSortBy> sortByOwnerIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ownerId', Sort.desc);
    });
  }

  QueryBuilder<ReportDefinitionCollection, ReportDefinitionCollection,
      QAfterSortBy> sortByReportType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'reportType', Sort.asc);
    });
  }

  QueryBuilder<ReportDefinitionCollection, ReportDefinitionCollection,
      QAfterSortBy> sortByReportTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'reportType', Sort.desc);
    });
  }

  QueryBuilder<ReportDefinitionCollection, ReportDefinitionCollection,
      QAfterSortBy> sortBySortByField() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sortByField', Sort.asc);
    });
  }

  QueryBuilder<ReportDefinitionCollection, ReportDefinitionCollection,
      QAfterSortBy> sortBySortByFieldDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sortByField', Sort.desc);
    });
  }

  QueryBuilder<ReportDefinitionCollection, ReportDefinitionCollection,
      QAfterSortBy> sortBySortDescending() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sortDescending', Sort.asc);
    });
  }

  QueryBuilder<ReportDefinitionCollection, ReportDefinitionCollection,
      QAfterSortBy> sortBySortDescendingDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sortDescending', Sort.desc);
    });
  }

  QueryBuilder<ReportDefinitionCollection, ReportDefinitionCollection,
      QAfterSortBy> sortByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.asc);
    });
  }

  QueryBuilder<ReportDefinitionCollection, ReportDefinitionCollection,
      QAfterSortBy> sortByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.desc);
    });
  }

  QueryBuilder<ReportDefinitionCollection, ReportDefinitionCollection,
      QAfterSortBy> sortByUuid() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uuid', Sort.asc);
    });
  }

  QueryBuilder<ReportDefinitionCollection, ReportDefinitionCollection,
      QAfterSortBy> sortByUuidDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uuid', Sort.desc);
    });
  }

  QueryBuilder<ReportDefinitionCollection, ReportDefinitionCollection,
      QAfterSortBy> sortByVisualSettingsJson() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'visualSettingsJson', Sort.asc);
    });
  }

  QueryBuilder<ReportDefinitionCollection, ReportDefinitionCollection,
      QAfterSortBy> sortByVisualSettingsJsonDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'visualSettingsJson', Sort.desc);
    });
  }
}

extension ReportDefinitionCollectionQuerySortThenBy on QueryBuilder<
    ReportDefinitionCollection, ReportDefinitionCollection, QSortThenBy> {
  QueryBuilder<ReportDefinitionCollection, ReportDefinitionCollection,
      QAfterSortBy> thenByAggregationJson() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'aggregationJson', Sort.asc);
    });
  }

  QueryBuilder<ReportDefinitionCollection, ReportDefinitionCollection,
      QAfterSortBy> thenByAggregationJsonDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'aggregationJson', Sort.desc);
    });
  }

  QueryBuilder<ReportDefinitionCollection, ReportDefinitionCollection,
      QAfterSortBy> thenByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<ReportDefinitionCollection, ReportDefinitionCollection,
      QAfterSortBy> thenByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<ReportDefinitionCollection, ReportDefinitionCollection,
      QAfterSortBy> thenByDataSource() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dataSource', Sort.asc);
    });
  }

  QueryBuilder<ReportDefinitionCollection, ReportDefinitionCollection,
      QAfterSortBy> thenByDataSourceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dataSource', Sort.desc);
    });
  }

  QueryBuilder<ReportDefinitionCollection, ReportDefinitionCollection,
      QAfterSortBy> thenByDescription() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.asc);
    });
  }

  QueryBuilder<ReportDefinitionCollection, ReportDefinitionCollection,
      QAfterSortBy> thenByDescriptionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.desc);
    });
  }

  QueryBuilder<ReportDefinitionCollection, ReportDefinitionCollection,
      QAfterSortBy> thenByFiltersJson() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'filtersJson', Sort.asc);
    });
  }

  QueryBuilder<ReportDefinitionCollection, ReportDefinitionCollection,
      QAfterSortBy> thenByFiltersJsonDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'filtersJson', Sort.desc);
    });
  }

  QueryBuilder<ReportDefinitionCollection, ReportDefinitionCollection,
      QAfterSortBy> thenByGroupByField() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'groupByField', Sort.asc);
    });
  }

  QueryBuilder<ReportDefinitionCollection, ReportDefinitionCollection,
      QAfterSortBy> thenByGroupByFieldDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'groupByField', Sort.desc);
    });
  }

  QueryBuilder<ReportDefinitionCollection, ReportDefinitionCollection,
      QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<ReportDefinitionCollection, ReportDefinitionCollection,
      QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<ReportDefinitionCollection, ReportDefinitionCollection,
      QAfterSortBy> thenByIsPredefined() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isPredefined', Sort.asc);
    });
  }

  QueryBuilder<ReportDefinitionCollection, ReportDefinitionCollection,
      QAfterSortBy> thenByIsPredefinedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isPredefined', Sort.desc);
    });
  }

  QueryBuilder<ReportDefinitionCollection, ReportDefinitionCollection,
      QAfterSortBy> thenByModule() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'module', Sort.asc);
    });
  }

  QueryBuilder<ReportDefinitionCollection, ReportDefinitionCollection,
      QAfterSortBy> thenByModuleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'module', Sort.desc);
    });
  }

  QueryBuilder<ReportDefinitionCollection, ReportDefinitionCollection,
      QAfterSortBy> thenByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<ReportDefinitionCollection, ReportDefinitionCollection,
      QAfterSortBy> thenByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<ReportDefinitionCollection, ReportDefinitionCollection,
      QAfterSortBy> thenByOwnerId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ownerId', Sort.asc);
    });
  }

  QueryBuilder<ReportDefinitionCollection, ReportDefinitionCollection,
      QAfterSortBy> thenByOwnerIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ownerId', Sort.desc);
    });
  }

  QueryBuilder<ReportDefinitionCollection, ReportDefinitionCollection,
      QAfterSortBy> thenByReportType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'reportType', Sort.asc);
    });
  }

  QueryBuilder<ReportDefinitionCollection, ReportDefinitionCollection,
      QAfterSortBy> thenByReportTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'reportType', Sort.desc);
    });
  }

  QueryBuilder<ReportDefinitionCollection, ReportDefinitionCollection,
      QAfterSortBy> thenBySortByField() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sortByField', Sort.asc);
    });
  }

  QueryBuilder<ReportDefinitionCollection, ReportDefinitionCollection,
      QAfterSortBy> thenBySortByFieldDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sortByField', Sort.desc);
    });
  }

  QueryBuilder<ReportDefinitionCollection, ReportDefinitionCollection,
      QAfterSortBy> thenBySortDescending() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sortDescending', Sort.asc);
    });
  }

  QueryBuilder<ReportDefinitionCollection, ReportDefinitionCollection,
      QAfterSortBy> thenBySortDescendingDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sortDescending', Sort.desc);
    });
  }

  QueryBuilder<ReportDefinitionCollection, ReportDefinitionCollection,
      QAfterSortBy> thenByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.asc);
    });
  }

  QueryBuilder<ReportDefinitionCollection, ReportDefinitionCollection,
      QAfterSortBy> thenByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.desc);
    });
  }

  QueryBuilder<ReportDefinitionCollection, ReportDefinitionCollection,
      QAfterSortBy> thenByUuid() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uuid', Sort.asc);
    });
  }

  QueryBuilder<ReportDefinitionCollection, ReportDefinitionCollection,
      QAfterSortBy> thenByUuidDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uuid', Sort.desc);
    });
  }

  QueryBuilder<ReportDefinitionCollection, ReportDefinitionCollection,
      QAfterSortBy> thenByVisualSettingsJson() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'visualSettingsJson', Sort.asc);
    });
  }

  QueryBuilder<ReportDefinitionCollection, ReportDefinitionCollection,
      QAfterSortBy> thenByVisualSettingsJsonDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'visualSettingsJson', Sort.desc);
    });
  }
}

extension ReportDefinitionCollectionQueryWhereDistinct on QueryBuilder<
    ReportDefinitionCollection, ReportDefinitionCollection, QDistinct> {
  QueryBuilder<ReportDefinitionCollection, ReportDefinitionCollection,
      QDistinct> distinctByAggregationJson({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'aggregationJson',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ReportDefinitionCollection, ReportDefinitionCollection,
      QDistinct> distinctByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'createdAt');
    });
  }

  QueryBuilder<ReportDefinitionCollection, ReportDefinitionCollection,
      QDistinct> distinctByDataSource({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'dataSource', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ReportDefinitionCollection, ReportDefinitionCollection,
      QDistinct> distinctByDescription({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'description', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ReportDefinitionCollection, ReportDefinitionCollection,
      QDistinct> distinctByFiltersJson({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'filtersJson', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ReportDefinitionCollection, ReportDefinitionCollection,
      QDistinct> distinctByGroupByField({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'groupByField', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ReportDefinitionCollection, ReportDefinitionCollection,
      QDistinct> distinctByIsPredefined() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isPredefined');
    });
  }

  QueryBuilder<ReportDefinitionCollection, ReportDefinitionCollection,
      QDistinct> distinctByModule({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'module', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ReportDefinitionCollection, ReportDefinitionCollection,
      QDistinct> distinctByName({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'name', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ReportDefinitionCollection, ReportDefinitionCollection,
      QDistinct> distinctByOwnerId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'ownerId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ReportDefinitionCollection, ReportDefinitionCollection,
      QDistinct> distinctByReportType({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'reportType', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ReportDefinitionCollection, ReportDefinitionCollection,
      QDistinct> distinctBySelectedFields() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'selectedFields');
    });
  }

  QueryBuilder<ReportDefinitionCollection, ReportDefinitionCollection,
      QDistinct> distinctBySharedWithRoleIds() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'sharedWithRoleIds');
    });
  }

  QueryBuilder<ReportDefinitionCollection, ReportDefinitionCollection,
      QDistinct> distinctBySortByField({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'sortByField', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ReportDefinitionCollection, ReportDefinitionCollection,
      QDistinct> distinctBySortDescending() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'sortDescending');
    });
  }

  QueryBuilder<ReportDefinitionCollection, ReportDefinitionCollection,
      QDistinct> distinctByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'updatedAt');
    });
  }

  QueryBuilder<ReportDefinitionCollection, ReportDefinitionCollection,
      QDistinct> distinctByUuid({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'uuid', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ReportDefinitionCollection, ReportDefinitionCollection,
      QDistinct> distinctByVisualSettingsJson({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'visualSettingsJson',
          caseSensitive: caseSensitive);
    });
  }
}

extension ReportDefinitionCollectionQueryProperty on QueryBuilder<
    ReportDefinitionCollection, ReportDefinitionCollection, QQueryProperty> {
  QueryBuilder<ReportDefinitionCollection, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<ReportDefinitionCollection, String?, QQueryOperations>
      aggregationJsonProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'aggregationJson');
    });
  }

  QueryBuilder<ReportDefinitionCollection, DateTime, QQueryOperations>
      createdAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'createdAt');
    });
  }

  QueryBuilder<ReportDefinitionCollection, String, QQueryOperations>
      dataSourceProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'dataSource');
    });
  }

  QueryBuilder<ReportDefinitionCollection, String, QQueryOperations>
      descriptionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'description');
    });
  }

  QueryBuilder<ReportDefinitionCollection, String?, QQueryOperations>
      filtersJsonProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'filtersJson');
    });
  }

  QueryBuilder<ReportDefinitionCollection, String?, QQueryOperations>
      groupByFieldProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'groupByField');
    });
  }

  QueryBuilder<ReportDefinitionCollection, bool, QQueryOperations>
      isPredefinedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isPredefined');
    });
  }

  QueryBuilder<ReportDefinitionCollection, String, QQueryOperations>
      moduleProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'module');
    });
  }

  QueryBuilder<ReportDefinitionCollection, String, QQueryOperations>
      nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'name');
    });
  }

  QueryBuilder<ReportDefinitionCollection, String, QQueryOperations>
      ownerIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'ownerId');
    });
  }

  QueryBuilder<ReportDefinitionCollection, String, QQueryOperations>
      reportTypeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'reportType');
    });
  }

  QueryBuilder<ReportDefinitionCollection, List<String>, QQueryOperations>
      selectedFieldsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'selectedFields');
    });
  }

  QueryBuilder<ReportDefinitionCollection, List<String>, QQueryOperations>
      sharedWithRoleIdsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'sharedWithRoleIds');
    });
  }

  QueryBuilder<ReportDefinitionCollection, String?, QQueryOperations>
      sortByFieldProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'sortByField');
    });
  }

  QueryBuilder<ReportDefinitionCollection, bool, QQueryOperations>
      sortDescendingProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'sortDescending');
    });
  }

  QueryBuilder<ReportDefinitionCollection, DateTime, QQueryOperations>
      updatedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'updatedAt');
    });
  }

  QueryBuilder<ReportDefinitionCollection, String, QQueryOperations>
      uuidProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'uuid');
    });
  }

  QueryBuilder<ReportDefinitionCollection, String?, QQueryOperations>
      visualSettingsJsonProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'visualSettingsJson');
    });
  }
}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetDashboardDefinitionCollectionCollection on Isar {
  IsarCollection<DashboardDefinitionCollection>
      get dashboardDefinitionCollections => this.collection();
}

const DashboardDefinitionCollectionSchema = CollectionSchema(
  name: r'DashboardDefinitionCollection',
  id: 786008024867890645,
  properties: {
    r'createdAt': PropertySchema(
      id: 0,
      name: r'createdAt',
      type: IsarType.dateTime,
    ),
    r'layoutJson': PropertySchema(
      id: 1,
      name: r'layoutJson',
      type: IsarType.string,
    ),
    r'ownerId': PropertySchema(
      id: 2,
      name: r'ownerId',
      type: IsarType.string,
    ),
    r'scope': PropertySchema(
      id: 3,
      name: r'scope',
      type: IsarType.string,
    ),
    r'title': PropertySchema(
      id: 4,
      name: r'title',
      type: IsarType.string,
    ),
    r'updatedAt': PropertySchema(
      id: 5,
      name: r'updatedAt',
      type: IsarType.dateTime,
    ),
    r'uuid': PropertySchema(
      id: 6,
      name: r'uuid',
      type: IsarType.string,
    )
  },
  estimateSize: _dashboardDefinitionCollectionEstimateSize,
  serialize: _dashboardDefinitionCollectionSerialize,
  deserialize: _dashboardDefinitionCollectionDeserialize,
  deserializeProp: _dashboardDefinitionCollectionDeserializeProp,
  idName: r'id',
  indexes: {
    r'uuid': IndexSchema(
      id: 2134397340427724972,
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
    r'title': IndexSchema(
      id: -7636685945352118059,
      name: r'title',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'title',
          type: IndexType.hash,
          caseSensitive: false,
        )
      ],
    ),
    r'scope': IndexSchema(
      id: 152078781581678656,
      name: r'scope',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'scope',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    ),
    r'ownerId': IndexSchema(
      id: -7594796109721319539,
      name: r'ownerId',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'ownerId',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _dashboardDefinitionCollectionGetId,
  getLinks: _dashboardDefinitionCollectionGetLinks,
  attach: _dashboardDefinitionCollectionAttach,
  version: '3.1.0+1',
);

int _dashboardDefinitionCollectionEstimateSize(
  DashboardDefinitionCollection object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.layoutJson;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.ownerId.length * 3;
  bytesCount += 3 + object.scope.length * 3;
  bytesCount += 3 + object.title.length * 3;
  bytesCount += 3 + object.uuid.length * 3;
  return bytesCount;
}

void _dashboardDefinitionCollectionSerialize(
  DashboardDefinitionCollection object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDateTime(offsets[0], object.createdAt);
  writer.writeString(offsets[1], object.layoutJson);
  writer.writeString(offsets[2], object.ownerId);
  writer.writeString(offsets[3], object.scope);
  writer.writeString(offsets[4], object.title);
  writer.writeDateTime(offsets[5], object.updatedAt);
  writer.writeString(offsets[6], object.uuid);
}

DashboardDefinitionCollection _dashboardDefinitionCollectionDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = DashboardDefinitionCollection();
  object.createdAt = reader.readDateTime(offsets[0]);
  object.id = id;
  object.layoutJson = reader.readStringOrNull(offsets[1]);
  object.ownerId = reader.readString(offsets[2]);
  object.scope = reader.readString(offsets[3]);
  object.title = reader.readString(offsets[4]);
  object.updatedAt = reader.readDateTime(offsets[5]);
  object.uuid = reader.readString(offsets[6]);
  return object;
}

P _dashboardDefinitionCollectionDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDateTime(offset)) as P;
    case 1:
      return (reader.readStringOrNull(offset)) as P;
    case 2:
      return (reader.readString(offset)) as P;
    case 3:
      return (reader.readString(offset)) as P;
    case 4:
      return (reader.readString(offset)) as P;
    case 5:
      return (reader.readDateTime(offset)) as P;
    case 6:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _dashboardDefinitionCollectionGetId(DashboardDefinitionCollection object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _dashboardDefinitionCollectionGetLinks(
    DashboardDefinitionCollection object) {
  return [];
}

void _dashboardDefinitionCollectionAttach(
    IsarCollection<dynamic> col, Id id, DashboardDefinitionCollection object) {
  object.id = id;
}

extension DashboardDefinitionCollectionByIndex
    on IsarCollection<DashboardDefinitionCollection> {
  Future<DashboardDefinitionCollection?> getByUuid(String uuid) {
    return getByIndex(r'uuid', [uuid]);
  }

  DashboardDefinitionCollection? getByUuidSync(String uuid) {
    return getByIndexSync(r'uuid', [uuid]);
  }

  Future<bool> deleteByUuid(String uuid) {
    return deleteByIndex(r'uuid', [uuid]);
  }

  bool deleteByUuidSync(String uuid) {
    return deleteByIndexSync(r'uuid', [uuid]);
  }

  Future<List<DashboardDefinitionCollection?>> getAllByUuid(
      List<String> uuidValues) {
    final values = uuidValues.map((e) => [e]).toList();
    return getAllByIndex(r'uuid', values);
  }

  List<DashboardDefinitionCollection?> getAllByUuidSync(
      List<String> uuidValues) {
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

  Future<Id> putByUuid(DashboardDefinitionCollection object) {
    return putByIndex(r'uuid', object);
  }

  Id putByUuidSync(DashboardDefinitionCollection object,
      {bool saveLinks = true}) {
    return putByIndexSync(r'uuid', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByUuid(List<DashboardDefinitionCollection> objects) {
    return putAllByIndex(r'uuid', objects);
  }

  List<Id> putAllByUuidSync(List<DashboardDefinitionCollection> objects,
      {bool saveLinks = true}) {
    return putAllByIndexSync(r'uuid', objects, saveLinks: saveLinks);
  }
}

extension DashboardDefinitionCollectionQueryWhereSort on QueryBuilder<
    DashboardDefinitionCollection, DashboardDefinitionCollection, QWhere> {
  QueryBuilder<DashboardDefinitionCollection, DashboardDefinitionCollection,
      QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension DashboardDefinitionCollectionQueryWhere on QueryBuilder<
    DashboardDefinitionCollection,
    DashboardDefinitionCollection,
    QWhereClause> {
  QueryBuilder<DashboardDefinitionCollection, DashboardDefinitionCollection,
      QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<DashboardDefinitionCollection, DashboardDefinitionCollection,
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

  QueryBuilder<DashboardDefinitionCollection, DashboardDefinitionCollection,
      QAfterWhereClause> idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<DashboardDefinitionCollection, DashboardDefinitionCollection,
      QAfterWhereClause> idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<DashboardDefinitionCollection, DashboardDefinitionCollection,
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

  QueryBuilder<DashboardDefinitionCollection, DashboardDefinitionCollection,
      QAfterWhereClause> uuidEqualTo(String uuid) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'uuid',
        value: [uuid],
      ));
    });
  }

  QueryBuilder<DashboardDefinitionCollection, DashboardDefinitionCollection,
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

  QueryBuilder<DashboardDefinitionCollection, DashboardDefinitionCollection,
      QAfterWhereClause> titleEqualTo(String title) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'title',
        value: [title],
      ));
    });
  }

  QueryBuilder<DashboardDefinitionCollection, DashboardDefinitionCollection,
      QAfterWhereClause> titleNotEqualTo(String title) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'title',
              lower: [],
              upper: [title],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'title',
              lower: [title],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'title',
              lower: [title],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'title',
              lower: [],
              upper: [title],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<DashboardDefinitionCollection, DashboardDefinitionCollection,
      QAfterWhereClause> scopeEqualTo(String scope) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'scope',
        value: [scope],
      ));
    });
  }

  QueryBuilder<DashboardDefinitionCollection, DashboardDefinitionCollection,
      QAfterWhereClause> scopeNotEqualTo(String scope) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'scope',
              lower: [],
              upper: [scope],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'scope',
              lower: [scope],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'scope',
              lower: [scope],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'scope',
              lower: [],
              upper: [scope],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<DashboardDefinitionCollection, DashboardDefinitionCollection,
      QAfterWhereClause> ownerIdEqualTo(String ownerId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'ownerId',
        value: [ownerId],
      ));
    });
  }

  QueryBuilder<DashboardDefinitionCollection, DashboardDefinitionCollection,
      QAfterWhereClause> ownerIdNotEqualTo(String ownerId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'ownerId',
              lower: [],
              upper: [ownerId],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'ownerId',
              lower: [ownerId],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'ownerId',
              lower: [ownerId],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'ownerId',
              lower: [],
              upper: [ownerId],
              includeUpper: false,
            ));
      }
    });
  }
}

extension DashboardDefinitionCollectionQueryFilter on QueryBuilder<
    DashboardDefinitionCollection,
    DashboardDefinitionCollection,
    QFilterCondition> {
  QueryBuilder<DashboardDefinitionCollection, DashboardDefinitionCollection,
      QAfterFilterCondition> createdAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<DashboardDefinitionCollection, DashboardDefinitionCollection,
      QAfterFilterCondition> createdAtGreaterThan(
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

  QueryBuilder<DashboardDefinitionCollection, DashboardDefinitionCollection,
      QAfterFilterCondition> createdAtLessThan(
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

  QueryBuilder<DashboardDefinitionCollection, DashboardDefinitionCollection,
      QAfterFilterCondition> createdAtBetween(
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

  QueryBuilder<DashboardDefinitionCollection, DashboardDefinitionCollection,
      QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<DashboardDefinitionCollection, DashboardDefinitionCollection,
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

  QueryBuilder<DashboardDefinitionCollection, DashboardDefinitionCollection,
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

  QueryBuilder<DashboardDefinitionCollection, DashboardDefinitionCollection,
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

  QueryBuilder<DashboardDefinitionCollection, DashboardDefinitionCollection,
      QAfterFilterCondition> layoutJsonIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'layoutJson',
      ));
    });
  }

  QueryBuilder<DashboardDefinitionCollection, DashboardDefinitionCollection,
      QAfterFilterCondition> layoutJsonIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'layoutJson',
      ));
    });
  }

  QueryBuilder<DashboardDefinitionCollection, DashboardDefinitionCollection,
      QAfterFilterCondition> layoutJsonEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'layoutJson',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DashboardDefinitionCollection, DashboardDefinitionCollection,
      QAfterFilterCondition> layoutJsonGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'layoutJson',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DashboardDefinitionCollection, DashboardDefinitionCollection,
      QAfterFilterCondition> layoutJsonLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'layoutJson',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DashboardDefinitionCollection, DashboardDefinitionCollection,
      QAfterFilterCondition> layoutJsonBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'layoutJson',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DashboardDefinitionCollection, DashboardDefinitionCollection,
      QAfterFilterCondition> layoutJsonStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'layoutJson',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DashboardDefinitionCollection, DashboardDefinitionCollection,
      QAfterFilterCondition> layoutJsonEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'layoutJson',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DashboardDefinitionCollection, DashboardDefinitionCollection,
          QAfterFilterCondition>
      layoutJsonContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'layoutJson',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DashboardDefinitionCollection, DashboardDefinitionCollection,
          QAfterFilterCondition>
      layoutJsonMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'layoutJson',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DashboardDefinitionCollection, DashboardDefinitionCollection,
      QAfterFilterCondition> layoutJsonIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'layoutJson',
        value: '',
      ));
    });
  }

  QueryBuilder<DashboardDefinitionCollection, DashboardDefinitionCollection,
      QAfterFilterCondition> layoutJsonIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'layoutJson',
        value: '',
      ));
    });
  }

  QueryBuilder<DashboardDefinitionCollection, DashboardDefinitionCollection,
      QAfterFilterCondition> ownerIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'ownerId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DashboardDefinitionCollection, DashboardDefinitionCollection,
      QAfterFilterCondition> ownerIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'ownerId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DashboardDefinitionCollection, DashboardDefinitionCollection,
      QAfterFilterCondition> ownerIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'ownerId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DashboardDefinitionCollection, DashboardDefinitionCollection,
      QAfterFilterCondition> ownerIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'ownerId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DashboardDefinitionCollection, DashboardDefinitionCollection,
      QAfterFilterCondition> ownerIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'ownerId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DashboardDefinitionCollection, DashboardDefinitionCollection,
      QAfterFilterCondition> ownerIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'ownerId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DashboardDefinitionCollection, DashboardDefinitionCollection,
          QAfterFilterCondition>
      ownerIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'ownerId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DashboardDefinitionCollection, DashboardDefinitionCollection,
          QAfterFilterCondition>
      ownerIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'ownerId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DashboardDefinitionCollection, DashboardDefinitionCollection,
      QAfterFilterCondition> ownerIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'ownerId',
        value: '',
      ));
    });
  }

  QueryBuilder<DashboardDefinitionCollection, DashboardDefinitionCollection,
      QAfterFilterCondition> ownerIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'ownerId',
        value: '',
      ));
    });
  }

  QueryBuilder<DashboardDefinitionCollection, DashboardDefinitionCollection,
      QAfterFilterCondition> scopeEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'scope',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DashboardDefinitionCollection, DashboardDefinitionCollection,
      QAfterFilterCondition> scopeGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'scope',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DashboardDefinitionCollection, DashboardDefinitionCollection,
      QAfterFilterCondition> scopeLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'scope',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DashboardDefinitionCollection, DashboardDefinitionCollection,
      QAfterFilterCondition> scopeBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'scope',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DashboardDefinitionCollection, DashboardDefinitionCollection,
      QAfterFilterCondition> scopeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'scope',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DashboardDefinitionCollection, DashboardDefinitionCollection,
      QAfterFilterCondition> scopeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'scope',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DashboardDefinitionCollection, DashboardDefinitionCollection,
          QAfterFilterCondition>
      scopeContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'scope',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DashboardDefinitionCollection, DashboardDefinitionCollection,
          QAfterFilterCondition>
      scopeMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'scope',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DashboardDefinitionCollection, DashboardDefinitionCollection,
      QAfterFilterCondition> scopeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'scope',
        value: '',
      ));
    });
  }

  QueryBuilder<DashboardDefinitionCollection, DashboardDefinitionCollection,
      QAfterFilterCondition> scopeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'scope',
        value: '',
      ));
    });
  }

  QueryBuilder<DashboardDefinitionCollection, DashboardDefinitionCollection,
      QAfterFilterCondition> titleEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DashboardDefinitionCollection, DashboardDefinitionCollection,
      QAfterFilterCondition> titleGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DashboardDefinitionCollection, DashboardDefinitionCollection,
      QAfterFilterCondition> titleLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DashboardDefinitionCollection, DashboardDefinitionCollection,
      QAfterFilterCondition> titleBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'title',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DashboardDefinitionCollection, DashboardDefinitionCollection,
      QAfterFilterCondition> titleStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DashboardDefinitionCollection, DashboardDefinitionCollection,
      QAfterFilterCondition> titleEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DashboardDefinitionCollection, DashboardDefinitionCollection,
          QAfterFilterCondition>
      titleContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DashboardDefinitionCollection, DashboardDefinitionCollection,
          QAfterFilterCondition>
      titleMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'title',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DashboardDefinitionCollection, DashboardDefinitionCollection,
      QAfterFilterCondition> titleIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'title',
        value: '',
      ));
    });
  }

  QueryBuilder<DashboardDefinitionCollection, DashboardDefinitionCollection,
      QAfterFilterCondition> titleIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'title',
        value: '',
      ));
    });
  }

  QueryBuilder<DashboardDefinitionCollection, DashboardDefinitionCollection,
      QAfterFilterCondition> updatedAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'updatedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<DashboardDefinitionCollection, DashboardDefinitionCollection,
      QAfterFilterCondition> updatedAtGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'updatedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<DashboardDefinitionCollection, DashboardDefinitionCollection,
      QAfterFilterCondition> updatedAtLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'updatedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<DashboardDefinitionCollection, DashboardDefinitionCollection,
      QAfterFilterCondition> updatedAtBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'updatedAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<DashboardDefinitionCollection, DashboardDefinitionCollection,
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

  QueryBuilder<DashboardDefinitionCollection, DashboardDefinitionCollection,
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

  QueryBuilder<DashboardDefinitionCollection, DashboardDefinitionCollection,
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

  QueryBuilder<DashboardDefinitionCollection, DashboardDefinitionCollection,
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

  QueryBuilder<DashboardDefinitionCollection, DashboardDefinitionCollection,
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

  QueryBuilder<DashboardDefinitionCollection, DashboardDefinitionCollection,
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

  QueryBuilder<DashboardDefinitionCollection, DashboardDefinitionCollection,
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

  QueryBuilder<DashboardDefinitionCollection, DashboardDefinitionCollection,
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

  QueryBuilder<DashboardDefinitionCollection, DashboardDefinitionCollection,
      QAfterFilterCondition> uuidIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'uuid',
        value: '',
      ));
    });
  }

  QueryBuilder<DashboardDefinitionCollection, DashboardDefinitionCollection,
      QAfterFilterCondition> uuidIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'uuid',
        value: '',
      ));
    });
  }
}

extension DashboardDefinitionCollectionQueryObject on QueryBuilder<
    DashboardDefinitionCollection,
    DashboardDefinitionCollection,
    QFilterCondition> {}

extension DashboardDefinitionCollectionQueryLinks on QueryBuilder<
    DashboardDefinitionCollection,
    DashboardDefinitionCollection,
    QFilterCondition> {}

extension DashboardDefinitionCollectionQuerySortBy on QueryBuilder<
    DashboardDefinitionCollection, DashboardDefinitionCollection, QSortBy> {
  QueryBuilder<DashboardDefinitionCollection, DashboardDefinitionCollection,
      QAfterSortBy> sortByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<DashboardDefinitionCollection, DashboardDefinitionCollection,
      QAfterSortBy> sortByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<DashboardDefinitionCollection, DashboardDefinitionCollection,
      QAfterSortBy> sortByLayoutJson() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'layoutJson', Sort.asc);
    });
  }

  QueryBuilder<DashboardDefinitionCollection, DashboardDefinitionCollection,
      QAfterSortBy> sortByLayoutJsonDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'layoutJson', Sort.desc);
    });
  }

  QueryBuilder<DashboardDefinitionCollection, DashboardDefinitionCollection,
      QAfterSortBy> sortByOwnerId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ownerId', Sort.asc);
    });
  }

  QueryBuilder<DashboardDefinitionCollection, DashboardDefinitionCollection,
      QAfterSortBy> sortByOwnerIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ownerId', Sort.desc);
    });
  }

  QueryBuilder<DashboardDefinitionCollection, DashboardDefinitionCollection,
      QAfterSortBy> sortByScope() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'scope', Sort.asc);
    });
  }

  QueryBuilder<DashboardDefinitionCollection, DashboardDefinitionCollection,
      QAfterSortBy> sortByScopeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'scope', Sort.desc);
    });
  }

  QueryBuilder<DashboardDefinitionCollection, DashboardDefinitionCollection,
      QAfterSortBy> sortByTitle() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.asc);
    });
  }

  QueryBuilder<DashboardDefinitionCollection, DashboardDefinitionCollection,
      QAfterSortBy> sortByTitleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.desc);
    });
  }

  QueryBuilder<DashboardDefinitionCollection, DashboardDefinitionCollection,
      QAfterSortBy> sortByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.asc);
    });
  }

  QueryBuilder<DashboardDefinitionCollection, DashboardDefinitionCollection,
      QAfterSortBy> sortByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.desc);
    });
  }

  QueryBuilder<DashboardDefinitionCollection, DashboardDefinitionCollection,
      QAfterSortBy> sortByUuid() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uuid', Sort.asc);
    });
  }

  QueryBuilder<DashboardDefinitionCollection, DashboardDefinitionCollection,
      QAfterSortBy> sortByUuidDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uuid', Sort.desc);
    });
  }
}

extension DashboardDefinitionCollectionQuerySortThenBy on QueryBuilder<
    DashboardDefinitionCollection, DashboardDefinitionCollection, QSortThenBy> {
  QueryBuilder<DashboardDefinitionCollection, DashboardDefinitionCollection,
      QAfterSortBy> thenByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<DashboardDefinitionCollection, DashboardDefinitionCollection,
      QAfterSortBy> thenByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<DashboardDefinitionCollection, DashboardDefinitionCollection,
      QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<DashboardDefinitionCollection, DashboardDefinitionCollection,
      QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<DashboardDefinitionCollection, DashboardDefinitionCollection,
      QAfterSortBy> thenByLayoutJson() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'layoutJson', Sort.asc);
    });
  }

  QueryBuilder<DashboardDefinitionCollection, DashboardDefinitionCollection,
      QAfterSortBy> thenByLayoutJsonDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'layoutJson', Sort.desc);
    });
  }

  QueryBuilder<DashboardDefinitionCollection, DashboardDefinitionCollection,
      QAfterSortBy> thenByOwnerId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ownerId', Sort.asc);
    });
  }

  QueryBuilder<DashboardDefinitionCollection, DashboardDefinitionCollection,
      QAfterSortBy> thenByOwnerIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ownerId', Sort.desc);
    });
  }

  QueryBuilder<DashboardDefinitionCollection, DashboardDefinitionCollection,
      QAfterSortBy> thenByScope() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'scope', Sort.asc);
    });
  }

  QueryBuilder<DashboardDefinitionCollection, DashboardDefinitionCollection,
      QAfterSortBy> thenByScopeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'scope', Sort.desc);
    });
  }

  QueryBuilder<DashboardDefinitionCollection, DashboardDefinitionCollection,
      QAfterSortBy> thenByTitle() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.asc);
    });
  }

  QueryBuilder<DashboardDefinitionCollection, DashboardDefinitionCollection,
      QAfterSortBy> thenByTitleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.desc);
    });
  }

  QueryBuilder<DashboardDefinitionCollection, DashboardDefinitionCollection,
      QAfterSortBy> thenByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.asc);
    });
  }

  QueryBuilder<DashboardDefinitionCollection, DashboardDefinitionCollection,
      QAfterSortBy> thenByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.desc);
    });
  }

  QueryBuilder<DashboardDefinitionCollection, DashboardDefinitionCollection,
      QAfterSortBy> thenByUuid() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uuid', Sort.asc);
    });
  }

  QueryBuilder<DashboardDefinitionCollection, DashboardDefinitionCollection,
      QAfterSortBy> thenByUuidDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uuid', Sort.desc);
    });
  }
}

extension DashboardDefinitionCollectionQueryWhereDistinct on QueryBuilder<
    DashboardDefinitionCollection, DashboardDefinitionCollection, QDistinct> {
  QueryBuilder<DashboardDefinitionCollection, DashboardDefinitionCollection,
      QDistinct> distinctByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'createdAt');
    });
  }

  QueryBuilder<DashboardDefinitionCollection, DashboardDefinitionCollection,
      QDistinct> distinctByLayoutJson({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'layoutJson', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<DashboardDefinitionCollection, DashboardDefinitionCollection,
      QDistinct> distinctByOwnerId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'ownerId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<DashboardDefinitionCollection, DashboardDefinitionCollection,
      QDistinct> distinctByScope({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'scope', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<DashboardDefinitionCollection, DashboardDefinitionCollection,
      QDistinct> distinctByTitle({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'title', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<DashboardDefinitionCollection, DashboardDefinitionCollection,
      QDistinct> distinctByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'updatedAt');
    });
  }

  QueryBuilder<DashboardDefinitionCollection, DashboardDefinitionCollection,
      QDistinct> distinctByUuid({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'uuid', caseSensitive: caseSensitive);
    });
  }
}

extension DashboardDefinitionCollectionQueryProperty on QueryBuilder<
    DashboardDefinitionCollection,
    DashboardDefinitionCollection,
    QQueryProperty> {
  QueryBuilder<DashboardDefinitionCollection, int, QQueryOperations>
      idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<DashboardDefinitionCollection, DateTime, QQueryOperations>
      createdAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'createdAt');
    });
  }

  QueryBuilder<DashboardDefinitionCollection, String?, QQueryOperations>
      layoutJsonProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'layoutJson');
    });
  }

  QueryBuilder<DashboardDefinitionCollection, String, QQueryOperations>
      ownerIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'ownerId');
    });
  }

  QueryBuilder<DashboardDefinitionCollection, String, QQueryOperations>
      scopeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'scope');
    });
  }

  QueryBuilder<DashboardDefinitionCollection, String, QQueryOperations>
      titleProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'title');
    });
  }

  QueryBuilder<DashboardDefinitionCollection, DateTime, QQueryOperations>
      updatedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'updatedAt');
    });
  }

  QueryBuilder<DashboardDefinitionCollection, String, QQueryOperations>
      uuidProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'uuid');
    });
  }
}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetReportScheduleCollectionCollection on Isar {
  IsarCollection<ReportScheduleCollection> get reportScheduleCollections =>
      this.collection();
}

const ReportScheduleCollectionSchema = CollectionSchema(
  name: r'ReportScheduleCollection',
  id: -4440961297617545797,
  properties: {
    r'createdAt': PropertySchema(
      id: 0,
      name: r'createdAt',
      type: IsarType.dateTime,
    ),
    r'deliveryChannel': PropertySchema(
      id: 1,
      name: r'deliveryChannel',
      type: IsarType.string,
    ),
    r'frequency': PropertySchema(
      id: 2,
      name: r'frequency',
      type: IsarType.string,
    ),
    r'isActive': PropertySchema(
      id: 3,
      name: r'isActive',
      type: IsarType.bool,
    ),
    r'nextRun': PropertySchema(
      id: 4,
      name: r'nextRun',
      type: IsarType.dateTime,
    ),
    r'recipientEmails': PropertySchema(
      id: 5,
      name: r'recipientEmails',
      type: IsarType.stringList,
    ),
    r'reportId': PropertySchema(
      id: 6,
      name: r'reportId',
      type: IsarType.string,
    ),
    r'uuid': PropertySchema(
      id: 7,
      name: r'uuid',
      type: IsarType.string,
    )
  },
  estimateSize: _reportScheduleCollectionEstimateSize,
  serialize: _reportScheduleCollectionSerialize,
  deserialize: _reportScheduleCollectionDeserialize,
  deserializeProp: _reportScheduleCollectionDeserializeProp,
  idName: r'id',
  indexes: {
    r'uuid': IndexSchema(
      id: 2134397340427724972,
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
    r'reportId': IndexSchema(
      id: 1732854644896652467,
      name: r'reportId',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'reportId',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _reportScheduleCollectionGetId,
  getLinks: _reportScheduleCollectionGetLinks,
  attach: _reportScheduleCollectionAttach,
  version: '3.1.0+1',
);

int _reportScheduleCollectionEstimateSize(
  ReportScheduleCollection object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.deliveryChannel.length * 3;
  bytesCount += 3 + object.frequency.length * 3;
  bytesCount += 3 + object.recipientEmails.length * 3;
  {
    for (var i = 0; i < object.recipientEmails.length; i++) {
      final value = object.recipientEmails[i];
      bytesCount += value.length * 3;
    }
  }
  bytesCount += 3 + object.reportId.length * 3;
  bytesCount += 3 + object.uuid.length * 3;
  return bytesCount;
}

void _reportScheduleCollectionSerialize(
  ReportScheduleCollection object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDateTime(offsets[0], object.createdAt);
  writer.writeString(offsets[1], object.deliveryChannel);
  writer.writeString(offsets[2], object.frequency);
  writer.writeBool(offsets[3], object.isActive);
  writer.writeDateTime(offsets[4], object.nextRun);
  writer.writeStringList(offsets[5], object.recipientEmails);
  writer.writeString(offsets[6], object.reportId);
  writer.writeString(offsets[7], object.uuid);
}

ReportScheduleCollection _reportScheduleCollectionDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = ReportScheduleCollection();
  object.createdAt = reader.readDateTime(offsets[0]);
  object.deliveryChannel = reader.readString(offsets[1]);
  object.frequency = reader.readString(offsets[2]);
  object.id = id;
  object.isActive = reader.readBool(offsets[3]);
  object.nextRun = reader.readDateTime(offsets[4]);
  object.recipientEmails = reader.readStringList(offsets[5]) ?? [];
  object.reportId = reader.readString(offsets[6]);
  object.uuid = reader.readString(offsets[7]);
  return object;
}

P _reportScheduleCollectionDeserializeProp<P>(
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
      return (reader.readBool(offset)) as P;
    case 4:
      return (reader.readDateTime(offset)) as P;
    case 5:
      return (reader.readStringList(offset) ?? []) as P;
    case 6:
      return (reader.readString(offset)) as P;
    case 7:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _reportScheduleCollectionGetId(ReportScheduleCollection object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _reportScheduleCollectionGetLinks(
    ReportScheduleCollection object) {
  return [];
}

void _reportScheduleCollectionAttach(
    IsarCollection<dynamic> col, Id id, ReportScheduleCollection object) {
  object.id = id;
}

extension ReportScheduleCollectionByIndex
    on IsarCollection<ReportScheduleCollection> {
  Future<ReportScheduleCollection?> getByUuid(String uuid) {
    return getByIndex(r'uuid', [uuid]);
  }

  ReportScheduleCollection? getByUuidSync(String uuid) {
    return getByIndexSync(r'uuid', [uuid]);
  }

  Future<bool> deleteByUuid(String uuid) {
    return deleteByIndex(r'uuid', [uuid]);
  }

  bool deleteByUuidSync(String uuid) {
    return deleteByIndexSync(r'uuid', [uuid]);
  }

  Future<List<ReportScheduleCollection?>> getAllByUuid(
      List<String> uuidValues) {
    final values = uuidValues.map((e) => [e]).toList();
    return getAllByIndex(r'uuid', values);
  }

  List<ReportScheduleCollection?> getAllByUuidSync(List<String> uuidValues) {
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

  Future<Id> putByUuid(ReportScheduleCollection object) {
    return putByIndex(r'uuid', object);
  }

  Id putByUuidSync(ReportScheduleCollection object, {bool saveLinks = true}) {
    return putByIndexSync(r'uuid', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByUuid(List<ReportScheduleCollection> objects) {
    return putAllByIndex(r'uuid', objects);
  }

  List<Id> putAllByUuidSync(List<ReportScheduleCollection> objects,
      {bool saveLinks = true}) {
    return putAllByIndexSync(r'uuid', objects, saveLinks: saveLinks);
  }
}

extension ReportScheduleCollectionQueryWhereSort on QueryBuilder<
    ReportScheduleCollection, ReportScheduleCollection, QWhere> {
  QueryBuilder<ReportScheduleCollection, ReportScheduleCollection, QAfterWhere>
      anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension ReportScheduleCollectionQueryWhere on QueryBuilder<
    ReportScheduleCollection, ReportScheduleCollection, QWhereClause> {
  QueryBuilder<ReportScheduleCollection, ReportScheduleCollection,
      QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<ReportScheduleCollection, ReportScheduleCollection,
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

  QueryBuilder<ReportScheduleCollection, ReportScheduleCollection,
      QAfterWhereClause> idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<ReportScheduleCollection, ReportScheduleCollection,
      QAfterWhereClause> idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<ReportScheduleCollection, ReportScheduleCollection,
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

  QueryBuilder<ReportScheduleCollection, ReportScheduleCollection,
      QAfterWhereClause> uuidEqualTo(String uuid) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'uuid',
        value: [uuid],
      ));
    });
  }

  QueryBuilder<ReportScheduleCollection, ReportScheduleCollection,
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

  QueryBuilder<ReportScheduleCollection, ReportScheduleCollection,
      QAfterWhereClause> reportIdEqualTo(String reportId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'reportId',
        value: [reportId],
      ));
    });
  }

  QueryBuilder<ReportScheduleCollection, ReportScheduleCollection,
      QAfterWhereClause> reportIdNotEqualTo(String reportId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'reportId',
              lower: [],
              upper: [reportId],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'reportId',
              lower: [reportId],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'reportId',
              lower: [reportId],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'reportId',
              lower: [],
              upper: [reportId],
              includeUpper: false,
            ));
      }
    });
  }
}

extension ReportScheduleCollectionQueryFilter on QueryBuilder<
    ReportScheduleCollection, ReportScheduleCollection, QFilterCondition> {
  QueryBuilder<ReportScheduleCollection, ReportScheduleCollection,
      QAfterFilterCondition> createdAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<ReportScheduleCollection, ReportScheduleCollection,
      QAfterFilterCondition> createdAtGreaterThan(
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

  QueryBuilder<ReportScheduleCollection, ReportScheduleCollection,
      QAfterFilterCondition> createdAtLessThan(
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

  QueryBuilder<ReportScheduleCollection, ReportScheduleCollection,
      QAfterFilterCondition> createdAtBetween(
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

  QueryBuilder<ReportScheduleCollection, ReportScheduleCollection,
      QAfterFilterCondition> deliveryChannelEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'deliveryChannel',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ReportScheduleCollection, ReportScheduleCollection,
      QAfterFilterCondition> deliveryChannelGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'deliveryChannel',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ReportScheduleCollection, ReportScheduleCollection,
      QAfterFilterCondition> deliveryChannelLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'deliveryChannel',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ReportScheduleCollection, ReportScheduleCollection,
      QAfterFilterCondition> deliveryChannelBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'deliveryChannel',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ReportScheduleCollection, ReportScheduleCollection,
      QAfterFilterCondition> deliveryChannelStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'deliveryChannel',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ReportScheduleCollection, ReportScheduleCollection,
      QAfterFilterCondition> deliveryChannelEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'deliveryChannel',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ReportScheduleCollection, ReportScheduleCollection,
          QAfterFilterCondition>
      deliveryChannelContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'deliveryChannel',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ReportScheduleCollection, ReportScheduleCollection,
          QAfterFilterCondition>
      deliveryChannelMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'deliveryChannel',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ReportScheduleCollection, ReportScheduleCollection,
      QAfterFilterCondition> deliveryChannelIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'deliveryChannel',
        value: '',
      ));
    });
  }

  QueryBuilder<ReportScheduleCollection, ReportScheduleCollection,
      QAfterFilterCondition> deliveryChannelIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'deliveryChannel',
        value: '',
      ));
    });
  }

  QueryBuilder<ReportScheduleCollection, ReportScheduleCollection,
      QAfterFilterCondition> frequencyEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'frequency',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ReportScheduleCollection, ReportScheduleCollection,
      QAfterFilterCondition> frequencyGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'frequency',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ReportScheduleCollection, ReportScheduleCollection,
      QAfterFilterCondition> frequencyLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'frequency',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ReportScheduleCollection, ReportScheduleCollection,
      QAfterFilterCondition> frequencyBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'frequency',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ReportScheduleCollection, ReportScheduleCollection,
      QAfterFilterCondition> frequencyStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'frequency',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ReportScheduleCollection, ReportScheduleCollection,
      QAfterFilterCondition> frequencyEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'frequency',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ReportScheduleCollection, ReportScheduleCollection,
          QAfterFilterCondition>
      frequencyContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'frequency',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ReportScheduleCollection, ReportScheduleCollection,
          QAfterFilterCondition>
      frequencyMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'frequency',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ReportScheduleCollection, ReportScheduleCollection,
      QAfterFilterCondition> frequencyIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'frequency',
        value: '',
      ));
    });
  }

  QueryBuilder<ReportScheduleCollection, ReportScheduleCollection,
      QAfterFilterCondition> frequencyIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'frequency',
        value: '',
      ));
    });
  }

  QueryBuilder<ReportScheduleCollection, ReportScheduleCollection,
      QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<ReportScheduleCollection, ReportScheduleCollection,
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

  QueryBuilder<ReportScheduleCollection, ReportScheduleCollection,
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

  QueryBuilder<ReportScheduleCollection, ReportScheduleCollection,
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

  QueryBuilder<ReportScheduleCollection, ReportScheduleCollection,
      QAfterFilterCondition> isActiveEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isActive',
        value: value,
      ));
    });
  }

  QueryBuilder<ReportScheduleCollection, ReportScheduleCollection,
      QAfterFilterCondition> nextRunEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'nextRun',
        value: value,
      ));
    });
  }

  QueryBuilder<ReportScheduleCollection, ReportScheduleCollection,
      QAfterFilterCondition> nextRunGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'nextRun',
        value: value,
      ));
    });
  }

  QueryBuilder<ReportScheduleCollection, ReportScheduleCollection,
      QAfterFilterCondition> nextRunLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'nextRun',
        value: value,
      ));
    });
  }

  QueryBuilder<ReportScheduleCollection, ReportScheduleCollection,
      QAfterFilterCondition> nextRunBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'nextRun',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ReportScheduleCollection, ReportScheduleCollection,
      QAfterFilterCondition> recipientEmailsElementEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'recipientEmails',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ReportScheduleCollection, ReportScheduleCollection,
      QAfterFilterCondition> recipientEmailsElementGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'recipientEmails',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ReportScheduleCollection, ReportScheduleCollection,
      QAfterFilterCondition> recipientEmailsElementLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'recipientEmails',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ReportScheduleCollection, ReportScheduleCollection,
      QAfterFilterCondition> recipientEmailsElementBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'recipientEmails',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ReportScheduleCollection, ReportScheduleCollection,
      QAfterFilterCondition> recipientEmailsElementStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'recipientEmails',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ReportScheduleCollection, ReportScheduleCollection,
      QAfterFilterCondition> recipientEmailsElementEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'recipientEmails',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ReportScheduleCollection, ReportScheduleCollection,
          QAfterFilterCondition>
      recipientEmailsElementContains(String value,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'recipientEmails',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ReportScheduleCollection, ReportScheduleCollection,
          QAfterFilterCondition>
      recipientEmailsElementMatches(String pattern,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'recipientEmails',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ReportScheduleCollection, ReportScheduleCollection,
      QAfterFilterCondition> recipientEmailsElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'recipientEmails',
        value: '',
      ));
    });
  }

  QueryBuilder<ReportScheduleCollection, ReportScheduleCollection,
      QAfterFilterCondition> recipientEmailsElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'recipientEmails',
        value: '',
      ));
    });
  }

  QueryBuilder<ReportScheduleCollection, ReportScheduleCollection,
      QAfterFilterCondition> recipientEmailsLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'recipientEmails',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<ReportScheduleCollection, ReportScheduleCollection,
      QAfterFilterCondition> recipientEmailsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'recipientEmails',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<ReportScheduleCollection, ReportScheduleCollection,
      QAfterFilterCondition> recipientEmailsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'recipientEmails',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<ReportScheduleCollection, ReportScheduleCollection,
      QAfterFilterCondition> recipientEmailsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'recipientEmails',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<ReportScheduleCollection, ReportScheduleCollection,
      QAfterFilterCondition> recipientEmailsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'recipientEmails',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<ReportScheduleCollection, ReportScheduleCollection,
      QAfterFilterCondition> recipientEmailsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'recipientEmails',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<ReportScheduleCollection, ReportScheduleCollection,
      QAfterFilterCondition> reportIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'reportId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ReportScheduleCollection, ReportScheduleCollection,
      QAfterFilterCondition> reportIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'reportId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ReportScheduleCollection, ReportScheduleCollection,
      QAfterFilterCondition> reportIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'reportId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ReportScheduleCollection, ReportScheduleCollection,
      QAfterFilterCondition> reportIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'reportId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ReportScheduleCollection, ReportScheduleCollection,
      QAfterFilterCondition> reportIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'reportId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ReportScheduleCollection, ReportScheduleCollection,
      QAfterFilterCondition> reportIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'reportId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ReportScheduleCollection, ReportScheduleCollection,
          QAfterFilterCondition>
      reportIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'reportId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ReportScheduleCollection, ReportScheduleCollection,
          QAfterFilterCondition>
      reportIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'reportId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ReportScheduleCollection, ReportScheduleCollection,
      QAfterFilterCondition> reportIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'reportId',
        value: '',
      ));
    });
  }

  QueryBuilder<ReportScheduleCollection, ReportScheduleCollection,
      QAfterFilterCondition> reportIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'reportId',
        value: '',
      ));
    });
  }

  QueryBuilder<ReportScheduleCollection, ReportScheduleCollection,
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

  QueryBuilder<ReportScheduleCollection, ReportScheduleCollection,
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

  QueryBuilder<ReportScheduleCollection, ReportScheduleCollection,
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

  QueryBuilder<ReportScheduleCollection, ReportScheduleCollection,
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

  QueryBuilder<ReportScheduleCollection, ReportScheduleCollection,
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

  QueryBuilder<ReportScheduleCollection, ReportScheduleCollection,
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

  QueryBuilder<ReportScheduleCollection, ReportScheduleCollection,
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

  QueryBuilder<ReportScheduleCollection, ReportScheduleCollection,
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

  QueryBuilder<ReportScheduleCollection, ReportScheduleCollection,
      QAfterFilterCondition> uuidIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'uuid',
        value: '',
      ));
    });
  }

  QueryBuilder<ReportScheduleCollection, ReportScheduleCollection,
      QAfterFilterCondition> uuidIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'uuid',
        value: '',
      ));
    });
  }
}

extension ReportScheduleCollectionQueryObject on QueryBuilder<
    ReportScheduleCollection, ReportScheduleCollection, QFilterCondition> {}

extension ReportScheduleCollectionQueryLinks on QueryBuilder<
    ReportScheduleCollection, ReportScheduleCollection, QFilterCondition> {}

extension ReportScheduleCollectionQuerySortBy on QueryBuilder<
    ReportScheduleCollection, ReportScheduleCollection, QSortBy> {
  QueryBuilder<ReportScheduleCollection, ReportScheduleCollection, QAfterSortBy>
      sortByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<ReportScheduleCollection, ReportScheduleCollection, QAfterSortBy>
      sortByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<ReportScheduleCollection, ReportScheduleCollection, QAfterSortBy>
      sortByDeliveryChannel() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'deliveryChannel', Sort.asc);
    });
  }

  QueryBuilder<ReportScheduleCollection, ReportScheduleCollection, QAfterSortBy>
      sortByDeliveryChannelDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'deliveryChannel', Sort.desc);
    });
  }

  QueryBuilder<ReportScheduleCollection, ReportScheduleCollection, QAfterSortBy>
      sortByFrequency() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'frequency', Sort.asc);
    });
  }

  QueryBuilder<ReportScheduleCollection, ReportScheduleCollection, QAfterSortBy>
      sortByFrequencyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'frequency', Sort.desc);
    });
  }

  QueryBuilder<ReportScheduleCollection, ReportScheduleCollection, QAfterSortBy>
      sortByIsActive() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isActive', Sort.asc);
    });
  }

  QueryBuilder<ReportScheduleCollection, ReportScheduleCollection, QAfterSortBy>
      sortByIsActiveDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isActive', Sort.desc);
    });
  }

  QueryBuilder<ReportScheduleCollection, ReportScheduleCollection, QAfterSortBy>
      sortByNextRun() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nextRun', Sort.asc);
    });
  }

  QueryBuilder<ReportScheduleCollection, ReportScheduleCollection, QAfterSortBy>
      sortByNextRunDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nextRun', Sort.desc);
    });
  }

  QueryBuilder<ReportScheduleCollection, ReportScheduleCollection, QAfterSortBy>
      sortByReportId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'reportId', Sort.asc);
    });
  }

  QueryBuilder<ReportScheduleCollection, ReportScheduleCollection, QAfterSortBy>
      sortByReportIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'reportId', Sort.desc);
    });
  }

  QueryBuilder<ReportScheduleCollection, ReportScheduleCollection, QAfterSortBy>
      sortByUuid() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uuid', Sort.asc);
    });
  }

  QueryBuilder<ReportScheduleCollection, ReportScheduleCollection, QAfterSortBy>
      sortByUuidDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uuid', Sort.desc);
    });
  }
}

extension ReportScheduleCollectionQuerySortThenBy on QueryBuilder<
    ReportScheduleCollection, ReportScheduleCollection, QSortThenBy> {
  QueryBuilder<ReportScheduleCollection, ReportScheduleCollection, QAfterSortBy>
      thenByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<ReportScheduleCollection, ReportScheduleCollection, QAfterSortBy>
      thenByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<ReportScheduleCollection, ReportScheduleCollection, QAfterSortBy>
      thenByDeliveryChannel() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'deliveryChannel', Sort.asc);
    });
  }

  QueryBuilder<ReportScheduleCollection, ReportScheduleCollection, QAfterSortBy>
      thenByDeliveryChannelDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'deliveryChannel', Sort.desc);
    });
  }

  QueryBuilder<ReportScheduleCollection, ReportScheduleCollection, QAfterSortBy>
      thenByFrequency() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'frequency', Sort.asc);
    });
  }

  QueryBuilder<ReportScheduleCollection, ReportScheduleCollection, QAfterSortBy>
      thenByFrequencyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'frequency', Sort.desc);
    });
  }

  QueryBuilder<ReportScheduleCollection, ReportScheduleCollection, QAfterSortBy>
      thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<ReportScheduleCollection, ReportScheduleCollection, QAfterSortBy>
      thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<ReportScheduleCollection, ReportScheduleCollection, QAfterSortBy>
      thenByIsActive() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isActive', Sort.asc);
    });
  }

  QueryBuilder<ReportScheduleCollection, ReportScheduleCollection, QAfterSortBy>
      thenByIsActiveDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isActive', Sort.desc);
    });
  }

  QueryBuilder<ReportScheduleCollection, ReportScheduleCollection, QAfterSortBy>
      thenByNextRun() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nextRun', Sort.asc);
    });
  }

  QueryBuilder<ReportScheduleCollection, ReportScheduleCollection, QAfterSortBy>
      thenByNextRunDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nextRun', Sort.desc);
    });
  }

  QueryBuilder<ReportScheduleCollection, ReportScheduleCollection, QAfterSortBy>
      thenByReportId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'reportId', Sort.asc);
    });
  }

  QueryBuilder<ReportScheduleCollection, ReportScheduleCollection, QAfterSortBy>
      thenByReportIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'reportId', Sort.desc);
    });
  }

  QueryBuilder<ReportScheduleCollection, ReportScheduleCollection, QAfterSortBy>
      thenByUuid() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uuid', Sort.asc);
    });
  }

  QueryBuilder<ReportScheduleCollection, ReportScheduleCollection, QAfterSortBy>
      thenByUuidDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uuid', Sort.desc);
    });
  }
}

extension ReportScheduleCollectionQueryWhereDistinct on QueryBuilder<
    ReportScheduleCollection, ReportScheduleCollection, QDistinct> {
  QueryBuilder<ReportScheduleCollection, ReportScheduleCollection, QDistinct>
      distinctByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'createdAt');
    });
  }

  QueryBuilder<ReportScheduleCollection, ReportScheduleCollection, QDistinct>
      distinctByDeliveryChannel({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'deliveryChannel',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ReportScheduleCollection, ReportScheduleCollection, QDistinct>
      distinctByFrequency({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'frequency', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ReportScheduleCollection, ReportScheduleCollection, QDistinct>
      distinctByIsActive() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isActive');
    });
  }

  QueryBuilder<ReportScheduleCollection, ReportScheduleCollection, QDistinct>
      distinctByNextRun() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'nextRun');
    });
  }

  QueryBuilder<ReportScheduleCollection, ReportScheduleCollection, QDistinct>
      distinctByRecipientEmails() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'recipientEmails');
    });
  }

  QueryBuilder<ReportScheduleCollection, ReportScheduleCollection, QDistinct>
      distinctByReportId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'reportId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ReportScheduleCollection, ReportScheduleCollection, QDistinct>
      distinctByUuid({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'uuid', caseSensitive: caseSensitive);
    });
  }
}

extension ReportScheduleCollectionQueryProperty on QueryBuilder<
    ReportScheduleCollection, ReportScheduleCollection, QQueryProperty> {
  QueryBuilder<ReportScheduleCollection, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<ReportScheduleCollection, DateTime, QQueryOperations>
      createdAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'createdAt');
    });
  }

  QueryBuilder<ReportScheduleCollection, String, QQueryOperations>
      deliveryChannelProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'deliveryChannel');
    });
  }

  QueryBuilder<ReportScheduleCollection, String, QQueryOperations>
      frequencyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'frequency');
    });
  }

  QueryBuilder<ReportScheduleCollection, bool, QQueryOperations>
      isActiveProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isActive');
    });
  }

  QueryBuilder<ReportScheduleCollection, DateTime, QQueryOperations>
      nextRunProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'nextRun');
    });
  }

  QueryBuilder<ReportScheduleCollection, List<String>, QQueryOperations>
      recipientEmailsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'recipientEmails');
    });
  }

  QueryBuilder<ReportScheduleCollection, String, QQueryOperations>
      reportIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'reportId');
    });
  }

  QueryBuilder<ReportScheduleCollection, String, QQueryOperations>
      uuidProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'uuid');
    });
  }
}
