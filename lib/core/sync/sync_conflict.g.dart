// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sync_conflict.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetSyncConflictCollection on Isar {
  IsarCollection<SyncConflict> get syncConflicts => this.collection();
}

const SyncConflictSchema = CollectionSchema(
  name: r'SyncConflict',
  id: -8770548852093850888,
  properties: {
    r'collectionName': PropertySchema(
      id: 0,
      name: r'collectionName',
      type: IsarType.string,
    ),
    r'conflictAt': PropertySchema(
      id: 1,
      name: r'conflictAt',
      type: IsarType.dateTime,
    ),
    r'entityUuid': PropertySchema(
      id: 2,
      name: r'entityUuid',
      type: IsarType.string,
    ),
    r'isResolved': PropertySchema(
      id: 3,
      name: r'isResolved',
      type: IsarType.bool,
    ),
    r'localPayload': PropertySchema(
      id: 4,
      name: r'localPayload',
      type: IsarType.string,
    ),
    r'remotePayload': PropertySchema(
      id: 5,
      name: r'remotePayload',
      type: IsarType.string,
    ),
    r'resolutionStrategy': PropertySchema(
      id: 6,
      name: r'resolutionStrategy',
      type: IsarType.byte,
      enumMap: _SyncConflictresolutionStrategyEnumValueMap,
    ),
    r'resolvedAt': PropertySchema(
      id: 7,
      name: r'resolvedAt',
      type: IsarType.dateTime,
    ),
    r'resolvedByUserId': PropertySchema(
      id: 8,
      name: r'resolvedByUserId',
      type: IsarType.string,
    )
  },
  estimateSize: _syncConflictEstimateSize,
  serialize: _syncConflictSerialize,
  deserialize: _syncConflictDeserialize,
  deserializeProp: _syncConflictDeserializeProp,
  idName: r'id',
  indexes: {
    r'collectionName': IndexSchema(
      id: -4238329797778617380,
      name: r'collectionName',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'collectionName',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    ),
    r'entityUuid': IndexSchema(
      id: -1414110998250231744,
      name: r'entityUuid',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'entityUuid',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    ),
    r'conflictAt': IndexSchema(
      id: 960179196648833740,
      name: r'conflictAt',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'conflictAt',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _syncConflictGetId,
  getLinks: _syncConflictGetLinks,
  attach: _syncConflictAttach,
  version: '3.1.0+1',
);

int _syncConflictEstimateSize(
  SyncConflict object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.collectionName.length * 3;
  bytesCount += 3 + object.entityUuid.length * 3;
  bytesCount += 3 + object.localPayload.length * 3;
  bytesCount += 3 + object.remotePayload.length * 3;
  {
    final value = object.resolvedByUserId;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _syncConflictSerialize(
  SyncConflict object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.collectionName);
  writer.writeDateTime(offsets[1], object.conflictAt);
  writer.writeString(offsets[2], object.entityUuid);
  writer.writeBool(offsets[3], object.isResolved);
  writer.writeString(offsets[4], object.localPayload);
  writer.writeString(offsets[5], object.remotePayload);
  writer.writeByte(offsets[6], object.resolutionStrategy.index);
  writer.writeDateTime(offsets[7], object.resolvedAt);
  writer.writeString(offsets[8], object.resolvedByUserId);
}

SyncConflict _syncConflictDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = SyncConflict();
  object.collectionName = reader.readString(offsets[0]);
  object.conflictAt = reader.readDateTime(offsets[1]);
  object.entityUuid = reader.readString(offsets[2]);
  object.id = id;
  object.isResolved = reader.readBool(offsets[3]);
  object.localPayload = reader.readString(offsets[4]);
  object.remotePayload = reader.readString(offsets[5]);
  object.resolutionStrategy = _SyncConflictresolutionStrategyValueEnumMap[
          reader.readByteOrNull(offsets[6])] ??
      ConflictResolutionStrategy.lastWriteWins;
  object.resolvedAt = reader.readDateTimeOrNull(offsets[7]);
  object.resolvedByUserId = reader.readStringOrNull(offsets[8]);
  return object;
}

P _syncConflictDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readDateTime(offset)) as P;
    case 2:
      return (reader.readString(offset)) as P;
    case 3:
      return (reader.readBool(offset)) as P;
    case 4:
      return (reader.readString(offset)) as P;
    case 5:
      return (reader.readString(offset)) as P;
    case 6:
      return (_SyncConflictresolutionStrategyValueEnumMap[
              reader.readByteOrNull(offset)] ??
          ConflictResolutionStrategy.lastWriteWins) as P;
    case 7:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 8:
      return (reader.readStringOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _SyncConflictresolutionStrategyEnumValueMap = {
  'lastWriteWins': 0,
  'manual': 1,
  'serverWins': 2,
};
const _SyncConflictresolutionStrategyValueEnumMap = {
  0: ConflictResolutionStrategy.lastWriteWins,
  1: ConflictResolutionStrategy.manual,
  2: ConflictResolutionStrategy.serverWins,
};

Id _syncConflictGetId(SyncConflict object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _syncConflictGetLinks(SyncConflict object) {
  return [];
}

void _syncConflictAttach(
    IsarCollection<dynamic> col, Id id, SyncConflict object) {
  object.id = id;
}

extension SyncConflictQueryWhereSort
    on QueryBuilder<SyncConflict, SyncConflict, QWhere> {
  QueryBuilder<SyncConflict, SyncConflict, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<SyncConflict, SyncConflict, QAfterWhere> anyConflictAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'conflictAt'),
      );
    });
  }
}

