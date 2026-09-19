// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_entity.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetProductEntityCollection on Isar {
  IsarCollection<ProductEntity> get productEntitys => this.collection();
}

const ProductEntitySchema = CollectionSchema(
  name: r'ProductEntity',
  id: (4867088266565 * 1000000 + 710661),
  properties: {
    r'basePrice': PropertySchema(
      id: 0,
      name: r'basePrice',
      type: IsarType.double,
    ),
    r'industryId': PropertySchema(
      id: 1,
      name: r'industryId',
      type: IsarType.string,
    ),
    r'isSynced': PropertySchema(
      id: 2,
      name: r'isSynced',
      type: IsarType.bool,
    ),
    r'lastModified': PropertySchema(
      id: 3,
      name: r'lastModified',
      type: IsarType.dateTime,
    ),
    r'name': PropertySchema(
      id: 4,
      name: r'name',
      type: IsarType.string,
    ),
    r'sku': PropertySchema(
      id: 5,
      name: r'sku',
      type: IsarType.string,
    )
  },
  estimateSize: _productEntityEstimateSize,
  serialize: _productEntitySerialize,
  deserialize: _productEntityDeserialize,
  deserializeProp: _productEntityDeserializeProp,
  idName: r'id',
  indexes: {
    r'sku': IndexSchema(
      id: -(3348042439688 * 1000000 + 860591),
      name: r'sku',
      unique: true,
      replace: true,
      properties: [
        IndexPropertySchema(
          name: r'sku',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    ),
    r'isSynced': IndexSchema(
      id: -(39763503327 * 1000000 + 887510),
      name: r'isSynced',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'isSynced',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _productEntityGetId,
  getLinks: _productEntityGetLinks,
  attach: _productEntityAttach,
  version: '3.1.0+1',
);

int _productEntityEstimateSize(
  ProductEntity object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.industryId.length * 3;
  bytesCount += 3 + object.name.length * 3;
  bytesCount += 3 + object.sku.length * 3;
  return bytesCount;
}

void _productEntitySerialize(
  ProductEntity object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDouble(offsets[0], object.basePrice);
  writer.writeString(offsets[1], object.industryId);
  writer.writeBool(offsets[2], object.isSynced);
  writer.writeDateTime(offsets[3], object.lastModified);
  writer.writeString(offsets[4], object.name);
  writer.writeString(offsets[5], object.sku);
}

ProductEntity _productEntityDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = ProductEntity();
  object.basePrice = reader.readDouble(offsets[0]);
  object.id = id;
  object.industryId = reader.readString(offsets[1]);
  object.isSynced = reader.readBool(offsets[2]);
  object.lastModified = reader.readDateTime(offsets[3]);
  object.name = reader.readString(offsets[4]);
  object.sku = reader.readString(offsets[5]);
  return object;
}

P _productEntityDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDouble(offset)) as P;
    case 1:
      return (reader.readString(offset)) as P;
    case 2:
      return (reader.readBool(offset)) as P;
    case 3:
      return (reader.readDateTime(offset)) as P;
    case 4:
      return (reader.readString(offset)) as P;
    case 5:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _productEntityGetId(ProductEntity object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _productEntityGetLinks(ProductEntity object) {
  return [];
}

void _productEntityAttach(
    IsarCollection<dynamic> col, Id id, ProductEntity object) {
  object.id = id;
}

extension ProductEntityByIndex on IsarCollection<ProductEntity> {
  Future<ProductEntity?> getBySku(String sku) {
    return getByIndex(r'sku', [sku]);
  }

  ProductEntity? getBySkuSync(String sku) {
    return getByIndexSync(r'sku', [sku]);
  }

  Future<bool> deleteBySku(String sku) {
    return deleteByIndex(r'sku', [sku]);
  }

  bool deleteBySkuSync(String sku) {
    return deleteByIndexSync(r'sku', [sku]);
  }

  Future<List<ProductEntity?>> getAllBySku(List<String> skuValues) {
    final values = skuValues.map((e) => [e]).toList();
    return getAllByIndex(r'sku', values);
  }

  List<ProductEntity?> getAllBySkuSync(List<String> skuValues) {
    final values = skuValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'sku', values);
  }

  Future<int> deleteAllBySku(List<String> skuValues) {
    final values = skuValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'sku', values);
  }

  int deleteAllBySkuSync(List<String> skuValues) {
    final values = skuValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'sku', values);
  }

  Future<Id> putBySku(ProductEntity object) {
    return putByIndex(r'sku', object);
  }

  Id putBySkuSync(ProductEntity object, {bool saveLinks = true}) {
    return putByIndexSync(r'sku', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllBySku(List<ProductEntity> objects) {
    return putAllByIndex(r'sku', objects);
  }

  List<Id> putAllBySkuSync(List<ProductEntity> objects,
      {bool saveLinks = true}) {
    return putAllByIndexSync(r'sku', objects, saveLinks: saveLinks);
  }
}

extension ProductEntityQueryWhereSort
    on QueryBuilder<ProductEntity, ProductEntity, QWhere> {
  QueryBuilder<ProductEntity, ProductEntity, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<ProductEntity, ProductEntity, QAfterWhere> anyIsSynced() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'isSynced'),
      );
    });
  }
}