extension SyncConflictQueryWhere
    on QueryBuilder<SyncConflict, SyncConflict, QWhereClause> {
  QueryBuilder<SyncConflict, SyncConflict, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<SyncConflict, SyncConflict, QAfterWhereClause> idNotEqualTo(
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

  QueryBuilder<SyncConflict, SyncConflict, QAfterWhereClause> idGreaterThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<SyncConflict, SyncConflict, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<SyncConflict, SyncConflict, QAfterWhereClause> idBetween(
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

  QueryBuilder<SyncConflict, SyncConflict, QAfterWhereClause>
      collectionNameEqualTo(String collectionName) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'collectionName',
        value: [collectionName],
      ));
    });
  }

  QueryBuilder<SyncConflict, SyncConflict, QAfterWhereClause>
      collectionNameNotEqualTo(String collectionName) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'collectionName',
              lower: [],
              upper: [collectionName],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'collectionName',
              lower: [collectionName],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'collectionName',
              lower: [collectionName],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'collectionName',
              lower: [],
              upper: [collectionName],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<SyncConflict, SyncConflict, QAfterWhereClause> entityUuidEqualTo(
      String entityUuid) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'entityUuid',
        value: [entityUuid],
      ));
    });
  }

  QueryBuilder<SyncConflict, SyncConflict, QAfterWhereClause>
      entityUuidNotEqualTo(String entityUuid) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'entityUuid',
              lower: [],
              upper: [entityUuid],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'entityUuid',
              lower: [entityUuid],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'entityUuid',
              lower: [entityUuid],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'entityUuid',
              lower: [],
              upper: [entityUuid],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<SyncConflict, SyncConflict, QAfterWhereClause> conflictAtEqualTo(
      DateTime conflictAt) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'conflictAt',
        value: [conflictAt],
      ));
    });
  }

  QueryBuilder<SyncConflict, SyncConflict, QAfterWhereClause>
      conflictAtNotEqualTo(DateTime conflictAt) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'conflictAt',
              lower: [],
              upper: [conflictAt],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'conflictAt',
              lower: [conflictAt],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'conflictAt',
              lower: [conflictAt],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'conflictAt',
              lower: [],
              upper: [conflictAt],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<SyncConflict, SyncConflict, QAfterWhereClause>
      conflictAtGreaterThan(
    DateTime conflictAt, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'conflictAt',
        lower: [conflictAt],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<SyncConflict, SyncConflict, QAfterWhereClause>
      conflictAtLessThan(
    DateTime conflictAt, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'conflictAt',
        lower: [],
        upper: [conflictAt],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<SyncConflict, SyncConflict, QAfterWhereClause> conflictAtBetween(
    DateTime lowerConflictAt,
    DateTime upperConflictAt, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'conflictAt',
        lower: [lowerConflictAt],
        includeLower: includeLower,
        upper: [upperConflictAt],
        includeUpper: includeUpper,
      ));
    });
  }
}

extension SyncConflictQueryFilter
    on QueryBuilder<SyncConflict, SyncConflict, QFilterCondition> {
  QueryBuilder<SyncConflict, SyncConflict, QAfterFilterCondition>
      collectionNameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'collectionName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SyncConflict, SyncConflict, QAfterFilterCondition>
      collectionNameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'collectionName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SyncConflict, SyncConflict, QAfterFilterCondition>
      collectionNameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'collectionName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SyncConflict, SyncConflict, QAfterFilterCondition>
      collectionNameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'collectionName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SyncConflict, SyncConflict, QAfterFilterCondition>
      collectionNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'collectionName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SyncConflict, SyncConflict, QAfterFilterCondition>
      collectionNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'collectionName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SyncConflict, SyncConflict, QAfterFilterCondition>
      collectionNameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'collectionName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SyncConflict, SyncConflict, QAfterFilterCondition>
      collectionNameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'collectionName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SyncConflict, SyncConflict, QAfterFilterCondition>
      collectionNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'collectionName',
        value: '',
      ));
    });
  }

  QueryBuilder<SyncConflict, SyncConflict, QAfterFilterCondition>
      collectionNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'collectionName',
        value: '',
      ));
    });
  }

  QueryBuilder<SyncConflict, SyncConflict, QAfterFilterCondition>
      conflictAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'conflictAt',
        value: value,
      ));
    });
  }

  QueryBuilder<SyncConflict, SyncConflict, QAfterFilterCondition>
      conflictAtGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'conflictAt',
        value: value,
      ));
    });
  }

  QueryBuilder<SyncConflict, SyncConflict, QAfterFilterCondition>
      conflictAtLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'conflictAt',
        value: value,
      ));
    });
  }

  QueryBuilder<SyncConflict, SyncConflict, QAfterFilterCondition>
      conflictAtBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'conflictAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<SyncConflict, SyncConflict, QAfterFilterCondition>
      entityUuidEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'entityUuid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SyncConflict, SyncConflict, QAfterFilterCondition>
      entityUuidGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'entityUuid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SyncConflict, SyncConflict, QAfterFilterCondition>
      entityUuidLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'entityUuid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SyncConflict, SyncConflict, QAfterFilterCondition>
      entityUuidBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'entityUuid',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SyncConflict, SyncConflict, QAfterFilterCondition>
      entityUuidStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'entityUuid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SyncConflict, SyncConflict, QAfterFilterCondition>
      entityUuidEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'entityUuid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SyncConflict, SyncConflict, QAfterFilterCondition>
      entityUuidContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'entityUuid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SyncConflict, SyncConflict, QAfterFilterCondition>
      entityUuidMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'entityUuid',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SyncConflict, SyncConflict, QAfterFilterCondition>
      entityUuidIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'entityUuid',
        value: '',
      ));
    });
  }

  QueryBuilder<SyncConflict, SyncConflict, QAfterFilterCondition>
      entityUuidIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'entityUuid',
        value: '',
      ));
    });
  }

  QueryBuilder<SyncConflict, SyncConflict, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<SyncConflict, SyncConflict, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<SyncConflict, SyncConflict, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<SyncConflict, SyncConflict, QAfterFilterCondition> idBetween(
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

  QueryBuilder<SyncConflict, SyncConflict, QAfterFilterCondition>
      isResolvedEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isResolved',
        value: value,
      ));
    });
  }

  QueryBuilder<SyncConflict, SyncConflict, QAfterFilterCondition>
      localPayloadEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'localPayload',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SyncConflict, SyncConflict, QAfterFilterCondition>
      localPayloadGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'localPayload',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SyncConflict, SyncConflict, QAfterFilterCondition>
      localPayloadLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'localPayload',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SyncConflict, SyncConflict, QAfterFilterCondition>
      localPayloadBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'localPayload',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SyncConflict, SyncConflict, QAfterFilterCondition>
      localPayloadStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'localPayload',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SyncConflict, SyncConflict, QAfterFilterCondition>
      localPayloadEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'localPayload',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SyncConflict, SyncConflict, QAfterFilterCondition>
      localPayloadContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'localPayload',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SyncConflict, SyncConflict, QAfterFilterCondition>
      localPayloadMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'localPayload',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SyncConflict, SyncConflict, QAfterFilterCondition>
      localPayloadIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'localPayload',
        value: '',
      ));
    });
  }

  QueryBuilder<SyncConflict, SyncConflict, QAfterFilterCondition>
      localPayloadIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'localPayload',
        value: '',
      ));
    });
  }

  QueryBuilder<SyncConflict, SyncConflict, QAfterFilterCondition>
      remotePayloadEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'remotePayload',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SyncConflict, SyncConflict, QAfterFilterCondition>
      remotePayloadGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'remotePayload',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SyncConflict, SyncConflict, QAfterFilterCondition>
      remotePayloadLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'remotePayload',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SyncConflict, SyncConflict, QAfterFilterCondition>
      remotePayloadBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'remotePayload',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SyncConflict, SyncConflict, QAfterFilterCondition>
      remotePayloadStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'remotePayload',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SyncConflict, SyncConflict, QAfterFilterCondition>
      remotePayloadEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'remotePayload',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SyncConflict, SyncConflict, QAfterFilterCondition>
      remotePayloadContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'remotePayload',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SyncConflict, SyncConflict, QAfterFilterCondition>
      remotePayloadMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'remotePayload',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SyncConflict, SyncConflict, QAfterFilterCondition>
      remotePayloadIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'remotePayload',
        value: '',
      ));
    });
  }

  QueryBuilder<SyncConflict, SyncConflict, QAfterFilterCondition>
      remotePayloadIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'remotePayload',
        value: '',
      ));
    });
  }

  QueryBuilder<SyncConflict, SyncConflict, QAfterFilterCondition>
      resolutionStrategyEqualTo(ConflictResolutionStrategy value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'resolutionStrategy',
        value: value,
      ));
    });
  }

  QueryBuilder<SyncConflict, SyncConflict, QAfterFilterCondition>
      resolutionStrategyGreaterThan(
    ConflictResolutionStrategy value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'resolutionStrategy',
        value: value,
      ));
    });
  }

  QueryBuilder<SyncConflict, SyncConflict, QAfterFilterCondition>
      resolutionStrategyLessThan(
    ConflictResolutionStrategy value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'resolutionStrategy',
        value: value,
      ));
    });
  }

  QueryBuilder<SyncConflict, SyncConflict, QAfterFilterCondition>
      resolutionStrategyBetween(
    ConflictResolutionStrategy lower,
    ConflictResolutionStrategy upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'resolutionStrategy',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<SyncConflict, SyncConflict, QAfterFilterCondition>
      resolvedAtIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'resolvedAt',
      ));
    });
  }

  QueryBuilder<SyncConflict, SyncConflict, QAfterFilterCondition>
      resolvedAtIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'resolvedAt',
      ));
    });
  }

  QueryBuilder<SyncConflict, SyncConflict, QAfterFilterCondition>
      resolvedAtEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'resolvedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<SyncConflict, SyncConflict, QAfterFilterCondition>
      resolvedAtGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'resolvedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<SyncConflict, SyncConflict, QAfterFilterCondition>
      resolvedAtLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'resolvedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<SyncConflict, SyncConflict, QAfterFilterCondition>
      resolvedAtBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'resolvedAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<SyncConflict, SyncConflict, QAfterFilterCondition>
      resolvedByUserIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'resolvedByUserId',
      ));
    });
  }

  QueryBuilder<SyncConflict, SyncConflict, QAfterFilterCondition>
      resolvedByUserIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'resolvedByUserId',
      ));
    });
  }

  QueryBuilder<SyncConflict, SyncConflict, QAfterFilterCondition>
      resolvedByUserIdEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'resolvedByUserId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SyncConflict, SyncConflict, QAfterFilterCondition>
      resolvedByUserIdGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'resolvedByUserId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SyncConflict, SyncConflict, QAfterFilterCondition>
      resolvedByUserIdLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'resolvedByUserId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SyncConflict, SyncConflict, QAfterFilterCondition>
      resolvedByUserIdBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'resolvedByUserId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SyncConflict, SyncConflict, QAfterFilterCondition>
      resolvedByUserIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'resolvedByUserId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SyncConflict, SyncConflict, QAfterFilterCondition>
      resolvedByUserIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'resolvedByUserId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SyncConflict, SyncConflict, QAfterFilterCondition>
      resolvedByUserIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'resolvedByUserId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SyncConflict, SyncConflict, QAfterFilterCondition>
      resolvedByUserIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'resolvedByUserId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SyncConflict, SyncConflict, QAfterFilterCondition>
      resolvedByUserIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'resolvedByUserId',
        value: '',
      ));
    });
  }

  QueryBuilder<SyncConflict, SyncConflict, QAfterFilterCondition>
      resolvedByUserIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'resolvedByUserId',
        value: '',
      ));
    });
  }
}