extension ProductEntityQueryWhere
    on QueryBuilder<ProductEntity, ProductEntity, QWhereClause> {
  QueryBuilder<ProductEntity, ProductEntity, QAfterWhereClause> idEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<ProductEntity, ProductEntity, QAfterWhereClause> idNotEqualTo(
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

  QueryBuilder<ProductEntity, ProductEntity, QAfterWhereClause> idGreaterThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<ProductEntity, ProductEntity, QAfterWhereClause> idLessThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<ProductEntity, ProductEntity, QAfterWhereClause> idBetween(
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

  QueryBuilder<ProductEntity, ProductEntity, QAfterWhereClause> skuEqualTo(
      String sku) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'sku',
        value: [sku],
      ));
    });
  }

  QueryBuilder<ProductEntity, ProductEntity, QAfterWhereClause> skuNotEqualTo(
      String sku) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'sku',
              lower: [],
              upper: [sku],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'sku',
              lower: [sku],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'sku',
              lower: [sku],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'sku',
              lower: [],
              upper: [sku],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<ProductEntity, ProductEntity, QAfterWhereClause> isSyncedEqualTo(
      bool isSynced) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'isSynced',
        value: [isSynced],
      ));
    });
  }

  QueryBuilder<ProductEntity, ProductEntity, QAfterWhereClause>
      isSyncedNotEqualTo(bool isSynced) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'isSynced',
              lower: [],
              upper: [isSynced],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'isSynced',
              lower: [isSynced],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'isSynced',
              lower: [isSynced],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'isSynced',
              lower: [],
              upper: [isSynced],
              includeUpper: false,
            ));
      }
    });
  }
}