extension SyncConflictQueryObject
    on QueryBuilder<SyncConflict, SyncConflict, QFilterCondition> {}

extension SyncConflictQueryLinks
    on QueryBuilder<SyncConflict, SyncConflict, QFilterCondition> {}

extension SyncConflictQuerySortBy
    on QueryBuilder<SyncConflict, SyncConflict, QSortBy> {
  QueryBuilder<SyncConflict, SyncConflict, QAfterSortBy>
      sortByCollectionName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'collectionName', Sort.asc);
    });
  }

  QueryBuilder<SyncConflict, SyncConflict, QAfterSortBy>
      sortByCollectionNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'collectionName', Sort.desc);
    });
  }

  QueryBuilder<SyncConflict, SyncConflict, QAfterSortBy> sortByConflictAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'conflictAt', Sort.asc);
    });
  }

  QueryBuilder<SyncConflict, SyncConflict, QAfterSortBy>
      sortByConflictAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'conflictAt', Sort.desc);
    });
  }

  QueryBuilder<SyncConflict, SyncConflict, QAfterSortBy> sortByEntityUuid() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'entityUuid', Sort.asc);
    });
  }

  QueryBuilder<SyncConflict, SyncConflict, QAfterSortBy>
      sortByEntityUuidDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'entityUuid', Sort.desc);
    });
  }

  QueryBuilder<SyncConflict, SyncConflict, QAfterSortBy> sortByIsResolved() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isResolved', Sort.asc);
    });
  }

  QueryBuilder<SyncConflict, SyncConflict, QAfterSortBy>
      sortByIsResolvedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isResolved', Sort.desc);
    });
  }

  QueryBuilder<SyncConflict, SyncConflict, QAfterSortBy> sortByLocalPayload() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'localPayload', Sort.asc);
    });
  }

  QueryBuilder<SyncConflict, SyncConflict, QAfterSortBy>
      sortByLocalPayloadDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'localPayload', Sort.desc);
    });
  }

  QueryBuilder<SyncConflict, SyncConflict, QAfterSortBy> sortByRemotePayload() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'remotePayload', Sort.asc);
    });
  }

  QueryBuilder<SyncConflict, SyncConflict, QAfterSortBy>
      sortByRemotePayloadDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'remotePayload', Sort.desc);
    });
  }

  QueryBuilder<SyncConflict, SyncConflict, QAfterSortBy>
      sortByResolutionStrategy() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'resolutionStrategy', Sort.asc);
    });
  }

  QueryBuilder<SyncConflict, SyncConflict, QAfterSortBy>
      sortByResolutionStrategyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'resolutionStrategy', Sort.desc);
    });
  }

  QueryBuilder<SyncConflict, SyncConflict, QAfterSortBy> sortByResolvedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'resolvedAt', Sort.asc);
    });
  }

  QueryBuilder<SyncConflict, SyncConflict, QAfterSortBy>
      sortByResolvedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'resolvedAt', Sort.desc);
    });
  }

  QueryBuilder<SyncConflict, SyncConflict, QAfterSortBy>
      sortByResolvedByUserId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'resolvedByUserId', Sort.asc);
    });
  }

  QueryBuilder<SyncConflict, SyncConflict, QAfterSortBy>
      sortByResolvedByUserIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'resolvedByUserId', Sort.desc);
    });
  }
}