extension ProductEntityQueryFilter
    on QueryBuilder<ProductEntity, ProductEntity, QFilterCondition> {
  QueryBuilder<ProductEntity, ProductEntity, QAfterFilterCondition>
      basePriceEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'basePrice',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<ProductEntity, ProductEntity, QAfterFilterCondition>
      basePriceGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'basePrice',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<ProductEntity, ProductEntity, QAfterFilterCondition>
      basePriceLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'basePrice',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<ProductEntity, ProductEntity, QAfterFilterCondition>
      basePriceBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'basePrice',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<ProductEntity, ProductEntity, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<ProductEntity, ProductEntity, QAfterFilterCondition>
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

  QueryBuilder<ProductEntity, ProductEntity, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<ProductEntity, ProductEntity, QAfterFilterCondition> idBetween(
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

  QueryBuilder<ProductEntity, ProductEntity, QAfterFilterCondition>
      industryIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'industryId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProductEntity, ProductEntity, QAfterFilterCondition>
      industryIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'industryId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProductEntity, ProductEntity, QAfterFilterCondition>
      industryIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'industryId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProductEntity, ProductEntity, QAfterFilterCondition>
      industryIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'industryId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProductEntity, ProductEntity, QAfterFilterCondition>
      industryIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'industryId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProductEntity, ProductEntity, QAfterFilterCondition>
      industryIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'industryId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProductEntity, ProductEntity, QAfterFilterCondition>
      industryIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'industryId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProductEntity, ProductEntity, QAfterFilterCondition>
      industryIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'industryId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProductEntity, ProductEntity, QAfterFilterCondition>
      industryIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'industryId',
        value: '',
      ));
    });
  }

  QueryBuilder<ProductEntity, ProductEntity, QAfterFilterCondition>
      industryIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'industryId',
        value: '',
      ));
    });
  }

  QueryBuilder<ProductEntity, ProductEntity, QAfterFilterCondition>
      isSyncedEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isSynced',
        value: value,
      ));
    });
  }

  QueryBuilder<ProductEntity, ProductEntity, QAfterFilterCondition>
      lastModifiedEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lastModified',
        value: value,
      ));
    });
  }

  QueryBuilder<ProductEntity, ProductEntity, QAfterFilterCondition>
      lastModifiedGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'lastModified',
        value: value,
      ));
    });
  }

  QueryBuilder<ProductEntity, ProductEntity, QAfterFilterCondition>
      lastModifiedLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'lastModified',
        value: value,
      ));
    });
  }

  QueryBuilder<ProductEntity, ProductEntity, QAfterFilterCondition>
      lastModifiedBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'lastModified',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ProductEntity, ProductEntity, QAfterFilterCondition> nameEqualTo(
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

  QueryBuilder<ProductEntity, ProductEntity, QAfterFilterCondition>
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

  QueryBuilder<ProductEntity, ProductEntity, QAfterFilterCondition>
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

  QueryBuilder<ProductEntity, ProductEntity, QAfterFilterCondition> nameBetween(
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

  QueryBuilder<ProductEntity, ProductEntity, QAfterFilterCondition>
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

  QueryBuilder<ProductEntity, ProductEntity, QAfterFilterCondition>
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

  QueryBuilder<ProductEntity, ProductEntity, QAfterFilterCondition>
      nameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProductEntity, ProductEntity, QAfterFilterCondition> nameMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'name',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProductEntity, ProductEntity, QAfterFilterCondition>
      nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<ProductEntity, ProductEntity, QAfterFilterCondition>
      nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<ProductEntity, ProductEntity, QAfterFilterCondition> skuEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'sku',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProductEntity, ProductEntity, QAfterFilterCondition>
      skuGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'sku',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProductEntity, ProductEntity, QAfterFilterCondition> skuLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'sku',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProductEntity, ProductEntity, QAfterFilterCondition> skuBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'sku',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProductEntity, ProductEntity, QAfterFilterCondition>
      skuStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'sku',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProductEntity, ProductEntity, QAfterFilterCondition> skuEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'sku',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProductEntity, ProductEntity, QAfterFilterCondition> skuContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'sku',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProductEntity, ProductEntity, QAfterFilterCondition> skuMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'sku',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProductEntity, ProductEntity, QAfterFilterCondition>
      skuIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'sku',
        value: '',
      ));
    });
  }

  QueryBuilder<ProductEntity, ProductEntity, QAfterFilterCondition>
      skuIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'sku',
        value: '',
      ));
    });
  }
}

extension ProductEntityQueryObject
    on QueryBuilder<ProductEntity, ProductEntity, QFilterCondition> {}

extension ProductEntityQueryLinks
    on QueryBuilder<ProductEntity, ProductEntity, QFilterCondition> {}

extension ProductEntityQuerySortBy
    on QueryBuilder<ProductEntity, ProductEntity, QSortBy> {
  QueryBuilder<ProductEntity, ProductEntity, QAfterSortBy> sortByBasePrice() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'basePrice', Sort.asc);
    });
  }

  QueryBuilder<ProductEntity, ProductEntity, QAfterSortBy>
      sortByBasePriceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'basePrice', Sort.desc);
    });
  }

  QueryBuilder<ProductEntity, ProductEntity, QAfterSortBy> sortByIndustryId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'industryId', Sort.asc);
    });
  }

  QueryBuilder<ProductEntity, ProductEntity, QAfterSortBy>
      sortByIndustryIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'industryId', Sort.desc);
    });
  }

  QueryBuilder<ProductEntity, ProductEntity, QAfterSortBy> sortByIsSynced() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isSynced', Sort.asc);
    });
  }

  QueryBuilder<ProductEntity, ProductEntity, QAfterSortBy>
      sortByIsSyncedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isSynced', Sort.desc);
    });
  }

  QueryBuilder<ProductEntity, ProductEntity, QAfterSortBy>
      sortByLastModified() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastModified', Sort.asc);
    });
  }

  QueryBuilder<ProductEntity, ProductEntity, QAfterSortBy>
      sortByLastModifiedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastModified', Sort.desc);
    });
  }

  QueryBuilder<ProductEntity, ProductEntity, QAfterSortBy> sortByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<ProductEntity, ProductEntity, QAfterSortBy> sortByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<ProductEntity, ProductEntity, QAfterSortBy> sortBySku() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sku', Sort.asc);
    });
  }

  QueryBuilder<ProductEntity, ProductEntity, QAfterSortBy> sortBySkuDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sku', Sort.desc);
    });
  }
}

extension ProductEntityQuerySortThenBy
    on QueryBuilder<ProductEntity, ProductEntity, QSortThenBy> {
  QueryBuilder<ProductEntity, ProductEntity, QAfterSortBy> thenByBasePrice() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'basePrice', Sort.asc);
    });
  }

  QueryBuilder<ProductEntity, ProductEntity, QAfterSortBy>
      thenByBasePriceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'basePrice', Sort.desc);
    });
  }

  QueryBuilder<ProductEntity, ProductEntity, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<ProductEntity, ProductEntity, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<ProductEntity, ProductEntity, QAfterSortBy> thenByIndustryId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'industryId', Sort.asc);
    });
  }

  QueryBuilder<ProductEntity, ProductEntity, QAfterSortBy>
      thenByIndustryIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'industryId', Sort.desc);
    });
  }

  QueryBuilder<ProductEntity, ProductEntity, QAfterSortBy> thenByIsSynced() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isSynced', Sort.asc);
    });
  }

  QueryBuilder<ProductEntity, ProductEntity, QAfterSortBy>
      thenByIsSyncedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isSynced', Sort.desc);
    });
  }

  QueryBuilder<ProductEntity, ProductEntity, QAfterSortBy>
      thenByLastModified() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastModified', Sort.asc);
    });
  }

  QueryBuilder<ProductEntity, ProductEntity, QAfterSortBy>
      thenByLastModifiedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastModified', Sort.desc);
    });
  }

  QueryBuilder<ProductEntity, ProductEntity, QAfterSortBy> thenByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<ProductEntity, ProductEntity, QAfterSortBy> thenByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<ProductEntity, ProductEntity, QAfterSortBy> thenBySku() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sku', Sort.asc);
    });
  }

  QueryBuilder<ProductEntity, ProductEntity, QAfterSortBy> thenBySkuDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sku', Sort.desc);
    });
  }
}

extension ProductEntityQueryWhereDistinct
    on QueryBuilder<ProductEntity, ProductEntity, QDistinct> {
  QueryBuilder<ProductEntity, ProductEntity, QDistinct> distinctByBasePrice() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'basePrice');
    });
  }

  QueryBuilder<ProductEntity, ProductEntity, QDistinct> distinctByIndustryId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'industryId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ProductEntity, ProductEntity, QDistinct> distinctByIsSynced() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isSynced');
    });
  }

  QueryBuilder<ProductEntity, ProductEntity, QDistinct>
      distinctByLastModified() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'lastModified');
    });
  }

  QueryBuilder<ProductEntity, ProductEntity, QDistinct> distinctByName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'name', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ProductEntity, ProductEntity, QDistinct> distinctBySku(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'sku', caseSensitive: caseSensitive);
    });
  }
}

extension ProductEntityQueryProperty
    on QueryBuilder<ProductEntity, ProductEntity, QQueryProperty> {
  QueryBuilder<ProductEntity, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<ProductEntity, double, QQueryOperations> basePriceProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'basePrice');
    });
  }

  QueryBuilder<ProductEntity, String, QQueryOperations> industryIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'industryId');
    });
  }

  QueryBuilder<ProductEntity, bool, QQueryOperations> isSyncedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isSynced');
    });
  }

  QueryBuilder<ProductEntity, DateTime, QQueryOperations>
      lastModifiedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'lastModified');
    });
  }

  QueryBuilder<ProductEntity, String, QQueryOperations> nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'name');
    });
  }

  QueryBuilder<ProductEntity, String, QQueryOperations> skuProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'sku');
    });
  }
}