extension SyncConflictQuerySortThenBy
    on QueryBuilder<SyncConflict, SyncConflict, QSortThenBy> {
  QueryBuilder<SyncConflict, SyncConflict, QAfterSortBy>
      thenByCollectionName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'collectionName', Sort.asc);
    });
  }

  QueryBuilder<SyncConflict, SyncConflict, QAfterSortBy>
      thenByCollectionNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'collectionName', Sort.desc);
    });
  }

  QueryBuilder<SyncConflict, SyncConflict, QAfterSortBy> thenByConflictAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'conflictAt', Sort.asc);
    });
  }

  QueryBuilder<SyncConflict, SyncConflict, QAfterSortBy>
      thenByConflictAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'conflictAt', Sort.desc);
    });
  }

  QueryBuilder<SyncConflict, SyncConflict, QAfterSortBy> thenByEntityUuid() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'entityUuid', Sort.asc);
    });
  }

  QueryBuilder<SyncConflict, SyncConflict, QAfterSortBy>
      thenByEntityUuidDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'entityUuid', Sort.desc);
    });
  }

  QueryBuilder<SyncConflict, SyncConflict, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<SyncConflict, SyncConflict, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<SyncConflict, SyncConflict, QAfterSortBy> thenByIsResolved() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isResolved', Sort.asc);
    });
  }

  QueryBuilder<SyncConflict, SyncConflict, QAfterSortBy>
      thenByIsResolvedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isResolved', Sort.desc);
    });
  }

  QueryBuilder<SyncConflict, SyncConflict, QAfterSortBy> thenByLocalPayload() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'localPayload', Sort.asc);
    });
  }

  QueryBuilder<SyncConflict, SyncConflict, QAfterSortBy>
      thenByLocalPayloadDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'localPayload', Sort.desc);
    });
  }

  QueryBuilder<SyncConflict, SyncConflict, QAfterSortBy> thenByRemotePayload() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'remotePayload', Sort.asc);
    });
  }

  QueryBuilder<SyncConflict, SyncConflict, QAfterSortBy>
      thenByRemotePayloadDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'remotePayload', Sort.desc);
    });
  }

  QueryBuilder<SyncConflict, SyncConflict, QAfterSortBy>
      thenByResolutionStrategy() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'resolutionStrategy', Sort.asc);
    });
  }

  QueryBuilder<SyncConflict, SyncConflict, QAfterSortBy>
      thenByResolutionStrategyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'resolutionStrategy', Sort.desc);
    });
  }

  QueryBuilder<SyncConflict, SyncConflict, QAfterSortBy> thenByResolvedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'resolvedAt', Sort.asc);
    });
  }

  QueryBuilder<SyncConflict, SyncConflict, QAfterSortBy>
      thenByResolvedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'resolvedAt', Sort.desc);
    });
  }

  QueryBuilder<SyncConflict, SyncConflict, QAfterSortBy>
      thenByResolvedByUserId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'resolvedByUserId', Sort.asc);
    });
  }

  QueryBuilder<SyncConflict, SyncConflict, QAfterSortBy>
      thenByResolvedByUserIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'resolvedByUserId', Sort.desc);
    });
  }
}

extension SyncConflictQueryWhereDistinct
    on QueryBuilder<SyncConflict, SyncConflict, QDistinct> {
  QueryBuilder<SyncConflict, SyncConflict, QDistinct> distinctByCollectionName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'collectionName',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<SyncConflict, SyncConflict, QDistinct> distinctByConflictAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'conflictAt');
    });
  }

  QueryBuilder<SyncConflict, SyncConflict, QDistinct> distinctByEntityUuid(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'entityUuid', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<SyncConflict, SyncConflict, QDistinct> distinctByIsResolved() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isResolved');
    });
  }

  QueryBuilder<SyncConflict, SyncConflict, QDistinct> distinctByLocalPayload(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'localPayload', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<SyncConflict, SyncConflict, QDistinct> distinctByRemotePayload(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'remotePayload',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<SyncConflict, SyncConflict, QDistinct>
      distinctByResolutionStrategy() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'resolutionStrategy');
    });
  }

  QueryBuilder<SyncConflict, SyncConflict, QDistinct> distinctByResolvedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'resolvedAt');
    });
  }

  QueryBuilder<SyncConflict, SyncConflict, QDistinct>
      distinctByResolvedByUserId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'resolvedByUserId',
          caseSensitive: caseSensitive);
    });
  }
}

extension SyncConflictQueryProperty
    on QueryBuilder<SyncConflict, SyncConflict, QQueryProperty> {
  QueryBuilder<SyncConflict, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<SyncConflict, String, QQueryOperations>
      collectionNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'collectionName');
    });
  }

  QueryBuilder<SyncConflict, DateTime, QQueryOperations> conflictAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'conflictAt');
    });
  }

  QueryBuilder<SyncConflict, String, QQueryOperations> entityUuidProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'entityUuid');
    });
  }

  QueryBuilder<SyncConflict, bool, QQueryOperations> isResolvedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isResolved');
    });
  }

  QueryBuilder<SyncConflict, String, QQueryOperations> localPayloadProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'localPayload');
    });
  }

  QueryBuilder<SyncConflict, String, QQueryOperations> remotePayloadProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'remotePayload');
    });
  }

  QueryBuilder<SyncConflict, ConflictResolutionStrategy, QQueryOperations>
      resolutionStrategyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'resolutionStrategy');
    });
  }

  QueryBuilder<SyncConflict, DateTime?, QQueryOperations> resolvedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'resolvedAt');
    });
  }

  QueryBuilder<SyncConflict, String?, QQueryOperations>
      resolvedByUserIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'resolvedByUserId');
    });
  }
}
