// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'staff_collections.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetEmployeeCollectionCollection on Isar {
  IsarCollection<EmployeeCollection> get employeeCollections =>
      this.collection();
}

const EmployeeCollectionSchema = CollectionSchema(
  name: r'EmployeeCollection',
  id: (5332590496774 * 1000000 + 953879),
  properties: {
    r'addressLine1': PropertySchema(
      id: 0,
      name: r'addressLine1',
      type: IsarType.string,
    ),
    r'addressLine2': PropertySchema(
      id: 1,
      name: r'addressLine2',
      type: IsarType.string,
    ),
    r'aiInsightsJson': PropertySchema(
      id: 2,
      name: r'aiInsightsJson',
      type: IsarType.string,
    ),
    r'bankAccountId': PropertySchema(
      id: 3,
      name: r'bankAccountId',
      type: IsarType.string,
    ),
    r'bloodGroup': PropertySchema(
      id: 4,
      name: r'bloodGroup',
      type: IsarType.string,
    ),
    r'branchId': PropertySchema(
      id: 5,
      name: r'branchId',
      type: IsarType.string,
    ),
    r'city': PropertySchema(
      id: 6,
      name: r'city',
      type: IsarType.string,
    ),
    r'companyId': PropertySchema(
      id: 7,
      name: r'companyId',
      type: IsarType.string,
    ),
    r'country': PropertySchema(
      id: 8,
      name: r'country',
      type: IsarType.string,
    ),
    r'createdAt': PropertySchema(
      id: 9,
      name: r'createdAt',
      type: IsarType.dateTime,
    ),
    r'dateOfBirth': PropertySchema(
      id: 10,
      name: r'dateOfBirth',
      type: IsarType.dateTime,
    ),
    r'dateOfJoining': PropertySchema(
      id: 11,
      name: r'dateOfJoining',
      type: IsarType.dateTime,
    ),
    r'departmentId': PropertySchema(
      id: 12,
      name: r'departmentId',
      type: IsarType.string,
    ),
    r'designationId': PropertySchema(
      id: 13,
      name: r'designationId',
      type: IsarType.string,
    ),
    r'email': PropertySchema(
      id: 14,
      name: r'email',
      type: IsarType.string,
    ),
    r'emergencyContactName': PropertySchema(
      id: 15,
      name: r'emergencyContactName',
      type: IsarType.string,
    ),
    r'emergencyContactPhone': PropertySchema(
      id: 16,
      name: r'emergencyContactPhone',
      type: IsarType.string,
    ),
    r'employeeCode': PropertySchema(
      id: 17,
      name: r'employeeCode',
      type: IsarType.string,
    ),
    r'employmentType': PropertySchema(
      id: 18,
      name: r'employmentType',
      type: IsarType.string,
    ),
    r'firstName': PropertySchema(
      id: 19,
      name: r'firstName',
      type: IsarType.string,
    ),
    r'gender': PropertySchema(
      id: 20,
      name: r'gender',
      type: IsarType.string,
    ),
    r'isDeleted': PropertySchema(
      id: 21,
      name: r'isDeleted',
      type: IsarType.bool,
    ),
    r'lastName': PropertySchema(
      id: 22,
      name: r'lastName',
      type: IsarType.string,
    ),
    r'managerId': PropertySchema(
      id: 23,
      name: r'managerId',
      type: IsarType.string,
    ),
    r'maritalStatus': PropertySchema(
      id: 24,
      name: r'maritalStatus',
      type: IsarType.string,
    ),
    r'name': PropertySchema(
      id: 25,
      name: r'name',
      type: IsarType.string,
    ),
    r'phone': PropertySchema(
      id: 26,
      name: r'phone',
      type: IsarType.string,
    ),
    r'photoUrl': PropertySchema(
      id: 27,
      name: r'photoUrl',
      type: IsarType.string,
    ),
    r'salaryStructureId': PropertySchema(
      id: 28,
      name: r'salaryStructureId',
      type: IsarType.string,
    ),
    r'shiftId': PropertySchema(
      id: 29,
      name: r'shiftId',
      type: IsarType.string,
    ),
    r'skills': PropertySchema(
      id: 30,
      name: r'skills',
      type: IsarType.stringList,
    ),
    r'state': PropertySchema(
      id: 31,
      name: r'state',
      type: IsarType.string,
    ),
    r'status': PropertySchema(
      id: 32,
      name: r'status',
      type: IsarType.string,
    ),
    r'updatedAt': PropertySchema(
      id: 33,
      name: r'updatedAt',
      type: IsarType.dateTime,
    ),
    r'userId': PropertySchema(
      id: 34,
      name: r'userId',
      type: IsarType.string,
    ),
    r'uuid': PropertySchema(
      id: 35,
      name: r'uuid',
      type: IsarType.string,
    ),
    r'whatsapp': PropertySchema(
      id: 36,
      name: r'whatsapp',
      type: IsarType.string,
    ),
    r'workLocation': PropertySchema(
      id: 37,
      name: r'workLocation',
      type: IsarType.string,
    ),
    r'zipCode': PropertySchema(
      id: 38,
      name: r'zipCode',
      type: IsarType.string,
    )
  },
  estimateSize: _employeeCollectionEstimateSize,
  serialize: _employeeCollectionSerialize,
  deserialize: _employeeCollectionDeserialize,
  deserializeProp: _employeeCollectionDeserializeProp,
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
    r'employeeCode': IndexSchema(
      id: (7493838445661 * 1000000 + 731167),
      name: r'employeeCode',
      unique: true,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'employeeCode',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    ),
    r'firstName': IndexSchema(
      id: -(2537032818573 * 1000000 + 98835),
      name: r'firstName',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'firstName',
          type: IndexType.hash,
          caseSensitive: false,
        )
      ],
    ),
    r'lastName': IndexSchema(
      id: (8422632250150 * 1000000 + 515205),
      name: r'lastName',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'lastName',
          type: IndexType.hash,
          caseSensitive: false,
        )
      ],
    ),
    r'companyId': IndexSchema(
      id: (482756417767 * 1000000 + 355356),
      name: r'companyId',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'companyId',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    ),
    r'branchId': IndexSchema(
      id: (2037049677925 * 1000000 + 728410),
      name: r'branchId',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'branchId',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    ),
    r'departmentId': IndexSchema(
      id: -(6304464459915 * 1000000 + 199197),
      name: r'departmentId',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'departmentId',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    ),
    r'designationId': IndexSchema(
      id: (7698469016630 * 1000000 + 293300),
      name: r'designationId',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'designationId',
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
  getId: _employeeCollectionGetId,
  getLinks: _employeeCollectionGetLinks,
  attach: _employeeCollectionAttach,
  version: '3.1.0+1',
);

int _employeeCollectionEstimateSize(
  EmployeeCollection object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.addressLine1;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.addressLine2;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.aiInsightsJson;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.bankAccountId;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.bloodGroup;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.branchId.length * 3;
  {
    final value = object.city;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.companyId.length * 3;
  {
    final value = object.country;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.departmentId.length * 3;
  bytesCount += 3 + object.designationId.length * 3;
  bytesCount += 3 + object.email.length * 3;
  {
    final value = object.emergencyContactName;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.emergencyContactPhone;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.employeeCode.length * 3;
  bytesCount += 3 + object.employmentType.length * 3;
  bytesCount += 3 + object.firstName.length * 3;
  bytesCount += 3 + object.gender.length * 3;
  bytesCount += 3 + object.lastName.length * 3;
  {
    final value = object.managerId;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.maritalStatus.length * 3;
  bytesCount += 3 + object.name.length * 3;
  bytesCount += 3 + object.phone.length * 3;
  {
    final value = object.photoUrl;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.salaryStructureId;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.shiftId;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.skills.length * 3;
  {
    for (var i = 0; i < object.skills.length; i++) {
      final value = object.skills[i];
      bytesCount += value.length * 3;
    }
  }
  {
    final value = object.state;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.status.length * 3;
  {
    final value = object.userId;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.uuid.length * 3;
  {
    final value = object.whatsapp;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.workLocation;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.zipCode;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _employeeCollectionSerialize(
  EmployeeCollection object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.addressLine1);
  writer.writeString(offsets[1], object.addressLine2);
  writer.writeString(offsets[2], object.aiInsightsJson);
  writer.writeString(offsets[3], object.bankAccountId);
  writer.writeString(offsets[4], object.bloodGroup);
  writer.writeString(offsets[5], object.branchId);
  writer.writeString(offsets[6], object.city);
  writer.writeString(offsets[7], object.companyId);
  writer.writeString(offsets[8], object.country);
  writer.writeDateTime(offsets[9], object.createdAt);
  writer.writeDateTime(offsets[10], object.dateOfBirth);
  writer.writeDateTime(offsets[11], object.dateOfJoining);
  writer.writeString(offsets[12], object.departmentId);
  writer.writeString(offsets[13], object.designationId);
  writer.writeString(offsets[14], object.email);
  writer.writeString(offsets[15], object.emergencyContactName);
  writer.writeString(offsets[16], object.emergencyContactPhone);
  writer.writeString(offsets[17], object.employeeCode);
  writer.writeString(offsets[18], object.employmentType);
  writer.writeString(offsets[19], object.firstName);
  writer.writeString(offsets[20], object.gender);
  writer.writeBool(offsets[21], object.isDeleted);
  writer.writeString(offsets[22], object.lastName);
  writer.writeString(offsets[23], object.managerId);
  writer.writeString(offsets[24], object.maritalStatus);
  writer.writeString(offsets[25], object.name);
  writer.writeString(offsets[26], object.phone);
  writer.writeString(offsets[27], object.photoUrl);
  writer.writeString(offsets[28], object.salaryStructureId);
  writer.writeString(offsets[29], object.shiftId);
  writer.writeStringList(offsets[30], object.skills);
  writer.writeString(offsets[31], object.state);
  writer.writeString(offsets[32], object.status);
  writer.writeDateTime(offsets[33], object.updatedAt);
  writer.writeString(offsets[34], object.userId);
  writer.writeString(offsets[35], object.uuid);
  writer.writeString(offsets[36], object.whatsapp);
  writer.writeString(offsets[37], object.workLocation);
  writer.writeString(offsets[38], object.zipCode);
}

EmployeeCollection _employeeCollectionDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = EmployeeCollection();
  object.addressLine1 = reader.readStringOrNull(offsets[0]);
  object.addressLine2 = reader.readStringOrNull(offsets[1]);
  object.aiInsightsJson = reader.readStringOrNull(offsets[2]);
  object.bankAccountId = reader.readStringOrNull(offsets[3]);
  object.bloodGroup = reader.readStringOrNull(offsets[4]);
  object.branchId = reader.readString(offsets[5]);
  object.city = reader.readStringOrNull(offsets[6]);
  object.companyId = reader.readString(offsets[7]);
  object.country = reader.readStringOrNull(offsets[8]);
  object.createdAt = reader.readDateTime(offsets[9]);
  object.dateOfBirth = reader.readDateTimeOrNull(offsets[10]);
  object.dateOfJoining = reader.readDateTime(offsets[11]);
  object.departmentId = reader.readString(offsets[12]);
  object.designationId = reader.readString(offsets[13]);
  object.email = reader.readString(offsets[14]);
  object.emergencyContactName = reader.readStringOrNull(offsets[15]);
  object.emergencyContactPhone = reader.readStringOrNull(offsets[16]);
  object.employeeCode = reader.readString(offsets[17]);
  object.employmentType = reader.readString(offsets[18]);
  object.firstName = reader.readString(offsets[19]);
  object.gender = reader.readString(offsets[20]);
  object.id = id;
  object.isDeleted = reader.readBool(offsets[21]);
  object.lastName = reader.readString(offsets[22]);
  object.managerId = reader.readStringOrNull(offsets[23]);
  object.maritalStatus = reader.readString(offsets[24]);
  object.phone = reader.readString(offsets[26]);
  object.photoUrl = reader.readStringOrNull(offsets[27]);
  object.salaryStructureId = reader.readStringOrNull(offsets[28]);
  object.shiftId = reader.readStringOrNull(offsets[29]);
  object.skills = reader.readStringList(offsets[30]) ?? [];
  object.state = reader.readStringOrNull(offsets[31]);
  object.status = reader.readString(offsets[32]);
  object.updatedAt = reader.readDateTime(offsets[33]);
  object.userId = reader.readStringOrNull(offsets[34]);
  object.uuid = reader.readString(offsets[35]);
  object.whatsapp = reader.readStringOrNull(offsets[36]);
  object.workLocation = reader.readStringOrNull(offsets[37]);
  object.zipCode = reader.readStringOrNull(offsets[38]);
  return object;
}

P _employeeCollectionDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringOrNull(offset)) as P;
    case 1:
      return (reader.readStringOrNull(offset)) as P;
    case 2:
      return (reader.readStringOrNull(offset)) as P;
    case 3:
      return (reader.readStringOrNull(offset)) as P;
    case 4:
      return (reader.readStringOrNull(offset)) as P;
    case 5:
      return (reader.readString(offset)) as P;
    case 6:
      return (reader.readStringOrNull(offset)) as P;
    case 7:
      return (reader.readString(offset)) as P;
    case 8:
      return (reader.readStringOrNull(offset)) as P;
    case 9:
      return (reader.readDateTime(offset)) as P;
    case 10:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 11:
      return (reader.readDateTime(offset)) as P;
    case 12:
      return (reader.readString(offset)) as P;
    case 13:
      return (reader.readString(offset)) as P;
    case 14:
      return (reader.readString(offset)) as P;
    case 15:
      return (reader.readStringOrNull(offset)) as P;
    case 16:
      return (reader.readStringOrNull(offset)) as P;
    case 17:
      return (reader.readString(offset)) as P;
    case 18:
      return (reader.readString(offset)) as P;
    case 19:
      return (reader.readString(offset)) as P;
    case 20:
      return (reader.readString(offset)) as P;
    case 21:
      return (reader.readBool(offset)) as P;
    case 22:
      return (reader.readString(offset)) as P;
    case 23:
      return (reader.readStringOrNull(offset)) as P;
    case 24:
      return (reader.readString(offset)) as P;
    case 25:
      return (reader.readString(offset)) as P;
    case 26:
      return (reader.readString(offset)) as P;
    case 27:
      return (reader.readStringOrNull(offset)) as P;
    case 28:
      return (reader.readStringOrNull(offset)) as P;
    case 29:
      return (reader.readStringOrNull(offset)) as P;
    case 30:
      return (reader.readStringList(offset) ?? []) as P;
    case 31:
      return (reader.readStringOrNull(offset)) as P;
    case 32:
      return (reader.readString(offset)) as P;
    case 33:
      return (reader.readDateTime(offset)) as P;
    case 34:
      return (reader.readStringOrNull(offset)) as P;
    case 35:
      return (reader.readString(offset)) as P;
    case 36:
      return (reader.readStringOrNull(offset)) as P;
    case 37:
      return (reader.readStringOrNull(offset)) as P;
    case 38:
      return (reader.readStringOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _employeeCollectionGetId(EmployeeCollection object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _employeeCollectionGetLinks(
    EmployeeCollection object) {
  return [];
}

void _employeeCollectionAttach(
    IsarCollection<dynamic> col, Id id, EmployeeCollection object) {
  object.id = id;
}

extension EmployeeCollectionByIndex on IsarCollection<EmployeeCollection> {
  Future<EmployeeCollection?> getByUuid(String uuid) {
    return getByIndex(r'uuid', [uuid]);
  }

  EmployeeCollection? getByUuidSync(String uuid) {
    return getByIndexSync(r'uuid', [uuid]);
  }

  Future<bool> deleteByUuid(String uuid) {
    return deleteByIndex(r'uuid', [uuid]);
  }

  bool deleteByUuidSync(String uuid) {
    return deleteByIndexSync(r'uuid', [uuid]);
  }

  Future<List<EmployeeCollection?>> getAllByUuid(List<String> uuidValues) {
    final values = uuidValues.map((e) => [e]).toList();
    return getAllByIndex(r'uuid', values);
  }

  List<EmployeeCollection?> getAllByUuidSync(List<String> uuidValues) {
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

  Future<Id> putByUuid(EmployeeCollection object) {
    return putByIndex(r'uuid', object);
  }

  Id putByUuidSync(EmployeeCollection object, {bool saveLinks = true}) {
    return putByIndexSync(r'uuid', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByUuid(List<EmployeeCollection> objects) {
    return putAllByIndex(r'uuid', objects);
  }

  List<Id> putAllByUuidSync(List<EmployeeCollection> objects,
      {bool saveLinks = true}) {
    return putAllByIndexSync(r'uuid', objects, saveLinks: saveLinks);
  }

  Future<EmployeeCollection?> getByEmployeeCode(String employeeCode) {
    return getByIndex(r'employeeCode', [employeeCode]);
  }

  EmployeeCollection? getByEmployeeCodeSync(String employeeCode) {
    return getByIndexSync(r'employeeCode', [employeeCode]);
  }

  Future<bool> deleteByEmployeeCode(String employeeCode) {
    return deleteByIndex(r'employeeCode', [employeeCode]);
  }

  bool deleteByEmployeeCodeSync(String employeeCode) {
    return deleteByIndexSync(r'employeeCode', [employeeCode]);
  }

  Future<List<EmployeeCollection?>> getAllByEmployeeCode(
      List<String> employeeCodeValues) {
    final values = employeeCodeValues.map((e) => [e]).toList();
    return getAllByIndex(r'employeeCode', values);
  }

  List<EmployeeCollection?> getAllByEmployeeCodeSync(
      List<String> employeeCodeValues) {
    final values = employeeCodeValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'employeeCode', values);
  }

  Future<int> deleteAllByEmployeeCode(List<String> employeeCodeValues) {
    final values = employeeCodeValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'employeeCode', values);
  }

  int deleteAllByEmployeeCodeSync(List<String> employeeCodeValues) {
    final values = employeeCodeValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'employeeCode', values);
  }

  Future<Id> putByEmployeeCode(EmployeeCollection object) {
    return putByIndex(r'employeeCode', object);
  }

  Id putByEmployeeCodeSync(EmployeeCollection object, {bool saveLinks = true}) {
    return putByIndexSync(r'employeeCode', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByEmployeeCode(List<EmployeeCollection> objects) {
    return putAllByIndex(r'employeeCode', objects);
  }

  List<Id> putAllByEmployeeCodeSync(List<EmployeeCollection> objects,
      {bool saveLinks = true}) {
    return putAllByIndexSync(r'employeeCode', objects, saveLinks: saveLinks);
  }
}

extension EmployeeCollectionQueryWhereSort
    on QueryBuilder<EmployeeCollection, EmployeeCollection, QWhere> {
  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension EmployeeCollectionQueryWhere
    on QueryBuilder<EmployeeCollection, EmployeeCollection, QWhereClause> {
  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterWhereClause>
      idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterWhereClause>
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

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterWhereClause>
      idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterWhereClause>
      idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterWhereClause>
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

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterWhereClause>
      uuidEqualTo(String uuid) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'uuid',
        value: [uuid],
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterWhereClause>
      uuidNotEqualTo(String uuid) {
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

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterWhereClause>
      employeeCodeEqualTo(String employeeCode) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'employeeCode',
        value: [employeeCode],
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterWhereClause>
      employeeCodeNotEqualTo(String employeeCode) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'employeeCode',
              lower: [],
              upper: [employeeCode],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'employeeCode',
              lower: [employeeCode],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'employeeCode',
              lower: [employeeCode],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'employeeCode',
              lower: [],
              upper: [employeeCode],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterWhereClause>
      firstNameEqualTo(String firstName) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'firstName',
        value: [firstName],
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterWhereClause>
      firstNameNotEqualTo(String firstName) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'firstName',
              lower: [],
              upper: [firstName],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'firstName',
              lower: [firstName],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'firstName',
              lower: [firstName],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'firstName',
              lower: [],
              upper: [firstName],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterWhereClause>
      lastNameEqualTo(String lastName) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'lastName',
        value: [lastName],
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterWhereClause>
      lastNameNotEqualTo(String lastName) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'lastName',
              lower: [],
              upper: [lastName],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'lastName',
              lower: [lastName],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'lastName',
              lower: [lastName],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'lastName',
              lower: [],
              upper: [lastName],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterWhereClause>
      companyIdEqualTo(String companyId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'companyId',
        value: [companyId],
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterWhereClause>
      companyIdNotEqualTo(String companyId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'companyId',
              lower: [],
              upper: [companyId],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'companyId',
              lower: [companyId],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'companyId',
              lower: [companyId],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'companyId',
              lower: [],
              upper: [companyId],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterWhereClause>
      branchIdEqualTo(String branchId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'branchId',
        value: [branchId],
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterWhereClause>
      branchIdNotEqualTo(String branchId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'branchId',
              lower: [],
              upper: [branchId],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'branchId',
              lower: [branchId],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'branchId',
              lower: [branchId],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'branchId',
              lower: [],
              upper: [branchId],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterWhereClause>
      departmentIdEqualTo(String departmentId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'departmentId',
        value: [departmentId],
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterWhereClause>
      departmentIdNotEqualTo(String departmentId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'departmentId',
              lower: [],
              upper: [departmentId],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'departmentId',
              lower: [departmentId],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'departmentId',
              lower: [departmentId],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'departmentId',
              lower: [],
              upper: [departmentId],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterWhereClause>
      designationIdEqualTo(String designationId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'designationId',
        value: [designationId],
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterWhereClause>
      designationIdNotEqualTo(String designationId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'designationId',
              lower: [],
              upper: [designationId],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'designationId',
              lower: [designationId],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'designationId',
              lower: [designationId],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'designationId',
              lower: [],
              upper: [designationId],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterWhereClause>
      statusEqualTo(String status) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'status',
        value: [status],
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterWhereClause>
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

extension EmployeeCollectionQueryFilter
    on QueryBuilder<EmployeeCollection, EmployeeCollection, QFilterCondition> {
  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      addressLine1IsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'addressLine1',
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      addressLine1IsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'addressLine1',
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      addressLine1EqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'addressLine1',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      addressLine1GreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'addressLine1',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      addressLine1LessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'addressLine1',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      addressLine1Between(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'addressLine1',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      addressLine1StartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'addressLine1',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      addressLine1EndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'addressLine1',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      addressLine1Contains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'addressLine1',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      addressLine1Matches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'addressLine1',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      addressLine1IsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'addressLine1',
        value: '',
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      addressLine1IsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'addressLine1',
        value: '',
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      addressLine2IsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'addressLine2',
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      addressLine2IsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'addressLine2',
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      addressLine2EqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'addressLine2',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      addressLine2GreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'addressLine2',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      addressLine2LessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'addressLine2',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      addressLine2Between(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'addressLine2',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      addressLine2StartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'addressLine2',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      addressLine2EndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'addressLine2',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      addressLine2Contains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'addressLine2',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      addressLine2Matches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'addressLine2',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      addressLine2IsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'addressLine2',
        value: '',
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      addressLine2IsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'addressLine2',
        value: '',
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      aiInsightsJsonIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'aiInsightsJson',
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      aiInsightsJsonIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'aiInsightsJson',
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      aiInsightsJsonEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'aiInsightsJson',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      aiInsightsJsonGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'aiInsightsJson',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      aiInsightsJsonLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'aiInsightsJson',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      aiInsightsJsonBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'aiInsightsJson',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      aiInsightsJsonStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'aiInsightsJson',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      aiInsightsJsonEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'aiInsightsJson',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      aiInsightsJsonContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'aiInsightsJson',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      aiInsightsJsonMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'aiInsightsJson',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      aiInsightsJsonIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'aiInsightsJson',
        value: '',
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      aiInsightsJsonIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'aiInsightsJson',
        value: '',
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      bankAccountIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'bankAccountId',
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      bankAccountIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'bankAccountId',
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      bankAccountIdEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'bankAccountId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      bankAccountIdGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'bankAccountId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      bankAccountIdLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'bankAccountId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      bankAccountIdBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'bankAccountId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      bankAccountIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'bankAccountId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      bankAccountIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'bankAccountId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      bankAccountIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'bankAccountId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      bankAccountIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'bankAccountId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      bankAccountIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'bankAccountId',
        value: '',
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      bankAccountIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'bankAccountId',
        value: '',
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      bloodGroupIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'bloodGroup',
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      bloodGroupIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'bloodGroup',
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      bloodGroupEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'bloodGroup',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      bloodGroupGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'bloodGroup',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      bloodGroupLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'bloodGroup',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      bloodGroupBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'bloodGroup',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      bloodGroupStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'bloodGroup',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      bloodGroupEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'bloodGroup',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      bloodGroupContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'bloodGroup',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      bloodGroupMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'bloodGroup',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      bloodGroupIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'bloodGroup',
        value: '',
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      bloodGroupIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'bloodGroup',
        value: '',
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      branchIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'branchId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      branchIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'branchId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      branchIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'branchId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      branchIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'branchId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      branchIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'branchId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      branchIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'branchId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      branchIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'branchId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      branchIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'branchId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      branchIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'branchId',
        value: '',
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      branchIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'branchId',
        value: '',
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      cityIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'city',
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      cityIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'city',
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      cityEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'city',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      cityGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'city',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      cityLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'city',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      cityBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'city',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      cityStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'city',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      cityEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'city',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      cityContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'city',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      cityMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'city',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      cityIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'city',
        value: '',
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      cityIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'city',
        value: '',
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      companyIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'companyId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      companyIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'companyId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      companyIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'companyId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      companyIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'companyId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      companyIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'companyId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      companyIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'companyId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      companyIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'companyId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      companyIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'companyId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      companyIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'companyId',
        value: '',
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      companyIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'companyId',
        value: '',
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      countryIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'country',
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      countryIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'country',
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      countryEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'country',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      countryGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'country',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      countryLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'country',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      countryBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'country',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      countryStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'country',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      countryEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'country',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      countryContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'country',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      countryMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'country',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      countryIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'country',
        value: '',
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      countryIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'country',
        value: '',
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      createdAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
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

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
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

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
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

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      dateOfBirthIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'dateOfBirth',
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      dateOfBirthIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'dateOfBirth',
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      dateOfBirthEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'dateOfBirth',
        value: value,
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      dateOfBirthGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'dateOfBirth',
        value: value,
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      dateOfBirthLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'dateOfBirth',
        value: value,
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      dateOfBirthBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'dateOfBirth',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      dateOfJoiningEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'dateOfJoining',
        value: value,
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      dateOfJoiningGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'dateOfJoining',
        value: value,
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      dateOfJoiningLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'dateOfJoining',
        value: value,
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      dateOfJoiningBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'dateOfJoining',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      departmentIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'departmentId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      departmentIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'departmentId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      departmentIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'departmentId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      departmentIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'departmentId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      departmentIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'departmentId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      departmentIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'departmentId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      departmentIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'departmentId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      departmentIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'departmentId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      departmentIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'departmentId',
        value: '',
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      departmentIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'departmentId',
        value: '',
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      designationIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'designationId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      designationIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'designationId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      designationIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'designationId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      designationIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'designationId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      designationIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'designationId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      designationIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'designationId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      designationIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'designationId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      designationIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'designationId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      designationIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'designationId',
        value: '',
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      designationIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'designationId',
        value: '',
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      emailEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'email',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      emailGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'email',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      emailLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'email',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      emailBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'email',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      emailStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'email',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      emailEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'email',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      emailContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'email',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      emailMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'email',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      emailIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'email',
        value: '',
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      emailIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'email',
        value: '',
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      emergencyContactNameIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'emergencyContactName',
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      emergencyContactNameIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'emergencyContactName',
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      emergencyContactNameEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'emergencyContactName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      emergencyContactNameGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'emergencyContactName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      emergencyContactNameLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'emergencyContactName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      emergencyContactNameBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'emergencyContactName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      emergencyContactNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'emergencyContactName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      emergencyContactNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'emergencyContactName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      emergencyContactNameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'emergencyContactName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      emergencyContactNameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'emergencyContactName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      emergencyContactNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'emergencyContactName',
        value: '',
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      emergencyContactNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'emergencyContactName',
        value: '',
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      emergencyContactPhoneIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'emergencyContactPhone',
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      emergencyContactPhoneIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'emergencyContactPhone',
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      emergencyContactPhoneEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'emergencyContactPhone',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      emergencyContactPhoneGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'emergencyContactPhone',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      emergencyContactPhoneLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'emergencyContactPhone',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      emergencyContactPhoneBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'emergencyContactPhone',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      emergencyContactPhoneStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'emergencyContactPhone',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      emergencyContactPhoneEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'emergencyContactPhone',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      emergencyContactPhoneContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'emergencyContactPhone',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      emergencyContactPhoneMatches(String pattern,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'emergencyContactPhone',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      emergencyContactPhoneIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'emergencyContactPhone',
        value: '',
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      emergencyContactPhoneIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'emergencyContactPhone',
        value: '',
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      employeeCodeEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'employeeCode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      employeeCodeGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'employeeCode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      employeeCodeLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'employeeCode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      employeeCodeBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'employeeCode',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      employeeCodeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'employeeCode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      employeeCodeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'employeeCode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      employeeCodeContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'employeeCode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      employeeCodeMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'employeeCode',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      employeeCodeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'employeeCode',
        value: '',
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      employeeCodeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'employeeCode',
        value: '',
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      employmentTypeEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'employmentType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      employmentTypeGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'employmentType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      employmentTypeLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'employmentType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      employmentTypeBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'employmentType',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      employmentTypeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'employmentType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      employmentTypeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'employmentType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      employmentTypeContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'employmentType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      employmentTypeMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'employmentType',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      employmentTypeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'employmentType',
        value: '',
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      employmentTypeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'employmentType',
        value: '',
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      firstNameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'firstName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      firstNameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'firstName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      firstNameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'firstName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      firstNameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'firstName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      firstNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'firstName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      firstNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'firstName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      firstNameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'firstName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      firstNameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'firstName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      firstNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'firstName',
        value: '',
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      firstNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'firstName',
        value: '',
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      genderEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'gender',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      genderGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'gender',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      genderLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'gender',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      genderBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'gender',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      genderStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'gender',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      genderEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'gender',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      genderContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'gender',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      genderMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'gender',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      genderIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'gender',
        value: '',
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      genderIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'gender',
        value: '',
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
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

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      idLessThan(
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

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      idBetween(
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

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      isDeletedEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isDeleted',
        value: value,
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      lastNameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lastName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      lastNameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'lastName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      lastNameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'lastName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      lastNameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'lastName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      lastNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'lastName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      lastNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'lastName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      lastNameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'lastName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      lastNameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'lastName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      lastNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lastName',
        value: '',
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      lastNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'lastName',
        value: '',
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      managerIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'managerId',
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      managerIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'managerId',
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      managerIdEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'managerId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      managerIdGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'managerId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      managerIdLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'managerId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      managerIdBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'managerId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      managerIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'managerId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      managerIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'managerId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      managerIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'managerId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      managerIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'managerId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      managerIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'managerId',
        value: '',
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      managerIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'managerId',
        value: '',
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      maritalStatusEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'maritalStatus',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      maritalStatusGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'maritalStatus',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      maritalStatusLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'maritalStatus',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      maritalStatusBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'maritalStatus',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      maritalStatusStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'maritalStatus',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      maritalStatusEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'maritalStatus',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      maritalStatusContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'maritalStatus',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      maritalStatusMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'maritalStatus',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      maritalStatusIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'maritalStatus',
        value: '',
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      maritalStatusIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'maritalStatus',
        value: '',
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
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

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
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

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
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

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
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

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
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

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
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

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      nameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      nameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'name',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      phoneEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'phone',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      phoneGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'phone',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      phoneLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'phone',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      phoneBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'phone',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      phoneStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'phone',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      phoneEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'phone',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      phoneContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'phone',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      phoneMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'phone',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      phoneIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'phone',
        value: '',
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      phoneIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'phone',
        value: '',
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      photoUrlIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'photoUrl',
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      photoUrlIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'photoUrl',
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      photoUrlEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'photoUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      photoUrlGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'photoUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      photoUrlLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'photoUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      photoUrlBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'photoUrl',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      photoUrlStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'photoUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      photoUrlEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'photoUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      photoUrlContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'photoUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      photoUrlMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'photoUrl',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      photoUrlIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'photoUrl',
        value: '',
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      photoUrlIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'photoUrl',
        value: '',
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      salaryStructureIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'salaryStructureId',
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      salaryStructureIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'salaryStructureId',
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      salaryStructureIdEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'salaryStructureId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      salaryStructureIdGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'salaryStructureId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      salaryStructureIdLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'salaryStructureId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      salaryStructureIdBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'salaryStructureId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      salaryStructureIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'salaryStructureId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      salaryStructureIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'salaryStructureId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      salaryStructureIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'salaryStructureId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      salaryStructureIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'salaryStructureId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      salaryStructureIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'salaryStructureId',
        value: '',
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      salaryStructureIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'salaryStructureId',
        value: '',
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      shiftIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'shiftId',
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      shiftIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'shiftId',
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      shiftIdEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'shiftId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      shiftIdGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'shiftId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      shiftIdLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'shiftId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      shiftIdBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'shiftId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      shiftIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'shiftId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      shiftIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'shiftId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      shiftIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'shiftId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      shiftIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'shiftId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      shiftIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'shiftId',
        value: '',
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      shiftIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'shiftId',
        value: '',
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      skillsElementEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'skills',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      skillsElementGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'skills',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      skillsElementLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'skills',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      skillsElementBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'skills',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      skillsElementStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'skills',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      skillsElementEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'skills',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      skillsElementContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'skills',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      skillsElementMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'skills',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      skillsElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'skills',
        value: '',
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      skillsElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'skills',
        value: '',
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      skillsLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'skills',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      skillsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'skills',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      skillsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'skills',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      skillsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'skills',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      skillsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'skills',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      skillsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'skills',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      stateIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'state',
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      stateIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'state',
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      stateEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'state',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      stateGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'state',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      stateLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'state',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      stateBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'state',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      stateStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'state',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      stateEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'state',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      stateContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'state',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      stateMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'state',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      stateIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'state',
        value: '',
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      stateIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'state',
        value: '',
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
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

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
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

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
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

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
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

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
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

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
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

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      statusContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'status',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      statusMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'status',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      statusIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'status',
        value: '',
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      statusIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'status',
        value: '',
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      updatedAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'updatedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      updatedAtGreaterThan(
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

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      updatedAtLessThan(
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

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      updatedAtBetween(
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

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      userIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'userId',
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      userIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'userId',
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      userIdEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'userId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      userIdGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'userId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      userIdLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'userId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      userIdBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'userId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      userIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'userId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      userIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'userId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      userIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'userId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      userIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'userId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      userIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'userId',
        value: '',
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      userIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'userId',
        value: '',
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      uuidEqualTo(
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

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
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

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
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

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      uuidBetween(
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

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
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

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
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

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      uuidContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'uuid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      uuidMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'uuid',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      uuidIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'uuid',
        value: '',
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      uuidIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'uuid',
        value: '',
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      whatsappIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'whatsapp',
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      whatsappIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'whatsapp',
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      whatsappEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'whatsapp',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      whatsappGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'whatsapp',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      whatsappLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'whatsapp',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      whatsappBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'whatsapp',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      whatsappStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'whatsapp',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      whatsappEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'whatsapp',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      whatsappContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'whatsapp',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      whatsappMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'whatsapp',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      whatsappIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'whatsapp',
        value: '',
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      whatsappIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'whatsapp',
        value: '',
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      workLocationIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'workLocation',
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      workLocationIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'workLocation',
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      workLocationEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'workLocation',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      workLocationGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'workLocation',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      workLocationLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'workLocation',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      workLocationBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'workLocation',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      workLocationStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'workLocation',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      workLocationEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'workLocation',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      workLocationContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'workLocation',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      workLocationMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'workLocation',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      workLocationIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'workLocation',
        value: '',
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      workLocationIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'workLocation',
        value: '',
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      zipCodeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'zipCode',
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      zipCodeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'zipCode',
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      zipCodeEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'zipCode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      zipCodeGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'zipCode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      zipCodeLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'zipCode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      zipCodeBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'zipCode',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      zipCodeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'zipCode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      zipCodeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'zipCode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      zipCodeContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'zipCode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      zipCodeMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'zipCode',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      zipCodeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'zipCode',
        value: '',
      ));
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterFilterCondition>
      zipCodeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'zipCode',
        value: '',
      ));
    });
  }
}

extension EmployeeCollectionQueryObject
    on QueryBuilder<EmployeeCollection, EmployeeCollection, QFilterCondition> {}

extension EmployeeCollectionQueryLinks
    on QueryBuilder<EmployeeCollection, EmployeeCollection, QFilterCondition> {}

extension EmployeeCollectionQuerySortBy
    on QueryBuilder<EmployeeCollection, EmployeeCollection, QSortBy> {
  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterSortBy>
      sortByAddressLine1() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'addressLine1', Sort.asc);
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterSortBy>
      sortByAddressLine1Desc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'addressLine1', Sort.desc);
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterSortBy>
      sortByAddressLine2() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'addressLine2', Sort.asc);
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterSortBy>
      sortByAddressLine2Desc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'addressLine2', Sort.desc);
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterSortBy>
      sortByAiInsightsJson() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'aiInsightsJson', Sort.asc);
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterSortBy>
      sortByAiInsightsJsonDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'aiInsightsJson', Sort.desc);
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterSortBy>
      sortByBankAccountId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bankAccountId', Sort.asc);
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterSortBy>
      sortByBankAccountIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bankAccountId', Sort.desc);
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterSortBy>
      sortByBloodGroup() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bloodGroup', Sort.asc);
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterSortBy>
      sortByBloodGroupDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bloodGroup', Sort.desc);
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterSortBy>
      sortByBranchId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'branchId', Sort.asc);
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterSortBy>
      sortByBranchIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'branchId', Sort.desc);
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterSortBy>
      sortByCity() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'city', Sort.asc);
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterSortBy>
      sortByCityDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'city', Sort.desc);
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterSortBy>
      sortByCompanyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'companyId', Sort.asc);
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterSortBy>
      sortByCompanyIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'companyId', Sort.desc);
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterSortBy>
      sortByCountry() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'country', Sort.asc);
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterSortBy>
      sortByCountryDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'country', Sort.desc);
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterSortBy>
      sortByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterSortBy>
      sortByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterSortBy>
      sortByDateOfBirth() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dateOfBirth', Sort.asc);
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterSortBy>
      sortByDateOfBirthDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dateOfBirth', Sort.desc);
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterSortBy>
      sortByDateOfJoining() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dateOfJoining', Sort.asc);
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterSortBy>
      sortByDateOfJoiningDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dateOfJoining', Sort.desc);
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterSortBy>
      sortByDepartmentId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'departmentId', Sort.asc);
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterSortBy>
      sortByDepartmentIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'departmentId', Sort.desc);
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterSortBy>
      sortByDesignationId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'designationId', Sort.asc);
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterSortBy>
      sortByDesignationIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'designationId', Sort.desc);
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterSortBy>
      sortByEmail() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'email', Sort.asc);
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterSortBy>
      sortByEmailDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'email', Sort.desc);
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterSortBy>
      sortByEmergencyContactName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'emergencyContactName', Sort.asc);
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterSortBy>
      sortByEmergencyContactNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'emergencyContactName', Sort.desc);
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterSortBy>
      sortByEmergencyContactPhone() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'emergencyContactPhone', Sort.asc);
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterSortBy>
      sortByEmergencyContactPhoneDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'emergencyContactPhone', Sort.desc);
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterSortBy>
      sortByEmployeeCode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'employeeCode', Sort.asc);
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterSortBy>
      sortByEmployeeCodeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'employeeCode', Sort.desc);
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterSortBy>
      sortByEmploymentType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'employmentType', Sort.asc);
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterSortBy>
      sortByEmploymentTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'employmentType', Sort.desc);
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterSortBy>
      sortByFirstName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'firstName', Sort.asc);
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterSortBy>
      sortByFirstNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'firstName', Sort.desc);
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterSortBy>
      sortByGender() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'gender', Sort.asc);
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterSortBy>
      sortByGenderDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'gender', Sort.desc);
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterSortBy>
      sortByIsDeleted() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isDeleted', Sort.asc);
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterSortBy>
      sortByIsDeletedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isDeleted', Sort.desc);
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterSortBy>
      sortByLastName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastName', Sort.asc);
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterSortBy>
      sortByLastNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastName', Sort.desc);
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterSortBy>
      sortByManagerId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'managerId', Sort.asc);
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterSortBy>
      sortByManagerIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'managerId', Sort.desc);
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterSortBy>
      sortByMaritalStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'maritalStatus', Sort.asc);
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterSortBy>
      sortByMaritalStatusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'maritalStatus', Sort.desc);
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterSortBy>
      sortByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterSortBy>
      sortByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterSortBy>
      sortByPhone() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'phone', Sort.asc);
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterSortBy>
      sortByPhoneDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'phone', Sort.desc);
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterSortBy>
      sortByPhotoUrl() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'photoUrl', Sort.asc);
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterSortBy>
      sortByPhotoUrlDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'photoUrl', Sort.desc);
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterSortBy>
      sortBySalaryStructureId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'salaryStructureId', Sort.asc);
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterSortBy>
      sortBySalaryStructureIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'salaryStructureId', Sort.desc);
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterSortBy>
      sortByShiftId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'shiftId', Sort.asc);
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterSortBy>
      sortByShiftIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'shiftId', Sort.desc);
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterSortBy>
      sortByState() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'state', Sort.asc);
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterSortBy>
      sortByStateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'state', Sort.desc);
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterSortBy>
      sortByStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.asc);
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterSortBy>
      sortByStatusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.desc);
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterSortBy>
      sortByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.asc);
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterSortBy>
      sortByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.desc);
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterSortBy>
      sortByUserId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userId', Sort.asc);
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterSortBy>
      sortByUserIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userId', Sort.desc);
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterSortBy>
      sortByUuid() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uuid', Sort.asc);
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterSortBy>
      sortByUuidDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uuid', Sort.desc);
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterSortBy>
      sortByWhatsapp() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'whatsapp', Sort.asc);
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterSortBy>
      sortByWhatsappDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'whatsapp', Sort.desc);
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterSortBy>
      sortByWorkLocation() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'workLocation', Sort.asc);
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterSortBy>
      sortByWorkLocationDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'workLocation', Sort.desc);
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterSortBy>
      sortByZipCode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'zipCode', Sort.asc);
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterSortBy>
      sortByZipCodeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'zipCode', Sort.desc);
    });
  }
}

extension EmployeeCollectionQuerySortThenBy
    on QueryBuilder<EmployeeCollection, EmployeeCollection, QSortThenBy> {
  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterSortBy>
      thenByAddressLine1() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'addressLine1', Sort.asc);
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterSortBy>
      thenByAddressLine1Desc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'addressLine1', Sort.desc);
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterSortBy>
      thenByAddressLine2() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'addressLine2', Sort.asc);
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterSortBy>
      thenByAddressLine2Desc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'addressLine2', Sort.desc);
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterSortBy>
      thenByAiInsightsJson() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'aiInsightsJson', Sort.asc);
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterSortBy>
      thenByAiInsightsJsonDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'aiInsightsJson', Sort.desc);
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterSortBy>
      thenByBankAccountId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bankAccountId', Sort.asc);
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterSortBy>
      thenByBankAccountIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bankAccountId', Sort.desc);
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterSortBy>
      thenByBloodGroup() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bloodGroup', Sort.asc);
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterSortBy>
      thenByBloodGroupDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bloodGroup', Sort.desc);
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterSortBy>
      thenByBranchId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'branchId', Sort.asc);
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterSortBy>
      thenByBranchIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'branchId', Sort.desc);
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterSortBy>
      thenByCity() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'city', Sort.asc);
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterSortBy>
      thenByCityDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'city', Sort.desc);
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterSortBy>
      thenByCompanyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'companyId', Sort.asc);
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterSortBy>
      thenByCompanyIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'companyId', Sort.desc);
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterSortBy>
      thenByCountry() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'country', Sort.asc);
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterSortBy>
      thenByCountryDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'country', Sort.desc);
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterSortBy>
      thenByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterSortBy>
      thenByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterSortBy>
      thenByDateOfBirth() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dateOfBirth', Sort.asc);
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterSortBy>
      thenByDateOfBirthDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dateOfBirth', Sort.desc);
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterSortBy>
      thenByDateOfJoining() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dateOfJoining', Sort.asc);
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterSortBy>
      thenByDateOfJoiningDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dateOfJoining', Sort.desc);
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterSortBy>
      thenByDepartmentId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'departmentId', Sort.asc);
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterSortBy>
      thenByDepartmentIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'departmentId', Sort.desc);
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterSortBy>
      thenByDesignationId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'designationId', Sort.asc);
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterSortBy>
      thenByDesignationIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'designationId', Sort.desc);
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterSortBy>
      thenByEmail() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'email', Sort.asc);
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterSortBy>
      thenByEmailDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'email', Sort.desc);
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterSortBy>
      thenByEmergencyContactName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'emergencyContactName', Sort.asc);
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterSortBy>
      thenByEmergencyContactNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'emergencyContactName', Sort.desc);
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterSortBy>
      thenByEmergencyContactPhone() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'emergencyContactPhone', Sort.asc);
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterSortBy>
      thenByEmergencyContactPhoneDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'emergencyContactPhone', Sort.desc);
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterSortBy>
      thenByEmployeeCode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'employeeCode', Sort.asc);
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterSortBy>
      thenByEmployeeCodeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'employeeCode', Sort.desc);
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterSortBy>
      thenByEmploymentType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'employmentType', Sort.asc);
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterSortBy>
      thenByEmploymentTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'employmentType', Sort.desc);
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterSortBy>
      thenByFirstName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'firstName', Sort.asc);
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterSortBy>
      thenByFirstNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'firstName', Sort.desc);
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterSortBy>
      thenByGender() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'gender', Sort.asc);
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterSortBy>
      thenByGenderDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'gender', Sort.desc);
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterSortBy>
      thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterSortBy>
      thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterSortBy>
      thenByIsDeleted() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isDeleted', Sort.asc);
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterSortBy>
      thenByIsDeletedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isDeleted', Sort.desc);
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterSortBy>
      thenByLastName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastName', Sort.asc);
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterSortBy>
      thenByLastNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastName', Sort.desc);
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterSortBy>
      thenByManagerId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'managerId', Sort.asc);
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterSortBy>
      thenByManagerIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'managerId', Sort.desc);
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterSortBy>
      thenByMaritalStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'maritalStatus', Sort.asc);
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterSortBy>
      thenByMaritalStatusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'maritalStatus', Sort.desc);
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterSortBy>
      thenByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterSortBy>
      thenByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterSortBy>
      thenByPhone() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'phone', Sort.asc);
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterSortBy>
      thenByPhoneDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'phone', Sort.desc);
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterSortBy>
      thenByPhotoUrl() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'photoUrl', Sort.asc);
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterSortBy>
      thenByPhotoUrlDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'photoUrl', Sort.desc);
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterSortBy>
      thenBySalaryStructureId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'salaryStructureId', Sort.asc);
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterSortBy>
      thenBySalaryStructureIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'salaryStructureId', Sort.desc);
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterSortBy>
      thenByShiftId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'shiftId', Sort.asc);
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterSortBy>
      thenByShiftIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'shiftId', Sort.desc);
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterSortBy>
      thenByState() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'state', Sort.asc);
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterSortBy>
      thenByStateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'state', Sort.desc);
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterSortBy>
      thenByStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.asc);
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterSortBy>
      thenByStatusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.desc);
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterSortBy>
      thenByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.asc);
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterSortBy>
      thenByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.desc);
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterSortBy>
      thenByUserId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userId', Sort.asc);
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterSortBy>
      thenByUserIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userId', Sort.desc);
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterSortBy>
      thenByUuid() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uuid', Sort.asc);
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterSortBy>
      thenByUuidDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uuid', Sort.desc);
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterSortBy>
      thenByWhatsapp() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'whatsapp', Sort.asc);
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterSortBy>
      thenByWhatsappDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'whatsapp', Sort.desc);
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterSortBy>
      thenByWorkLocation() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'workLocation', Sort.asc);
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterSortBy>
      thenByWorkLocationDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'workLocation', Sort.desc);
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterSortBy>
      thenByZipCode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'zipCode', Sort.asc);
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QAfterSortBy>
      thenByZipCodeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'zipCode', Sort.desc);
    });
  }
}

extension EmployeeCollectionQueryWhereDistinct
    on QueryBuilder<EmployeeCollection, EmployeeCollection, QDistinct> {
  QueryBuilder<EmployeeCollection, EmployeeCollection, QDistinct>
      distinctByAddressLine1({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'addressLine1', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QDistinct>
      distinctByAddressLine2({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'addressLine2', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QDistinct>
      distinctByAiInsightsJson({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'aiInsightsJson',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QDistinct>
      distinctByBankAccountId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'bankAccountId',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QDistinct>
      distinctByBloodGroup({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'bloodGroup', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QDistinct>
      distinctByBranchId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'branchId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QDistinct>
      distinctByCity({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'city', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QDistinct>
      distinctByCompanyId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'companyId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QDistinct>
      distinctByCountry({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'country', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QDistinct>
      distinctByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'createdAt');
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QDistinct>
      distinctByDateOfBirth() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'dateOfBirth');
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QDistinct>
      distinctByDateOfJoining() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'dateOfJoining');
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QDistinct>
      distinctByDepartmentId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'departmentId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QDistinct>
      distinctByDesignationId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'designationId',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QDistinct>
      distinctByEmail({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'email', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QDistinct>
      distinctByEmergencyContactName({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'emergencyContactName',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QDistinct>
      distinctByEmergencyContactPhone({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'emergencyContactPhone',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QDistinct>
      distinctByEmployeeCode({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'employeeCode', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QDistinct>
      distinctByEmploymentType({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'employmentType',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QDistinct>
      distinctByFirstName({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'firstName', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QDistinct>
      distinctByGender({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'gender', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QDistinct>
      distinctByIsDeleted() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isDeleted');
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QDistinct>
      distinctByLastName({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'lastName', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QDistinct>
      distinctByManagerId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'managerId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QDistinct>
      distinctByMaritalStatus({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'maritalStatus',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QDistinct>
      distinctByName({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'name', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QDistinct>
      distinctByPhone({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'phone', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QDistinct>
      distinctByPhotoUrl({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'photoUrl', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QDistinct>
      distinctBySalaryStructureId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'salaryStructureId',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QDistinct>
      distinctByShiftId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'shiftId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QDistinct>
      distinctBySkills() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'skills');
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QDistinct>
      distinctByState({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'state', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QDistinct>
      distinctByStatus({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'status', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QDistinct>
      distinctByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'updatedAt');
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QDistinct>
      distinctByUserId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'userId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QDistinct>
      distinctByUuid({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'uuid', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QDistinct>
      distinctByWhatsapp({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'whatsapp', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QDistinct>
      distinctByWorkLocation({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'workLocation', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<EmployeeCollection, EmployeeCollection, QDistinct>
      distinctByZipCode({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'zipCode', caseSensitive: caseSensitive);
    });
  }
}

extension EmployeeCollectionQueryProperty
    on QueryBuilder<EmployeeCollection, EmployeeCollection, QQueryProperty> {
  QueryBuilder<EmployeeCollection, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<EmployeeCollection, String?, QQueryOperations>
      addressLine1Property() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'addressLine1');
    });
  }

  QueryBuilder<EmployeeCollection, String?, QQueryOperations>
      addressLine2Property() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'addressLine2');
    });
  }

  QueryBuilder<EmployeeCollection, String?, QQueryOperations>
      aiInsightsJsonProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'aiInsightsJson');
    });
  }

  QueryBuilder<EmployeeCollection, String?, QQueryOperations>
      bankAccountIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'bankAccountId');
    });
  }

  QueryBuilder<EmployeeCollection, String?, QQueryOperations>
      bloodGroupProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'bloodGroup');
    });
  }

  QueryBuilder<EmployeeCollection, String, QQueryOperations>
      branchIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'branchId');
    });
  }

  QueryBuilder<EmployeeCollection, String?, QQueryOperations> cityProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'city');
    });
  }

  QueryBuilder<EmployeeCollection, String, QQueryOperations>
      companyIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'companyId');
    });
  }

  QueryBuilder<EmployeeCollection, String?, QQueryOperations>
      countryProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'country');
    });
  }

  QueryBuilder<EmployeeCollection, DateTime, QQueryOperations>
      createdAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'createdAt');
    });
  }

  QueryBuilder<EmployeeCollection, DateTime?, QQueryOperations>
      dateOfBirthProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'dateOfBirth');
    });
  }

  QueryBuilder<EmployeeCollection, DateTime, QQueryOperations>
      dateOfJoiningProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'dateOfJoining');
    });
  }

  QueryBuilder<EmployeeCollection, String, QQueryOperations>
      departmentIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'departmentId');
    });
  }

  QueryBuilder<EmployeeCollection, String, QQueryOperations>
      designationIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'designationId');
    });
  }

  QueryBuilder<EmployeeCollection, String, QQueryOperations> emailProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'email');
    });
  }

  QueryBuilder<EmployeeCollection, String?, QQueryOperations>
      emergencyContactNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'emergencyContactName');
    });
  }

  QueryBuilder<EmployeeCollection, String?, QQueryOperations>
      emergencyContactPhoneProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'emergencyContactPhone');
    });
  }

  QueryBuilder<EmployeeCollection, String, QQueryOperations>
      employeeCodeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'employeeCode');
    });
  }

  QueryBuilder<EmployeeCollection, String, QQueryOperations>
      employmentTypeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'employmentType');
    });
  }

  QueryBuilder<EmployeeCollection, String, QQueryOperations>
      firstNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'firstName');
    });
  }

  QueryBuilder<EmployeeCollection, String, QQueryOperations> genderProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'gender');
    });
  }

  QueryBuilder<EmployeeCollection, bool, QQueryOperations> isDeletedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isDeleted');
    });
  }

  QueryBuilder<EmployeeCollection, String, QQueryOperations>
      lastNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'lastName');
    });
  }

  QueryBuilder<EmployeeCollection, String?, QQueryOperations>
      managerIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'managerId');
    });
  }

  QueryBuilder<EmployeeCollection, String, QQueryOperations>
      maritalStatusProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'maritalStatus');
    });
  }

  QueryBuilder<EmployeeCollection, String, QQueryOperations> nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'name');
    });
  }

  QueryBuilder<EmployeeCollection, String, QQueryOperations> phoneProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'phone');
    });
  }

  QueryBuilder<EmployeeCollection, String?, QQueryOperations>
      photoUrlProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'photoUrl');
    });
  }

  QueryBuilder<EmployeeCollection, String?, QQueryOperations>
      salaryStructureIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'salaryStructureId');
    });
  }

  QueryBuilder<EmployeeCollection, String?, QQueryOperations>
      shiftIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'shiftId');
    });
  }

  QueryBuilder<EmployeeCollection, List<String>, QQueryOperations>
      skillsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'skills');
    });
  }

  QueryBuilder<EmployeeCollection, String?, QQueryOperations> stateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'state');
    });
  }

  QueryBuilder<EmployeeCollection, String, QQueryOperations> statusProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'status');
    });
  }

  QueryBuilder<EmployeeCollection, DateTime, QQueryOperations>
      updatedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'updatedAt');
    });
  }

  QueryBuilder<EmployeeCollection, String?, QQueryOperations> userIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'userId');
    });
  }

  QueryBuilder<EmployeeCollection, String, QQueryOperations> uuidProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'uuid');
    });
  }

  QueryBuilder<EmployeeCollection, String?, QQueryOperations>
      whatsappProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'whatsapp');
    });
  }

  QueryBuilder<EmployeeCollection, String?, QQueryOperations>
      workLocationProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'workLocation');
    });
  }

  QueryBuilder<EmployeeCollection, String?, QQueryOperations>
      zipCodeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'zipCode');
    });
  }
}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetAttendanceCollectionCollection on Isar {
  IsarCollection<AttendanceCollection> get attendanceCollections =>
      this.collection();
}

const AttendanceCollectionSchema = CollectionSchema(
  name: r'AttendanceCollection',
  id: (3456058879993 * 1000000 + 160087),
  properties: {
    r'clockIn': PropertySchema(
      id: 0,
      name: r'clockIn',
      type: IsarType.dateTime,
    ),
    r'clockOut': PropertySchema(
      id: 1,
      name: r'clockOut',
      type: IsarType.dateTime,
    ),
    r'employeeId': PropertySchema(
      id: 2,
      name: r'employeeId',
      type: IsarType.string,
    ),
    r'isEarlyDeparture': PropertySchema(
      id: 3,
      name: r'isEarlyDeparture',
      type: IsarType.bool,
    ),
    r'isLate': PropertySchema(
      id: 4,
      name: r'isLate',
      type: IsarType.bool,
    ),
    r'latitude': PropertySchema(
      id: 5,
      name: r'latitude',
      type: IsarType.double,
    ),
    r'longitude': PropertySchema(
      id: 6,
      name: r'longitude',
      type: IsarType.double,
    ),
    r'overtimeHours': PropertySchema(
      id: 7,
      name: r'overtimeHours',
      type: IsarType.double,
    ),
    r'shiftId': PropertySchema(
      id: 8,
      name: r'shiftId',
      type: IsarType.string,
    ),
    r'source': PropertySchema(
      id: 9,
      name: r'source',
      type: IsarType.string,
    )
  },
  estimateSize: _attendanceCollectionEstimateSize,
  serialize: _attendanceCollectionSerialize,
  deserialize: _attendanceCollectionDeserialize,
  deserializeProp: _attendanceCollectionDeserializeProp,
  idName: r'id',
  indexes: {
    r'employeeId': IndexSchema(
      id: (1283453093523 * 1000000 + 34672),
      name: r'employeeId',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'employeeId',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    ),
    r'clockIn': IndexSchema(
      id: (2898206528224 * 1000000 + 234958),
      name: r'clockIn',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'clockIn',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _attendanceCollectionGetId,
  getLinks: _attendanceCollectionGetLinks,
  attach: _attendanceCollectionAttach,
  version: '3.1.0+1',
);

int _attendanceCollectionEstimateSize(
  AttendanceCollection object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.employeeId.length * 3;
  {
    final value = object.shiftId;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.source.length * 3;
  return bytesCount;
}

void _attendanceCollectionSerialize(
  AttendanceCollection object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDateTime(offsets[0], object.clockIn);
  writer.writeDateTime(offsets[1], object.clockOut);
  writer.writeString(offsets[2], object.employeeId);
  writer.writeBool(offsets[3], object.isEarlyDeparture);
  writer.writeBool(offsets[4], object.isLate);
  writer.writeDouble(offsets[5], object.latitude);
  writer.writeDouble(offsets[6], object.longitude);
  writer.writeDouble(offsets[7], object.overtimeHours);
  writer.writeString(offsets[8], object.shiftId);
  writer.writeString(offsets[9], object.source);
}

AttendanceCollection _attendanceCollectionDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = AttendanceCollection();
  object.clockIn = reader.readDateTime(offsets[0]);
  object.clockOut = reader.readDateTimeOrNull(offsets[1]);
  object.employeeId = reader.readString(offsets[2]);
  object.id = id;
  object.isEarlyDeparture = reader.readBool(offsets[3]);
  object.isLate = reader.readBool(offsets[4]);
  object.latitude = reader.readDoubleOrNull(offsets[5]);
  object.longitude = reader.readDoubleOrNull(offsets[6]);
  object.overtimeHours = reader.readDouble(offsets[7]);
  object.shiftId = reader.readStringOrNull(offsets[8]);
  object.source = reader.readString(offsets[9]);
  return object;
}

P _attendanceCollectionDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDateTime(offset)) as P;
    case 1:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 2:
      return (reader.readString(offset)) as P;
    case 3:
      return (reader.readBool(offset)) as P;
    case 4:
      return (reader.readBool(offset)) as P;
    case 5:
      return (reader.readDoubleOrNull(offset)) as P;
    case 6:
      return (reader.readDoubleOrNull(offset)) as P;
    case 7:
      return (reader.readDouble(offset)) as P;
    case 8:
      return (reader.readStringOrNull(offset)) as P;
    case 9:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _attendanceCollectionGetId(AttendanceCollection object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _attendanceCollectionGetLinks(
    AttendanceCollection object) {
  return [];
}

void _attendanceCollectionAttach(
    IsarCollection<dynamic> col, Id id, AttendanceCollection object) {
  object.id = id;
}

extension AttendanceCollectionQueryWhereSort
    on QueryBuilder<AttendanceCollection, AttendanceCollection, QWhere> {
  QueryBuilder<AttendanceCollection, AttendanceCollection, QAfterWhere>
      anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<AttendanceCollection, AttendanceCollection, QAfterWhere>
      anyClockIn() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'clockIn'),
      );
    });
  }
}

extension AttendanceCollectionQueryWhere
    on QueryBuilder<AttendanceCollection, AttendanceCollection, QWhereClause> {
  QueryBuilder<AttendanceCollection, AttendanceCollection, QAfterWhereClause>
      idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<AttendanceCollection, AttendanceCollection, QAfterWhereClause>
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

  QueryBuilder<AttendanceCollection, AttendanceCollection, QAfterWhereClause>
      idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<AttendanceCollection, AttendanceCollection, QAfterWhereClause>
      idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<AttendanceCollection, AttendanceCollection, QAfterWhereClause>
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

  QueryBuilder<AttendanceCollection, AttendanceCollection, QAfterWhereClause>
      employeeIdEqualTo(String employeeId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'employeeId',
        value: [employeeId],
      ));
    });
  }

  QueryBuilder<AttendanceCollection, AttendanceCollection, QAfterWhereClause>
      employeeIdNotEqualTo(String employeeId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'employeeId',
              lower: [],
              upper: [employeeId],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'employeeId',
              lower: [employeeId],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'employeeId',
              lower: [employeeId],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'employeeId',
              lower: [],
              upper: [employeeId],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<AttendanceCollection, AttendanceCollection, QAfterWhereClause>
      clockInEqualTo(DateTime clockIn) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'clockIn',
        value: [clockIn],
      ));
    });
  }

  QueryBuilder<AttendanceCollection, AttendanceCollection, QAfterWhereClause>
      clockInNotEqualTo(DateTime clockIn) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'clockIn',
              lower: [],
              upper: [clockIn],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'clockIn',
              lower: [clockIn],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'clockIn',
              lower: [clockIn],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'clockIn',
              lower: [],
              upper: [clockIn],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<AttendanceCollection, AttendanceCollection, QAfterWhereClause>
      clockInGreaterThan(
    DateTime clockIn, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'clockIn',
        lower: [clockIn],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<AttendanceCollection, AttendanceCollection, QAfterWhereClause>
      clockInLessThan(
    DateTime clockIn, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'clockIn',
        lower: [],
        upper: [clockIn],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<AttendanceCollection, AttendanceCollection, QAfterWhereClause>
      clockInBetween(
    DateTime lowerClockIn,
    DateTime upperClockIn, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'clockIn',
        lower: [lowerClockIn],
        includeLower: includeLower,
        upper: [upperClockIn],
        includeUpper: includeUpper,
      ));
    });
  }
}

extension AttendanceCollectionQueryFilter on QueryBuilder<AttendanceCollection,
    AttendanceCollection, QFilterCondition> {
  QueryBuilder<AttendanceCollection, AttendanceCollection,
      QAfterFilterCondition> clockInEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'clockIn',
        value: value,
      ));
    });
  }

  QueryBuilder<AttendanceCollection, AttendanceCollection,
      QAfterFilterCondition> clockInGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'clockIn',
        value: value,
      ));
    });
  }

  QueryBuilder<AttendanceCollection, AttendanceCollection,
      QAfterFilterCondition> clockInLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'clockIn',
        value: value,
      ));
    });
  }

  QueryBuilder<AttendanceCollection, AttendanceCollection,
      QAfterFilterCondition> clockInBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'clockIn',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<AttendanceCollection, AttendanceCollection,
      QAfterFilterCondition> clockOutIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'clockOut',
      ));
    });
  }

  QueryBuilder<AttendanceCollection, AttendanceCollection,
      QAfterFilterCondition> clockOutIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'clockOut',
      ));
    });
  }

  QueryBuilder<AttendanceCollection, AttendanceCollection,
      QAfterFilterCondition> clockOutEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'clockOut',
        value: value,
      ));
    });
  }

  QueryBuilder<AttendanceCollection, AttendanceCollection,
      QAfterFilterCondition> clockOutGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'clockOut',
        value: value,
      ));
    });
  }

  QueryBuilder<AttendanceCollection, AttendanceCollection,
      QAfterFilterCondition> clockOutLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'clockOut',
        value: value,
      ));
    });
  }

  QueryBuilder<AttendanceCollection, AttendanceCollection,
      QAfterFilterCondition> clockOutBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'clockOut',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<AttendanceCollection, AttendanceCollection,
      QAfterFilterCondition> employeeIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'employeeId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AttendanceCollection, AttendanceCollection,
      QAfterFilterCondition> employeeIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'employeeId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AttendanceCollection, AttendanceCollection,
      QAfterFilterCondition> employeeIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'employeeId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AttendanceCollection, AttendanceCollection,
      QAfterFilterCondition> employeeIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'employeeId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AttendanceCollection, AttendanceCollection,
      QAfterFilterCondition> employeeIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'employeeId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AttendanceCollection, AttendanceCollection,
      QAfterFilterCondition> employeeIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'employeeId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AttendanceCollection, AttendanceCollection,
          QAfterFilterCondition>
      employeeIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'employeeId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AttendanceCollection, AttendanceCollection,
          QAfterFilterCondition>
      employeeIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'employeeId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AttendanceCollection, AttendanceCollection,
      QAfterFilterCondition> employeeIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'employeeId',
        value: '',
      ));
    });
  }

  QueryBuilder<AttendanceCollection, AttendanceCollection,
      QAfterFilterCondition> employeeIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'employeeId',
        value: '',
      ));
    });
  }

  QueryBuilder<AttendanceCollection, AttendanceCollection,
      QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<AttendanceCollection, AttendanceCollection,
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

  QueryBuilder<AttendanceCollection, AttendanceCollection,
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

  QueryBuilder<AttendanceCollection, AttendanceCollection,
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

  QueryBuilder<AttendanceCollection, AttendanceCollection,
      QAfterFilterCondition> isEarlyDepartureEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isEarlyDeparture',
        value: value,
      ));
    });
  }

  QueryBuilder<AttendanceCollection, AttendanceCollection,
      QAfterFilterCondition> isLateEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isLate',
        value: value,
      ));
    });
  }

  QueryBuilder<AttendanceCollection, AttendanceCollection,
      QAfterFilterCondition> latitudeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'latitude',
      ));
    });
  }

  QueryBuilder<AttendanceCollection, AttendanceCollection,
      QAfterFilterCondition> latitudeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'latitude',
      ));
    });
  }

  QueryBuilder<AttendanceCollection, AttendanceCollection,
      QAfterFilterCondition> latitudeEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'latitude',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<AttendanceCollection, AttendanceCollection,
      QAfterFilterCondition> latitudeGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'latitude',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<AttendanceCollection, AttendanceCollection,
      QAfterFilterCondition> latitudeLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'latitude',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<AttendanceCollection, AttendanceCollection,
      QAfterFilterCondition> latitudeBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'latitude',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<AttendanceCollection, AttendanceCollection,
      QAfterFilterCondition> longitudeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'longitude',
      ));
    });
  }

  QueryBuilder<AttendanceCollection, AttendanceCollection,
      QAfterFilterCondition> longitudeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'longitude',
      ));
    });
  }

  QueryBuilder<AttendanceCollection, AttendanceCollection,
      QAfterFilterCondition> longitudeEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'longitude',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<AttendanceCollection, AttendanceCollection,
      QAfterFilterCondition> longitudeGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'longitude',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<AttendanceCollection, AttendanceCollection,
      QAfterFilterCondition> longitudeLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'longitude',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<AttendanceCollection, AttendanceCollection,
      QAfterFilterCondition> longitudeBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'longitude',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<AttendanceCollection, AttendanceCollection,
      QAfterFilterCondition> overtimeHoursEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'overtimeHours',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<AttendanceCollection, AttendanceCollection,
      QAfterFilterCondition> overtimeHoursGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'overtimeHours',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<AttendanceCollection, AttendanceCollection,
      QAfterFilterCondition> overtimeHoursLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'overtimeHours',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<AttendanceCollection, AttendanceCollection,
      QAfterFilterCondition> overtimeHoursBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'overtimeHours',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<AttendanceCollection, AttendanceCollection,
      QAfterFilterCondition> shiftIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'shiftId',
      ));
    });
  }

  QueryBuilder<AttendanceCollection, AttendanceCollection,
      QAfterFilterCondition> shiftIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'shiftId',
      ));
    });
  }

  QueryBuilder<AttendanceCollection, AttendanceCollection,
      QAfterFilterCondition> shiftIdEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'shiftId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AttendanceCollection, AttendanceCollection,
      QAfterFilterCondition> shiftIdGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'shiftId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AttendanceCollection, AttendanceCollection,
      QAfterFilterCondition> shiftIdLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'shiftId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AttendanceCollection, AttendanceCollection,
      QAfterFilterCondition> shiftIdBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'shiftId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AttendanceCollection, AttendanceCollection,
      QAfterFilterCondition> shiftIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'shiftId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AttendanceCollection, AttendanceCollection,
      QAfterFilterCondition> shiftIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'shiftId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AttendanceCollection, AttendanceCollection,
          QAfterFilterCondition>
      shiftIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'shiftId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AttendanceCollection, AttendanceCollection,
          QAfterFilterCondition>
      shiftIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'shiftId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AttendanceCollection, AttendanceCollection,
      QAfterFilterCondition> shiftIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'shiftId',
        value: '',
      ));
    });
  }

  QueryBuilder<AttendanceCollection, AttendanceCollection,
      QAfterFilterCondition> shiftIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'shiftId',
        value: '',
      ));
    });
  }

  QueryBuilder<AttendanceCollection, AttendanceCollection,
      QAfterFilterCondition> sourceEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'source',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AttendanceCollection, AttendanceCollection,
      QAfterFilterCondition> sourceGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'source',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AttendanceCollection, AttendanceCollection,
      QAfterFilterCondition> sourceLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'source',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AttendanceCollection, AttendanceCollection,
      QAfterFilterCondition> sourceBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'source',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AttendanceCollection, AttendanceCollection,
      QAfterFilterCondition> sourceStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'source',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AttendanceCollection, AttendanceCollection,
      QAfterFilterCondition> sourceEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'source',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AttendanceCollection, AttendanceCollection,
          QAfterFilterCondition>
      sourceContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'source',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AttendanceCollection, AttendanceCollection,
          QAfterFilterCondition>
      sourceMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'source',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AttendanceCollection, AttendanceCollection,
      QAfterFilterCondition> sourceIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'source',
        value: '',
      ));
    });
  }

  QueryBuilder<AttendanceCollection, AttendanceCollection,
      QAfterFilterCondition> sourceIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'source',
        value: '',
      ));
    });
  }
}

extension AttendanceCollectionQueryObject on QueryBuilder<AttendanceCollection,
    AttendanceCollection, QFilterCondition> {}

extension AttendanceCollectionQueryLinks on QueryBuilder<AttendanceCollection,
    AttendanceCollection, QFilterCondition> {}

extension AttendanceCollectionQuerySortBy
    on QueryBuilder<AttendanceCollection, AttendanceCollection, QSortBy> {
  QueryBuilder<AttendanceCollection, AttendanceCollection, QAfterSortBy>
      sortByClockIn() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'clockIn', Sort.asc);
    });
  }

  QueryBuilder<AttendanceCollection, AttendanceCollection, QAfterSortBy>
      sortByClockInDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'clockIn', Sort.desc);
    });
  }

  QueryBuilder<AttendanceCollection, AttendanceCollection, QAfterSortBy>
      sortByClockOut() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'clockOut', Sort.asc);
    });
  }

  QueryBuilder<AttendanceCollection, AttendanceCollection, QAfterSortBy>
      sortByClockOutDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'clockOut', Sort.desc);
    });
  }

  QueryBuilder<AttendanceCollection, AttendanceCollection, QAfterSortBy>
      sortByEmployeeId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'employeeId', Sort.asc);
    });
  }

  QueryBuilder<AttendanceCollection, AttendanceCollection, QAfterSortBy>
      sortByEmployeeIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'employeeId', Sort.desc);
    });
  }

  QueryBuilder<AttendanceCollection, AttendanceCollection, QAfterSortBy>
      sortByIsEarlyDeparture() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isEarlyDeparture', Sort.asc);
    });
  }

  QueryBuilder<AttendanceCollection, AttendanceCollection, QAfterSortBy>
      sortByIsEarlyDepartureDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isEarlyDeparture', Sort.desc);
    });
  }

  QueryBuilder<AttendanceCollection, AttendanceCollection, QAfterSortBy>
      sortByIsLate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isLate', Sort.asc);
    });
  }

  QueryBuilder<AttendanceCollection, AttendanceCollection, QAfterSortBy>
      sortByIsLateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isLate', Sort.desc);
    });
  }

  QueryBuilder<AttendanceCollection, AttendanceCollection, QAfterSortBy>
      sortByLatitude() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'latitude', Sort.asc);
    });
  }

  QueryBuilder<AttendanceCollection, AttendanceCollection, QAfterSortBy>
      sortByLatitudeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'latitude', Sort.desc);
    });
  }

  QueryBuilder<AttendanceCollection, AttendanceCollection, QAfterSortBy>
      sortByLongitude() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'longitude', Sort.asc);
    });
  }

  QueryBuilder<AttendanceCollection, AttendanceCollection, QAfterSortBy>
      sortByLongitudeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'longitude', Sort.desc);
    });
  }

  QueryBuilder<AttendanceCollection, AttendanceCollection, QAfterSortBy>
      sortByOvertimeHours() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'overtimeHours', Sort.asc);
    });
  }

  QueryBuilder<AttendanceCollection, AttendanceCollection, QAfterSortBy>
      sortByOvertimeHoursDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'overtimeHours', Sort.desc);
    });
  }

  QueryBuilder<AttendanceCollection, AttendanceCollection, QAfterSortBy>
      sortByShiftId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'shiftId', Sort.asc);
    });
  }

  QueryBuilder<AttendanceCollection, AttendanceCollection, QAfterSortBy>
      sortByShiftIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'shiftId', Sort.desc);
    });
  }

  QueryBuilder<AttendanceCollection, AttendanceCollection, QAfterSortBy>
      sortBySource() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'source', Sort.asc);
    });
  }

  QueryBuilder<AttendanceCollection, AttendanceCollection, QAfterSortBy>
      sortBySourceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'source', Sort.desc);
    });
  }
}

extension AttendanceCollectionQuerySortThenBy
    on QueryBuilder<AttendanceCollection, AttendanceCollection, QSortThenBy> {
  QueryBuilder<AttendanceCollection, AttendanceCollection, QAfterSortBy>
      thenByClockIn() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'clockIn', Sort.asc);
    });
  }

  QueryBuilder<AttendanceCollection, AttendanceCollection, QAfterSortBy>
      thenByClockInDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'clockIn', Sort.desc);
    });
  }

  QueryBuilder<AttendanceCollection, AttendanceCollection, QAfterSortBy>
      thenByClockOut() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'clockOut', Sort.asc);
    });
  }

  QueryBuilder<AttendanceCollection, AttendanceCollection, QAfterSortBy>
      thenByClockOutDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'clockOut', Sort.desc);
    });
  }

  QueryBuilder<AttendanceCollection, AttendanceCollection, QAfterSortBy>
      thenByEmployeeId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'employeeId', Sort.asc);
    });
  }

  QueryBuilder<AttendanceCollection, AttendanceCollection, QAfterSortBy>
      thenByEmployeeIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'employeeId', Sort.desc);
    });
  }

  QueryBuilder<AttendanceCollection, AttendanceCollection, QAfterSortBy>
      thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<AttendanceCollection, AttendanceCollection, QAfterSortBy>
      thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<AttendanceCollection, AttendanceCollection, QAfterSortBy>
      thenByIsEarlyDeparture() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isEarlyDeparture', Sort.asc);
    });
  }

  QueryBuilder<AttendanceCollection, AttendanceCollection, QAfterSortBy>
      thenByIsEarlyDepartureDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isEarlyDeparture', Sort.desc);
    });
  }

  QueryBuilder<AttendanceCollection, AttendanceCollection, QAfterSortBy>
      thenByIsLate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isLate', Sort.asc);
    });
  }

  QueryBuilder<AttendanceCollection, AttendanceCollection, QAfterSortBy>
      thenByIsLateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isLate', Sort.desc);
    });
  }

  QueryBuilder<AttendanceCollection, AttendanceCollection, QAfterSortBy>
      thenByLatitude() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'latitude', Sort.asc);
    });
  }

  QueryBuilder<AttendanceCollection, AttendanceCollection, QAfterSortBy>
      thenByLatitudeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'latitude', Sort.desc);
    });
  }

  QueryBuilder<AttendanceCollection, AttendanceCollection, QAfterSortBy>
      thenByLongitude() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'longitude', Sort.asc);
    });
  }

  QueryBuilder<AttendanceCollection, AttendanceCollection, QAfterSortBy>
      thenByLongitudeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'longitude', Sort.desc);
    });
  }

  QueryBuilder<AttendanceCollection, AttendanceCollection, QAfterSortBy>
      thenByOvertimeHours() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'overtimeHours', Sort.asc);
    });
  }

  QueryBuilder<AttendanceCollection, AttendanceCollection, QAfterSortBy>
      thenByOvertimeHoursDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'overtimeHours', Sort.desc);
    });
  }

  QueryBuilder<AttendanceCollection, AttendanceCollection, QAfterSortBy>
      thenByShiftId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'shiftId', Sort.asc);
    });
  }

  QueryBuilder<AttendanceCollection, AttendanceCollection, QAfterSortBy>
      thenByShiftIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'shiftId', Sort.desc);
    });
  }

  QueryBuilder<AttendanceCollection, AttendanceCollection, QAfterSortBy>
      thenBySource() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'source', Sort.asc);
    });
  }

  QueryBuilder<AttendanceCollection, AttendanceCollection, QAfterSortBy>
      thenBySourceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'source', Sort.desc);
    });
  }
}

extension AttendanceCollectionQueryWhereDistinct
    on QueryBuilder<AttendanceCollection, AttendanceCollection, QDistinct> {
  QueryBuilder<AttendanceCollection, AttendanceCollection, QDistinct>
      distinctByClockIn() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'clockIn');
    });
  }

  QueryBuilder<AttendanceCollection, AttendanceCollection, QDistinct>
      distinctByClockOut() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'clockOut');
    });
  }

  QueryBuilder<AttendanceCollection, AttendanceCollection, QDistinct>
      distinctByEmployeeId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'employeeId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<AttendanceCollection, AttendanceCollection, QDistinct>
      distinctByIsEarlyDeparture() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isEarlyDeparture');
    });
  }

  QueryBuilder<AttendanceCollection, AttendanceCollection, QDistinct>
      distinctByIsLate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isLate');
    });
  }

  QueryBuilder<AttendanceCollection, AttendanceCollection, QDistinct>
      distinctByLatitude() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'latitude');
    });
  }

  QueryBuilder<AttendanceCollection, AttendanceCollection, QDistinct>
      distinctByLongitude() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'longitude');
    });
  }

  QueryBuilder<AttendanceCollection, AttendanceCollection, QDistinct>
      distinctByOvertimeHours() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'overtimeHours');
    });
  }

  QueryBuilder<AttendanceCollection, AttendanceCollection, QDistinct>
      distinctByShiftId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'shiftId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<AttendanceCollection, AttendanceCollection, QDistinct>
      distinctBySource({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'source', caseSensitive: caseSensitive);
    });
  }
}

extension AttendanceCollectionQueryProperty on QueryBuilder<
    AttendanceCollection, AttendanceCollection, QQueryProperty> {
  QueryBuilder<AttendanceCollection, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<AttendanceCollection, DateTime, QQueryOperations>
      clockInProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'clockIn');
    });
  }

  QueryBuilder<AttendanceCollection, DateTime?, QQueryOperations>
      clockOutProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'clockOut');
    });
  }

  QueryBuilder<AttendanceCollection, String, QQueryOperations>
      employeeIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'employeeId');
    });
  }

  QueryBuilder<AttendanceCollection, bool, QQueryOperations>
      isEarlyDepartureProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isEarlyDeparture');
    });
  }

  QueryBuilder<AttendanceCollection, bool, QQueryOperations> isLateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isLate');
    });
  }

  QueryBuilder<AttendanceCollection, double?, QQueryOperations>
      latitudeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'latitude');
    });
  }

  QueryBuilder<AttendanceCollection, double?, QQueryOperations>
      longitudeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'longitude');
    });
  }

  QueryBuilder<AttendanceCollection, double, QQueryOperations>
      overtimeHoursProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'overtimeHours');
    });
  }

  QueryBuilder<AttendanceCollection, String?, QQueryOperations>
      shiftIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'shiftId');
    });
  }

  QueryBuilder<AttendanceCollection, String, QQueryOperations>
      sourceProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'source');
    });
  }
}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetPayrollCollectionCollection on Isar {
  IsarCollection<PayrollCollection> get payrollCollections => this.collection();
}

const PayrollCollectionSchema = CollectionSchema(
  name: r'PayrollCollection',
  id: (1780511031968 * 1000000 + 285574),
  properties: {
    r'allowances': PropertySchema(
      id: 0,
      name: r'allowances',
      type: IsarType.double,
    ),
    r'bankReference': PropertySchema(
      id: 1,
      name: r'bankReference',
      type: IsarType.string,
    ),
    r'basicSalary': PropertySchema(
      id: 2,
      name: r'basicSalary',
      type: IsarType.double,
    ),
    r'bonuses': PropertySchema(
      id: 3,
      name: r'bonuses',
      type: IsarType.double,
    ),
    r'deductions': PropertySchema(
      id: 4,
      name: r'deductions',
      type: IsarType.double,
    ),
    r'employeeId': PropertySchema(
      id: 5,
      name: r'employeeId',
      type: IsarType.string,
    ),
    r'glTransactionId': PropertySchema(
      id: 6,
      name: r'glTransactionId',
      type: IsarType.string,
    ),
    r'hra': PropertySchema(
      id: 7,
      name: r'hra',
      type: IsarType.double,
    ),
    r'isPaid': PropertySchema(
      id: 8,
      name: r'isPaid',
      type: IsarType.bool,
    ),
    r'month': PropertySchema(
      id: 9,
      name: r'month',
      type: IsarType.string,
    ),
    r'netAmount': PropertySchema(
      id: 10,
      name: r'netAmount',
      type: IsarType.double,
    ),
    r'overtimePay': PropertySchema(
      id: 11,
      name: r'overtimePay',
      type: IsarType.double,
    ),
    r'paymentDate': PropertySchema(
      id: 12,
      name: r'paymentDate',
      type: IsarType.dateTime,
    ),
    r'statutoryTaxes': PropertySchema(
      id: 13,
      name: r'statutoryTaxes',
      type: IsarType.double,
    ),
    r'uuid': PropertySchema(
      id: 14,
      name: r'uuid',
      type: IsarType.string,
    )
  },
  estimateSize: _payrollCollectionEstimateSize,
  serialize: _payrollCollectionSerialize,
  deserialize: _payrollCollectionDeserialize,
  deserializeProp: _payrollCollectionDeserializeProp,
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
    r'employeeId': IndexSchema(
      id: (1283453093523 * 1000000 + 34672),
      name: r'employeeId',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'employeeId',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    ),
    r'month': IndexSchema(
      id: -(3594385961712 * 1000000 + 742690),
      name: r'month',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'month',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    ),
    r'isPaid': IndexSchema(
      id: -(8955270508682 * 1000000 + 588844),
      name: r'isPaid',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'isPaid',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _payrollCollectionGetId,
  getLinks: _payrollCollectionGetLinks,
  attach: _payrollCollectionAttach,
  version: '3.1.0+1',
);

int _payrollCollectionEstimateSize(
  PayrollCollection object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.bankReference;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.employeeId.length * 3;
  {
    final value = object.glTransactionId;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.month.length * 3;
  bytesCount += 3 + object.uuid.length * 3;
  return bytesCount;
}

void _payrollCollectionSerialize(
  PayrollCollection object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDouble(offsets[0], object.allowances);
  writer.writeString(offsets[1], object.bankReference);
  writer.writeDouble(offsets[2], object.basicSalary);
  writer.writeDouble(offsets[3], object.bonuses);
  writer.writeDouble(offsets[4], object.deductions);
  writer.writeString(offsets[5], object.employeeId);
  writer.writeString(offsets[6], object.glTransactionId);
  writer.writeDouble(offsets[7], object.hra);
  writer.writeBool(offsets[8], object.isPaid);
  writer.writeString(offsets[9], object.month);
  writer.writeDouble(offsets[10], object.netAmount);
  writer.writeDouble(offsets[11], object.overtimePay);
  writer.writeDateTime(offsets[12], object.paymentDate);
  writer.writeDouble(offsets[13], object.statutoryTaxes);
  writer.writeString(offsets[14], object.uuid);
}

PayrollCollection _payrollCollectionDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = PayrollCollection();
  object.allowances = reader.readDouble(offsets[0]);
  object.bankReference = reader.readStringOrNull(offsets[1]);
  object.basicSalary = reader.readDouble(offsets[2]);
  object.bonuses = reader.readDouble(offsets[3]);
  object.deductions = reader.readDouble(offsets[4]);
  object.employeeId = reader.readString(offsets[5]);
  object.glTransactionId = reader.readStringOrNull(offsets[6]);
  object.hra = reader.readDouble(offsets[7]);
  object.id = id;
  object.isPaid = reader.readBool(offsets[8]);
  object.month = reader.readString(offsets[9]);
  object.netAmount = reader.readDouble(offsets[10]);
  object.overtimePay = reader.readDouble(offsets[11]);
  object.paymentDate = reader.readDateTimeOrNull(offsets[12]);
  object.statutoryTaxes = reader.readDouble(offsets[13]);
  object.uuid = reader.readString(offsets[14]);
  return object;
}

P _payrollCollectionDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDouble(offset)) as P;
    case 1:
      return (reader.readStringOrNull(offset)) as P;
    case 2:
      return (reader.readDouble(offset)) as P;
    case 3:
      return (reader.readDouble(offset)) as P;
    case 4:
      return (reader.readDouble(offset)) as P;
    case 5:
      return (reader.readString(offset)) as P;
    case 6:
      return (reader.readStringOrNull(offset)) as P;
    case 7:
      return (reader.readDouble(offset)) as P;
    case 8:
      return (reader.readBool(offset)) as P;
    case 9:
      return (reader.readString(offset)) as P;
    case 10:
      return (reader.readDouble(offset)) as P;
    case 11:
      return (reader.readDouble(offset)) as P;
    case 12:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 13:
      return (reader.readDouble(offset)) as P;
    case 14:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _payrollCollectionGetId(PayrollCollection object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _payrollCollectionGetLinks(
    PayrollCollection object) {
  return [];
}

void _payrollCollectionAttach(
    IsarCollection<dynamic> col, Id id, PayrollCollection object) {
  object.id = id;
}

extension PayrollCollectionByIndex on IsarCollection<PayrollCollection> {
  Future<PayrollCollection?> getByUuid(String uuid) {
    return getByIndex(r'uuid', [uuid]);
  }

  PayrollCollection? getByUuidSync(String uuid) {
    return getByIndexSync(r'uuid', [uuid]);
  }

  Future<bool> deleteByUuid(String uuid) {
    return deleteByIndex(r'uuid', [uuid]);
  }

  bool deleteByUuidSync(String uuid) {
    return deleteByIndexSync(r'uuid', [uuid]);
  }

  Future<List<PayrollCollection?>> getAllByUuid(List<String> uuidValues) {
    final values = uuidValues.map((e) => [e]).toList();
    return getAllByIndex(r'uuid', values);
  }

  List<PayrollCollection?> getAllByUuidSync(List<String> uuidValues) {
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

  Future<Id> putByUuid(PayrollCollection object) {
    return putByIndex(r'uuid', object);
  }

  Id putByUuidSync(PayrollCollection object, {bool saveLinks = true}) {
    return putByIndexSync(r'uuid', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByUuid(List<PayrollCollection> objects) {
    return putAllByIndex(r'uuid', objects);
  }

  List<Id> putAllByUuidSync(List<PayrollCollection> objects,
      {bool saveLinks = true}) {
    return putAllByIndexSync(r'uuid', objects, saveLinks: saveLinks);
  }
}

extension PayrollCollectionQueryWhereSort
    on QueryBuilder<PayrollCollection, PayrollCollection, QWhere> {
  QueryBuilder<PayrollCollection, PayrollCollection, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<PayrollCollection, PayrollCollection, QAfterWhere> anyIsPaid() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'isPaid'),
      );
    });
  }
}

extension PayrollCollectionQueryWhere
    on QueryBuilder<PayrollCollection, PayrollCollection, QWhereClause> {
  QueryBuilder<PayrollCollection, PayrollCollection, QAfterWhereClause>
      idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<PayrollCollection, PayrollCollection, QAfterWhereClause>
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

  QueryBuilder<PayrollCollection, PayrollCollection, QAfterWhereClause>
      idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<PayrollCollection, PayrollCollection, QAfterWhereClause>
      idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<PayrollCollection, PayrollCollection, QAfterWhereClause>
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

  QueryBuilder<PayrollCollection, PayrollCollection, QAfterWhereClause>
      uuidEqualTo(String uuid) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'uuid',
        value: [uuid],
      ));
    });
  }

  QueryBuilder<PayrollCollection, PayrollCollection, QAfterWhereClause>
      uuidNotEqualTo(String uuid) {
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

  QueryBuilder<PayrollCollection, PayrollCollection, QAfterWhereClause>
      employeeIdEqualTo(String employeeId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'employeeId',
        value: [employeeId],
      ));
    });
  }

  QueryBuilder<PayrollCollection, PayrollCollection, QAfterWhereClause>
      employeeIdNotEqualTo(String employeeId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'employeeId',
              lower: [],
              upper: [employeeId],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'employeeId',
              lower: [employeeId],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'employeeId',
              lower: [employeeId],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'employeeId',
              lower: [],
              upper: [employeeId],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<PayrollCollection, PayrollCollection, QAfterWhereClause>
      monthEqualTo(String month) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'month',
        value: [month],
      ));
    });
  }

  QueryBuilder<PayrollCollection, PayrollCollection, QAfterWhereClause>
      monthNotEqualTo(String month) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'month',
              lower: [],
              upper: [month],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'month',
              lower: [month],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'month',
              lower: [month],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'month',
              lower: [],
              upper: [month],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<PayrollCollection, PayrollCollection, QAfterWhereClause>
      isPaidEqualTo(bool isPaid) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'isPaid',
        value: [isPaid],
      ));
    });
  }

  QueryBuilder<PayrollCollection, PayrollCollection, QAfterWhereClause>
      isPaidNotEqualTo(bool isPaid) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'isPaid',
              lower: [],
              upper: [isPaid],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'isPaid',
              lower: [isPaid],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'isPaid',
              lower: [isPaid],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'isPaid',
              lower: [],
              upper: [isPaid],
              includeUpper: false,
            ));
      }
    });
  }
}

extension PayrollCollectionQueryFilter
    on QueryBuilder<PayrollCollection, PayrollCollection, QFilterCondition> {
  QueryBuilder<PayrollCollection, PayrollCollection, QAfterFilterCondition>
      allowancesEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'allowances',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<PayrollCollection, PayrollCollection, QAfterFilterCondition>
      allowancesGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'allowances',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<PayrollCollection, PayrollCollection, QAfterFilterCondition>
      allowancesLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'allowances',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<PayrollCollection, PayrollCollection, QAfterFilterCondition>
      allowancesBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'allowances',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<PayrollCollection, PayrollCollection, QAfterFilterCondition>
      bankReferenceIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'bankReference',
      ));
    });
  }

  QueryBuilder<PayrollCollection, PayrollCollection, QAfterFilterCondition>
      bankReferenceIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'bankReference',
      ));
    });
  }

  QueryBuilder<PayrollCollection, PayrollCollection, QAfterFilterCondition>
      bankReferenceEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'bankReference',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PayrollCollection, PayrollCollection, QAfterFilterCondition>
      bankReferenceGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'bankReference',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PayrollCollection, PayrollCollection, QAfterFilterCondition>
      bankReferenceLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'bankReference',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PayrollCollection, PayrollCollection, QAfterFilterCondition>
      bankReferenceBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'bankReference',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PayrollCollection, PayrollCollection, QAfterFilterCondition>
      bankReferenceStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'bankReference',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PayrollCollection, PayrollCollection, QAfterFilterCondition>
      bankReferenceEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'bankReference',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PayrollCollection, PayrollCollection, QAfterFilterCondition>
      bankReferenceContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'bankReference',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PayrollCollection, PayrollCollection, QAfterFilterCondition>
      bankReferenceMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'bankReference',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PayrollCollection, PayrollCollection, QAfterFilterCondition>
      bankReferenceIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'bankReference',
        value: '',
      ));
    });
  }

  QueryBuilder<PayrollCollection, PayrollCollection, QAfterFilterCondition>
      bankReferenceIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'bankReference',
        value: '',
      ));
    });
  }

  QueryBuilder<PayrollCollection, PayrollCollection, QAfterFilterCondition>
      basicSalaryEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'basicSalary',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<PayrollCollection, PayrollCollection, QAfterFilterCondition>
      basicSalaryGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'basicSalary',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<PayrollCollection, PayrollCollection, QAfterFilterCondition>
      basicSalaryLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'basicSalary',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<PayrollCollection, PayrollCollection, QAfterFilterCondition>
      basicSalaryBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'basicSalary',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<PayrollCollection, PayrollCollection, QAfterFilterCondition>
      bonusesEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'bonuses',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<PayrollCollection, PayrollCollection, QAfterFilterCondition>
      bonusesGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'bonuses',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<PayrollCollection, PayrollCollection, QAfterFilterCondition>
      bonusesLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'bonuses',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<PayrollCollection, PayrollCollection, QAfterFilterCondition>
      bonusesBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'bonuses',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<PayrollCollection, PayrollCollection, QAfterFilterCondition>
      deductionsEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'deductions',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<PayrollCollection, PayrollCollection, QAfterFilterCondition>
      deductionsGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'deductions',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<PayrollCollection, PayrollCollection, QAfterFilterCondition>
      deductionsLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'deductions',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<PayrollCollection, PayrollCollection, QAfterFilterCondition>
      deductionsBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'deductions',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<PayrollCollection, PayrollCollection, QAfterFilterCondition>
      employeeIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'employeeId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PayrollCollection, PayrollCollection, QAfterFilterCondition>
      employeeIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'employeeId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PayrollCollection, PayrollCollection, QAfterFilterCondition>
      employeeIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'employeeId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PayrollCollection, PayrollCollection, QAfterFilterCondition>
      employeeIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'employeeId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PayrollCollection, PayrollCollection, QAfterFilterCondition>
      employeeIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'employeeId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PayrollCollection, PayrollCollection, QAfterFilterCondition>
      employeeIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'employeeId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PayrollCollection, PayrollCollection, QAfterFilterCondition>
      employeeIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'employeeId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PayrollCollection, PayrollCollection, QAfterFilterCondition>
      employeeIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'employeeId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PayrollCollection, PayrollCollection, QAfterFilterCondition>
      employeeIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'employeeId',
        value: '',
      ));
    });
  }

  QueryBuilder<PayrollCollection, PayrollCollection, QAfterFilterCondition>
      employeeIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'employeeId',
        value: '',
      ));
    });
  }

  QueryBuilder<PayrollCollection, PayrollCollection, QAfterFilterCondition>
      glTransactionIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'glTransactionId',
      ));
    });
  }

  QueryBuilder<PayrollCollection, PayrollCollection, QAfterFilterCondition>
      glTransactionIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'glTransactionId',
      ));
    });
  }

  QueryBuilder<PayrollCollection, PayrollCollection, QAfterFilterCondition>
      glTransactionIdEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'glTransactionId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PayrollCollection, PayrollCollection, QAfterFilterCondition>
      glTransactionIdGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'glTransactionId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PayrollCollection, PayrollCollection, QAfterFilterCondition>
      glTransactionIdLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'glTransactionId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PayrollCollection, PayrollCollection, QAfterFilterCondition>
      glTransactionIdBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'glTransactionId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PayrollCollection, PayrollCollection, QAfterFilterCondition>
      glTransactionIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'glTransactionId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PayrollCollection, PayrollCollection, QAfterFilterCondition>
      glTransactionIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'glTransactionId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PayrollCollection, PayrollCollection, QAfterFilterCondition>
      glTransactionIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'glTransactionId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PayrollCollection, PayrollCollection, QAfterFilterCondition>
      glTransactionIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'glTransactionId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PayrollCollection, PayrollCollection, QAfterFilterCondition>
      glTransactionIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'glTransactionId',
        value: '',
      ));
    });
  }

  QueryBuilder<PayrollCollection, PayrollCollection, QAfterFilterCondition>
      glTransactionIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'glTransactionId',
        value: '',
      ));
    });
  }

  QueryBuilder<PayrollCollection, PayrollCollection, QAfterFilterCondition>
      hraEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'hra',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<PayrollCollection, PayrollCollection, QAfterFilterCondition>
      hraGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'hra',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<PayrollCollection, PayrollCollection, QAfterFilterCondition>
      hraLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'hra',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<PayrollCollection, PayrollCollection, QAfterFilterCondition>
      hraBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'hra',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<PayrollCollection, PayrollCollection, QAfterFilterCondition>
      idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<PayrollCollection, PayrollCollection, QAfterFilterCondition>
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

  QueryBuilder<PayrollCollection, PayrollCollection, QAfterFilterCondition>
      idLessThan(
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

  QueryBuilder<PayrollCollection, PayrollCollection, QAfterFilterCondition>
      idBetween(
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

  QueryBuilder<PayrollCollection, PayrollCollection, QAfterFilterCondition>
      isPaidEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isPaid',
        value: value,
      ));
    });
  }

  QueryBuilder<PayrollCollection, PayrollCollection, QAfterFilterCondition>
      monthEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'month',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PayrollCollection, PayrollCollection, QAfterFilterCondition>
      monthGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'month',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PayrollCollection, PayrollCollection, QAfterFilterCondition>
      monthLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'month',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PayrollCollection, PayrollCollection, QAfterFilterCondition>
      monthBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'month',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PayrollCollection, PayrollCollection, QAfterFilterCondition>
      monthStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'month',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PayrollCollection, PayrollCollection, QAfterFilterCondition>
      monthEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'month',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PayrollCollection, PayrollCollection, QAfterFilterCondition>
      monthContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'month',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PayrollCollection, PayrollCollection, QAfterFilterCondition>
      monthMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'month',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PayrollCollection, PayrollCollection, QAfterFilterCondition>
      monthIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'month',
        value: '',
      ));
    });
  }

  QueryBuilder<PayrollCollection, PayrollCollection, QAfterFilterCondition>
      monthIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'month',
        value: '',
      ));
    });
  }

  QueryBuilder<PayrollCollection, PayrollCollection, QAfterFilterCondition>
      netAmountEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'netAmount',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<PayrollCollection, PayrollCollection, QAfterFilterCondition>
      netAmountGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'netAmount',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<PayrollCollection, PayrollCollection, QAfterFilterCondition>
      netAmountLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'netAmount',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<PayrollCollection, PayrollCollection, QAfterFilterCondition>
      netAmountBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'netAmount',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<PayrollCollection, PayrollCollection, QAfterFilterCondition>
      overtimePayEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'overtimePay',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<PayrollCollection, PayrollCollection, QAfterFilterCondition>
      overtimePayGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'overtimePay',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<PayrollCollection, PayrollCollection, QAfterFilterCondition>
      overtimePayLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'overtimePay',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<PayrollCollection, PayrollCollection, QAfterFilterCondition>
      overtimePayBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'overtimePay',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<PayrollCollection, PayrollCollection, QAfterFilterCondition>
      paymentDateIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'paymentDate',
      ));
    });
  }

  QueryBuilder<PayrollCollection, PayrollCollection, QAfterFilterCondition>
      paymentDateIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'paymentDate',
      ));
    });
  }

  QueryBuilder<PayrollCollection, PayrollCollection, QAfterFilterCondition>
      paymentDateEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'paymentDate',
        value: value,
      ));
    });
  }

  QueryBuilder<PayrollCollection, PayrollCollection, QAfterFilterCondition>
      paymentDateGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'paymentDate',
        value: value,
      ));
    });
  }

  QueryBuilder<PayrollCollection, PayrollCollection, QAfterFilterCondition>
      paymentDateLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'paymentDate',
        value: value,
      ));
    });
  }

  QueryBuilder<PayrollCollection, PayrollCollection, QAfterFilterCondition>
      paymentDateBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'paymentDate',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<PayrollCollection, PayrollCollection, QAfterFilterCondition>
      statutoryTaxesEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'statutoryTaxes',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<PayrollCollection, PayrollCollection, QAfterFilterCondition>
      statutoryTaxesGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'statutoryTaxes',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<PayrollCollection, PayrollCollection, QAfterFilterCondition>
      statutoryTaxesLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'statutoryTaxes',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<PayrollCollection, PayrollCollection, QAfterFilterCondition>
      statutoryTaxesBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'statutoryTaxes',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<PayrollCollection, PayrollCollection, QAfterFilterCondition>
      uuidEqualTo(
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

  QueryBuilder<PayrollCollection, PayrollCollection, QAfterFilterCondition>
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

  QueryBuilder<PayrollCollection, PayrollCollection, QAfterFilterCondition>
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

  QueryBuilder<PayrollCollection, PayrollCollection, QAfterFilterCondition>
      uuidBetween(
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

  QueryBuilder<PayrollCollection, PayrollCollection, QAfterFilterCondition>
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

  QueryBuilder<PayrollCollection, PayrollCollection, QAfterFilterCondition>
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

  QueryBuilder<PayrollCollection, PayrollCollection, QAfterFilterCondition>
      uuidContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'uuid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PayrollCollection, PayrollCollection, QAfterFilterCondition>
      uuidMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'uuid',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PayrollCollection, PayrollCollection, QAfterFilterCondition>
      uuidIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'uuid',
        value: '',
      ));
    });
  }

  QueryBuilder<PayrollCollection, PayrollCollection, QAfterFilterCondition>
      uuidIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'uuid',
        value: '',
      ));
    });
  }
}

extension PayrollCollectionQueryObject
    on QueryBuilder<PayrollCollection, PayrollCollection, QFilterCondition> {}

extension PayrollCollectionQueryLinks
    on QueryBuilder<PayrollCollection, PayrollCollection, QFilterCondition> {}

extension PayrollCollectionQuerySortBy
    on QueryBuilder<PayrollCollection, PayrollCollection, QSortBy> {
  QueryBuilder<PayrollCollection, PayrollCollection, QAfterSortBy>
      sortByAllowances() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'allowances', Sort.asc);
    });
  }

  QueryBuilder<PayrollCollection, PayrollCollection, QAfterSortBy>
      sortByAllowancesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'allowances', Sort.desc);
    });
  }

  QueryBuilder<PayrollCollection, PayrollCollection, QAfterSortBy>
      sortByBankReference() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bankReference', Sort.asc);
    });
  }

  QueryBuilder<PayrollCollection, PayrollCollection, QAfterSortBy>
      sortByBankReferenceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bankReference', Sort.desc);
    });
  }

  QueryBuilder<PayrollCollection, PayrollCollection, QAfterSortBy>
      sortByBasicSalary() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'basicSalary', Sort.asc);
    });
  }

  QueryBuilder<PayrollCollection, PayrollCollection, QAfterSortBy>
      sortByBasicSalaryDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'basicSalary', Sort.desc);
    });
  }

  QueryBuilder<PayrollCollection, PayrollCollection, QAfterSortBy>
      sortByBonuses() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bonuses', Sort.asc);
    });
  }

  QueryBuilder<PayrollCollection, PayrollCollection, QAfterSortBy>
      sortByBonusesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bonuses', Sort.desc);
    });
  }

  QueryBuilder<PayrollCollection, PayrollCollection, QAfterSortBy>
      sortByDeductions() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'deductions', Sort.asc);
    });
  }

  QueryBuilder<PayrollCollection, PayrollCollection, QAfterSortBy>
      sortByDeductionsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'deductions', Sort.desc);
    });
  }

  QueryBuilder<PayrollCollection, PayrollCollection, QAfterSortBy>
      sortByEmployeeId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'employeeId', Sort.asc);
    });
  }

  QueryBuilder<PayrollCollection, PayrollCollection, QAfterSortBy>
      sortByEmployeeIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'employeeId', Sort.desc);
    });
  }

  QueryBuilder<PayrollCollection, PayrollCollection, QAfterSortBy>
      sortByGlTransactionId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'glTransactionId', Sort.asc);
    });
  }

  QueryBuilder<PayrollCollection, PayrollCollection, QAfterSortBy>
      sortByGlTransactionIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'glTransactionId', Sort.desc);
    });
  }

  QueryBuilder<PayrollCollection, PayrollCollection, QAfterSortBy> sortByHra() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hra', Sort.asc);
    });
  }

  QueryBuilder<PayrollCollection, PayrollCollection, QAfterSortBy>
      sortByHraDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hra', Sort.desc);
    });
  }

  QueryBuilder<PayrollCollection, PayrollCollection, QAfterSortBy>
      sortByIsPaid() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isPaid', Sort.asc);
    });
  }

  QueryBuilder<PayrollCollection, PayrollCollection, QAfterSortBy>
      sortByIsPaidDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isPaid', Sort.desc);
    });
  }

  QueryBuilder<PayrollCollection, PayrollCollection, QAfterSortBy>
      sortByMonth() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'month', Sort.asc);
    });
  }

  QueryBuilder<PayrollCollection, PayrollCollection, QAfterSortBy>
      sortByMonthDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'month', Sort.desc);
    });
  }

  QueryBuilder<PayrollCollection, PayrollCollection, QAfterSortBy>
      sortByNetAmount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'netAmount', Sort.asc);
    });
  }

  QueryBuilder<PayrollCollection, PayrollCollection, QAfterSortBy>
      sortByNetAmountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'netAmount', Sort.desc);
    });
  }

  QueryBuilder<PayrollCollection, PayrollCollection, QAfterSortBy>
      sortByOvertimePay() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'overtimePay', Sort.asc);
    });
  }

  QueryBuilder<PayrollCollection, PayrollCollection, QAfterSortBy>
      sortByOvertimePayDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'overtimePay', Sort.desc);
    });
  }

  QueryBuilder<PayrollCollection, PayrollCollection, QAfterSortBy>
      sortByPaymentDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'paymentDate', Sort.asc);
    });
  }

  QueryBuilder<PayrollCollection, PayrollCollection, QAfterSortBy>
      sortByPaymentDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'paymentDate', Sort.desc);
    });
  }

  QueryBuilder<PayrollCollection, PayrollCollection, QAfterSortBy>
      sortByStatutoryTaxes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'statutoryTaxes', Sort.asc);
    });
  }

  QueryBuilder<PayrollCollection, PayrollCollection, QAfterSortBy>
      sortByStatutoryTaxesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'statutoryTaxes', Sort.desc);
    });
  }

  QueryBuilder<PayrollCollection, PayrollCollection, QAfterSortBy>
      sortByUuid() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uuid', Sort.asc);
    });
  }

  QueryBuilder<PayrollCollection, PayrollCollection, QAfterSortBy>
      sortByUuidDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uuid', Sort.desc);
    });
  }
}

extension PayrollCollectionQuerySortThenBy
    on QueryBuilder<PayrollCollection, PayrollCollection, QSortThenBy> {
  QueryBuilder<PayrollCollection, PayrollCollection, QAfterSortBy>
      thenByAllowances() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'allowances', Sort.asc);
    });
  }

  QueryBuilder<PayrollCollection, PayrollCollection, QAfterSortBy>
      thenByAllowancesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'allowances', Sort.desc);
    });
  }

  QueryBuilder<PayrollCollection, PayrollCollection, QAfterSortBy>
      thenByBankReference() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bankReference', Sort.asc);
    });
  }

  QueryBuilder<PayrollCollection, PayrollCollection, QAfterSortBy>
      thenByBankReferenceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bankReference', Sort.desc);
    });
  }

  QueryBuilder<PayrollCollection, PayrollCollection, QAfterSortBy>
      thenByBasicSalary() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'basicSalary', Sort.asc);
    });
  }

  QueryBuilder<PayrollCollection, PayrollCollection, QAfterSortBy>
      thenByBasicSalaryDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'basicSalary', Sort.desc);
    });
  }

  QueryBuilder<PayrollCollection, PayrollCollection, QAfterSortBy>
      thenByBonuses() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bonuses', Sort.asc);
    });
  }

  QueryBuilder<PayrollCollection, PayrollCollection, QAfterSortBy>
      thenByBonusesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bonuses', Sort.desc);
    });
  }

  QueryBuilder<PayrollCollection, PayrollCollection, QAfterSortBy>
      thenByDeductions() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'deductions', Sort.asc);
    });
  }

  QueryBuilder<PayrollCollection, PayrollCollection, QAfterSortBy>
      thenByDeductionsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'deductions', Sort.desc);
    });
  }

  QueryBuilder<PayrollCollection, PayrollCollection, QAfterSortBy>
      thenByEmployeeId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'employeeId', Sort.asc);
    });
  }

  QueryBuilder<PayrollCollection, PayrollCollection, QAfterSortBy>
      thenByEmployeeIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'employeeId', Sort.desc);
    });
  }

  QueryBuilder<PayrollCollection, PayrollCollection, QAfterSortBy>
      thenByGlTransactionId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'glTransactionId', Sort.asc);
    });
  }

  QueryBuilder<PayrollCollection, PayrollCollection, QAfterSortBy>
      thenByGlTransactionIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'glTransactionId', Sort.desc);
    });
  }

  QueryBuilder<PayrollCollection, PayrollCollection, QAfterSortBy> thenByHra() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hra', Sort.asc);
    });
  }

  QueryBuilder<PayrollCollection, PayrollCollection, QAfterSortBy>
      thenByHraDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hra', Sort.desc);
    });
  }

  QueryBuilder<PayrollCollection, PayrollCollection, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<PayrollCollection, PayrollCollection, QAfterSortBy>
      thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<PayrollCollection, PayrollCollection, QAfterSortBy>
      thenByIsPaid() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isPaid', Sort.asc);
    });
  }

  QueryBuilder<PayrollCollection, PayrollCollection, QAfterSortBy>
      thenByIsPaidDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isPaid', Sort.desc);
    });
  }

  QueryBuilder<PayrollCollection, PayrollCollection, QAfterSortBy>
      thenByMonth() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'month', Sort.asc);
    });
  }

  QueryBuilder<PayrollCollection, PayrollCollection, QAfterSortBy>
      thenByMonthDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'month', Sort.desc);
    });
  }

  QueryBuilder<PayrollCollection, PayrollCollection, QAfterSortBy>
      thenByNetAmount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'netAmount', Sort.asc);
    });
  }

  QueryBuilder<PayrollCollection, PayrollCollection, QAfterSortBy>
      thenByNetAmountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'netAmount', Sort.desc);
    });
  }

  QueryBuilder<PayrollCollection, PayrollCollection, QAfterSortBy>
      thenByOvertimePay() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'overtimePay', Sort.asc);
    });
  }

  QueryBuilder<PayrollCollection, PayrollCollection, QAfterSortBy>
      thenByOvertimePayDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'overtimePay', Sort.desc);
    });
  }

  QueryBuilder<PayrollCollection, PayrollCollection, QAfterSortBy>
      thenByPaymentDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'paymentDate', Sort.asc);
    });
  }

  QueryBuilder<PayrollCollection, PayrollCollection, QAfterSortBy>
      thenByPaymentDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'paymentDate', Sort.desc);
    });
  }

  QueryBuilder<PayrollCollection, PayrollCollection, QAfterSortBy>
      thenByStatutoryTaxes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'statutoryTaxes', Sort.asc);
    });
  }

  QueryBuilder<PayrollCollection, PayrollCollection, QAfterSortBy>
      thenByStatutoryTaxesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'statutoryTaxes', Sort.desc);
    });
  }

  QueryBuilder<PayrollCollection, PayrollCollection, QAfterSortBy>
      thenByUuid() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uuid', Sort.asc);
    });
  }

  QueryBuilder<PayrollCollection, PayrollCollection, QAfterSortBy>
      thenByUuidDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uuid', Sort.desc);
    });
  }
}

extension PayrollCollectionQueryWhereDistinct
    on QueryBuilder<PayrollCollection, PayrollCollection, QDistinct> {
  QueryBuilder<PayrollCollection, PayrollCollection, QDistinct>
      distinctByAllowances() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'allowances');
    });
  }

  QueryBuilder<PayrollCollection, PayrollCollection, QDistinct>
      distinctByBankReference({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'bankReference',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<PayrollCollection, PayrollCollection, QDistinct>
      distinctByBasicSalary() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'basicSalary');
    });
  }

  QueryBuilder<PayrollCollection, PayrollCollection, QDistinct>
      distinctByBonuses() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'bonuses');
    });
  }

  QueryBuilder<PayrollCollection, PayrollCollection, QDistinct>
      distinctByDeductions() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'deductions');
    });
  }

  QueryBuilder<PayrollCollection, PayrollCollection, QDistinct>
      distinctByEmployeeId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'employeeId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<PayrollCollection, PayrollCollection, QDistinct>
      distinctByGlTransactionId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'glTransactionId',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<PayrollCollection, PayrollCollection, QDistinct>
      distinctByHra() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'hra');
    });
  }

  QueryBuilder<PayrollCollection, PayrollCollection, QDistinct>
      distinctByIsPaid() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isPaid');
    });
  }

  QueryBuilder<PayrollCollection, PayrollCollection, QDistinct> distinctByMonth(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'month', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<PayrollCollection, PayrollCollection, QDistinct>
      distinctByNetAmount() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'netAmount');
    });
  }

  QueryBuilder<PayrollCollection, PayrollCollection, QDistinct>
      distinctByOvertimePay() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'overtimePay');
    });
  }

  QueryBuilder<PayrollCollection, PayrollCollection, QDistinct>
      distinctByPaymentDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'paymentDate');
    });
  }

  QueryBuilder<PayrollCollection, PayrollCollection, QDistinct>
      distinctByStatutoryTaxes() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'statutoryTaxes');
    });
  }

  QueryBuilder<PayrollCollection, PayrollCollection, QDistinct> distinctByUuid(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'uuid', caseSensitive: caseSensitive);
    });
  }
}

extension PayrollCollectionQueryProperty
    on QueryBuilder<PayrollCollection, PayrollCollection, QQueryProperty> {
  QueryBuilder<PayrollCollection, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<PayrollCollection, double, QQueryOperations>
      allowancesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'allowances');
    });
  }

  QueryBuilder<PayrollCollection, String?, QQueryOperations>
      bankReferenceProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'bankReference');
    });
  }

  QueryBuilder<PayrollCollection, double, QQueryOperations>
      basicSalaryProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'basicSalary');
    });
  }

  QueryBuilder<PayrollCollection, double, QQueryOperations> bonusesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'bonuses');
    });
  }

  QueryBuilder<PayrollCollection, double, QQueryOperations>
      deductionsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'deductions');
    });
  }

  QueryBuilder<PayrollCollection, String, QQueryOperations>
      employeeIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'employeeId');
    });
  }

  QueryBuilder<PayrollCollection, String?, QQueryOperations>
      glTransactionIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'glTransactionId');
    });
  }

  QueryBuilder<PayrollCollection, double, QQueryOperations> hraProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'hra');
    });
  }

  QueryBuilder<PayrollCollection, bool, QQueryOperations> isPaidProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isPaid');
    });
  }

  QueryBuilder<PayrollCollection, String, QQueryOperations> monthProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'month');
    });
  }

  QueryBuilder<PayrollCollection, double, QQueryOperations>
      netAmountProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'netAmount');
    });
  }

  QueryBuilder<PayrollCollection, double, QQueryOperations>
      overtimePayProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'overtimePay');
    });
  }

  QueryBuilder<PayrollCollection, DateTime?, QQueryOperations>
      paymentDateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'paymentDate');
    });
  }

  QueryBuilder<PayrollCollection, double, QQueryOperations>
      statutoryTaxesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'statutoryTaxes');
    });
  }

  QueryBuilder<PayrollCollection, String, QQueryOperations> uuidProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'uuid');
    });
  }
}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetLeaveCollectionCollection on Isar {
  IsarCollection<LeaveCollection> get leaveCollections => this.collection();
}

const LeaveCollectionSchema = CollectionSchema(
  name: r'LeaveCollection',
  id: -(5721144903326 * 1000000 + 480914),
  properties: {
    r'approvedById': PropertySchema(
      id: 0,
      name: r'approvedById',
      type: IsarType.string,
    ),
    r'employeeId': PropertySchema(
      id: 1,
      name: r'employeeId',
      type: IsarType.string,
    ),
    r'endDate': PropertySchema(
      id: 2,
      name: r'endDate',
      type: IsarType.dateTime,
    ),
    r'reason': PropertySchema(
      id: 3,
      name: r'reason',
      type: IsarType.string,
    ),
    r'startDate': PropertySchema(
      id: 4,
      name: r'startDate',
      type: IsarType.dateTime,
    ),
    r'status': PropertySchema(
      id: 5,
      name: r'status',
      type: IsarType.string,
    ),
    r'type': PropertySchema(
      id: 6,
      name: r'type',
      type: IsarType.string,
    ),
    r'uuid': PropertySchema(
      id: 7,
      name: r'uuid',
      type: IsarType.string,
    )
  },
  estimateSize: _leaveCollectionEstimateSize,
  serialize: _leaveCollectionSerialize,
  deserialize: _leaveCollectionDeserialize,
  deserializeProp: _leaveCollectionDeserializeProp,
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
    r'employeeId': IndexSchema(
      id: (1283453093523 * 1000000 + 34672),
      name: r'employeeId',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'employeeId',
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
  getId: _leaveCollectionGetId,
  getLinks: _leaveCollectionGetLinks,
  attach: _leaveCollectionAttach,
  version: '3.1.0+1',
);

int _leaveCollectionEstimateSize(
  LeaveCollection object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.approvedById;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.employeeId.length * 3;
  bytesCount += 3 + object.reason.length * 3;
  bytesCount += 3 + object.status.length * 3;
  bytesCount += 3 + object.type.length * 3;
  bytesCount += 3 + object.uuid.length * 3;
  return bytesCount;
}

void _leaveCollectionSerialize(
  LeaveCollection object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.approvedById);
  writer.writeString(offsets[1], object.employeeId);
  writer.writeDateTime(offsets[2], object.endDate);
  writer.writeString(offsets[3], object.reason);
  writer.writeDateTime(offsets[4], object.startDate);
  writer.writeString(offsets[5], object.status);
  writer.writeString(offsets[6], object.type);
  writer.writeString(offsets[7], object.uuid);
}

LeaveCollection _leaveCollectionDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = LeaveCollection();
  object.approvedById = reader.readStringOrNull(offsets[0]);
  object.employeeId = reader.readString(offsets[1]);
  object.endDate = reader.readDateTime(offsets[2]);
  object.id = id;
  object.reason = reader.readString(offsets[3]);
  object.startDate = reader.readDateTime(offsets[4]);
  object.status = reader.readString(offsets[5]);
  object.type = reader.readString(offsets[6]);
  object.uuid = reader.readString(offsets[7]);
  return object;
}

P _leaveCollectionDeserializeProp<P>(
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
      return (reader.readDateTime(offset)) as P;
    case 3:
      return (reader.readString(offset)) as P;
    case 4:
      return (reader.readDateTime(offset)) as P;
    case 5:
      return (reader.readString(offset)) as P;
    case 6:
      return (reader.readString(offset)) as P;
    case 7:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _leaveCollectionGetId(LeaveCollection object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _leaveCollectionGetLinks(LeaveCollection object) {
  return [];
}

void _leaveCollectionAttach(
    IsarCollection<dynamic> col, Id id, LeaveCollection object) {
  object.id = id;
}

extension LeaveCollectionByIndex on IsarCollection<LeaveCollection> {
  Future<LeaveCollection?> getByUuid(String uuid) {
    return getByIndex(r'uuid', [uuid]);
  }

  LeaveCollection? getByUuidSync(String uuid) {
    return getByIndexSync(r'uuid', [uuid]);
  }

  Future<bool> deleteByUuid(String uuid) {
    return deleteByIndex(r'uuid', [uuid]);
  }

  bool deleteByUuidSync(String uuid) {
    return deleteByIndexSync(r'uuid', [uuid]);
  }

  Future<List<LeaveCollection?>> getAllByUuid(List<String> uuidValues) {
    final values = uuidValues.map((e) => [e]).toList();
    return getAllByIndex(r'uuid', values);
  }

  List<LeaveCollection?> getAllByUuidSync(List<String> uuidValues) {
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

  Future<Id> putByUuid(LeaveCollection object) {
    return putByIndex(r'uuid', object);
  }

  Id putByUuidSync(LeaveCollection object, {bool saveLinks = true}) {
    return putByIndexSync(r'uuid', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByUuid(List<LeaveCollection> objects) {
    return putAllByIndex(r'uuid', objects);
  }

  List<Id> putAllByUuidSync(List<LeaveCollection> objects,
      {bool saveLinks = true}) {
    return putAllByIndexSync(r'uuid', objects, saveLinks: saveLinks);
  }
}

extension LeaveCollectionQueryWhereSort
    on QueryBuilder<LeaveCollection, LeaveCollection, QWhere> {
  QueryBuilder<LeaveCollection, LeaveCollection, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension LeaveCollectionQueryWhere
    on QueryBuilder<LeaveCollection, LeaveCollection, QWhereClause> {
  QueryBuilder<LeaveCollection, LeaveCollection, QAfterWhereClause> idEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<LeaveCollection, LeaveCollection, QAfterWhereClause>
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

  QueryBuilder<LeaveCollection, LeaveCollection, QAfterWhereClause>
      idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<LeaveCollection, LeaveCollection, QAfterWhereClause> idLessThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<LeaveCollection, LeaveCollection, QAfterWhereClause> idBetween(
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

  QueryBuilder<LeaveCollection, LeaveCollection, QAfterWhereClause> uuidEqualTo(
      String uuid) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'uuid',
        value: [uuid],
      ));
    });
  }

  QueryBuilder<LeaveCollection, LeaveCollection, QAfterWhereClause>
      uuidNotEqualTo(String uuid) {
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

  QueryBuilder<LeaveCollection, LeaveCollection, QAfterWhereClause>
      employeeIdEqualTo(String employeeId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'employeeId',
        value: [employeeId],
      ));
    });
  }

  QueryBuilder<LeaveCollection, LeaveCollection, QAfterWhereClause>
      employeeIdNotEqualTo(String employeeId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'employeeId',
              lower: [],
              upper: [employeeId],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'employeeId',
              lower: [employeeId],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'employeeId',
              lower: [employeeId],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'employeeId',
              lower: [],
              upper: [employeeId],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<LeaveCollection, LeaveCollection, QAfterWhereClause>
      statusEqualTo(String status) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'status',
        value: [status],
      ));
    });
  }

  QueryBuilder<LeaveCollection, LeaveCollection, QAfterWhereClause>
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

extension LeaveCollectionQueryFilter
    on QueryBuilder<LeaveCollection, LeaveCollection, QFilterCondition> {
  QueryBuilder<LeaveCollection, LeaveCollection, QAfterFilterCondition>
      approvedByIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'approvedById',
      ));
    });
  }

  QueryBuilder<LeaveCollection, LeaveCollection, QAfterFilterCondition>
      approvedByIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'approvedById',
      ));
    });
  }

  QueryBuilder<LeaveCollection, LeaveCollection, QAfterFilterCondition>
      approvedByIdEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'approvedById',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LeaveCollection, LeaveCollection, QAfterFilterCondition>
      approvedByIdGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'approvedById',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LeaveCollection, LeaveCollection, QAfterFilterCondition>
      approvedByIdLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'approvedById',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LeaveCollection, LeaveCollection, QAfterFilterCondition>
      approvedByIdBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'approvedById',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LeaveCollection, LeaveCollection, QAfterFilterCondition>
      approvedByIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'approvedById',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LeaveCollection, LeaveCollection, QAfterFilterCondition>
      approvedByIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'approvedById',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LeaveCollection, LeaveCollection, QAfterFilterCondition>
      approvedByIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'approvedById',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LeaveCollection, LeaveCollection, QAfterFilterCondition>
      approvedByIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'approvedById',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LeaveCollection, LeaveCollection, QAfterFilterCondition>
      approvedByIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'approvedById',
        value: '',
      ));
    });
  }

  QueryBuilder<LeaveCollection, LeaveCollection, QAfterFilterCondition>
      approvedByIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'approvedById',
        value: '',
      ));
    });
  }

  QueryBuilder<LeaveCollection, LeaveCollection, QAfterFilterCondition>
      employeeIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'employeeId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LeaveCollection, LeaveCollection, QAfterFilterCondition>
      employeeIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'employeeId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LeaveCollection, LeaveCollection, QAfterFilterCondition>
      employeeIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'employeeId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LeaveCollection, LeaveCollection, QAfterFilterCondition>
      employeeIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'employeeId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LeaveCollection, LeaveCollection, QAfterFilterCondition>
      employeeIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'employeeId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LeaveCollection, LeaveCollection, QAfterFilterCondition>
      employeeIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'employeeId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LeaveCollection, LeaveCollection, QAfterFilterCondition>
      employeeIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'employeeId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LeaveCollection, LeaveCollection, QAfterFilterCondition>
      employeeIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'employeeId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LeaveCollection, LeaveCollection, QAfterFilterCondition>
      employeeIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'employeeId',
        value: '',
      ));
    });
  }

  QueryBuilder<LeaveCollection, LeaveCollection, QAfterFilterCondition>
      employeeIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'employeeId',
        value: '',
      ));
    });
  }

  QueryBuilder<LeaveCollection, LeaveCollection, QAfterFilterCondition>
      endDateEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'endDate',
        value: value,
      ));
    });
  }

  QueryBuilder<LeaveCollection, LeaveCollection, QAfterFilterCondition>
      endDateGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'endDate',
        value: value,
      ));
    });
  }

  QueryBuilder<LeaveCollection, LeaveCollection, QAfterFilterCondition>
      endDateLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'endDate',
        value: value,
      ));
    });
  }

  QueryBuilder<LeaveCollection, LeaveCollection, QAfterFilterCondition>
      endDateBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'endDate',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<LeaveCollection, LeaveCollection, QAfterFilterCondition>
      idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<LeaveCollection, LeaveCollection, QAfterFilterCondition>
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

  QueryBuilder<LeaveCollection, LeaveCollection, QAfterFilterCondition>
      idLessThan(
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

  QueryBuilder<LeaveCollection, LeaveCollection, QAfterFilterCondition>
      idBetween(
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

  QueryBuilder<LeaveCollection, LeaveCollection, QAfterFilterCondition>
      reasonEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'reason',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LeaveCollection, LeaveCollection, QAfterFilterCondition>
      reasonGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'reason',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LeaveCollection, LeaveCollection, QAfterFilterCondition>
      reasonLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'reason',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LeaveCollection, LeaveCollection, QAfterFilterCondition>
      reasonBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'reason',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LeaveCollection, LeaveCollection, QAfterFilterCondition>
      reasonStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'reason',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LeaveCollection, LeaveCollection, QAfterFilterCondition>
      reasonEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'reason',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LeaveCollection, LeaveCollection, QAfterFilterCondition>
      reasonContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'reason',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LeaveCollection, LeaveCollection, QAfterFilterCondition>
      reasonMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'reason',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LeaveCollection, LeaveCollection, QAfterFilterCondition>
      reasonIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'reason',
        value: '',
      ));
    });
  }

  QueryBuilder<LeaveCollection, LeaveCollection, QAfterFilterCondition>
      reasonIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'reason',
        value: '',
      ));
    });
  }

  QueryBuilder<LeaveCollection, LeaveCollection, QAfterFilterCondition>
      startDateEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'startDate',
        value: value,
      ));
    });
  }

  QueryBuilder<LeaveCollection, LeaveCollection, QAfterFilterCondition>
      startDateGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'startDate',
        value: value,
      ));
    });
  }

  QueryBuilder<LeaveCollection, LeaveCollection, QAfterFilterCondition>
      startDateLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'startDate',
        value: value,
      ));
    });
  }

  QueryBuilder<LeaveCollection, LeaveCollection, QAfterFilterCondition>
      startDateBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'startDate',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<LeaveCollection, LeaveCollection, QAfterFilterCondition>
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

  QueryBuilder<LeaveCollection, LeaveCollection, QAfterFilterCondition>
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

  QueryBuilder<LeaveCollection, LeaveCollection, QAfterFilterCondition>
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

  QueryBuilder<LeaveCollection, LeaveCollection, QAfterFilterCondition>
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

  QueryBuilder<LeaveCollection, LeaveCollection, QAfterFilterCondition>
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

  QueryBuilder<LeaveCollection, LeaveCollection, QAfterFilterCondition>
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

  QueryBuilder<LeaveCollection, LeaveCollection, QAfterFilterCondition>
      statusContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'status',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LeaveCollection, LeaveCollection, QAfterFilterCondition>
      statusMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'status',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LeaveCollection, LeaveCollection, QAfterFilterCondition>
      statusIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'status',
        value: '',
      ));
    });
  }

  QueryBuilder<LeaveCollection, LeaveCollection, QAfterFilterCondition>
      statusIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'status',
        value: '',
      ));
    });
  }

  QueryBuilder<LeaveCollection, LeaveCollection, QAfterFilterCondition>
      typeEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LeaveCollection, LeaveCollection, QAfterFilterCondition>
      typeGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LeaveCollection, LeaveCollection, QAfterFilterCondition>
      typeLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LeaveCollection, LeaveCollection, QAfterFilterCondition>
      typeBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'type',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LeaveCollection, LeaveCollection, QAfterFilterCondition>
      typeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LeaveCollection, LeaveCollection, QAfterFilterCondition>
      typeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LeaveCollection, LeaveCollection, QAfterFilterCondition>
      typeContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LeaveCollection, LeaveCollection, QAfterFilterCondition>
      typeMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'type',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LeaveCollection, LeaveCollection, QAfterFilterCondition>
      typeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'type',
        value: '',
      ));
    });
  }

  QueryBuilder<LeaveCollection, LeaveCollection, QAfterFilterCondition>
      typeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'type',
        value: '',
      ));
    });
  }

  QueryBuilder<LeaveCollection, LeaveCollection, QAfterFilterCondition>
      uuidEqualTo(
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

  QueryBuilder<LeaveCollection, LeaveCollection, QAfterFilterCondition>
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

  QueryBuilder<LeaveCollection, LeaveCollection, QAfterFilterCondition>
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

  QueryBuilder<LeaveCollection, LeaveCollection, QAfterFilterCondition>
      uuidBetween(
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

  QueryBuilder<LeaveCollection, LeaveCollection, QAfterFilterCondition>
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

  QueryBuilder<LeaveCollection, LeaveCollection, QAfterFilterCondition>
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

  QueryBuilder<LeaveCollection, LeaveCollection, QAfterFilterCondition>
      uuidContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'uuid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LeaveCollection, LeaveCollection, QAfterFilterCondition>
      uuidMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'uuid',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LeaveCollection, LeaveCollection, QAfterFilterCondition>
      uuidIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'uuid',
        value: '',
      ));
    });
  }

  QueryBuilder<LeaveCollection, LeaveCollection, QAfterFilterCondition>
      uuidIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'uuid',
        value: '',
      ));
    });
  }
}

extension LeaveCollectionQueryObject
    on QueryBuilder<LeaveCollection, LeaveCollection, QFilterCondition> {}

extension LeaveCollectionQueryLinks
    on QueryBuilder<LeaveCollection, LeaveCollection, QFilterCondition> {}

extension LeaveCollectionQuerySortBy
    on QueryBuilder<LeaveCollection, LeaveCollection, QSortBy> {
  QueryBuilder<LeaveCollection, LeaveCollection, QAfterSortBy>
      sortByApprovedById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'approvedById', Sort.asc);
    });
  }

  QueryBuilder<LeaveCollection, LeaveCollection, QAfterSortBy>
      sortByApprovedByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'approvedById', Sort.desc);
    });
  }

  QueryBuilder<LeaveCollection, LeaveCollection, QAfterSortBy>
      sortByEmployeeId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'employeeId', Sort.asc);
    });
  }

  QueryBuilder<LeaveCollection, LeaveCollection, QAfterSortBy>
      sortByEmployeeIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'employeeId', Sort.desc);
    });
  }

  QueryBuilder<LeaveCollection, LeaveCollection, QAfterSortBy> sortByEndDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'endDate', Sort.asc);
    });
  }

  QueryBuilder<LeaveCollection, LeaveCollection, QAfterSortBy>
      sortByEndDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'endDate', Sort.desc);
    });
  }

  QueryBuilder<LeaveCollection, LeaveCollection, QAfterSortBy> sortByReason() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'reason', Sort.asc);
    });
  }

  QueryBuilder<LeaveCollection, LeaveCollection, QAfterSortBy>
      sortByReasonDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'reason', Sort.desc);
    });
  }

  QueryBuilder<LeaveCollection, LeaveCollection, QAfterSortBy>
      sortByStartDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'startDate', Sort.asc);
    });
  }

  QueryBuilder<LeaveCollection, LeaveCollection, QAfterSortBy>
      sortByStartDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'startDate', Sort.desc);
    });
  }

  QueryBuilder<LeaveCollection, LeaveCollection, QAfterSortBy> sortByStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.asc);
    });
  }

  QueryBuilder<LeaveCollection, LeaveCollection, QAfterSortBy>
      sortByStatusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.desc);
    });
  }

  QueryBuilder<LeaveCollection, LeaveCollection, QAfterSortBy> sortByType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.asc);
    });
  }

  QueryBuilder<LeaveCollection, LeaveCollection, QAfterSortBy>
      sortByTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.desc);
    });
  }

  QueryBuilder<LeaveCollection, LeaveCollection, QAfterSortBy> sortByUuid() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uuid', Sort.asc);
    });
  }

  QueryBuilder<LeaveCollection, LeaveCollection, QAfterSortBy>
      sortByUuidDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uuid', Sort.desc);
    });
  }
}

extension LeaveCollectionQuerySortThenBy
    on QueryBuilder<LeaveCollection, LeaveCollection, QSortThenBy> {
  QueryBuilder<LeaveCollection, LeaveCollection, QAfterSortBy>
      thenByApprovedById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'approvedById', Sort.asc);
    });
  }

  QueryBuilder<LeaveCollection, LeaveCollection, QAfterSortBy>
      thenByApprovedByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'approvedById', Sort.desc);
    });
  }

  QueryBuilder<LeaveCollection, LeaveCollection, QAfterSortBy>
      thenByEmployeeId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'employeeId', Sort.asc);
    });
  }

  QueryBuilder<LeaveCollection, LeaveCollection, QAfterSortBy>
      thenByEmployeeIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'employeeId', Sort.desc);
    });
  }

  QueryBuilder<LeaveCollection, LeaveCollection, QAfterSortBy> thenByEndDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'endDate', Sort.asc);
    });
  }

  QueryBuilder<LeaveCollection, LeaveCollection, QAfterSortBy>
      thenByEndDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'endDate', Sort.desc);
    });
  }

  QueryBuilder<LeaveCollection, LeaveCollection, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<LeaveCollection, LeaveCollection, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<LeaveCollection, LeaveCollection, QAfterSortBy> thenByReason() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'reason', Sort.asc);
    });
  }

  QueryBuilder<LeaveCollection, LeaveCollection, QAfterSortBy>
      thenByReasonDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'reason', Sort.desc);
    });
  }

  QueryBuilder<LeaveCollection, LeaveCollection, QAfterSortBy>
      thenByStartDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'startDate', Sort.asc);
    });
  }

  QueryBuilder<LeaveCollection, LeaveCollection, QAfterSortBy>
      thenByStartDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'startDate', Sort.desc);
    });
  }

  QueryBuilder<LeaveCollection, LeaveCollection, QAfterSortBy> thenByStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.asc);
    });
  }

  QueryBuilder<LeaveCollection, LeaveCollection, QAfterSortBy>
      thenByStatusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.desc);
    });
  }

  QueryBuilder<LeaveCollection, LeaveCollection, QAfterSortBy> thenByType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.asc);
    });
  }

  QueryBuilder<LeaveCollection, LeaveCollection, QAfterSortBy>
      thenByTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.desc);
    });
  }

  QueryBuilder<LeaveCollection, LeaveCollection, QAfterSortBy> thenByUuid() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uuid', Sort.asc);
    });
  }

  QueryBuilder<LeaveCollection, LeaveCollection, QAfterSortBy>
      thenByUuidDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uuid', Sort.desc);
    });
  }
}

extension LeaveCollectionQueryWhereDistinct
    on QueryBuilder<LeaveCollection, LeaveCollection, QDistinct> {
  QueryBuilder<LeaveCollection, LeaveCollection, QDistinct>
      distinctByApprovedById({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'approvedById', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<LeaveCollection, LeaveCollection, QDistinct>
      distinctByEmployeeId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'employeeId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<LeaveCollection, LeaveCollection, QDistinct>
      distinctByEndDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'endDate');
    });
  }

  QueryBuilder<LeaveCollection, LeaveCollection, QDistinct> distinctByReason(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'reason', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<LeaveCollection, LeaveCollection, QDistinct>
      distinctByStartDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'startDate');
    });
  }

  QueryBuilder<LeaveCollection, LeaveCollection, QDistinct> distinctByStatus(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'status', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<LeaveCollection, LeaveCollection, QDistinct> distinctByType(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'type', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<LeaveCollection, LeaveCollection, QDistinct> distinctByUuid(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'uuid', caseSensitive: caseSensitive);
    });
  }
}

extension LeaveCollectionQueryProperty
    on QueryBuilder<LeaveCollection, LeaveCollection, QQueryProperty> {
  QueryBuilder<LeaveCollection, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<LeaveCollection, String?, QQueryOperations>
      approvedByIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'approvedById');
    });
  }

  QueryBuilder<LeaveCollection, String, QQueryOperations> employeeIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'employeeId');
    });
  }

  QueryBuilder<LeaveCollection, DateTime, QQueryOperations> endDateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'endDate');
    });
  }

  QueryBuilder<LeaveCollection, String, QQueryOperations> reasonProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'reason');
    });
  }

  QueryBuilder<LeaveCollection, DateTime, QQueryOperations>
      startDateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'startDate');
    });
  }

  QueryBuilder<LeaveCollection, String, QQueryOperations> statusProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'status');
    });
  }

  QueryBuilder<LeaveCollection, String, QQueryOperations> typeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'type');
    });
  }

  QueryBuilder<LeaveCollection, String, QQueryOperations> uuidProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'uuid');
    });
  }
}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetDepartmentCollectionCollection on Isar {
  IsarCollection<DepartmentCollection> get departmentCollections =>
      this.collection();
}

const DepartmentCollectionSchema = CollectionSchema(
  name: r'DepartmentCollection',
  id: -(4029594380042 * 1000000 + 767630),
  properties: {
    r'companyId': PropertySchema(
      id: 0,
      name: r'companyId',
      type: IsarType.string,
    ),
    r'name': PropertySchema(
      id: 1,
      name: r'name',
      type: IsarType.string,
    ),
    r'uuid': PropertySchema(
      id: 2,
      name: r'uuid',
      type: IsarType.string,
    )
  },
  estimateSize: _departmentCollectionEstimateSize,
  serialize: _departmentCollectionSerialize,
  deserialize: _departmentCollectionDeserialize,
  deserializeProp: _departmentCollectionDeserializeProp,
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
          caseSensitive: false,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _departmentCollectionGetId,
  getLinks: _departmentCollectionGetLinks,
  attach: _departmentCollectionAttach,
  version: '3.1.0+1',
);

int _departmentCollectionEstimateSize(
  DepartmentCollection object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.companyId.length * 3;
  bytesCount += 3 + object.name.length * 3;
  bytesCount += 3 + object.uuid.length * 3;
  return bytesCount;
}

void _departmentCollectionSerialize(
  DepartmentCollection object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.companyId);
  writer.writeString(offsets[1], object.name);
  writer.writeString(offsets[2], object.uuid);
}

DepartmentCollection _departmentCollectionDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = DepartmentCollection();
  object.companyId = reader.readString(offsets[0]);
  object.id = id;
  object.name = reader.readString(offsets[1]);
  object.uuid = reader.readString(offsets[2]);
  return object;
}

P _departmentCollectionDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readString(offset)) as P;
    case 2:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _departmentCollectionGetId(DepartmentCollection object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _departmentCollectionGetLinks(
    DepartmentCollection object) {
  return [];
}

void _departmentCollectionAttach(
    IsarCollection<dynamic> col, Id id, DepartmentCollection object) {
  object.id = id;
}

extension DepartmentCollectionByIndex on IsarCollection<DepartmentCollection> {
  Future<DepartmentCollection?> getByUuid(String uuid) {
    return getByIndex(r'uuid', [uuid]);
  }

  DepartmentCollection? getByUuidSync(String uuid) {
    return getByIndexSync(r'uuid', [uuid]);
  }

  Future<bool> deleteByUuid(String uuid) {
    return deleteByIndex(r'uuid', [uuid]);
  }

  bool deleteByUuidSync(String uuid) {
    return deleteByIndexSync(r'uuid', [uuid]);
  }

  Future<List<DepartmentCollection?>> getAllByUuid(List<String> uuidValues) {
    final values = uuidValues.map((e) => [e]).toList();
    return getAllByIndex(r'uuid', values);
  }

  List<DepartmentCollection?> getAllByUuidSync(List<String> uuidValues) {
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

  Future<Id> putByUuid(DepartmentCollection object) {
    return putByIndex(r'uuid', object);
  }

  Id putByUuidSync(DepartmentCollection object, {bool saveLinks = true}) {
    return putByIndexSync(r'uuid', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByUuid(List<DepartmentCollection> objects) {
    return putAllByIndex(r'uuid', objects);
  }

  List<Id> putAllByUuidSync(List<DepartmentCollection> objects,
      {bool saveLinks = true}) {
    return putAllByIndexSync(r'uuid', objects, saveLinks: saveLinks);
  }
}

extension DepartmentCollectionQueryWhereSort
    on QueryBuilder<DepartmentCollection, DepartmentCollection, QWhere> {
  QueryBuilder<DepartmentCollection, DepartmentCollection, QAfterWhere>
      anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension DepartmentCollectionQueryWhere
    on QueryBuilder<DepartmentCollection, DepartmentCollection, QWhereClause> {
  QueryBuilder<DepartmentCollection, DepartmentCollection, QAfterWhereClause>
      idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<DepartmentCollection, DepartmentCollection, QAfterWhereClause>
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

  QueryBuilder<DepartmentCollection, DepartmentCollection, QAfterWhereClause>
      idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<DepartmentCollection, DepartmentCollection, QAfterWhereClause>
      idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<DepartmentCollection, DepartmentCollection, QAfterWhereClause>
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

  QueryBuilder<DepartmentCollection, DepartmentCollection, QAfterWhereClause>
      uuidEqualTo(String uuid) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'uuid',
        value: [uuid],
      ));
    });
  }

  QueryBuilder<DepartmentCollection, DepartmentCollection, QAfterWhereClause>
      uuidNotEqualTo(String uuid) {
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

  QueryBuilder<DepartmentCollection, DepartmentCollection, QAfterWhereClause>
      nameEqualTo(String name) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'name',
        value: [name],
      ));
    });
  }

  QueryBuilder<DepartmentCollection, DepartmentCollection, QAfterWhereClause>
      nameNotEqualTo(String name) {
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

extension DepartmentCollectionQueryFilter on QueryBuilder<DepartmentCollection,
    DepartmentCollection, QFilterCondition> {
  QueryBuilder<DepartmentCollection, DepartmentCollection,
      QAfterFilterCondition> companyIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'companyId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DepartmentCollection, DepartmentCollection,
      QAfterFilterCondition> companyIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'companyId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DepartmentCollection, DepartmentCollection,
      QAfterFilterCondition> companyIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'companyId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DepartmentCollection, DepartmentCollection,
      QAfterFilterCondition> companyIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'companyId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DepartmentCollection, DepartmentCollection,
      QAfterFilterCondition> companyIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'companyId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DepartmentCollection, DepartmentCollection,
      QAfterFilterCondition> companyIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'companyId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DepartmentCollection, DepartmentCollection,
          QAfterFilterCondition>
      companyIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'companyId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DepartmentCollection, DepartmentCollection,
          QAfterFilterCondition>
      companyIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'companyId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DepartmentCollection, DepartmentCollection,
      QAfterFilterCondition> companyIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'companyId',
        value: '',
      ));
    });
  }

  QueryBuilder<DepartmentCollection, DepartmentCollection,
      QAfterFilterCondition> companyIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'companyId',
        value: '',
      ));
    });
  }

  QueryBuilder<DepartmentCollection, DepartmentCollection,
      QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<DepartmentCollection, DepartmentCollection,
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

  QueryBuilder<DepartmentCollection, DepartmentCollection,
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

  QueryBuilder<DepartmentCollection, DepartmentCollection,
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

  QueryBuilder<DepartmentCollection, DepartmentCollection,
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

  QueryBuilder<DepartmentCollection, DepartmentCollection,
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

  QueryBuilder<DepartmentCollection, DepartmentCollection,
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

  QueryBuilder<DepartmentCollection, DepartmentCollection,
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

  QueryBuilder<DepartmentCollection, DepartmentCollection,
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

  QueryBuilder<DepartmentCollection, DepartmentCollection,
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

  QueryBuilder<DepartmentCollection, DepartmentCollection,
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

  QueryBuilder<DepartmentCollection, DepartmentCollection,
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

  QueryBuilder<DepartmentCollection, DepartmentCollection,
      QAfterFilterCondition> nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<DepartmentCollection, DepartmentCollection,
      QAfterFilterCondition> nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<DepartmentCollection, DepartmentCollection,
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

  QueryBuilder<DepartmentCollection, DepartmentCollection,
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

  QueryBuilder<DepartmentCollection, DepartmentCollection,
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

  QueryBuilder<DepartmentCollection, DepartmentCollection,
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

  QueryBuilder<DepartmentCollection, DepartmentCollection,
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

  QueryBuilder<DepartmentCollection, DepartmentCollection,
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

  QueryBuilder<DepartmentCollection, DepartmentCollection,
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

  QueryBuilder<DepartmentCollection, DepartmentCollection,
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

  QueryBuilder<DepartmentCollection, DepartmentCollection,
      QAfterFilterCondition> uuidIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'uuid',
        value: '',
      ));
    });
  }

  QueryBuilder<DepartmentCollection, DepartmentCollection,
      QAfterFilterCondition> uuidIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'uuid',
        value: '',
      ));
    });
  }
}

extension DepartmentCollectionQueryObject on QueryBuilder<DepartmentCollection,
    DepartmentCollection, QFilterCondition> {}

extension DepartmentCollectionQueryLinks on QueryBuilder<DepartmentCollection,
    DepartmentCollection, QFilterCondition> {}

extension DepartmentCollectionQuerySortBy
    on QueryBuilder<DepartmentCollection, DepartmentCollection, QSortBy> {
  QueryBuilder<DepartmentCollection, DepartmentCollection, QAfterSortBy>
      sortByCompanyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'companyId', Sort.asc);
    });
  }

  QueryBuilder<DepartmentCollection, DepartmentCollection, QAfterSortBy>
      sortByCompanyIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'companyId', Sort.desc);
    });
  }

  QueryBuilder<DepartmentCollection, DepartmentCollection, QAfterSortBy>
      sortByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<DepartmentCollection, DepartmentCollection, QAfterSortBy>
      sortByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<DepartmentCollection, DepartmentCollection, QAfterSortBy>
      sortByUuid() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uuid', Sort.asc);
    });
  }

  QueryBuilder<DepartmentCollection, DepartmentCollection, QAfterSortBy>
      sortByUuidDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uuid', Sort.desc);
    });
  }
}

extension DepartmentCollectionQuerySortThenBy
    on QueryBuilder<DepartmentCollection, DepartmentCollection, QSortThenBy> {
  QueryBuilder<DepartmentCollection, DepartmentCollection, QAfterSortBy>
      thenByCompanyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'companyId', Sort.asc);
    });
  }

  QueryBuilder<DepartmentCollection, DepartmentCollection, QAfterSortBy>
      thenByCompanyIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'companyId', Sort.desc);
    });
  }

  QueryBuilder<DepartmentCollection, DepartmentCollection, QAfterSortBy>
      thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<DepartmentCollection, DepartmentCollection, QAfterSortBy>
      thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<DepartmentCollection, DepartmentCollection, QAfterSortBy>
      thenByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<DepartmentCollection, DepartmentCollection, QAfterSortBy>
      thenByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<DepartmentCollection, DepartmentCollection, QAfterSortBy>
      thenByUuid() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uuid', Sort.asc);
    });
  }

  QueryBuilder<DepartmentCollection, DepartmentCollection, QAfterSortBy>
      thenByUuidDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uuid', Sort.desc);
    });
  }
}

extension DepartmentCollectionQueryWhereDistinct
    on QueryBuilder<DepartmentCollection, DepartmentCollection, QDistinct> {
  QueryBuilder<DepartmentCollection, DepartmentCollection, QDistinct>
      distinctByCompanyId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'companyId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<DepartmentCollection, DepartmentCollection, QDistinct>
      distinctByName({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'name', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<DepartmentCollection, DepartmentCollection, QDistinct>
      distinctByUuid({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'uuid', caseSensitive: caseSensitive);
    });
  }
}

extension DepartmentCollectionQueryProperty on QueryBuilder<
    DepartmentCollection, DepartmentCollection, QQueryProperty> {
  QueryBuilder<DepartmentCollection, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<DepartmentCollection, String, QQueryOperations>
      companyIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'companyId');
    });
  }

  QueryBuilder<DepartmentCollection, String, QQueryOperations> nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'name');
    });
  }

  QueryBuilder<DepartmentCollection, String, QQueryOperations> uuidProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'uuid');
    });
  }
}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetDesignationCollectionCollection on Isar {
  IsarCollection<DesignationCollection> get designationCollections =>
      this.collection();
}

const DesignationCollectionSchema = CollectionSchema(
  name: r'DesignationCollection',
  id: (1934852748453 * 1000000 + 948127),
  properties: {
    r'name': PropertySchema(
      id: 0,
      name: r'name',
      type: IsarType.string,
    ),
    r'uuid': PropertySchema(
      id: 1,
      name: r'uuid',
      type: IsarType.string,
    )
  },
  estimateSize: _designationCollectionEstimateSize,
  serialize: _designationCollectionSerialize,
  deserialize: _designationCollectionDeserialize,
  deserializeProp: _designationCollectionDeserializeProp,
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
          caseSensitive: false,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _designationCollectionGetId,
  getLinks: _designationCollectionGetLinks,
  attach: _designationCollectionAttach,
  version: '3.1.0+1',
);

int _designationCollectionEstimateSize(
  DesignationCollection object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.name.length * 3;
  bytesCount += 3 + object.uuid.length * 3;
  return bytesCount;
}

void _designationCollectionSerialize(
  DesignationCollection object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.name);
  writer.writeString(offsets[1], object.uuid);
}

DesignationCollection _designationCollectionDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = DesignationCollection();
  object.id = id;
  object.name = reader.readString(offsets[0]);
  object.uuid = reader.readString(offsets[1]);
  return object;
}

P _designationCollectionDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _designationCollectionGetId(DesignationCollection object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _designationCollectionGetLinks(
    DesignationCollection object) {
  return [];
}

void _designationCollectionAttach(
    IsarCollection<dynamic> col, Id id, DesignationCollection object) {
  object.id = id;
}

extension DesignationCollectionByIndex
    on IsarCollection<DesignationCollection> {
  Future<DesignationCollection?> getByUuid(String uuid) {
    return getByIndex(r'uuid', [uuid]);
  }

  DesignationCollection? getByUuidSync(String uuid) {
    return getByIndexSync(r'uuid', [uuid]);
  }

  Future<bool> deleteByUuid(String uuid) {
    return deleteByIndex(r'uuid', [uuid]);
  }

  bool deleteByUuidSync(String uuid) {
    return deleteByIndexSync(r'uuid', [uuid]);
  }

  Future<List<DesignationCollection?>> getAllByUuid(List<String> uuidValues) {
    final values = uuidValues.map((e) => [e]).toList();
    return getAllByIndex(r'uuid', values);
  }

  List<DesignationCollection?> getAllByUuidSync(List<String> uuidValues) {
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

  Future<Id> putByUuid(DesignationCollection object) {
    return putByIndex(r'uuid', object);
  }

  Id putByUuidSync(DesignationCollection object, {bool saveLinks = true}) {
    return putByIndexSync(r'uuid', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByUuid(List<DesignationCollection> objects) {
    return putAllByIndex(r'uuid', objects);
  }

  List<Id> putAllByUuidSync(List<DesignationCollection> objects,
      {bool saveLinks = true}) {
    return putAllByIndexSync(r'uuid', objects, saveLinks: saveLinks);
  }
}

extension DesignationCollectionQueryWhereSort
    on QueryBuilder<DesignationCollection, DesignationCollection, QWhere> {
  QueryBuilder<DesignationCollection, DesignationCollection, QAfterWhere>
      anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension DesignationCollectionQueryWhere on QueryBuilder<DesignationCollection,
    DesignationCollection, QWhereClause> {
  QueryBuilder<DesignationCollection, DesignationCollection, QAfterWhereClause>
      idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<DesignationCollection, DesignationCollection, QAfterWhereClause>
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

  QueryBuilder<DesignationCollection, DesignationCollection, QAfterWhereClause>
      idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<DesignationCollection, DesignationCollection, QAfterWhereClause>
      idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<DesignationCollection, DesignationCollection, QAfterWhereClause>
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

  QueryBuilder<DesignationCollection, DesignationCollection, QAfterWhereClause>
      uuidEqualTo(String uuid) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'uuid',
        value: [uuid],
      ));
    });
  }

  QueryBuilder<DesignationCollection, DesignationCollection, QAfterWhereClause>
      uuidNotEqualTo(String uuid) {
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

  QueryBuilder<DesignationCollection, DesignationCollection, QAfterWhereClause>
      nameEqualTo(String name) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'name',
        value: [name],
      ));
    });
  }

  QueryBuilder<DesignationCollection, DesignationCollection, QAfterWhereClause>
      nameNotEqualTo(String name) {
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

extension DesignationCollectionQueryFilter on QueryBuilder<
    DesignationCollection, DesignationCollection, QFilterCondition> {
  QueryBuilder<DesignationCollection, DesignationCollection,
      QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<DesignationCollection, DesignationCollection,
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

  QueryBuilder<DesignationCollection, DesignationCollection,
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

  QueryBuilder<DesignationCollection, DesignationCollection,
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

  QueryBuilder<DesignationCollection, DesignationCollection,
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

  QueryBuilder<DesignationCollection, DesignationCollection,
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

  QueryBuilder<DesignationCollection, DesignationCollection,
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

  QueryBuilder<DesignationCollection, DesignationCollection,
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

  QueryBuilder<DesignationCollection, DesignationCollection,
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

  QueryBuilder<DesignationCollection, DesignationCollection,
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

  QueryBuilder<DesignationCollection, DesignationCollection,
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

  QueryBuilder<DesignationCollection, DesignationCollection,
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

  QueryBuilder<DesignationCollection, DesignationCollection,
      QAfterFilterCondition> nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<DesignationCollection, DesignationCollection,
      QAfterFilterCondition> nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<DesignationCollection, DesignationCollection,
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

  QueryBuilder<DesignationCollection, DesignationCollection,
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

  QueryBuilder<DesignationCollection, DesignationCollection,
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

  QueryBuilder<DesignationCollection, DesignationCollection,
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

  QueryBuilder<DesignationCollection, DesignationCollection,
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

  QueryBuilder<DesignationCollection, DesignationCollection,
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

  QueryBuilder<DesignationCollection, DesignationCollection,
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

  QueryBuilder<DesignationCollection, DesignationCollection,
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

  QueryBuilder<DesignationCollection, DesignationCollection,
      QAfterFilterCondition> uuidIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'uuid',
        value: '',
      ));
    });
  }

  QueryBuilder<DesignationCollection, DesignationCollection,
      QAfterFilterCondition> uuidIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'uuid',
        value: '',
      ));
    });
  }
}

extension DesignationCollectionQueryObject on QueryBuilder<
    DesignationCollection, DesignationCollection, QFilterCondition> {}

extension DesignationCollectionQueryLinks on QueryBuilder<DesignationCollection,
    DesignationCollection, QFilterCondition> {}

extension DesignationCollectionQuerySortBy
    on QueryBuilder<DesignationCollection, DesignationCollection, QSortBy> {
  QueryBuilder<DesignationCollection, DesignationCollection, QAfterSortBy>
      sortByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<DesignationCollection, DesignationCollection, QAfterSortBy>
      sortByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<DesignationCollection, DesignationCollection, QAfterSortBy>
      sortByUuid() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uuid', Sort.asc);
    });
  }

  QueryBuilder<DesignationCollection, DesignationCollection, QAfterSortBy>
      sortByUuidDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uuid', Sort.desc);
    });
  }
}

extension DesignationCollectionQuerySortThenBy
    on QueryBuilder<DesignationCollection, DesignationCollection, QSortThenBy> {
  QueryBuilder<DesignationCollection, DesignationCollection, QAfterSortBy>
      thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<DesignationCollection, DesignationCollection, QAfterSortBy>
      thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<DesignationCollection, DesignationCollection, QAfterSortBy>
      thenByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<DesignationCollection, DesignationCollection, QAfterSortBy>
      thenByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<DesignationCollection, DesignationCollection, QAfterSortBy>
      thenByUuid() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uuid', Sort.asc);
    });
  }

  QueryBuilder<DesignationCollection, DesignationCollection, QAfterSortBy>
      thenByUuidDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uuid', Sort.desc);
    });
  }
}

extension DesignationCollectionQueryWhereDistinct
    on QueryBuilder<DesignationCollection, DesignationCollection, QDistinct> {
  QueryBuilder<DesignationCollection, DesignationCollection, QDistinct>
      distinctByName({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'name', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<DesignationCollection, DesignationCollection, QDistinct>
      distinctByUuid({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'uuid', caseSensitive: caseSensitive);
    });
  }
}

extension DesignationCollectionQueryProperty on QueryBuilder<
    DesignationCollection, DesignationCollection, QQueryProperty> {
  QueryBuilder<DesignationCollection, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<DesignationCollection, String, QQueryOperations> nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'name');
    });
  }

  QueryBuilder<DesignationCollection, String, QQueryOperations> uuidProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'uuid');
    });
  }
}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetShiftCollectionCollection on Isar {
  IsarCollection<ShiftCollection> get shiftCollections => this.collection();
}

const ShiftCollectionSchema = CollectionSchema(
  name: r'ShiftCollection',
  id: -(8195632981365 * 1000000 + 416109),
  properties: {
    r'endHour': PropertySchema(
      id: 0,
      name: r'endHour',
      type: IsarType.long,
    ),
    r'endMinute': PropertySchema(
      id: 1,
      name: r'endMinute',
      type: IsarType.long,
    ),
    r'graceMinutes': PropertySchema(
      id: 2,
      name: r'graceMinutes',
      type: IsarType.long,
    ),
    r'name': PropertySchema(
      id: 3,
      name: r'name',
      type: IsarType.string,
    ),
    r'startHour': PropertySchema(
      id: 4,
      name: r'startHour',
      type: IsarType.long,
    ),
    r'startMinute': PropertySchema(
      id: 5,
      name: r'startMinute',
      type: IsarType.long,
    ),
    r'uuid': PropertySchema(
      id: 6,
      name: r'uuid',
      type: IsarType.string,
    )
  },
  estimateSize: _shiftCollectionEstimateSize,
  serialize: _shiftCollectionSerialize,
  deserialize: _shiftCollectionDeserialize,
  deserializeProp: _shiftCollectionDeserializeProp,
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
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _shiftCollectionGetId,
  getLinks: _shiftCollectionGetLinks,
  attach: _shiftCollectionAttach,
  version: '3.1.0+1',
);

int _shiftCollectionEstimateSize(
  ShiftCollection object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.name.length * 3;
  bytesCount += 3 + object.uuid.length * 3;
  return bytesCount;
}

void _shiftCollectionSerialize(
  ShiftCollection object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.endHour);
  writer.writeLong(offsets[1], object.endMinute);
  writer.writeLong(offsets[2], object.graceMinutes);
  writer.writeString(offsets[3], object.name);
  writer.writeLong(offsets[4], object.startHour);
  writer.writeLong(offsets[5], object.startMinute);
  writer.writeString(offsets[6], object.uuid);
}

ShiftCollection _shiftCollectionDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = ShiftCollection();
  object.endHour = reader.readLong(offsets[0]);
  object.endMinute = reader.readLong(offsets[1]);
  object.graceMinutes = reader.readLong(offsets[2]);
  object.id = id;
  object.name = reader.readString(offsets[3]);
  object.startHour = reader.readLong(offsets[4]);
  object.startMinute = reader.readLong(offsets[5]);
  object.uuid = reader.readString(offsets[6]);
  return object;
}

P _shiftCollectionDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLong(offset)) as P;
    case 1:
      return (reader.readLong(offset)) as P;
    case 2:
      return (reader.readLong(offset)) as P;
    case 3:
      return (reader.readString(offset)) as P;
    case 4:
      return (reader.readLong(offset)) as P;
    case 5:
      return (reader.readLong(offset)) as P;
    case 6:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _shiftCollectionGetId(ShiftCollection object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _shiftCollectionGetLinks(ShiftCollection object) {
  return [];
}

void _shiftCollectionAttach(
    IsarCollection<dynamic> col, Id id, ShiftCollection object) {
  object.id = id;
}

extension ShiftCollectionByIndex on IsarCollection<ShiftCollection> {
  Future<ShiftCollection?> getByUuid(String uuid) {
    return getByIndex(r'uuid', [uuid]);
  }

  ShiftCollection? getByUuidSync(String uuid) {
    return getByIndexSync(r'uuid', [uuid]);
  }

  Future<bool> deleteByUuid(String uuid) {
    return deleteByIndex(r'uuid', [uuid]);
  }

  bool deleteByUuidSync(String uuid) {
    return deleteByIndexSync(r'uuid', [uuid]);
  }

  Future<List<ShiftCollection?>> getAllByUuid(List<String> uuidValues) {
    final values = uuidValues.map((e) => [e]).toList();
    return getAllByIndex(r'uuid', values);
  }

  List<ShiftCollection?> getAllByUuidSync(List<String> uuidValues) {
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

  Future<Id> putByUuid(ShiftCollection object) {
    return putByIndex(r'uuid', object);
  }

  Id putByUuidSync(ShiftCollection object, {bool saveLinks = true}) {
    return putByIndexSync(r'uuid', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByUuid(List<ShiftCollection> objects) {
    return putAllByIndex(r'uuid', objects);
  }

  List<Id> putAllByUuidSync(List<ShiftCollection> objects,
      {bool saveLinks = true}) {
    return putAllByIndexSync(r'uuid', objects, saveLinks: saveLinks);
  }
}

extension ShiftCollectionQueryWhereSort
    on QueryBuilder<ShiftCollection, ShiftCollection, QWhere> {
  QueryBuilder<ShiftCollection, ShiftCollection, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension ShiftCollectionQueryWhere
    on QueryBuilder<ShiftCollection, ShiftCollection, QWhereClause> {
  QueryBuilder<ShiftCollection, ShiftCollection, QAfterWhereClause> idEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<ShiftCollection, ShiftCollection, QAfterWhereClause>
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

  QueryBuilder<ShiftCollection, ShiftCollection, QAfterWhereClause>
      idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<ShiftCollection, ShiftCollection, QAfterWhereClause> idLessThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<ShiftCollection, ShiftCollection, QAfterWhereClause> idBetween(
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

  QueryBuilder<ShiftCollection, ShiftCollection, QAfterWhereClause> uuidEqualTo(
      String uuid) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'uuid',
        value: [uuid],
      ));
    });
  }

  QueryBuilder<ShiftCollection, ShiftCollection, QAfterWhereClause>
      uuidNotEqualTo(String uuid) {
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
}

extension ShiftCollectionQueryFilter
    on QueryBuilder<ShiftCollection, ShiftCollection, QFilterCondition> {
  QueryBuilder<ShiftCollection, ShiftCollection, QAfterFilterCondition>
      endHourEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'endHour',
        value: value,
      ));
    });
  }

  QueryBuilder<ShiftCollection, ShiftCollection, QAfterFilterCondition>
      endHourGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'endHour',
        value: value,
      ));
    });
  }

  QueryBuilder<ShiftCollection, ShiftCollection, QAfterFilterCondition>
      endHourLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'endHour',
        value: value,
      ));
    });
  }

  QueryBuilder<ShiftCollection, ShiftCollection, QAfterFilterCondition>
      endHourBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'endHour',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ShiftCollection, ShiftCollection, QAfterFilterCondition>
      endMinuteEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'endMinute',
        value: value,
      ));
    });
  }

  QueryBuilder<ShiftCollection, ShiftCollection, QAfterFilterCondition>
      endMinuteGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'endMinute',
        value: value,
      ));
    });
  }

  QueryBuilder<ShiftCollection, ShiftCollection, QAfterFilterCondition>
      endMinuteLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'endMinute',
        value: value,
      ));
    });
  }

  QueryBuilder<ShiftCollection, ShiftCollection, QAfterFilterCondition>
      endMinuteBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'endMinute',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ShiftCollection, ShiftCollection, QAfterFilterCondition>
      graceMinutesEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'graceMinutes',
        value: value,
      ));
    });
  }

  QueryBuilder<ShiftCollection, ShiftCollection, QAfterFilterCondition>
      graceMinutesGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'graceMinutes',
        value: value,
      ));
    });
  }

  QueryBuilder<ShiftCollection, ShiftCollection, QAfterFilterCondition>
      graceMinutesLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'graceMinutes',
        value: value,
      ));
    });
  }

  QueryBuilder<ShiftCollection, ShiftCollection, QAfterFilterCondition>
      graceMinutesBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'graceMinutes',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ShiftCollection, ShiftCollection, QAfterFilterCondition>
      idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<ShiftCollection, ShiftCollection, QAfterFilterCondition>
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

  QueryBuilder<ShiftCollection, ShiftCollection, QAfterFilterCondition>
      idLessThan(
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

  QueryBuilder<ShiftCollection, ShiftCollection, QAfterFilterCondition>
      idBetween(
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

  QueryBuilder<ShiftCollection, ShiftCollection, QAfterFilterCondition>
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

  QueryBuilder<ShiftCollection, ShiftCollection, QAfterFilterCondition>
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

  QueryBuilder<ShiftCollection, ShiftCollection, QAfterFilterCondition>
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

  QueryBuilder<ShiftCollection, ShiftCollection, QAfterFilterCondition>
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

  QueryBuilder<ShiftCollection, ShiftCollection, QAfterFilterCondition>
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

  QueryBuilder<ShiftCollection, ShiftCollection, QAfterFilterCondition>
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

  QueryBuilder<ShiftCollection, ShiftCollection, QAfterFilterCondition>
      nameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ShiftCollection, ShiftCollection, QAfterFilterCondition>
      nameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'name',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ShiftCollection, ShiftCollection, QAfterFilterCondition>
      nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<ShiftCollection, ShiftCollection, QAfterFilterCondition>
      nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<ShiftCollection, ShiftCollection, QAfterFilterCondition>
      startHourEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'startHour',
        value: value,
      ));
    });
  }

  QueryBuilder<ShiftCollection, ShiftCollection, QAfterFilterCondition>
      startHourGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'startHour',
        value: value,
      ));
    });
  }

  QueryBuilder<ShiftCollection, ShiftCollection, QAfterFilterCondition>
      startHourLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'startHour',
        value: value,
      ));
    });
  }

  QueryBuilder<ShiftCollection, ShiftCollection, QAfterFilterCondition>
      startHourBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'startHour',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ShiftCollection, ShiftCollection, QAfterFilterCondition>
      startMinuteEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'startMinute',
        value: value,
      ));
    });
  }

  QueryBuilder<ShiftCollection, ShiftCollection, QAfterFilterCondition>
      startMinuteGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'startMinute',
        value: value,
      ));
    });
  }

  QueryBuilder<ShiftCollection, ShiftCollection, QAfterFilterCondition>
      startMinuteLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'startMinute',
        value: value,
      ));
    });
  }

  QueryBuilder<ShiftCollection, ShiftCollection, QAfterFilterCondition>
      startMinuteBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'startMinute',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ShiftCollection, ShiftCollection, QAfterFilterCondition>
      uuidEqualTo(
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

  QueryBuilder<ShiftCollection, ShiftCollection, QAfterFilterCondition>
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

  QueryBuilder<ShiftCollection, ShiftCollection, QAfterFilterCondition>
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

  QueryBuilder<ShiftCollection, ShiftCollection, QAfterFilterCondition>
      uuidBetween(
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

  QueryBuilder<ShiftCollection, ShiftCollection, QAfterFilterCondition>
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

  QueryBuilder<ShiftCollection, ShiftCollection, QAfterFilterCondition>
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

  QueryBuilder<ShiftCollection, ShiftCollection, QAfterFilterCondition>
      uuidContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'uuid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ShiftCollection, ShiftCollection, QAfterFilterCondition>
      uuidMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'uuid',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ShiftCollection, ShiftCollection, QAfterFilterCondition>
      uuidIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'uuid',
        value: '',
      ));
    });
  }

  QueryBuilder<ShiftCollection, ShiftCollection, QAfterFilterCondition>
      uuidIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'uuid',
        value: '',
      ));
    });
  }
}

extension ShiftCollectionQueryObject
    on QueryBuilder<ShiftCollection, ShiftCollection, QFilterCondition> {}

extension ShiftCollectionQueryLinks
    on QueryBuilder<ShiftCollection, ShiftCollection, QFilterCondition> {}

extension ShiftCollectionQuerySortBy
    on QueryBuilder<ShiftCollection, ShiftCollection, QSortBy> {
  QueryBuilder<ShiftCollection, ShiftCollection, QAfterSortBy> sortByEndHour() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'endHour', Sort.asc);
    });
  }

  QueryBuilder<ShiftCollection, ShiftCollection, QAfterSortBy>
      sortByEndHourDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'endHour', Sort.desc);
    });
  }

  QueryBuilder<ShiftCollection, ShiftCollection, QAfterSortBy>
      sortByEndMinute() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'endMinute', Sort.asc);
    });
  }

  QueryBuilder<ShiftCollection, ShiftCollection, QAfterSortBy>
      sortByEndMinuteDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'endMinute', Sort.desc);
    });
  }

  QueryBuilder<ShiftCollection, ShiftCollection, QAfterSortBy>
      sortByGraceMinutes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'graceMinutes', Sort.asc);
    });
  }

  QueryBuilder<ShiftCollection, ShiftCollection, QAfterSortBy>
      sortByGraceMinutesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'graceMinutes', Sort.desc);
    });
  }

  QueryBuilder<ShiftCollection, ShiftCollection, QAfterSortBy> sortByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<ShiftCollection, ShiftCollection, QAfterSortBy>
      sortByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<ShiftCollection, ShiftCollection, QAfterSortBy>
      sortByStartHour() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'startHour', Sort.asc);
    });
  }

  QueryBuilder<ShiftCollection, ShiftCollection, QAfterSortBy>
      sortByStartHourDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'startHour', Sort.desc);
    });
  }

  QueryBuilder<ShiftCollection, ShiftCollection, QAfterSortBy>
      sortByStartMinute() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'startMinute', Sort.asc);
    });
  }

  QueryBuilder<ShiftCollection, ShiftCollection, QAfterSortBy>
      sortByStartMinuteDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'startMinute', Sort.desc);
    });
  }

  QueryBuilder<ShiftCollection, ShiftCollection, QAfterSortBy> sortByUuid() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uuid', Sort.asc);
    });
  }

  QueryBuilder<ShiftCollection, ShiftCollection, QAfterSortBy>
      sortByUuidDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uuid', Sort.desc);
    });
  }
}

extension ShiftCollectionQuerySortThenBy
    on QueryBuilder<ShiftCollection, ShiftCollection, QSortThenBy> {
  QueryBuilder<ShiftCollection, ShiftCollection, QAfterSortBy> thenByEndHour() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'endHour', Sort.asc);
    });
  }

  QueryBuilder<ShiftCollection, ShiftCollection, QAfterSortBy>
      thenByEndHourDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'endHour', Sort.desc);
    });
  }

  QueryBuilder<ShiftCollection, ShiftCollection, QAfterSortBy>
      thenByEndMinute() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'endMinute', Sort.asc);
    });
  }

  QueryBuilder<ShiftCollection, ShiftCollection, QAfterSortBy>
      thenByEndMinuteDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'endMinute', Sort.desc);
    });
  }

  QueryBuilder<ShiftCollection, ShiftCollection, QAfterSortBy>
      thenByGraceMinutes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'graceMinutes', Sort.asc);
    });
  }

  QueryBuilder<ShiftCollection, ShiftCollection, QAfterSortBy>
      thenByGraceMinutesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'graceMinutes', Sort.desc);
    });
  }

  QueryBuilder<ShiftCollection, ShiftCollection, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<ShiftCollection, ShiftCollection, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<ShiftCollection, ShiftCollection, QAfterSortBy> thenByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<ShiftCollection, ShiftCollection, QAfterSortBy>
      thenByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<ShiftCollection, ShiftCollection, QAfterSortBy>
      thenByStartHour() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'startHour', Sort.asc);
    });
  }

  QueryBuilder<ShiftCollection, ShiftCollection, QAfterSortBy>
      thenByStartHourDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'startHour', Sort.desc);
    });
  }

  QueryBuilder<ShiftCollection, ShiftCollection, QAfterSortBy>
      thenByStartMinute() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'startMinute', Sort.asc);
    });
  }

  QueryBuilder<ShiftCollection, ShiftCollection, QAfterSortBy>
      thenByStartMinuteDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'startMinute', Sort.desc);
    });
  }

  QueryBuilder<ShiftCollection, ShiftCollection, QAfterSortBy> thenByUuid() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uuid', Sort.asc);
    });
  }

  QueryBuilder<ShiftCollection, ShiftCollection, QAfterSortBy>
      thenByUuidDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uuid', Sort.desc);
    });
  }
}

extension ShiftCollectionQueryWhereDistinct
    on QueryBuilder<ShiftCollection, ShiftCollection, QDistinct> {
  QueryBuilder<ShiftCollection, ShiftCollection, QDistinct>
      distinctByEndHour() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'endHour');
    });
  }

  QueryBuilder<ShiftCollection, ShiftCollection, QDistinct>
      distinctByEndMinute() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'endMinute');
    });
  }

  QueryBuilder<ShiftCollection, ShiftCollection, QDistinct>
      distinctByGraceMinutes() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'graceMinutes');
    });
  }

  QueryBuilder<ShiftCollection, ShiftCollection, QDistinct> distinctByName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'name', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ShiftCollection, ShiftCollection, QDistinct>
      distinctByStartHour() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'startHour');
    });
  }

  QueryBuilder<ShiftCollection, ShiftCollection, QDistinct>
      distinctByStartMinute() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'startMinute');
    });
  }

  QueryBuilder<ShiftCollection, ShiftCollection, QDistinct> distinctByUuid(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'uuid', caseSensitive: caseSensitive);
    });
  }
}

extension ShiftCollectionQueryProperty
    on QueryBuilder<ShiftCollection, ShiftCollection, QQueryProperty> {
  QueryBuilder<ShiftCollection, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<ShiftCollection, int, QQueryOperations> endHourProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'endHour');
    });
  }

  QueryBuilder<ShiftCollection, int, QQueryOperations> endMinuteProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'endMinute');
    });
  }

  QueryBuilder<ShiftCollection, int, QQueryOperations> graceMinutesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'graceMinutes');
    });
  }

  QueryBuilder<ShiftCollection, String, QQueryOperations> nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'name');
    });
  }

  QueryBuilder<ShiftCollection, int, QQueryOperations> startHourProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'startHour');
    });
  }

  QueryBuilder<ShiftCollection, int, QQueryOperations> startMinuteProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'startMinute');
    });
  }

  QueryBuilder<ShiftCollection, String, QQueryOperations> uuidProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'uuid');
    });
  }
}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetRecruitmentOpeningCollectionCollection on Isar {
  IsarCollection<RecruitmentOpeningCollection>
      get recruitmentOpeningCollections => this.collection();
}

const RecruitmentOpeningCollectionSchema = CollectionSchema(
  name: r'RecruitmentOpeningCollection',
  id: (9122871485390 * 1000000 + 895045),
  properties: {
    r'closingDate': PropertySchema(
      id: 0,
      name: r'closingDate',
      type: IsarType.dateTime,
    ),
    r'departmentId': PropertySchema(
      id: 1,
      name: r'departmentId',
      type: IsarType.string,
    ),
    r'description': PropertySchema(
      id: 2,
      name: r'description',
      type: IsarType.string,
    ),
    r'jobTitle': PropertySchema(
      id: 3,
      name: r'jobTitle',
      type: IsarType.string,
    ),
    r'postedDate': PropertySchema(
      id: 4,
      name: r'postedDate',
      type: IsarType.dateTime,
    ),
    r'status': PropertySchema(
      id: 5,
      name: r'status',
      type: IsarType.string,
    ),
    r'uuid': PropertySchema(
      id: 6,
      name: r'uuid',
      type: IsarType.string,
    )
  },
  estimateSize: _recruitmentOpeningCollectionEstimateSize,
  serialize: _recruitmentOpeningCollectionSerialize,
  deserialize: _recruitmentOpeningCollectionDeserialize,
  deserializeProp: _recruitmentOpeningCollectionDeserializeProp,
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
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _recruitmentOpeningCollectionGetId,
  getLinks: _recruitmentOpeningCollectionGetLinks,
  attach: _recruitmentOpeningCollectionAttach,
  version: '3.1.0+1',
);

int _recruitmentOpeningCollectionEstimateSize(
  RecruitmentOpeningCollection object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.departmentId.length * 3;
  bytesCount += 3 + object.description.length * 3;
  bytesCount += 3 + object.jobTitle.length * 3;
  bytesCount += 3 + object.status.length * 3;
  bytesCount += 3 + object.uuid.length * 3;
  return bytesCount;
}

void _recruitmentOpeningCollectionSerialize(
  RecruitmentOpeningCollection object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDateTime(offsets[0], object.closingDate);
  writer.writeString(offsets[1], object.departmentId);
  writer.writeString(offsets[2], object.description);
  writer.writeString(offsets[3], object.jobTitle);
  writer.writeDateTime(offsets[4], object.postedDate);
  writer.writeString(offsets[5], object.status);
  writer.writeString(offsets[6], object.uuid);
}

RecruitmentOpeningCollection _recruitmentOpeningCollectionDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = RecruitmentOpeningCollection();
  object.closingDate = reader.readDateTimeOrNull(offsets[0]);
  object.departmentId = reader.readString(offsets[1]);
  object.description = reader.readString(offsets[2]);
  object.id = id;
  object.jobTitle = reader.readString(offsets[3]);
  object.postedDate = reader.readDateTime(offsets[4]);
  object.status = reader.readString(offsets[5]);
  object.uuid = reader.readString(offsets[6]);
  return object;
}

P _recruitmentOpeningCollectionDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 1:
      return (reader.readString(offset)) as P;
    case 2:
      return (reader.readString(offset)) as P;
    case 3:
      return (reader.readString(offset)) as P;
    case 4:
      return (reader.readDateTime(offset)) as P;
    case 5:
      return (reader.readString(offset)) as P;
    case 6:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _recruitmentOpeningCollectionGetId(RecruitmentOpeningCollection object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _recruitmentOpeningCollectionGetLinks(
    RecruitmentOpeningCollection object) {
  return [];
}

void _recruitmentOpeningCollectionAttach(
    IsarCollection<dynamic> col, Id id, RecruitmentOpeningCollection object) {
  object.id = id;
}

extension RecruitmentOpeningCollectionByIndex
    on IsarCollection<RecruitmentOpeningCollection> {
  Future<RecruitmentOpeningCollection?> getByUuid(String uuid) {
    return getByIndex(r'uuid', [uuid]);
  }

  RecruitmentOpeningCollection? getByUuidSync(String uuid) {
    return getByIndexSync(r'uuid', [uuid]);
  }

  Future<bool> deleteByUuid(String uuid) {
    return deleteByIndex(r'uuid', [uuid]);
  }

  bool deleteByUuidSync(String uuid) {
    return deleteByIndexSync(r'uuid', [uuid]);
  }

  Future<List<RecruitmentOpeningCollection?>> getAllByUuid(
      List<String> uuidValues) {
    final values = uuidValues.map((e) => [e]).toList();
    return getAllByIndex(r'uuid', values);
  }

  List<RecruitmentOpeningCollection?> getAllByUuidSync(
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

  Future<Id> putByUuid(RecruitmentOpeningCollection object) {
    return putByIndex(r'uuid', object);
  }

  Id putByUuidSync(RecruitmentOpeningCollection object,
      {bool saveLinks = true}) {
    return putByIndexSync(r'uuid', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByUuid(List<RecruitmentOpeningCollection> objects) {
    return putAllByIndex(r'uuid', objects);
  }

  List<Id> putAllByUuidSync(List<RecruitmentOpeningCollection> objects,
      {bool saveLinks = true}) {
    return putAllByIndexSync(r'uuid', objects, saveLinks: saveLinks);
  }
}

extension RecruitmentOpeningCollectionQueryWhereSort on QueryBuilder<
    RecruitmentOpeningCollection, RecruitmentOpeningCollection, QWhere> {
  QueryBuilder<RecruitmentOpeningCollection, RecruitmentOpeningCollection,
      QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension RecruitmentOpeningCollectionQueryWhere on QueryBuilder<
    RecruitmentOpeningCollection, RecruitmentOpeningCollection, QWhereClause> {
  QueryBuilder<RecruitmentOpeningCollection, RecruitmentOpeningCollection,
      QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<RecruitmentOpeningCollection, RecruitmentOpeningCollection,
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

  QueryBuilder<RecruitmentOpeningCollection, RecruitmentOpeningCollection,
      QAfterWhereClause> idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<RecruitmentOpeningCollection, RecruitmentOpeningCollection,
      QAfterWhereClause> idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<RecruitmentOpeningCollection, RecruitmentOpeningCollection,
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

  QueryBuilder<RecruitmentOpeningCollection, RecruitmentOpeningCollection,
      QAfterWhereClause> uuidEqualTo(String uuid) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'uuid',
        value: [uuid],
      ));
    });
  }

  QueryBuilder<RecruitmentOpeningCollection, RecruitmentOpeningCollection,
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
}

extension RecruitmentOpeningCollectionQueryFilter on QueryBuilder<
    RecruitmentOpeningCollection,
    RecruitmentOpeningCollection,
    QFilterCondition> {
  QueryBuilder<RecruitmentOpeningCollection, RecruitmentOpeningCollection,
      QAfterFilterCondition> closingDateIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'closingDate',
      ));
    });
  }

  QueryBuilder<RecruitmentOpeningCollection, RecruitmentOpeningCollection,
      QAfterFilterCondition> closingDateIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'closingDate',
      ));
    });
  }

  QueryBuilder<RecruitmentOpeningCollection, RecruitmentOpeningCollection,
      QAfterFilterCondition> closingDateEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'closingDate',
        value: value,
      ));
    });
  }

  QueryBuilder<RecruitmentOpeningCollection, RecruitmentOpeningCollection,
      QAfterFilterCondition> closingDateGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'closingDate',
        value: value,
      ));
    });
  }

  QueryBuilder<RecruitmentOpeningCollection, RecruitmentOpeningCollection,
      QAfterFilterCondition> closingDateLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'closingDate',
        value: value,
      ));
    });
  }

  QueryBuilder<RecruitmentOpeningCollection, RecruitmentOpeningCollection,
      QAfterFilterCondition> closingDateBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'closingDate',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<RecruitmentOpeningCollection, RecruitmentOpeningCollection,
      QAfterFilterCondition> departmentIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'departmentId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecruitmentOpeningCollection, RecruitmentOpeningCollection,
      QAfterFilterCondition> departmentIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'departmentId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecruitmentOpeningCollection, RecruitmentOpeningCollection,
      QAfterFilterCondition> departmentIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'departmentId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecruitmentOpeningCollection, RecruitmentOpeningCollection,
      QAfterFilterCondition> departmentIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'departmentId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecruitmentOpeningCollection, RecruitmentOpeningCollection,
      QAfterFilterCondition> departmentIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'departmentId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecruitmentOpeningCollection, RecruitmentOpeningCollection,
      QAfterFilterCondition> departmentIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'departmentId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecruitmentOpeningCollection, RecruitmentOpeningCollection,
          QAfterFilterCondition>
      departmentIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'departmentId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecruitmentOpeningCollection, RecruitmentOpeningCollection,
          QAfterFilterCondition>
      departmentIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'departmentId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecruitmentOpeningCollection, RecruitmentOpeningCollection,
      QAfterFilterCondition> departmentIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'departmentId',
        value: '',
      ));
    });
  }

  QueryBuilder<RecruitmentOpeningCollection, RecruitmentOpeningCollection,
      QAfterFilterCondition> departmentIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'departmentId',
        value: '',
      ));
    });
  }

  QueryBuilder<RecruitmentOpeningCollection, RecruitmentOpeningCollection,
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

  QueryBuilder<RecruitmentOpeningCollection, RecruitmentOpeningCollection,
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

  QueryBuilder<RecruitmentOpeningCollection, RecruitmentOpeningCollection,
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

  QueryBuilder<RecruitmentOpeningCollection, RecruitmentOpeningCollection,
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

  QueryBuilder<RecruitmentOpeningCollection, RecruitmentOpeningCollection,
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

  QueryBuilder<RecruitmentOpeningCollection, RecruitmentOpeningCollection,
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

  QueryBuilder<RecruitmentOpeningCollection, RecruitmentOpeningCollection,
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

  QueryBuilder<RecruitmentOpeningCollection, RecruitmentOpeningCollection,
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

  QueryBuilder<RecruitmentOpeningCollection, RecruitmentOpeningCollection,
      QAfterFilterCondition> descriptionIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'description',
        value: '',
      ));
    });
  }

  QueryBuilder<RecruitmentOpeningCollection, RecruitmentOpeningCollection,
      QAfterFilterCondition> descriptionIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'description',
        value: '',
      ));
    });
  }

  QueryBuilder<RecruitmentOpeningCollection, RecruitmentOpeningCollection,
      QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<RecruitmentOpeningCollection, RecruitmentOpeningCollection,
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

  QueryBuilder<RecruitmentOpeningCollection, RecruitmentOpeningCollection,
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

  QueryBuilder<RecruitmentOpeningCollection, RecruitmentOpeningCollection,
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

  QueryBuilder<RecruitmentOpeningCollection, RecruitmentOpeningCollection,
      QAfterFilterCondition> jobTitleEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'jobTitle',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecruitmentOpeningCollection, RecruitmentOpeningCollection,
      QAfterFilterCondition> jobTitleGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'jobTitle',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecruitmentOpeningCollection, RecruitmentOpeningCollection,
      QAfterFilterCondition> jobTitleLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'jobTitle',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecruitmentOpeningCollection, RecruitmentOpeningCollection,
      QAfterFilterCondition> jobTitleBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'jobTitle',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecruitmentOpeningCollection, RecruitmentOpeningCollection,
      QAfterFilterCondition> jobTitleStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'jobTitle',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecruitmentOpeningCollection, RecruitmentOpeningCollection,
      QAfterFilterCondition> jobTitleEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'jobTitle',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecruitmentOpeningCollection, RecruitmentOpeningCollection,
          QAfterFilterCondition>
      jobTitleContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'jobTitle',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecruitmentOpeningCollection, RecruitmentOpeningCollection,
          QAfterFilterCondition>
      jobTitleMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'jobTitle',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecruitmentOpeningCollection, RecruitmentOpeningCollection,
      QAfterFilterCondition> jobTitleIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'jobTitle',
        value: '',
      ));
    });
  }

  QueryBuilder<RecruitmentOpeningCollection, RecruitmentOpeningCollection,
      QAfterFilterCondition> jobTitleIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'jobTitle',
        value: '',
      ));
    });
  }

  QueryBuilder<RecruitmentOpeningCollection, RecruitmentOpeningCollection,
      QAfterFilterCondition> postedDateEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'postedDate',
        value: value,
      ));
    });
  }

  QueryBuilder<RecruitmentOpeningCollection, RecruitmentOpeningCollection,
      QAfterFilterCondition> postedDateGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'postedDate',
        value: value,
      ));
    });
  }

  QueryBuilder<RecruitmentOpeningCollection, RecruitmentOpeningCollection,
      QAfterFilterCondition> postedDateLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'postedDate',
        value: value,
      ));
    });
  }

  QueryBuilder<RecruitmentOpeningCollection, RecruitmentOpeningCollection,
      QAfterFilterCondition> postedDateBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'postedDate',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<RecruitmentOpeningCollection, RecruitmentOpeningCollection,
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

  QueryBuilder<RecruitmentOpeningCollection, RecruitmentOpeningCollection,
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

  QueryBuilder<RecruitmentOpeningCollection, RecruitmentOpeningCollection,
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

  QueryBuilder<RecruitmentOpeningCollection, RecruitmentOpeningCollection,
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

  QueryBuilder<RecruitmentOpeningCollection, RecruitmentOpeningCollection,
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

  QueryBuilder<RecruitmentOpeningCollection, RecruitmentOpeningCollection,
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

  QueryBuilder<RecruitmentOpeningCollection, RecruitmentOpeningCollection,
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

  QueryBuilder<RecruitmentOpeningCollection, RecruitmentOpeningCollection,
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

  QueryBuilder<RecruitmentOpeningCollection, RecruitmentOpeningCollection,
      QAfterFilterCondition> statusIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'status',
        value: '',
      ));
    });
  }

  QueryBuilder<RecruitmentOpeningCollection, RecruitmentOpeningCollection,
      QAfterFilterCondition> statusIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'status',
        value: '',
      ));
    });
  }

  QueryBuilder<RecruitmentOpeningCollection, RecruitmentOpeningCollection,
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

  QueryBuilder<RecruitmentOpeningCollection, RecruitmentOpeningCollection,
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

  QueryBuilder<RecruitmentOpeningCollection, RecruitmentOpeningCollection,
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

  QueryBuilder<RecruitmentOpeningCollection, RecruitmentOpeningCollection,
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

  QueryBuilder<RecruitmentOpeningCollection, RecruitmentOpeningCollection,
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

  QueryBuilder<RecruitmentOpeningCollection, RecruitmentOpeningCollection,
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

  QueryBuilder<RecruitmentOpeningCollection, RecruitmentOpeningCollection,
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

  QueryBuilder<RecruitmentOpeningCollection, RecruitmentOpeningCollection,
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

  QueryBuilder<RecruitmentOpeningCollection, RecruitmentOpeningCollection,
      QAfterFilterCondition> uuidIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'uuid',
        value: '',
      ));
    });
  }

  QueryBuilder<RecruitmentOpeningCollection, RecruitmentOpeningCollection,
      QAfterFilterCondition> uuidIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'uuid',
        value: '',
      ));
    });
  }
}

extension RecruitmentOpeningCollectionQueryObject on QueryBuilder<
    RecruitmentOpeningCollection,
    RecruitmentOpeningCollection,
    QFilterCondition> {}

extension RecruitmentOpeningCollectionQueryLinks on QueryBuilder<
    RecruitmentOpeningCollection,
    RecruitmentOpeningCollection,
    QFilterCondition> {}

extension RecruitmentOpeningCollectionQuerySortBy on QueryBuilder<
    RecruitmentOpeningCollection, RecruitmentOpeningCollection, QSortBy> {
  QueryBuilder<RecruitmentOpeningCollection, RecruitmentOpeningCollection,
      QAfterSortBy> sortByClosingDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'closingDate', Sort.asc);
    });
  }

  QueryBuilder<RecruitmentOpeningCollection, RecruitmentOpeningCollection,
      QAfterSortBy> sortByClosingDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'closingDate', Sort.desc);
    });
  }

  QueryBuilder<RecruitmentOpeningCollection, RecruitmentOpeningCollection,
      QAfterSortBy> sortByDepartmentId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'departmentId', Sort.asc);
    });
  }

  QueryBuilder<RecruitmentOpeningCollection, RecruitmentOpeningCollection,
      QAfterSortBy> sortByDepartmentIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'departmentId', Sort.desc);
    });
  }

  QueryBuilder<RecruitmentOpeningCollection, RecruitmentOpeningCollection,
      QAfterSortBy> sortByDescription() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.asc);
    });
  }

  QueryBuilder<RecruitmentOpeningCollection, RecruitmentOpeningCollection,
      QAfterSortBy> sortByDescriptionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.desc);
    });
  }

  QueryBuilder<RecruitmentOpeningCollection, RecruitmentOpeningCollection,
      QAfterSortBy> sortByJobTitle() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'jobTitle', Sort.asc);
    });
  }

  QueryBuilder<RecruitmentOpeningCollection, RecruitmentOpeningCollection,
      QAfterSortBy> sortByJobTitleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'jobTitle', Sort.desc);
    });
  }

  QueryBuilder<RecruitmentOpeningCollection, RecruitmentOpeningCollection,
      QAfterSortBy> sortByPostedDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'postedDate', Sort.asc);
    });
  }

  QueryBuilder<RecruitmentOpeningCollection, RecruitmentOpeningCollection,
      QAfterSortBy> sortByPostedDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'postedDate', Sort.desc);
    });
  }

  QueryBuilder<RecruitmentOpeningCollection, RecruitmentOpeningCollection,
      QAfterSortBy> sortByStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.asc);
    });
  }

  QueryBuilder<RecruitmentOpeningCollection, RecruitmentOpeningCollection,
      QAfterSortBy> sortByStatusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.desc);
    });
  }

  QueryBuilder<RecruitmentOpeningCollection, RecruitmentOpeningCollection,
      QAfterSortBy> sortByUuid() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uuid', Sort.asc);
    });
  }

  QueryBuilder<RecruitmentOpeningCollection, RecruitmentOpeningCollection,
      QAfterSortBy> sortByUuidDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uuid', Sort.desc);
    });
  }
}

extension RecruitmentOpeningCollectionQuerySortThenBy on QueryBuilder<
    RecruitmentOpeningCollection, RecruitmentOpeningCollection, QSortThenBy> {
  QueryBuilder<RecruitmentOpeningCollection, RecruitmentOpeningCollection,
      QAfterSortBy> thenByClosingDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'closingDate', Sort.asc);
    });
  }

  QueryBuilder<RecruitmentOpeningCollection, RecruitmentOpeningCollection,
      QAfterSortBy> thenByClosingDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'closingDate', Sort.desc);
    });
  }

  QueryBuilder<RecruitmentOpeningCollection, RecruitmentOpeningCollection,
      QAfterSortBy> thenByDepartmentId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'departmentId', Sort.asc);
    });
  }

  QueryBuilder<RecruitmentOpeningCollection, RecruitmentOpeningCollection,
      QAfterSortBy> thenByDepartmentIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'departmentId', Sort.desc);
    });
  }

  QueryBuilder<RecruitmentOpeningCollection, RecruitmentOpeningCollection,
      QAfterSortBy> thenByDescription() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.asc);
    });
  }

  QueryBuilder<RecruitmentOpeningCollection, RecruitmentOpeningCollection,
      QAfterSortBy> thenByDescriptionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.desc);
    });
  }

  QueryBuilder<RecruitmentOpeningCollection, RecruitmentOpeningCollection,
      QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<RecruitmentOpeningCollection, RecruitmentOpeningCollection,
      QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<RecruitmentOpeningCollection, RecruitmentOpeningCollection,
      QAfterSortBy> thenByJobTitle() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'jobTitle', Sort.asc);
    });
  }

  QueryBuilder<RecruitmentOpeningCollection, RecruitmentOpeningCollection,
      QAfterSortBy> thenByJobTitleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'jobTitle', Sort.desc);
    });
  }

  QueryBuilder<RecruitmentOpeningCollection, RecruitmentOpeningCollection,
      QAfterSortBy> thenByPostedDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'postedDate', Sort.asc);
    });
  }

  QueryBuilder<RecruitmentOpeningCollection, RecruitmentOpeningCollection,
      QAfterSortBy> thenByPostedDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'postedDate', Sort.desc);
    });
  }

  QueryBuilder<RecruitmentOpeningCollection, RecruitmentOpeningCollection,
      QAfterSortBy> thenByStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.asc);
    });
  }

  QueryBuilder<RecruitmentOpeningCollection, RecruitmentOpeningCollection,
      QAfterSortBy> thenByStatusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.desc);
    });
  }

  QueryBuilder<RecruitmentOpeningCollection, RecruitmentOpeningCollection,
      QAfterSortBy> thenByUuid() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uuid', Sort.asc);
    });
  }

  QueryBuilder<RecruitmentOpeningCollection, RecruitmentOpeningCollection,
      QAfterSortBy> thenByUuidDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uuid', Sort.desc);
    });
  }
}

extension RecruitmentOpeningCollectionQueryWhereDistinct on QueryBuilder<
    RecruitmentOpeningCollection, RecruitmentOpeningCollection, QDistinct> {
  QueryBuilder<RecruitmentOpeningCollection, RecruitmentOpeningCollection,
      QDistinct> distinctByClosingDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'closingDate');
    });
  }

  QueryBuilder<RecruitmentOpeningCollection, RecruitmentOpeningCollection,
      QDistinct> distinctByDepartmentId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'departmentId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<RecruitmentOpeningCollection, RecruitmentOpeningCollection,
      QDistinct> distinctByDescription({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'description', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<RecruitmentOpeningCollection, RecruitmentOpeningCollection,
      QDistinct> distinctByJobTitle({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'jobTitle', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<RecruitmentOpeningCollection, RecruitmentOpeningCollection,
      QDistinct> distinctByPostedDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'postedDate');
    });
  }

  QueryBuilder<RecruitmentOpeningCollection, RecruitmentOpeningCollection,
      QDistinct> distinctByStatus({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'status', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<RecruitmentOpeningCollection, RecruitmentOpeningCollection,
      QDistinct> distinctByUuid({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'uuid', caseSensitive: caseSensitive);
    });
  }
}

extension RecruitmentOpeningCollectionQueryProperty on QueryBuilder<
    RecruitmentOpeningCollection,
    RecruitmentOpeningCollection,
    QQueryProperty> {
  QueryBuilder<RecruitmentOpeningCollection, int, QQueryOperations>
      idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<RecruitmentOpeningCollection, DateTime?, QQueryOperations>
      closingDateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'closingDate');
    });
  }

  QueryBuilder<RecruitmentOpeningCollection, String, QQueryOperations>
      departmentIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'departmentId');
    });
  }

  QueryBuilder<RecruitmentOpeningCollection, String, QQueryOperations>
      descriptionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'description');
    });
  }

  QueryBuilder<RecruitmentOpeningCollection, String, QQueryOperations>
      jobTitleProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'jobTitle');
    });
  }

  QueryBuilder<RecruitmentOpeningCollection, DateTime, QQueryOperations>
      postedDateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'postedDate');
    });
  }

  QueryBuilder<RecruitmentOpeningCollection, String, QQueryOperations>
      statusProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'status');
    });
  }

  QueryBuilder<RecruitmentOpeningCollection, String, QQueryOperations>
      uuidProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'uuid');
    });
  }
}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetRecruitmentCandidateCollectionCollection on Isar {
  IsarCollection<RecruitmentCandidateCollection>
      get recruitmentCandidateCollections => this.collection();
}

const RecruitmentCandidateCollectionSchema = CollectionSchema(
  name: r'RecruitmentCandidateCollection',
  id: -(44988395201 * 1000000 + 935273),
  properties: {
    r'email': PropertySchema(
      id: 0,
      name: r'email',
      type: IsarType.string,
    ),
    r'firstName': PropertySchema(
      id: 1,
      name: r'firstName',
      type: IsarType.string,
    ),
    r'lastName': PropertySchema(
      id: 2,
      name: r'lastName',
      type: IsarType.string,
    ),
    r'openingId': PropertySchema(
      id: 3,
      name: r'openingId',
      type: IsarType.string,
    ),
    r'phone': PropertySchema(
      id: 4,
      name: r'phone',
      type: IsarType.string,
    ),
    r'resumeUrl': PropertySchema(
      id: 5,
      name: r'resumeUrl',
      type: IsarType.string,
    ),
    r'score': PropertySchema(
      id: 6,
      name: r'score',
      type: IsarType.double,
    ),
    r'status': PropertySchema(
      id: 7,
      name: r'status',
      type: IsarType.string,
    ),
    r'uuid': PropertySchema(
      id: 8,
      name: r'uuid',
      type: IsarType.string,
    )
  },
  estimateSize: _recruitmentCandidateCollectionEstimateSize,
  serialize: _recruitmentCandidateCollectionSerialize,
  deserialize: _recruitmentCandidateCollectionDeserialize,
  deserializeProp: _recruitmentCandidateCollectionDeserializeProp,
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
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _recruitmentCandidateCollectionGetId,
  getLinks: _recruitmentCandidateCollectionGetLinks,
  attach: _recruitmentCandidateCollectionAttach,
  version: '3.1.0+1',
);

int _recruitmentCandidateCollectionEstimateSize(
  RecruitmentCandidateCollection object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.email.length * 3;
  bytesCount += 3 + object.firstName.length * 3;
  bytesCount += 3 + object.lastName.length * 3;
  bytesCount += 3 + object.openingId.length * 3;
  bytesCount += 3 + object.phone.length * 3;
  {
    final value = object.resumeUrl;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.status.length * 3;
  bytesCount += 3 + object.uuid.length * 3;
  return bytesCount;
}

void _recruitmentCandidateCollectionSerialize(
  RecruitmentCandidateCollection object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.email);
  writer.writeString(offsets[1], object.firstName);
  writer.writeString(offsets[2], object.lastName);
  writer.writeString(offsets[3], object.openingId);
  writer.writeString(offsets[4], object.phone);
  writer.writeString(offsets[5], object.resumeUrl);
  writer.writeDouble(offsets[6], object.score);
  writer.writeString(offsets[7], object.status);
  writer.writeString(offsets[8], object.uuid);
}

RecruitmentCandidateCollection _recruitmentCandidateCollectionDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = RecruitmentCandidateCollection();
  object.email = reader.readString(offsets[0]);
  object.firstName = reader.readString(offsets[1]);
  object.id = id;
  object.lastName = reader.readString(offsets[2]);
  object.openingId = reader.readString(offsets[3]);
  object.phone = reader.readString(offsets[4]);
  object.resumeUrl = reader.readStringOrNull(offsets[5]);
  object.score = reader.readDouble(offsets[6]);
  object.status = reader.readString(offsets[7]);
  object.uuid = reader.readString(offsets[8]);
  return object;
}

P _recruitmentCandidateCollectionDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readString(offset)) as P;
    case 2:
      return (reader.readString(offset)) as P;
    case 3:
      return (reader.readString(offset)) as P;
    case 4:
      return (reader.readString(offset)) as P;
    case 5:
      return (reader.readStringOrNull(offset)) as P;
    case 6:
      return (reader.readDouble(offset)) as P;
    case 7:
      return (reader.readString(offset)) as P;
    case 8:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _recruitmentCandidateCollectionGetId(RecruitmentCandidateCollection object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _recruitmentCandidateCollectionGetLinks(
    RecruitmentCandidateCollection object) {
  return [];
}

void _recruitmentCandidateCollectionAttach(
    IsarCollection<dynamic> col, Id id, RecruitmentCandidateCollection object) {
  object.id = id;
}

extension RecruitmentCandidateCollectionByIndex
    on IsarCollection<RecruitmentCandidateCollection> {
  Future<RecruitmentCandidateCollection?> getByUuid(String uuid) {
    return getByIndex(r'uuid', [uuid]);
  }

  RecruitmentCandidateCollection? getByUuidSync(String uuid) {
    return getByIndexSync(r'uuid', [uuid]);
  }

  Future<bool> deleteByUuid(String uuid) {
    return deleteByIndex(r'uuid', [uuid]);
  }

  bool deleteByUuidSync(String uuid) {
    return deleteByIndexSync(r'uuid', [uuid]);
  }

  Future<List<RecruitmentCandidateCollection?>> getAllByUuid(
      List<String> uuidValues) {
    final values = uuidValues.map((e) => [e]).toList();
    return getAllByIndex(r'uuid', values);
  }

  List<RecruitmentCandidateCollection?> getAllByUuidSync(
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

  Future<Id> putByUuid(RecruitmentCandidateCollection object) {
    return putByIndex(r'uuid', object);
  }

  Id putByUuidSync(RecruitmentCandidateCollection object,
      {bool saveLinks = true}) {
    return putByIndexSync(r'uuid', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByUuid(List<RecruitmentCandidateCollection> objects) {
    return putAllByIndex(r'uuid', objects);
  }

  List<Id> putAllByUuidSync(List<RecruitmentCandidateCollection> objects,
      {bool saveLinks = true}) {
    return putAllByIndexSync(r'uuid', objects, saveLinks: saveLinks);
  }
}

extension RecruitmentCandidateCollectionQueryWhereSort on QueryBuilder<
    RecruitmentCandidateCollection, RecruitmentCandidateCollection, QWhere> {
  QueryBuilder<RecruitmentCandidateCollection, RecruitmentCandidateCollection,
      QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension RecruitmentCandidateCollectionQueryWhere on QueryBuilder<
    RecruitmentCandidateCollection,
    RecruitmentCandidateCollection,
    QWhereClause> {
  QueryBuilder<RecruitmentCandidateCollection, RecruitmentCandidateCollection,
      QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<RecruitmentCandidateCollection, RecruitmentCandidateCollection,
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

  QueryBuilder<RecruitmentCandidateCollection, RecruitmentCandidateCollection,
      QAfterWhereClause> idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<RecruitmentCandidateCollection, RecruitmentCandidateCollection,
      QAfterWhereClause> idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<RecruitmentCandidateCollection, RecruitmentCandidateCollection,
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

  QueryBuilder<RecruitmentCandidateCollection, RecruitmentCandidateCollection,
      QAfterWhereClause> uuidEqualTo(String uuid) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'uuid',
        value: [uuid],
      ));
    });
  }

  QueryBuilder<RecruitmentCandidateCollection, RecruitmentCandidateCollection,
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
}

extension RecruitmentCandidateCollectionQueryFilter on QueryBuilder<
    RecruitmentCandidateCollection,
    RecruitmentCandidateCollection,
    QFilterCondition> {
  QueryBuilder<RecruitmentCandidateCollection, RecruitmentCandidateCollection,
      QAfterFilterCondition> emailEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'email',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecruitmentCandidateCollection, RecruitmentCandidateCollection,
      QAfterFilterCondition> emailGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'email',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecruitmentCandidateCollection, RecruitmentCandidateCollection,
      QAfterFilterCondition> emailLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'email',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecruitmentCandidateCollection, RecruitmentCandidateCollection,
      QAfterFilterCondition> emailBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'email',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecruitmentCandidateCollection, RecruitmentCandidateCollection,
      QAfterFilterCondition> emailStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'email',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecruitmentCandidateCollection, RecruitmentCandidateCollection,
      QAfterFilterCondition> emailEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'email',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecruitmentCandidateCollection, RecruitmentCandidateCollection,
          QAfterFilterCondition>
      emailContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'email',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecruitmentCandidateCollection, RecruitmentCandidateCollection,
          QAfterFilterCondition>
      emailMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'email',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecruitmentCandidateCollection, RecruitmentCandidateCollection,
      QAfterFilterCondition> emailIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'email',
        value: '',
      ));
    });
  }

  QueryBuilder<RecruitmentCandidateCollection, RecruitmentCandidateCollection,
      QAfterFilterCondition> emailIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'email',
        value: '',
      ));
    });
  }

  QueryBuilder<RecruitmentCandidateCollection, RecruitmentCandidateCollection,
      QAfterFilterCondition> firstNameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'firstName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecruitmentCandidateCollection, RecruitmentCandidateCollection,
      QAfterFilterCondition> firstNameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'firstName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecruitmentCandidateCollection, RecruitmentCandidateCollection,
      QAfterFilterCondition> firstNameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'firstName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecruitmentCandidateCollection, RecruitmentCandidateCollection,
      QAfterFilterCondition> firstNameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'firstName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecruitmentCandidateCollection, RecruitmentCandidateCollection,
      QAfterFilterCondition> firstNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'firstName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecruitmentCandidateCollection, RecruitmentCandidateCollection,
      QAfterFilterCondition> firstNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'firstName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecruitmentCandidateCollection, RecruitmentCandidateCollection,
          QAfterFilterCondition>
      firstNameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'firstName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecruitmentCandidateCollection, RecruitmentCandidateCollection,
          QAfterFilterCondition>
      firstNameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'firstName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecruitmentCandidateCollection, RecruitmentCandidateCollection,
      QAfterFilterCondition> firstNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'firstName',
        value: '',
      ));
    });
  }

  QueryBuilder<RecruitmentCandidateCollection, RecruitmentCandidateCollection,
      QAfterFilterCondition> firstNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'firstName',
        value: '',
      ));
    });
  }

  QueryBuilder<RecruitmentCandidateCollection, RecruitmentCandidateCollection,
      QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<RecruitmentCandidateCollection, RecruitmentCandidateCollection,
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

  QueryBuilder<RecruitmentCandidateCollection, RecruitmentCandidateCollection,
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

  QueryBuilder<RecruitmentCandidateCollection, RecruitmentCandidateCollection,
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

  QueryBuilder<RecruitmentCandidateCollection, RecruitmentCandidateCollection,
      QAfterFilterCondition> lastNameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lastName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecruitmentCandidateCollection, RecruitmentCandidateCollection,
      QAfterFilterCondition> lastNameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'lastName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecruitmentCandidateCollection, RecruitmentCandidateCollection,
      QAfterFilterCondition> lastNameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'lastName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecruitmentCandidateCollection, RecruitmentCandidateCollection,
      QAfterFilterCondition> lastNameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'lastName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecruitmentCandidateCollection, RecruitmentCandidateCollection,
      QAfterFilterCondition> lastNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'lastName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecruitmentCandidateCollection, RecruitmentCandidateCollection,
      QAfterFilterCondition> lastNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'lastName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecruitmentCandidateCollection, RecruitmentCandidateCollection,
          QAfterFilterCondition>
      lastNameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'lastName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecruitmentCandidateCollection, RecruitmentCandidateCollection,
          QAfterFilterCondition>
      lastNameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'lastName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecruitmentCandidateCollection, RecruitmentCandidateCollection,
      QAfterFilterCondition> lastNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lastName',
        value: '',
      ));
    });
  }

  QueryBuilder<RecruitmentCandidateCollection, RecruitmentCandidateCollection,
      QAfterFilterCondition> lastNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'lastName',
        value: '',
      ));
    });
  }

  QueryBuilder<RecruitmentCandidateCollection, RecruitmentCandidateCollection,
      QAfterFilterCondition> openingIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'openingId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecruitmentCandidateCollection, RecruitmentCandidateCollection,
      QAfterFilterCondition> openingIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'openingId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecruitmentCandidateCollection, RecruitmentCandidateCollection,
      QAfterFilterCondition> openingIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'openingId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecruitmentCandidateCollection, RecruitmentCandidateCollection,
      QAfterFilterCondition> openingIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'openingId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecruitmentCandidateCollection, RecruitmentCandidateCollection,
      QAfterFilterCondition> openingIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'openingId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecruitmentCandidateCollection, RecruitmentCandidateCollection,
      QAfterFilterCondition> openingIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'openingId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecruitmentCandidateCollection, RecruitmentCandidateCollection,
          QAfterFilterCondition>
      openingIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'openingId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecruitmentCandidateCollection, RecruitmentCandidateCollection,
          QAfterFilterCondition>
      openingIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'openingId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecruitmentCandidateCollection, RecruitmentCandidateCollection,
      QAfterFilterCondition> openingIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'openingId',
        value: '',
      ));
    });
  }

  QueryBuilder<RecruitmentCandidateCollection, RecruitmentCandidateCollection,
      QAfterFilterCondition> openingIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'openingId',
        value: '',
      ));
    });
  }

  QueryBuilder<RecruitmentCandidateCollection, RecruitmentCandidateCollection,
      QAfterFilterCondition> phoneEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'phone',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecruitmentCandidateCollection, RecruitmentCandidateCollection,
      QAfterFilterCondition> phoneGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'phone',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecruitmentCandidateCollection, RecruitmentCandidateCollection,
      QAfterFilterCondition> phoneLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'phone',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecruitmentCandidateCollection, RecruitmentCandidateCollection,
      QAfterFilterCondition> phoneBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'phone',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecruitmentCandidateCollection, RecruitmentCandidateCollection,
      QAfterFilterCondition> phoneStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'phone',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecruitmentCandidateCollection, RecruitmentCandidateCollection,
      QAfterFilterCondition> phoneEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'phone',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecruitmentCandidateCollection, RecruitmentCandidateCollection,
          QAfterFilterCondition>
      phoneContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'phone',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecruitmentCandidateCollection, RecruitmentCandidateCollection,
          QAfterFilterCondition>
      phoneMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'phone',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecruitmentCandidateCollection, RecruitmentCandidateCollection,
      QAfterFilterCondition> phoneIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'phone',
        value: '',
      ));
    });
  }

  QueryBuilder<RecruitmentCandidateCollection, RecruitmentCandidateCollection,
      QAfterFilterCondition> phoneIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'phone',
        value: '',
      ));
    });
  }

  QueryBuilder<RecruitmentCandidateCollection, RecruitmentCandidateCollection,
      QAfterFilterCondition> resumeUrlIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'resumeUrl',
      ));
    });
  }

  QueryBuilder<RecruitmentCandidateCollection, RecruitmentCandidateCollection,
      QAfterFilterCondition> resumeUrlIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'resumeUrl',
      ));
    });
  }

  QueryBuilder<RecruitmentCandidateCollection, RecruitmentCandidateCollection,
      QAfterFilterCondition> resumeUrlEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'resumeUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecruitmentCandidateCollection, RecruitmentCandidateCollection,
      QAfterFilterCondition> resumeUrlGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'resumeUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecruitmentCandidateCollection, RecruitmentCandidateCollection,
      QAfterFilterCondition> resumeUrlLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'resumeUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecruitmentCandidateCollection, RecruitmentCandidateCollection,
      QAfterFilterCondition> resumeUrlBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'resumeUrl',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecruitmentCandidateCollection, RecruitmentCandidateCollection,
      QAfterFilterCondition> resumeUrlStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'resumeUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecruitmentCandidateCollection, RecruitmentCandidateCollection,
      QAfterFilterCondition> resumeUrlEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'resumeUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecruitmentCandidateCollection, RecruitmentCandidateCollection,
          QAfterFilterCondition>
      resumeUrlContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'resumeUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecruitmentCandidateCollection, RecruitmentCandidateCollection,
          QAfterFilterCondition>
      resumeUrlMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'resumeUrl',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecruitmentCandidateCollection, RecruitmentCandidateCollection,
      QAfterFilterCondition> resumeUrlIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'resumeUrl',
        value: '',
      ));
    });
  }

  QueryBuilder<RecruitmentCandidateCollection, RecruitmentCandidateCollection,
      QAfterFilterCondition> resumeUrlIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'resumeUrl',
        value: '',
      ));
    });
  }

  QueryBuilder<RecruitmentCandidateCollection, RecruitmentCandidateCollection,
      QAfterFilterCondition> scoreEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'score',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<RecruitmentCandidateCollection, RecruitmentCandidateCollection,
      QAfterFilterCondition> scoreGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'score',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<RecruitmentCandidateCollection, RecruitmentCandidateCollection,
      QAfterFilterCondition> scoreLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'score',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<RecruitmentCandidateCollection, RecruitmentCandidateCollection,
      QAfterFilterCondition> scoreBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'score',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<RecruitmentCandidateCollection, RecruitmentCandidateCollection,
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

  QueryBuilder<RecruitmentCandidateCollection, RecruitmentCandidateCollection,
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

  QueryBuilder<RecruitmentCandidateCollection, RecruitmentCandidateCollection,
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

  QueryBuilder<RecruitmentCandidateCollection, RecruitmentCandidateCollection,
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

  QueryBuilder<RecruitmentCandidateCollection, RecruitmentCandidateCollection,
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

  QueryBuilder<RecruitmentCandidateCollection, RecruitmentCandidateCollection,
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

  QueryBuilder<RecruitmentCandidateCollection, RecruitmentCandidateCollection,
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

  QueryBuilder<RecruitmentCandidateCollection, RecruitmentCandidateCollection,
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

  QueryBuilder<RecruitmentCandidateCollection, RecruitmentCandidateCollection,
      QAfterFilterCondition> statusIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'status',
        value: '',
      ));
    });
  }

  QueryBuilder<RecruitmentCandidateCollection, RecruitmentCandidateCollection,
      QAfterFilterCondition> statusIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'status',
        value: '',
      ));
    });
  }

  QueryBuilder<RecruitmentCandidateCollection, RecruitmentCandidateCollection,
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

  QueryBuilder<RecruitmentCandidateCollection, RecruitmentCandidateCollection,
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

  QueryBuilder<RecruitmentCandidateCollection, RecruitmentCandidateCollection,
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

  QueryBuilder<RecruitmentCandidateCollection, RecruitmentCandidateCollection,
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

  QueryBuilder<RecruitmentCandidateCollection, RecruitmentCandidateCollection,
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

  QueryBuilder<RecruitmentCandidateCollection, RecruitmentCandidateCollection,
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

  QueryBuilder<RecruitmentCandidateCollection, RecruitmentCandidateCollection,
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

  QueryBuilder<RecruitmentCandidateCollection, RecruitmentCandidateCollection,
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

  QueryBuilder<RecruitmentCandidateCollection, RecruitmentCandidateCollection,
      QAfterFilterCondition> uuidIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'uuid',
        value: '',
      ));
    });
  }

  QueryBuilder<RecruitmentCandidateCollection, RecruitmentCandidateCollection,
      QAfterFilterCondition> uuidIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'uuid',
        value: '',
      ));
    });
  }
}

extension RecruitmentCandidateCollectionQueryObject on QueryBuilder<
    RecruitmentCandidateCollection,
    RecruitmentCandidateCollection,
    QFilterCondition> {}

extension RecruitmentCandidateCollectionQueryLinks on QueryBuilder<
    RecruitmentCandidateCollection,
    RecruitmentCandidateCollection,
    QFilterCondition> {}

extension RecruitmentCandidateCollectionQuerySortBy on QueryBuilder<
    RecruitmentCandidateCollection, RecruitmentCandidateCollection, QSortBy> {
  QueryBuilder<RecruitmentCandidateCollection, RecruitmentCandidateCollection,
      QAfterSortBy> sortByEmail() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'email', Sort.asc);
    });
  }

  QueryBuilder<RecruitmentCandidateCollection, RecruitmentCandidateCollection,
      QAfterSortBy> sortByEmailDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'email', Sort.desc);
    });
  }

  QueryBuilder<RecruitmentCandidateCollection, RecruitmentCandidateCollection,
      QAfterSortBy> sortByFirstName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'firstName', Sort.asc);
    });
  }

  QueryBuilder<RecruitmentCandidateCollection, RecruitmentCandidateCollection,
      QAfterSortBy> sortByFirstNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'firstName', Sort.desc);
    });
  }

  QueryBuilder<RecruitmentCandidateCollection, RecruitmentCandidateCollection,
      QAfterSortBy> sortByLastName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastName', Sort.asc);
    });
  }

  QueryBuilder<RecruitmentCandidateCollection, RecruitmentCandidateCollection,
      QAfterSortBy> sortByLastNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastName', Sort.desc);
    });
  }

  QueryBuilder<RecruitmentCandidateCollection, RecruitmentCandidateCollection,
      QAfterSortBy> sortByOpeningId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'openingId', Sort.asc);
    });
  }

  QueryBuilder<RecruitmentCandidateCollection, RecruitmentCandidateCollection,
      QAfterSortBy> sortByOpeningIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'openingId', Sort.desc);
    });
  }

  QueryBuilder<RecruitmentCandidateCollection, RecruitmentCandidateCollection,
      QAfterSortBy> sortByPhone() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'phone', Sort.asc);
    });
  }

  QueryBuilder<RecruitmentCandidateCollection, RecruitmentCandidateCollection,
      QAfterSortBy> sortByPhoneDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'phone', Sort.desc);
    });
  }

  QueryBuilder<RecruitmentCandidateCollection, RecruitmentCandidateCollection,
      QAfterSortBy> sortByResumeUrl() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'resumeUrl', Sort.asc);
    });
  }

  QueryBuilder<RecruitmentCandidateCollection, RecruitmentCandidateCollection,
      QAfterSortBy> sortByResumeUrlDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'resumeUrl', Sort.desc);
    });
  }

  QueryBuilder<RecruitmentCandidateCollection, RecruitmentCandidateCollection,
      QAfterSortBy> sortByScore() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'score', Sort.asc);
    });
  }

  QueryBuilder<RecruitmentCandidateCollection, RecruitmentCandidateCollection,
      QAfterSortBy> sortByScoreDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'score', Sort.desc);
    });
  }

  QueryBuilder<RecruitmentCandidateCollection, RecruitmentCandidateCollection,
      QAfterSortBy> sortByStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.asc);
    });
  }

  QueryBuilder<RecruitmentCandidateCollection, RecruitmentCandidateCollection,
      QAfterSortBy> sortByStatusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.desc);
    });
  }

  QueryBuilder<RecruitmentCandidateCollection, RecruitmentCandidateCollection,
      QAfterSortBy> sortByUuid() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uuid', Sort.asc);
    });
  }

  QueryBuilder<RecruitmentCandidateCollection, RecruitmentCandidateCollection,
      QAfterSortBy> sortByUuidDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uuid', Sort.desc);
    });
  }
}

extension RecruitmentCandidateCollectionQuerySortThenBy on QueryBuilder<
    RecruitmentCandidateCollection,
    RecruitmentCandidateCollection,
    QSortThenBy> {
  QueryBuilder<RecruitmentCandidateCollection, RecruitmentCandidateCollection,
      QAfterSortBy> thenByEmail() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'email', Sort.asc);
    });
  }

  QueryBuilder<RecruitmentCandidateCollection, RecruitmentCandidateCollection,
      QAfterSortBy> thenByEmailDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'email', Sort.desc);
    });
  }

  QueryBuilder<RecruitmentCandidateCollection, RecruitmentCandidateCollection,
      QAfterSortBy> thenByFirstName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'firstName', Sort.asc);
    });
  }

  QueryBuilder<RecruitmentCandidateCollection, RecruitmentCandidateCollection,
      QAfterSortBy> thenByFirstNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'firstName', Sort.desc);
    });
  }

  QueryBuilder<RecruitmentCandidateCollection, RecruitmentCandidateCollection,
      QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<RecruitmentCandidateCollection, RecruitmentCandidateCollection,
      QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<RecruitmentCandidateCollection, RecruitmentCandidateCollection,
      QAfterSortBy> thenByLastName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastName', Sort.asc);
    });
  }

  QueryBuilder<RecruitmentCandidateCollection, RecruitmentCandidateCollection,
      QAfterSortBy> thenByLastNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastName', Sort.desc);
    });
  }

  QueryBuilder<RecruitmentCandidateCollection, RecruitmentCandidateCollection,
      QAfterSortBy> thenByOpeningId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'openingId', Sort.asc);
    });
  }

  QueryBuilder<RecruitmentCandidateCollection, RecruitmentCandidateCollection,
      QAfterSortBy> thenByOpeningIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'openingId', Sort.desc);
    });
  }

  QueryBuilder<RecruitmentCandidateCollection, RecruitmentCandidateCollection,
      QAfterSortBy> thenByPhone() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'phone', Sort.asc);
    });
  }

  QueryBuilder<RecruitmentCandidateCollection, RecruitmentCandidateCollection,
      QAfterSortBy> thenByPhoneDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'phone', Sort.desc);
    });
  }

  QueryBuilder<RecruitmentCandidateCollection, RecruitmentCandidateCollection,
      QAfterSortBy> thenByResumeUrl() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'resumeUrl', Sort.asc);
    });
  }

  QueryBuilder<RecruitmentCandidateCollection, RecruitmentCandidateCollection,
      QAfterSortBy> thenByResumeUrlDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'resumeUrl', Sort.desc);
    });
  }

  QueryBuilder<RecruitmentCandidateCollection, RecruitmentCandidateCollection,
      QAfterSortBy> thenByScore() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'score', Sort.asc);
    });
  }

  QueryBuilder<RecruitmentCandidateCollection, RecruitmentCandidateCollection,
      QAfterSortBy> thenByScoreDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'score', Sort.desc);
    });
  }

  QueryBuilder<RecruitmentCandidateCollection, RecruitmentCandidateCollection,
      QAfterSortBy> thenByStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.asc);
    });
  }

  QueryBuilder<RecruitmentCandidateCollection, RecruitmentCandidateCollection,
      QAfterSortBy> thenByStatusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.desc);
    });
  }

  QueryBuilder<RecruitmentCandidateCollection, RecruitmentCandidateCollection,
      QAfterSortBy> thenByUuid() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uuid', Sort.asc);
    });
  }

  QueryBuilder<RecruitmentCandidateCollection, RecruitmentCandidateCollection,
      QAfterSortBy> thenByUuidDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uuid', Sort.desc);
    });
  }
}

extension RecruitmentCandidateCollectionQueryWhereDistinct on QueryBuilder<
    RecruitmentCandidateCollection, RecruitmentCandidateCollection, QDistinct> {
  QueryBuilder<RecruitmentCandidateCollection, RecruitmentCandidateCollection,
      QDistinct> distinctByEmail({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'email', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<RecruitmentCandidateCollection, RecruitmentCandidateCollection,
      QDistinct> distinctByFirstName({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'firstName', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<RecruitmentCandidateCollection, RecruitmentCandidateCollection,
      QDistinct> distinctByLastName({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'lastName', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<RecruitmentCandidateCollection, RecruitmentCandidateCollection,
      QDistinct> distinctByOpeningId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'openingId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<RecruitmentCandidateCollection, RecruitmentCandidateCollection,
      QDistinct> distinctByPhone({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'phone', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<RecruitmentCandidateCollection, RecruitmentCandidateCollection,
      QDistinct> distinctByResumeUrl({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'resumeUrl', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<RecruitmentCandidateCollection, RecruitmentCandidateCollection,
      QDistinct> distinctByScore() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'score');
    });
  }

  QueryBuilder<RecruitmentCandidateCollection, RecruitmentCandidateCollection,
      QDistinct> distinctByStatus({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'status', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<RecruitmentCandidateCollection, RecruitmentCandidateCollection,
      QDistinct> distinctByUuid({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'uuid', caseSensitive: caseSensitive);
    });
  }
}

extension RecruitmentCandidateCollectionQueryProperty on QueryBuilder<
    RecruitmentCandidateCollection,
    RecruitmentCandidateCollection,
    QQueryProperty> {
  QueryBuilder<RecruitmentCandidateCollection, int, QQueryOperations>
      idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<RecruitmentCandidateCollection, String, QQueryOperations>
      emailProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'email');
    });
  }

  QueryBuilder<RecruitmentCandidateCollection, String, QQueryOperations>
      firstNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'firstName');
    });
  }

  QueryBuilder<RecruitmentCandidateCollection, String, QQueryOperations>
      lastNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'lastName');
    });
  }

  QueryBuilder<RecruitmentCandidateCollection, String, QQueryOperations>
      openingIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'openingId');
    });
  }

  QueryBuilder<RecruitmentCandidateCollection, String, QQueryOperations>
      phoneProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'phone');
    });
  }

  QueryBuilder<RecruitmentCandidateCollection, String?, QQueryOperations>
      resumeUrlProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'resumeUrl');
    });
  }

  QueryBuilder<RecruitmentCandidateCollection, double, QQueryOperations>
      scoreProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'score');
    });
  }

  QueryBuilder<RecruitmentCandidateCollection, String, QQueryOperations>
      statusProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'status');
    });
  }

  QueryBuilder<RecruitmentCandidateCollection, String, QQueryOperations>
      uuidProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'uuid');
    });
  }
}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetPerformanceReviewCollectionCollection on Isar {
  IsarCollection<PerformanceReviewCollection>
      get performanceReviewCollections => this.collection();
}

const PerformanceReviewCollectionSchema = CollectionSchema(
  name: r'PerformanceReviewCollection',
  id: -(6308138210214 * 1000000 + 131438),
  properties: {
    r'employeeId': PropertySchema(
      id: 0,
      name: r'employeeId',
      type: IsarType.string,
    ),
    r'feedback': PropertySchema(
      id: 1,
      name: r'feedback',
      type: IsarType.string,
    ),
    r'nextSteps': PropertySchema(
      id: 2,
      name: r'nextSteps',
      type: IsarType.string,
    ),
    r'rating': PropertySchema(
      id: 3,
      name: r'rating',
      type: IsarType.double,
    ),
    r'reviewDate': PropertySchema(
      id: 4,
      name: r'reviewDate',
      type: IsarType.dateTime,
    ),
    r'reviewerId': PropertySchema(
      id: 5,
      name: r'reviewerId',
      type: IsarType.string,
    ),
    r'uuid': PropertySchema(
      id: 6,
      name: r'uuid',
      type: IsarType.string,
    )
  },
  estimateSize: _performanceReviewCollectionEstimateSize,
  serialize: _performanceReviewCollectionSerialize,
  deserialize: _performanceReviewCollectionDeserialize,
  deserializeProp: _performanceReviewCollectionDeserializeProp,
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
    r'employeeId': IndexSchema(
      id: (1283453093523 * 1000000 + 34672),
      name: r'employeeId',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'employeeId',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _performanceReviewCollectionGetId,
  getLinks: _performanceReviewCollectionGetLinks,
  attach: _performanceReviewCollectionAttach,
  version: '3.1.0+1',
);

int _performanceReviewCollectionEstimateSize(
  PerformanceReviewCollection object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.employeeId.length * 3;
  bytesCount += 3 + object.feedback.length * 3;
  bytesCount += 3 + object.nextSteps.length * 3;
  bytesCount += 3 + object.reviewerId.length * 3;
  bytesCount += 3 + object.uuid.length * 3;
  return bytesCount;
}

void _performanceReviewCollectionSerialize(
  PerformanceReviewCollection object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.employeeId);
  writer.writeString(offsets[1], object.feedback);
  writer.writeString(offsets[2], object.nextSteps);
  writer.writeDouble(offsets[3], object.rating);
  writer.writeDateTime(offsets[4], object.reviewDate);
  writer.writeString(offsets[5], object.reviewerId);
  writer.writeString(offsets[6], object.uuid);
}

PerformanceReviewCollection _performanceReviewCollectionDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = PerformanceReviewCollection();
  object.employeeId = reader.readString(offsets[0]);
  object.feedback = reader.readString(offsets[1]);
  object.id = id;
  object.nextSteps = reader.readString(offsets[2]);
  object.rating = reader.readDouble(offsets[3]);
  object.reviewDate = reader.readDateTime(offsets[4]);
  object.reviewerId = reader.readString(offsets[5]);
  object.uuid = reader.readString(offsets[6]);
  return object;
}

P _performanceReviewCollectionDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readString(offset)) as P;
    case 2:
      return (reader.readString(offset)) as P;
    case 3:
      return (reader.readDouble(offset)) as P;
    case 4:
      return (reader.readDateTime(offset)) as P;
    case 5:
      return (reader.readString(offset)) as P;
    case 6:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _performanceReviewCollectionGetId(PerformanceReviewCollection object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _performanceReviewCollectionGetLinks(
    PerformanceReviewCollection object) {
  return [];
}

void _performanceReviewCollectionAttach(
    IsarCollection<dynamic> col, Id id, PerformanceReviewCollection object) {
  object.id = id;
}

extension PerformanceReviewCollectionByIndex
    on IsarCollection<PerformanceReviewCollection> {
  Future<PerformanceReviewCollection?> getByUuid(String uuid) {
    return getByIndex(r'uuid', [uuid]);
  }

  PerformanceReviewCollection? getByUuidSync(String uuid) {
    return getByIndexSync(r'uuid', [uuid]);
  }

  Future<bool> deleteByUuid(String uuid) {
    return deleteByIndex(r'uuid', [uuid]);
  }

  bool deleteByUuidSync(String uuid) {
    return deleteByIndexSync(r'uuid', [uuid]);
  }

  Future<List<PerformanceReviewCollection?>> getAllByUuid(
      List<String> uuidValues) {
    final values = uuidValues.map((e) => [e]).toList();
    return getAllByIndex(r'uuid', values);
  }

  List<PerformanceReviewCollection?> getAllByUuidSync(List<String> uuidValues) {
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

  Future<Id> putByUuid(PerformanceReviewCollection object) {
    return putByIndex(r'uuid', object);
  }

  Id putByUuidSync(PerformanceReviewCollection object,
      {bool saveLinks = true}) {
    return putByIndexSync(r'uuid', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByUuid(List<PerformanceReviewCollection> objects) {
    return putAllByIndex(r'uuid', objects);
  }

  List<Id> putAllByUuidSync(List<PerformanceReviewCollection> objects,
      {bool saveLinks = true}) {
    return putAllByIndexSync(r'uuid', objects, saveLinks: saveLinks);
  }
}

extension PerformanceReviewCollectionQueryWhereSort on QueryBuilder<
    PerformanceReviewCollection, PerformanceReviewCollection, QWhere> {
  QueryBuilder<PerformanceReviewCollection, PerformanceReviewCollection,
      QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension PerformanceReviewCollectionQueryWhere on QueryBuilder<
    PerformanceReviewCollection, PerformanceReviewCollection, QWhereClause> {
  QueryBuilder<PerformanceReviewCollection, PerformanceReviewCollection,
      QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<PerformanceReviewCollection, PerformanceReviewCollection,
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

  QueryBuilder<PerformanceReviewCollection, PerformanceReviewCollection,
      QAfterWhereClause> idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<PerformanceReviewCollection, PerformanceReviewCollection,
      QAfterWhereClause> idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<PerformanceReviewCollection, PerformanceReviewCollection,
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

  QueryBuilder<PerformanceReviewCollection, PerformanceReviewCollection,
      QAfterWhereClause> uuidEqualTo(String uuid) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'uuid',
        value: [uuid],
      ));
    });
  }

  QueryBuilder<PerformanceReviewCollection, PerformanceReviewCollection,
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

  QueryBuilder<PerformanceReviewCollection, PerformanceReviewCollection,
      QAfterWhereClause> employeeIdEqualTo(String employeeId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'employeeId',
        value: [employeeId],
      ));
    });
  }

  QueryBuilder<PerformanceReviewCollection, PerformanceReviewCollection,
      QAfterWhereClause> employeeIdNotEqualTo(String employeeId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'employeeId',
              lower: [],
              upper: [employeeId],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'employeeId',
              lower: [employeeId],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'employeeId',
              lower: [employeeId],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'employeeId',
              lower: [],
              upper: [employeeId],
              includeUpper: false,
            ));
      }
    });
  }
}

extension PerformanceReviewCollectionQueryFilter on QueryBuilder<
    PerformanceReviewCollection,
    PerformanceReviewCollection,
    QFilterCondition> {
  QueryBuilder<PerformanceReviewCollection, PerformanceReviewCollection,
      QAfterFilterCondition> employeeIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'employeeId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PerformanceReviewCollection, PerformanceReviewCollection,
      QAfterFilterCondition> employeeIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'employeeId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PerformanceReviewCollection, PerformanceReviewCollection,
      QAfterFilterCondition> employeeIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'employeeId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PerformanceReviewCollection, PerformanceReviewCollection,
      QAfterFilterCondition> employeeIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'employeeId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PerformanceReviewCollection, PerformanceReviewCollection,
      QAfterFilterCondition> employeeIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'employeeId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PerformanceReviewCollection, PerformanceReviewCollection,
      QAfterFilterCondition> employeeIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'employeeId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PerformanceReviewCollection, PerformanceReviewCollection,
          QAfterFilterCondition>
      employeeIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'employeeId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PerformanceReviewCollection, PerformanceReviewCollection,
          QAfterFilterCondition>
      employeeIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'employeeId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PerformanceReviewCollection, PerformanceReviewCollection,
      QAfterFilterCondition> employeeIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'employeeId',
        value: '',
      ));
    });
  }

  QueryBuilder<PerformanceReviewCollection, PerformanceReviewCollection,
      QAfterFilterCondition> employeeIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'employeeId',
        value: '',
      ));
    });
  }

  QueryBuilder<PerformanceReviewCollection, PerformanceReviewCollection,
      QAfterFilterCondition> feedbackEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'feedback',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PerformanceReviewCollection, PerformanceReviewCollection,
      QAfterFilterCondition> feedbackGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'feedback',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PerformanceReviewCollection, PerformanceReviewCollection,
      QAfterFilterCondition> feedbackLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'feedback',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PerformanceReviewCollection, PerformanceReviewCollection,
      QAfterFilterCondition> feedbackBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'feedback',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PerformanceReviewCollection, PerformanceReviewCollection,
      QAfterFilterCondition> feedbackStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'feedback',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PerformanceReviewCollection, PerformanceReviewCollection,
      QAfterFilterCondition> feedbackEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'feedback',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PerformanceReviewCollection, PerformanceReviewCollection,
          QAfterFilterCondition>
      feedbackContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'feedback',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PerformanceReviewCollection, PerformanceReviewCollection,
          QAfterFilterCondition>
      feedbackMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'feedback',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PerformanceReviewCollection, PerformanceReviewCollection,
      QAfterFilterCondition> feedbackIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'feedback',
        value: '',
      ));
    });
  }

  QueryBuilder<PerformanceReviewCollection, PerformanceReviewCollection,
      QAfterFilterCondition> feedbackIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'feedback',
        value: '',
      ));
    });
  }

  QueryBuilder<PerformanceReviewCollection, PerformanceReviewCollection,
      QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<PerformanceReviewCollection, PerformanceReviewCollection,
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

  QueryBuilder<PerformanceReviewCollection, PerformanceReviewCollection,
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

  QueryBuilder<PerformanceReviewCollection, PerformanceReviewCollection,
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

  QueryBuilder<PerformanceReviewCollection, PerformanceReviewCollection,
      QAfterFilterCondition> nextStepsEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'nextSteps',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PerformanceReviewCollection, PerformanceReviewCollection,
      QAfterFilterCondition> nextStepsGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'nextSteps',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PerformanceReviewCollection, PerformanceReviewCollection,
      QAfterFilterCondition> nextStepsLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'nextSteps',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PerformanceReviewCollection, PerformanceReviewCollection,
      QAfterFilterCondition> nextStepsBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'nextSteps',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PerformanceReviewCollection, PerformanceReviewCollection,
      QAfterFilterCondition> nextStepsStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'nextSteps',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PerformanceReviewCollection, PerformanceReviewCollection,
      QAfterFilterCondition> nextStepsEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'nextSteps',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PerformanceReviewCollection, PerformanceReviewCollection,
          QAfterFilterCondition>
      nextStepsContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'nextSteps',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PerformanceReviewCollection, PerformanceReviewCollection,
          QAfterFilterCondition>
      nextStepsMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'nextSteps',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PerformanceReviewCollection, PerformanceReviewCollection,
      QAfterFilterCondition> nextStepsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'nextSteps',
        value: '',
      ));
    });
  }

  QueryBuilder<PerformanceReviewCollection, PerformanceReviewCollection,
      QAfterFilterCondition> nextStepsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'nextSteps',
        value: '',
      ));
    });
  }

  QueryBuilder<PerformanceReviewCollection, PerformanceReviewCollection,
      QAfterFilterCondition> ratingEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'rating',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<PerformanceReviewCollection, PerformanceReviewCollection,
      QAfterFilterCondition> ratingGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'rating',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<PerformanceReviewCollection, PerformanceReviewCollection,
      QAfterFilterCondition> ratingLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'rating',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<PerformanceReviewCollection, PerformanceReviewCollection,
      QAfterFilterCondition> ratingBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'rating',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<PerformanceReviewCollection, PerformanceReviewCollection,
      QAfterFilterCondition> reviewDateEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'reviewDate',
        value: value,
      ));
    });
  }

  QueryBuilder<PerformanceReviewCollection, PerformanceReviewCollection,
      QAfterFilterCondition> reviewDateGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'reviewDate',
        value: value,
      ));
    });
  }

  QueryBuilder<PerformanceReviewCollection, PerformanceReviewCollection,
      QAfterFilterCondition> reviewDateLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'reviewDate',
        value: value,
      ));
    });
  }

  QueryBuilder<PerformanceReviewCollection, PerformanceReviewCollection,
      QAfterFilterCondition> reviewDateBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'reviewDate',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<PerformanceReviewCollection, PerformanceReviewCollection,
      QAfterFilterCondition> reviewerIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'reviewerId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PerformanceReviewCollection, PerformanceReviewCollection,
      QAfterFilterCondition> reviewerIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'reviewerId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PerformanceReviewCollection, PerformanceReviewCollection,
      QAfterFilterCondition> reviewerIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'reviewerId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PerformanceReviewCollection, PerformanceReviewCollection,
      QAfterFilterCondition> reviewerIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'reviewerId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PerformanceReviewCollection, PerformanceReviewCollection,
      QAfterFilterCondition> reviewerIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'reviewerId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PerformanceReviewCollection, PerformanceReviewCollection,
      QAfterFilterCondition> reviewerIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'reviewerId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PerformanceReviewCollection, PerformanceReviewCollection,
          QAfterFilterCondition>
      reviewerIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'reviewerId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PerformanceReviewCollection, PerformanceReviewCollection,
          QAfterFilterCondition>
      reviewerIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'reviewerId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PerformanceReviewCollection, PerformanceReviewCollection,
      QAfterFilterCondition> reviewerIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'reviewerId',
        value: '',
      ));
    });
  }

  QueryBuilder<PerformanceReviewCollection, PerformanceReviewCollection,
      QAfterFilterCondition> reviewerIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'reviewerId',
        value: '',
      ));
    });
  }

  QueryBuilder<PerformanceReviewCollection, PerformanceReviewCollection,
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

  QueryBuilder<PerformanceReviewCollection, PerformanceReviewCollection,
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

  QueryBuilder<PerformanceReviewCollection, PerformanceReviewCollection,
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

  QueryBuilder<PerformanceReviewCollection, PerformanceReviewCollection,
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

  QueryBuilder<PerformanceReviewCollection, PerformanceReviewCollection,
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

  QueryBuilder<PerformanceReviewCollection, PerformanceReviewCollection,
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

  QueryBuilder<PerformanceReviewCollection, PerformanceReviewCollection,
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

  QueryBuilder<PerformanceReviewCollection, PerformanceReviewCollection,
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

  QueryBuilder<PerformanceReviewCollection, PerformanceReviewCollection,
      QAfterFilterCondition> uuidIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'uuid',
        value: '',
      ));
    });
  }

  QueryBuilder<PerformanceReviewCollection, PerformanceReviewCollection,
      QAfterFilterCondition> uuidIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'uuid',
        value: '',
      ));
    });
  }
}

extension PerformanceReviewCollectionQueryObject on QueryBuilder<
    PerformanceReviewCollection,
    PerformanceReviewCollection,
    QFilterCondition> {}

extension PerformanceReviewCollectionQueryLinks on QueryBuilder<
    PerformanceReviewCollection,
    PerformanceReviewCollection,
    QFilterCondition> {}

extension PerformanceReviewCollectionQuerySortBy on QueryBuilder<
    PerformanceReviewCollection, PerformanceReviewCollection, QSortBy> {
  QueryBuilder<PerformanceReviewCollection, PerformanceReviewCollection,
      QAfterSortBy> sortByEmployeeId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'employeeId', Sort.asc);
    });
  }

  QueryBuilder<PerformanceReviewCollection, PerformanceReviewCollection,
      QAfterSortBy> sortByEmployeeIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'employeeId', Sort.desc);
    });
  }

  QueryBuilder<PerformanceReviewCollection, PerformanceReviewCollection,
      QAfterSortBy> sortByFeedback() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'feedback', Sort.asc);
    });
  }

  QueryBuilder<PerformanceReviewCollection, PerformanceReviewCollection,
      QAfterSortBy> sortByFeedbackDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'feedback', Sort.desc);
    });
  }

  QueryBuilder<PerformanceReviewCollection, PerformanceReviewCollection,
      QAfterSortBy> sortByNextSteps() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nextSteps', Sort.asc);
    });
  }

  QueryBuilder<PerformanceReviewCollection, PerformanceReviewCollection,
      QAfterSortBy> sortByNextStepsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nextSteps', Sort.desc);
    });
  }

  QueryBuilder<PerformanceReviewCollection, PerformanceReviewCollection,
      QAfterSortBy> sortByRating() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rating', Sort.asc);
    });
  }

  QueryBuilder<PerformanceReviewCollection, PerformanceReviewCollection,
      QAfterSortBy> sortByRatingDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rating', Sort.desc);
    });
  }

  QueryBuilder<PerformanceReviewCollection, PerformanceReviewCollection,
      QAfterSortBy> sortByReviewDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'reviewDate', Sort.asc);
    });
  }

  QueryBuilder<PerformanceReviewCollection, PerformanceReviewCollection,
      QAfterSortBy> sortByReviewDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'reviewDate', Sort.desc);
    });
  }

  QueryBuilder<PerformanceReviewCollection, PerformanceReviewCollection,
      QAfterSortBy> sortByReviewerId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'reviewerId', Sort.asc);
    });
  }

  QueryBuilder<PerformanceReviewCollection, PerformanceReviewCollection,
      QAfterSortBy> sortByReviewerIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'reviewerId', Sort.desc);
    });
  }

  QueryBuilder<PerformanceReviewCollection, PerformanceReviewCollection,
      QAfterSortBy> sortByUuid() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uuid', Sort.asc);
    });
  }

  QueryBuilder<PerformanceReviewCollection, PerformanceReviewCollection,
      QAfterSortBy> sortByUuidDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uuid', Sort.desc);
    });
  }
}

extension PerformanceReviewCollectionQuerySortThenBy on QueryBuilder<
    PerformanceReviewCollection, PerformanceReviewCollection, QSortThenBy> {
  QueryBuilder<PerformanceReviewCollection, PerformanceReviewCollection,
      QAfterSortBy> thenByEmployeeId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'employeeId', Sort.asc);
    });
  }

  QueryBuilder<PerformanceReviewCollection, PerformanceReviewCollection,
      QAfterSortBy> thenByEmployeeIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'employeeId', Sort.desc);
    });
  }

  QueryBuilder<PerformanceReviewCollection, PerformanceReviewCollection,
      QAfterSortBy> thenByFeedback() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'feedback', Sort.asc);
    });
  }

  QueryBuilder<PerformanceReviewCollection, PerformanceReviewCollection,
      QAfterSortBy> thenByFeedbackDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'feedback', Sort.desc);
    });
  }

  QueryBuilder<PerformanceReviewCollection, PerformanceReviewCollection,
      QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<PerformanceReviewCollection, PerformanceReviewCollection,
      QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<PerformanceReviewCollection, PerformanceReviewCollection,
      QAfterSortBy> thenByNextSteps() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nextSteps', Sort.asc);
    });
  }

  QueryBuilder<PerformanceReviewCollection, PerformanceReviewCollection,
      QAfterSortBy> thenByNextStepsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nextSteps', Sort.desc);
    });
  }

  QueryBuilder<PerformanceReviewCollection, PerformanceReviewCollection,
      QAfterSortBy> thenByRating() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rating', Sort.asc);
    });
  }

  QueryBuilder<PerformanceReviewCollection, PerformanceReviewCollection,
      QAfterSortBy> thenByRatingDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rating', Sort.desc);
    });
  }

  QueryBuilder<PerformanceReviewCollection, PerformanceReviewCollection,
      QAfterSortBy> thenByReviewDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'reviewDate', Sort.asc);
    });
  }

  QueryBuilder<PerformanceReviewCollection, PerformanceReviewCollection,
      QAfterSortBy> thenByReviewDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'reviewDate', Sort.desc);
    });
  }

  QueryBuilder<PerformanceReviewCollection, PerformanceReviewCollection,
      QAfterSortBy> thenByReviewerId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'reviewerId', Sort.asc);
    });
  }

  QueryBuilder<PerformanceReviewCollection, PerformanceReviewCollection,
      QAfterSortBy> thenByReviewerIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'reviewerId', Sort.desc);
    });
  }

  QueryBuilder<PerformanceReviewCollection, PerformanceReviewCollection,
      QAfterSortBy> thenByUuid() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uuid', Sort.asc);
    });
  }

  QueryBuilder<PerformanceReviewCollection, PerformanceReviewCollection,
      QAfterSortBy> thenByUuidDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uuid', Sort.desc);
    });
  }
}

extension PerformanceReviewCollectionQueryWhereDistinct on QueryBuilder<
    PerformanceReviewCollection, PerformanceReviewCollection, QDistinct> {
  QueryBuilder<PerformanceReviewCollection, PerformanceReviewCollection,
      QDistinct> distinctByEmployeeId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'employeeId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<PerformanceReviewCollection, PerformanceReviewCollection,
      QDistinct> distinctByFeedback({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'feedback', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<PerformanceReviewCollection, PerformanceReviewCollection,
      QDistinct> distinctByNextSteps({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'nextSteps', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<PerformanceReviewCollection, PerformanceReviewCollection,
      QDistinct> distinctByRating() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'rating');
    });
  }

  QueryBuilder<PerformanceReviewCollection, PerformanceReviewCollection,
      QDistinct> distinctByReviewDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'reviewDate');
    });
  }

  QueryBuilder<PerformanceReviewCollection, PerformanceReviewCollection,
      QDistinct> distinctByReviewerId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'reviewerId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<PerformanceReviewCollection, PerformanceReviewCollection,
      QDistinct> distinctByUuid({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'uuid', caseSensitive: caseSensitive);
    });
  }
}

extension PerformanceReviewCollectionQueryProperty on QueryBuilder<
    PerformanceReviewCollection, PerformanceReviewCollection, QQueryProperty> {
  QueryBuilder<PerformanceReviewCollection, int, QQueryOperations>
      idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<PerformanceReviewCollection, String, QQueryOperations>
      employeeIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'employeeId');
    });
  }

  QueryBuilder<PerformanceReviewCollection, String, QQueryOperations>
      feedbackProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'feedback');
    });
  }

  QueryBuilder<PerformanceReviewCollection, String, QQueryOperations>
      nextStepsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'nextSteps');
    });
  }

  QueryBuilder<PerformanceReviewCollection, double, QQueryOperations>
      ratingProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'rating');
    });
  }

  QueryBuilder<PerformanceReviewCollection, DateTime, QQueryOperations>
      reviewDateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'reviewDate');
    });
  }

  QueryBuilder<PerformanceReviewCollection, String, QQueryOperations>
      reviewerIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'reviewerId');
    });
  }

  QueryBuilder<PerformanceReviewCollection, String, QQueryOperations>
      uuidProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'uuid');
    });
  }
}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetTrainingProgramCollectionCollection on Isar {
  IsarCollection<TrainingProgramCollection> get trainingProgramCollections =>
      this.collection();
}

const TrainingProgramCollectionSchema = CollectionSchema(
  name: r'TrainingProgramCollection',
  id: -(6833873199090 * 1000000 + 6968),
  properties: {
    r'assignedEmployeeIds': PropertySchema(
      id: 0,
      name: r'assignedEmployeeIds',
      type: IsarType.stringList,
    ),
    r'description': PropertySchema(
      id: 1,
      name: r'description',
      type: IsarType.string,
    ),
    r'endDate': PropertySchema(
      id: 2,
      name: r'endDate',
      type: IsarType.dateTime,
    ),
    r'startDate': PropertySchema(
      id: 3,
      name: r'startDate',
      type: IsarType.dateTime,
    ),
    r'title': PropertySchema(
      id: 4,
      name: r'title',
      type: IsarType.string,
    ),
    r'uuid': PropertySchema(
      id: 5,
      name: r'uuid',
      type: IsarType.string,
    )
  },
  estimateSize: _trainingProgramCollectionEstimateSize,
  serialize: _trainingProgramCollectionSerialize,
  deserialize: _trainingProgramCollectionDeserialize,
  deserializeProp: _trainingProgramCollectionDeserializeProp,
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
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _trainingProgramCollectionGetId,
  getLinks: _trainingProgramCollectionGetLinks,
  attach: _trainingProgramCollectionAttach,
  version: '3.1.0+1',
);

int _trainingProgramCollectionEstimateSize(
  TrainingProgramCollection object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.assignedEmployeeIds.length * 3;
  {
    for (var i = 0; i < object.assignedEmployeeIds.length; i++) {
      final value = object.assignedEmployeeIds[i];
      bytesCount += value.length * 3;
    }
  }
  bytesCount += 3 + object.description.length * 3;
  bytesCount += 3 + object.title.length * 3;
  bytesCount += 3 + object.uuid.length * 3;
  return bytesCount;
}

void _trainingProgramCollectionSerialize(
  TrainingProgramCollection object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeStringList(offsets[0], object.assignedEmployeeIds);
  writer.writeString(offsets[1], object.description);
  writer.writeDateTime(offsets[2], object.endDate);
  writer.writeDateTime(offsets[3], object.startDate);
  writer.writeString(offsets[4], object.title);
  writer.writeString(offsets[5], object.uuid);
}

TrainingProgramCollection _trainingProgramCollectionDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = TrainingProgramCollection();
  object.assignedEmployeeIds = reader.readStringList(offsets[0]) ?? [];
  object.description = reader.readString(offsets[1]);
  object.endDate = reader.readDateTime(offsets[2]);
  object.id = id;
  object.startDate = reader.readDateTime(offsets[3]);
  object.title = reader.readString(offsets[4]);
  object.uuid = reader.readString(offsets[5]);
  return object;
}

P _trainingProgramCollectionDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringList(offset) ?? []) as P;
    case 1:
      return (reader.readString(offset)) as P;
    case 2:
      return (reader.readDateTime(offset)) as P;
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

Id _trainingProgramCollectionGetId(TrainingProgramCollection object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _trainingProgramCollectionGetLinks(
    TrainingProgramCollection object) {
  return [];
}

void _trainingProgramCollectionAttach(
    IsarCollection<dynamic> col, Id id, TrainingProgramCollection object) {
  object.id = id;
}

extension TrainingProgramCollectionByIndex
    on IsarCollection<TrainingProgramCollection> {
  Future<TrainingProgramCollection?> getByUuid(String uuid) {
    return getByIndex(r'uuid', [uuid]);
  }

  TrainingProgramCollection? getByUuidSync(String uuid) {
    return getByIndexSync(r'uuid', [uuid]);
  }

  Future<bool> deleteByUuid(String uuid) {
    return deleteByIndex(r'uuid', [uuid]);
  }

  bool deleteByUuidSync(String uuid) {
    return deleteByIndexSync(r'uuid', [uuid]);
  }

  Future<List<TrainingProgramCollection?>> getAllByUuid(
      List<String> uuidValues) {
    final values = uuidValues.map((e) => [e]).toList();
    return getAllByIndex(r'uuid', values);
  }

  List<TrainingProgramCollection?> getAllByUuidSync(List<String> uuidValues) {
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

  Future<Id> putByUuid(TrainingProgramCollection object) {
    return putByIndex(r'uuid', object);
  }

  Id putByUuidSync(TrainingProgramCollection object, {bool saveLinks = true}) {
    return putByIndexSync(r'uuid', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByUuid(List<TrainingProgramCollection> objects) {
    return putAllByIndex(r'uuid', objects);
  }

  List<Id> putAllByUuidSync(List<TrainingProgramCollection> objects,
      {bool saveLinks = true}) {
    return putAllByIndexSync(r'uuid', objects, saveLinks: saveLinks);
  }
}

extension TrainingProgramCollectionQueryWhereSort on QueryBuilder<
    TrainingProgramCollection, TrainingProgramCollection, QWhere> {
  QueryBuilder<TrainingProgramCollection, TrainingProgramCollection,
      QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension TrainingProgramCollectionQueryWhere on QueryBuilder<
    TrainingProgramCollection, TrainingProgramCollection, QWhereClause> {
  QueryBuilder<TrainingProgramCollection, TrainingProgramCollection,
      QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<TrainingProgramCollection, TrainingProgramCollection,
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

  QueryBuilder<TrainingProgramCollection, TrainingProgramCollection,
      QAfterWhereClause> idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<TrainingProgramCollection, TrainingProgramCollection,
      QAfterWhereClause> idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<TrainingProgramCollection, TrainingProgramCollection,
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

  QueryBuilder<TrainingProgramCollection, TrainingProgramCollection,
      QAfterWhereClause> uuidEqualTo(String uuid) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'uuid',
        value: [uuid],
      ));
    });
  }

  QueryBuilder<TrainingProgramCollection, TrainingProgramCollection,
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
}

extension TrainingProgramCollectionQueryFilter on QueryBuilder<
    TrainingProgramCollection, TrainingProgramCollection, QFilterCondition> {
  QueryBuilder<TrainingProgramCollection, TrainingProgramCollection,
      QAfterFilterCondition> assignedEmployeeIdsElementEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'assignedEmployeeIds',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TrainingProgramCollection, TrainingProgramCollection,
      QAfterFilterCondition> assignedEmployeeIdsElementGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'assignedEmployeeIds',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TrainingProgramCollection, TrainingProgramCollection,
      QAfterFilterCondition> assignedEmployeeIdsElementLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'assignedEmployeeIds',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TrainingProgramCollection, TrainingProgramCollection,
      QAfterFilterCondition> assignedEmployeeIdsElementBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'assignedEmployeeIds',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TrainingProgramCollection, TrainingProgramCollection,
      QAfterFilterCondition> assignedEmployeeIdsElementStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'assignedEmployeeIds',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TrainingProgramCollection, TrainingProgramCollection,
      QAfterFilterCondition> assignedEmployeeIdsElementEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'assignedEmployeeIds',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TrainingProgramCollection, TrainingProgramCollection,
          QAfterFilterCondition>
      assignedEmployeeIdsElementContains(String value,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'assignedEmployeeIds',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TrainingProgramCollection, TrainingProgramCollection,
          QAfterFilterCondition>
      assignedEmployeeIdsElementMatches(String pattern,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'assignedEmployeeIds',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TrainingProgramCollection, TrainingProgramCollection,
      QAfterFilterCondition> assignedEmployeeIdsElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'assignedEmployeeIds',
        value: '',
      ));
    });
  }

  QueryBuilder<TrainingProgramCollection, TrainingProgramCollection,
      QAfterFilterCondition> assignedEmployeeIdsElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'assignedEmployeeIds',
        value: '',
      ));
    });
  }

  QueryBuilder<TrainingProgramCollection, TrainingProgramCollection,
      QAfterFilterCondition> assignedEmployeeIdsLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'assignedEmployeeIds',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<TrainingProgramCollection, TrainingProgramCollection,
      QAfterFilterCondition> assignedEmployeeIdsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'assignedEmployeeIds',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<TrainingProgramCollection, TrainingProgramCollection,
      QAfterFilterCondition> assignedEmployeeIdsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'assignedEmployeeIds',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<TrainingProgramCollection, TrainingProgramCollection,
      QAfterFilterCondition> assignedEmployeeIdsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'assignedEmployeeIds',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<TrainingProgramCollection, TrainingProgramCollection,
      QAfterFilterCondition> assignedEmployeeIdsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'assignedEmployeeIds',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<TrainingProgramCollection, TrainingProgramCollection,
      QAfterFilterCondition> assignedEmployeeIdsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'assignedEmployeeIds',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<TrainingProgramCollection, TrainingProgramCollection,
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

  QueryBuilder<TrainingProgramCollection, TrainingProgramCollection,
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

  QueryBuilder<TrainingProgramCollection, TrainingProgramCollection,
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

  QueryBuilder<TrainingProgramCollection, TrainingProgramCollection,
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

  QueryBuilder<TrainingProgramCollection, TrainingProgramCollection,
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

  QueryBuilder<TrainingProgramCollection, TrainingProgramCollection,
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

  QueryBuilder<TrainingProgramCollection, TrainingProgramCollection,
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

  QueryBuilder<TrainingProgramCollection, TrainingProgramCollection,
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

  QueryBuilder<TrainingProgramCollection, TrainingProgramCollection,
      QAfterFilterCondition> descriptionIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'description',
        value: '',
      ));
    });
  }

  QueryBuilder<TrainingProgramCollection, TrainingProgramCollection,
      QAfterFilterCondition> descriptionIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'description',
        value: '',
      ));
    });
  }

  QueryBuilder<TrainingProgramCollection, TrainingProgramCollection,
      QAfterFilterCondition> endDateEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'endDate',
        value: value,
      ));
    });
  }

  QueryBuilder<TrainingProgramCollection, TrainingProgramCollection,
      QAfterFilterCondition> endDateGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'endDate',
        value: value,
      ));
    });
  }

  QueryBuilder<TrainingProgramCollection, TrainingProgramCollection,
      QAfterFilterCondition> endDateLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'endDate',
        value: value,
      ));
    });
  }

  QueryBuilder<TrainingProgramCollection, TrainingProgramCollection,
      QAfterFilterCondition> endDateBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'endDate',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<TrainingProgramCollection, TrainingProgramCollection,
      QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<TrainingProgramCollection, TrainingProgramCollection,
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

  QueryBuilder<TrainingProgramCollection, TrainingProgramCollection,
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

  QueryBuilder<TrainingProgramCollection, TrainingProgramCollection,
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

  QueryBuilder<TrainingProgramCollection, TrainingProgramCollection,
      QAfterFilterCondition> startDateEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'startDate',
        value: value,
      ));
    });
  }

  QueryBuilder<TrainingProgramCollection, TrainingProgramCollection,
      QAfterFilterCondition> startDateGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'startDate',
        value: value,
      ));
    });
  }

  QueryBuilder<TrainingProgramCollection, TrainingProgramCollection,
      QAfterFilterCondition> startDateLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'startDate',
        value: value,
      ));
    });
  }

  QueryBuilder<TrainingProgramCollection, TrainingProgramCollection,
      QAfterFilterCondition> startDateBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'startDate',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<TrainingProgramCollection, TrainingProgramCollection,
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

  QueryBuilder<TrainingProgramCollection, TrainingProgramCollection,
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

  QueryBuilder<TrainingProgramCollection, TrainingProgramCollection,
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

  QueryBuilder<TrainingProgramCollection, TrainingProgramCollection,
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

  QueryBuilder<TrainingProgramCollection, TrainingProgramCollection,
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

  QueryBuilder<TrainingProgramCollection, TrainingProgramCollection,
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

  QueryBuilder<TrainingProgramCollection, TrainingProgramCollection,
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

  QueryBuilder<TrainingProgramCollection, TrainingProgramCollection,
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

  QueryBuilder<TrainingProgramCollection, TrainingProgramCollection,
      QAfterFilterCondition> titleIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'title',
        value: '',
      ));
    });
  }

  QueryBuilder<TrainingProgramCollection, TrainingProgramCollection,
      QAfterFilterCondition> titleIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'title',
        value: '',
      ));
    });
  }

  QueryBuilder<TrainingProgramCollection, TrainingProgramCollection,
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

  QueryBuilder<TrainingProgramCollection, TrainingProgramCollection,
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

  QueryBuilder<TrainingProgramCollection, TrainingProgramCollection,
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

  QueryBuilder<TrainingProgramCollection, TrainingProgramCollection,
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

  QueryBuilder<TrainingProgramCollection, TrainingProgramCollection,
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

  QueryBuilder<TrainingProgramCollection, TrainingProgramCollection,
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

  QueryBuilder<TrainingProgramCollection, TrainingProgramCollection,
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

  QueryBuilder<TrainingProgramCollection, TrainingProgramCollection,
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

  QueryBuilder<TrainingProgramCollection, TrainingProgramCollection,
      QAfterFilterCondition> uuidIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'uuid',
        value: '',
      ));
    });
  }

  QueryBuilder<TrainingProgramCollection, TrainingProgramCollection,
      QAfterFilterCondition> uuidIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'uuid',
        value: '',
      ));
    });
  }
}

extension TrainingProgramCollectionQueryObject on QueryBuilder<
    TrainingProgramCollection, TrainingProgramCollection, QFilterCondition> {}

extension TrainingProgramCollectionQueryLinks on QueryBuilder<
    TrainingProgramCollection, TrainingProgramCollection, QFilterCondition> {}

extension TrainingProgramCollectionQuerySortBy on QueryBuilder<
    TrainingProgramCollection, TrainingProgramCollection, QSortBy> {
  QueryBuilder<TrainingProgramCollection, TrainingProgramCollection,
      QAfterSortBy> sortByDescription() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.asc);
    });
  }

  QueryBuilder<TrainingProgramCollection, TrainingProgramCollection,
      QAfterSortBy> sortByDescriptionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.desc);
    });
  }

  QueryBuilder<TrainingProgramCollection, TrainingProgramCollection,
      QAfterSortBy> sortByEndDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'endDate', Sort.asc);
    });
  }

  QueryBuilder<TrainingProgramCollection, TrainingProgramCollection,
      QAfterSortBy> sortByEndDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'endDate', Sort.desc);
    });
  }

  QueryBuilder<TrainingProgramCollection, TrainingProgramCollection,
      QAfterSortBy> sortByStartDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'startDate', Sort.asc);
    });
  }

  QueryBuilder<TrainingProgramCollection, TrainingProgramCollection,
      QAfterSortBy> sortByStartDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'startDate', Sort.desc);
    });
  }

  QueryBuilder<TrainingProgramCollection, TrainingProgramCollection,
      QAfterSortBy> sortByTitle() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.asc);
    });
  }

  QueryBuilder<TrainingProgramCollection, TrainingProgramCollection,
      QAfterSortBy> sortByTitleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.desc);
    });
  }

  QueryBuilder<TrainingProgramCollection, TrainingProgramCollection,
      QAfterSortBy> sortByUuid() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uuid', Sort.asc);
    });
  }

  QueryBuilder<TrainingProgramCollection, TrainingProgramCollection,
      QAfterSortBy> sortByUuidDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uuid', Sort.desc);
    });
  }
}

extension TrainingProgramCollectionQuerySortThenBy on QueryBuilder<
    TrainingProgramCollection, TrainingProgramCollection, QSortThenBy> {
  QueryBuilder<TrainingProgramCollection, TrainingProgramCollection,
      QAfterSortBy> thenByDescription() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.asc);
    });
  }

  QueryBuilder<TrainingProgramCollection, TrainingProgramCollection,
      QAfterSortBy> thenByDescriptionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.desc);
    });
  }

  QueryBuilder<TrainingProgramCollection, TrainingProgramCollection,
      QAfterSortBy> thenByEndDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'endDate', Sort.asc);
    });
  }

  QueryBuilder<TrainingProgramCollection, TrainingProgramCollection,
      QAfterSortBy> thenByEndDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'endDate', Sort.desc);
    });
  }

  QueryBuilder<TrainingProgramCollection, TrainingProgramCollection,
      QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<TrainingProgramCollection, TrainingProgramCollection,
      QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<TrainingProgramCollection, TrainingProgramCollection,
      QAfterSortBy> thenByStartDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'startDate', Sort.asc);
    });
  }

  QueryBuilder<TrainingProgramCollection, TrainingProgramCollection,
      QAfterSortBy> thenByStartDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'startDate', Sort.desc);
    });
  }

  QueryBuilder<TrainingProgramCollection, TrainingProgramCollection,
      QAfterSortBy> thenByTitle() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.asc);
    });
  }

  QueryBuilder<TrainingProgramCollection, TrainingProgramCollection,
      QAfterSortBy> thenByTitleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.desc);
    });
  }

  QueryBuilder<TrainingProgramCollection, TrainingProgramCollection,
      QAfterSortBy> thenByUuid() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uuid', Sort.asc);
    });
  }

  QueryBuilder<TrainingProgramCollection, TrainingProgramCollection,
      QAfterSortBy> thenByUuidDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uuid', Sort.desc);
    });
  }
}

extension TrainingProgramCollectionQueryWhereDistinct on QueryBuilder<
    TrainingProgramCollection, TrainingProgramCollection, QDistinct> {
  QueryBuilder<TrainingProgramCollection, TrainingProgramCollection, QDistinct>
      distinctByAssignedEmployeeIds() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'assignedEmployeeIds');
    });
  }

  QueryBuilder<TrainingProgramCollection, TrainingProgramCollection, QDistinct>
      distinctByDescription({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'description', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<TrainingProgramCollection, TrainingProgramCollection, QDistinct>
      distinctByEndDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'endDate');
    });
  }

  QueryBuilder<TrainingProgramCollection, TrainingProgramCollection, QDistinct>
      distinctByStartDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'startDate');
    });
  }

  QueryBuilder<TrainingProgramCollection, TrainingProgramCollection, QDistinct>
      distinctByTitle({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'title', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<TrainingProgramCollection, TrainingProgramCollection, QDistinct>
      distinctByUuid({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'uuid', caseSensitive: caseSensitive);
    });
  }
}

extension TrainingProgramCollectionQueryProperty on QueryBuilder<
    TrainingProgramCollection, TrainingProgramCollection, QQueryProperty> {
  QueryBuilder<TrainingProgramCollection, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<TrainingProgramCollection, List<String>, QQueryOperations>
      assignedEmployeeIdsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'assignedEmployeeIds');
    });
  }

  QueryBuilder<TrainingProgramCollection, String, QQueryOperations>
      descriptionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'description');
    });
  }

  QueryBuilder<TrainingProgramCollection, DateTime, QQueryOperations>
      endDateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'endDate');
    });
  }

  QueryBuilder<TrainingProgramCollection, DateTime, QQueryOperations>
      startDateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'startDate');
    });
  }

  QueryBuilder<TrainingProgramCollection, String, QQueryOperations>
      titleProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'title');
    });
  }

  QueryBuilder<TrainingProgramCollection, String, QQueryOperations>
      uuidProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'uuid');
    });
  }
}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetEmployeeDocumentCollectionCollection on Isar {
  IsarCollection<EmployeeDocumentCollection> get employeeDocumentCollections =>
      this.collection();
}

const EmployeeDocumentCollectionSchema = CollectionSchema(
  name: r'EmployeeDocumentCollection',
  id: (419596759954 * 1000000 + 253147),
  properties: {
    r'documentType': PropertySchema(
      id: 0,
      name: r'documentType',
      type: IsarType.string,
    ),
    r'employeeId': PropertySchema(
      id: 1,
      name: r'employeeId',
      type: IsarType.string,
    ),
    r'expiryDate': PropertySchema(
      id: 2,
      name: r'expiryDate',
      type: IsarType.dateTime,
    ),
    r'fileName': PropertySchema(
      id: 3,
      name: r'fileName',
      type: IsarType.string,
    ),
    r'fileUrl': PropertySchema(
      id: 4,
      name: r'fileUrl',
      type: IsarType.string,
    ),
    r'status': PropertySchema(
      id: 5,
      name: r'status',
      type: IsarType.string,
    ),
    r'uuid': PropertySchema(
      id: 6,
      name: r'uuid',
      type: IsarType.string,
    )
  },
  estimateSize: _employeeDocumentCollectionEstimateSize,
  serialize: _employeeDocumentCollectionSerialize,
  deserialize: _employeeDocumentCollectionDeserialize,
  deserializeProp: _employeeDocumentCollectionDeserializeProp,
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
    r'employeeId': IndexSchema(
      id: (1283453093523 * 1000000 + 34672),
      name: r'employeeId',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'employeeId',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _employeeDocumentCollectionGetId,
  getLinks: _employeeDocumentCollectionGetLinks,
  attach: _employeeDocumentCollectionAttach,
  version: '3.1.0+1',
);

int _employeeDocumentCollectionEstimateSize(
  EmployeeDocumentCollection object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.documentType.length * 3;
  bytesCount += 3 + object.employeeId.length * 3;
  bytesCount += 3 + object.fileName.length * 3;
  bytesCount += 3 + object.fileUrl.length * 3;
  bytesCount += 3 + object.status.length * 3;
  bytesCount += 3 + object.uuid.length * 3;
  return bytesCount;
}

void _employeeDocumentCollectionSerialize(
  EmployeeDocumentCollection object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.documentType);
  writer.writeString(offsets[1], object.employeeId);
  writer.writeDateTime(offsets[2], object.expiryDate);
  writer.writeString(offsets[3], object.fileName);
  writer.writeString(offsets[4], object.fileUrl);
  writer.writeString(offsets[5], object.status);
  writer.writeString(offsets[6], object.uuid);
}

EmployeeDocumentCollection _employeeDocumentCollectionDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = EmployeeDocumentCollection();
  object.documentType = reader.readString(offsets[0]);
  object.employeeId = reader.readString(offsets[1]);
  object.expiryDate = reader.readDateTimeOrNull(offsets[2]);
  object.fileName = reader.readString(offsets[3]);
  object.fileUrl = reader.readString(offsets[4]);
  object.id = id;
  object.status = reader.readString(offsets[5]);
  object.uuid = reader.readString(offsets[6]);
  return object;
}

P _employeeDocumentCollectionDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readString(offset)) as P;
    case 2:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 3:
      return (reader.readString(offset)) as P;
    case 4:
      return (reader.readString(offset)) as P;
    case 5:
      return (reader.readString(offset)) as P;
    case 6:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _employeeDocumentCollectionGetId(EmployeeDocumentCollection object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _employeeDocumentCollectionGetLinks(
    EmployeeDocumentCollection object) {
  return [];
}

void _employeeDocumentCollectionAttach(
    IsarCollection<dynamic> col, Id id, EmployeeDocumentCollection object) {
  object.id = id;
}

extension EmployeeDocumentCollectionByIndex
    on IsarCollection<EmployeeDocumentCollection> {
  Future<EmployeeDocumentCollection?> getByUuid(String uuid) {
    return getByIndex(r'uuid', [uuid]);
  }

  EmployeeDocumentCollection? getByUuidSync(String uuid) {
    return getByIndexSync(r'uuid', [uuid]);
  }

  Future<bool> deleteByUuid(String uuid) {
    return deleteByIndex(r'uuid', [uuid]);
  }

  bool deleteByUuidSync(String uuid) {
    return deleteByIndexSync(r'uuid', [uuid]);
  }

  Future<List<EmployeeDocumentCollection?>> getAllByUuid(
      List<String> uuidValues) {
    final values = uuidValues.map((e) => [e]).toList();
    return getAllByIndex(r'uuid', values);
  }

  List<EmployeeDocumentCollection?> getAllByUuidSync(List<String> uuidValues) {
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

  Future<Id> putByUuid(EmployeeDocumentCollection object) {
    return putByIndex(r'uuid', object);
  }

  Id putByUuidSync(EmployeeDocumentCollection object, {bool saveLinks = true}) {
    return putByIndexSync(r'uuid', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByUuid(List<EmployeeDocumentCollection> objects) {
    return putAllByIndex(r'uuid', objects);
  }

  List<Id> putAllByUuidSync(List<EmployeeDocumentCollection> objects,
      {bool saveLinks = true}) {
    return putAllByIndexSync(r'uuid', objects, saveLinks: saveLinks);
  }
}

extension EmployeeDocumentCollectionQueryWhereSort on QueryBuilder<
    EmployeeDocumentCollection, EmployeeDocumentCollection, QWhere> {
  QueryBuilder<EmployeeDocumentCollection, EmployeeDocumentCollection,
      QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension EmployeeDocumentCollectionQueryWhere on QueryBuilder<
    EmployeeDocumentCollection, EmployeeDocumentCollection, QWhereClause> {
  QueryBuilder<EmployeeDocumentCollection, EmployeeDocumentCollection,
      QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<EmployeeDocumentCollection, EmployeeDocumentCollection,
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

  QueryBuilder<EmployeeDocumentCollection, EmployeeDocumentCollection,
      QAfterWhereClause> idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<EmployeeDocumentCollection, EmployeeDocumentCollection,
      QAfterWhereClause> idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<EmployeeDocumentCollection, EmployeeDocumentCollection,
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

  QueryBuilder<EmployeeDocumentCollection, EmployeeDocumentCollection,
      QAfterWhereClause> uuidEqualTo(String uuid) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'uuid',
        value: [uuid],
      ));
    });
  }

  QueryBuilder<EmployeeDocumentCollection, EmployeeDocumentCollection,
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

  QueryBuilder<EmployeeDocumentCollection, EmployeeDocumentCollection,
      QAfterWhereClause> employeeIdEqualTo(String employeeId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'employeeId',
        value: [employeeId],
      ));
    });
  }

  QueryBuilder<EmployeeDocumentCollection, EmployeeDocumentCollection,
      QAfterWhereClause> employeeIdNotEqualTo(String employeeId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'employeeId',
              lower: [],
              upper: [employeeId],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'employeeId',
              lower: [employeeId],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'employeeId',
              lower: [employeeId],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'employeeId',
              lower: [],
              upper: [employeeId],
              includeUpper: false,
            ));
      }
    });
  }
}

extension EmployeeDocumentCollectionQueryFilter on QueryBuilder<
    EmployeeDocumentCollection, EmployeeDocumentCollection, QFilterCondition> {
  QueryBuilder<EmployeeDocumentCollection, EmployeeDocumentCollection,
      QAfterFilterCondition> documentTypeEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'documentType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmployeeDocumentCollection, EmployeeDocumentCollection,
      QAfterFilterCondition> documentTypeGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'documentType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmployeeDocumentCollection, EmployeeDocumentCollection,
      QAfterFilterCondition> documentTypeLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'documentType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmployeeDocumentCollection, EmployeeDocumentCollection,
      QAfterFilterCondition> documentTypeBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'documentType',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmployeeDocumentCollection, EmployeeDocumentCollection,
      QAfterFilterCondition> documentTypeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'documentType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmployeeDocumentCollection, EmployeeDocumentCollection,
      QAfterFilterCondition> documentTypeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'documentType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmployeeDocumentCollection, EmployeeDocumentCollection,
          QAfterFilterCondition>
      documentTypeContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'documentType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmployeeDocumentCollection, EmployeeDocumentCollection,
          QAfterFilterCondition>
      documentTypeMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'documentType',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmployeeDocumentCollection, EmployeeDocumentCollection,
      QAfterFilterCondition> documentTypeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'documentType',
        value: '',
      ));
    });
  }

  QueryBuilder<EmployeeDocumentCollection, EmployeeDocumentCollection,
      QAfterFilterCondition> documentTypeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'documentType',
        value: '',
      ));
    });
  }

  QueryBuilder<EmployeeDocumentCollection, EmployeeDocumentCollection,
      QAfterFilterCondition> employeeIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'employeeId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmployeeDocumentCollection, EmployeeDocumentCollection,
      QAfterFilterCondition> employeeIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'employeeId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmployeeDocumentCollection, EmployeeDocumentCollection,
      QAfterFilterCondition> employeeIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'employeeId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmployeeDocumentCollection, EmployeeDocumentCollection,
      QAfterFilterCondition> employeeIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'employeeId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmployeeDocumentCollection, EmployeeDocumentCollection,
      QAfterFilterCondition> employeeIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'employeeId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmployeeDocumentCollection, EmployeeDocumentCollection,
      QAfterFilterCondition> employeeIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'employeeId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmployeeDocumentCollection, EmployeeDocumentCollection,
          QAfterFilterCondition>
      employeeIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'employeeId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmployeeDocumentCollection, EmployeeDocumentCollection,
          QAfterFilterCondition>
      employeeIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'employeeId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmployeeDocumentCollection, EmployeeDocumentCollection,
      QAfterFilterCondition> employeeIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'employeeId',
        value: '',
      ));
    });
  }

  QueryBuilder<EmployeeDocumentCollection, EmployeeDocumentCollection,
      QAfterFilterCondition> employeeIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'employeeId',
        value: '',
      ));
    });
  }

  QueryBuilder<EmployeeDocumentCollection, EmployeeDocumentCollection,
      QAfterFilterCondition> expiryDateIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'expiryDate',
      ));
    });
  }

  QueryBuilder<EmployeeDocumentCollection, EmployeeDocumentCollection,
      QAfterFilterCondition> expiryDateIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'expiryDate',
      ));
    });
  }

  QueryBuilder<EmployeeDocumentCollection, EmployeeDocumentCollection,
      QAfterFilterCondition> expiryDateEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'expiryDate',
        value: value,
      ));
    });
  }

  QueryBuilder<EmployeeDocumentCollection, EmployeeDocumentCollection,
      QAfterFilterCondition> expiryDateGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'expiryDate',
        value: value,
      ));
    });
  }

  QueryBuilder<EmployeeDocumentCollection, EmployeeDocumentCollection,
      QAfterFilterCondition> expiryDateLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'expiryDate',
        value: value,
      ));
    });
  }

  QueryBuilder<EmployeeDocumentCollection, EmployeeDocumentCollection,
      QAfterFilterCondition> expiryDateBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'expiryDate',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<EmployeeDocumentCollection, EmployeeDocumentCollection,
      QAfterFilterCondition> fileNameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'fileName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmployeeDocumentCollection, EmployeeDocumentCollection,
      QAfterFilterCondition> fileNameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'fileName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmployeeDocumentCollection, EmployeeDocumentCollection,
      QAfterFilterCondition> fileNameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'fileName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmployeeDocumentCollection, EmployeeDocumentCollection,
      QAfterFilterCondition> fileNameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'fileName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmployeeDocumentCollection, EmployeeDocumentCollection,
      QAfterFilterCondition> fileNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'fileName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmployeeDocumentCollection, EmployeeDocumentCollection,
      QAfterFilterCondition> fileNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'fileName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmployeeDocumentCollection, EmployeeDocumentCollection,
          QAfterFilterCondition>
      fileNameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'fileName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmployeeDocumentCollection, EmployeeDocumentCollection,
          QAfterFilterCondition>
      fileNameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'fileName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmployeeDocumentCollection, EmployeeDocumentCollection,
      QAfterFilterCondition> fileNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'fileName',
        value: '',
      ));
    });
  }

  QueryBuilder<EmployeeDocumentCollection, EmployeeDocumentCollection,
      QAfterFilterCondition> fileNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'fileName',
        value: '',
      ));
    });
  }

  QueryBuilder<EmployeeDocumentCollection, EmployeeDocumentCollection,
      QAfterFilterCondition> fileUrlEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'fileUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmployeeDocumentCollection, EmployeeDocumentCollection,
      QAfterFilterCondition> fileUrlGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'fileUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmployeeDocumentCollection, EmployeeDocumentCollection,
      QAfterFilterCondition> fileUrlLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'fileUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmployeeDocumentCollection, EmployeeDocumentCollection,
      QAfterFilterCondition> fileUrlBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'fileUrl',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmployeeDocumentCollection, EmployeeDocumentCollection,
      QAfterFilterCondition> fileUrlStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'fileUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmployeeDocumentCollection, EmployeeDocumentCollection,
      QAfterFilterCondition> fileUrlEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'fileUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmployeeDocumentCollection, EmployeeDocumentCollection,
          QAfterFilterCondition>
      fileUrlContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'fileUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmployeeDocumentCollection, EmployeeDocumentCollection,
          QAfterFilterCondition>
      fileUrlMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'fileUrl',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmployeeDocumentCollection, EmployeeDocumentCollection,
      QAfterFilterCondition> fileUrlIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'fileUrl',
        value: '',
      ));
    });
  }

  QueryBuilder<EmployeeDocumentCollection, EmployeeDocumentCollection,
      QAfterFilterCondition> fileUrlIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'fileUrl',
        value: '',
      ));
    });
  }

  QueryBuilder<EmployeeDocumentCollection, EmployeeDocumentCollection,
      QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<EmployeeDocumentCollection, EmployeeDocumentCollection,
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

  QueryBuilder<EmployeeDocumentCollection, EmployeeDocumentCollection,
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

  QueryBuilder<EmployeeDocumentCollection, EmployeeDocumentCollection,
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

  QueryBuilder<EmployeeDocumentCollection, EmployeeDocumentCollection,
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

  QueryBuilder<EmployeeDocumentCollection, EmployeeDocumentCollection,
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

  QueryBuilder<EmployeeDocumentCollection, EmployeeDocumentCollection,
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

  QueryBuilder<EmployeeDocumentCollection, EmployeeDocumentCollection,
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

  QueryBuilder<EmployeeDocumentCollection, EmployeeDocumentCollection,
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

  QueryBuilder<EmployeeDocumentCollection, EmployeeDocumentCollection,
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

  QueryBuilder<EmployeeDocumentCollection, EmployeeDocumentCollection,
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

  QueryBuilder<EmployeeDocumentCollection, EmployeeDocumentCollection,
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

  QueryBuilder<EmployeeDocumentCollection, EmployeeDocumentCollection,
      QAfterFilterCondition> statusIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'status',
        value: '',
      ));
    });
  }

  QueryBuilder<EmployeeDocumentCollection, EmployeeDocumentCollection,
      QAfterFilterCondition> statusIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'status',
        value: '',
      ));
    });
  }

  QueryBuilder<EmployeeDocumentCollection, EmployeeDocumentCollection,
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

  QueryBuilder<EmployeeDocumentCollection, EmployeeDocumentCollection,
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

  QueryBuilder<EmployeeDocumentCollection, EmployeeDocumentCollection,
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

  QueryBuilder<EmployeeDocumentCollection, EmployeeDocumentCollection,
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

  QueryBuilder<EmployeeDocumentCollection, EmployeeDocumentCollection,
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

  QueryBuilder<EmployeeDocumentCollection, EmployeeDocumentCollection,
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

  QueryBuilder<EmployeeDocumentCollection, EmployeeDocumentCollection,
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

  QueryBuilder<EmployeeDocumentCollection, EmployeeDocumentCollection,
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

  QueryBuilder<EmployeeDocumentCollection, EmployeeDocumentCollection,
      QAfterFilterCondition> uuidIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'uuid',
        value: '',
      ));
    });
  }

  QueryBuilder<EmployeeDocumentCollection, EmployeeDocumentCollection,
      QAfterFilterCondition> uuidIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'uuid',
        value: '',
      ));
    });
  }
}

extension EmployeeDocumentCollectionQueryObject on QueryBuilder<
    EmployeeDocumentCollection, EmployeeDocumentCollection, QFilterCondition> {}

extension EmployeeDocumentCollectionQueryLinks on QueryBuilder<
    EmployeeDocumentCollection, EmployeeDocumentCollection, QFilterCondition> {}

extension EmployeeDocumentCollectionQuerySortBy on QueryBuilder<
    EmployeeDocumentCollection, EmployeeDocumentCollection, QSortBy> {
  QueryBuilder<EmployeeDocumentCollection, EmployeeDocumentCollection,
      QAfterSortBy> sortByDocumentType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'documentType', Sort.asc);
    });
  }

  QueryBuilder<EmployeeDocumentCollection, EmployeeDocumentCollection,
      QAfterSortBy> sortByDocumentTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'documentType', Sort.desc);
    });
  }

  QueryBuilder<EmployeeDocumentCollection, EmployeeDocumentCollection,
      QAfterSortBy> sortByEmployeeId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'employeeId', Sort.asc);
    });
  }

  QueryBuilder<EmployeeDocumentCollection, EmployeeDocumentCollection,
      QAfterSortBy> sortByEmployeeIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'employeeId', Sort.desc);
    });
  }

  QueryBuilder<EmployeeDocumentCollection, EmployeeDocumentCollection,
      QAfterSortBy> sortByExpiryDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'expiryDate', Sort.asc);
    });
  }

  QueryBuilder<EmployeeDocumentCollection, EmployeeDocumentCollection,
      QAfterSortBy> sortByExpiryDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'expiryDate', Sort.desc);
    });
  }

  QueryBuilder<EmployeeDocumentCollection, EmployeeDocumentCollection,
      QAfterSortBy> sortByFileName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fileName', Sort.asc);
    });
  }

  QueryBuilder<EmployeeDocumentCollection, EmployeeDocumentCollection,
      QAfterSortBy> sortByFileNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fileName', Sort.desc);
    });
  }

  QueryBuilder<EmployeeDocumentCollection, EmployeeDocumentCollection,
      QAfterSortBy> sortByFileUrl() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fileUrl', Sort.asc);
    });
  }

  QueryBuilder<EmployeeDocumentCollection, EmployeeDocumentCollection,
      QAfterSortBy> sortByFileUrlDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fileUrl', Sort.desc);
    });
  }

  QueryBuilder<EmployeeDocumentCollection, EmployeeDocumentCollection,
      QAfterSortBy> sortByStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.asc);
    });
  }

  QueryBuilder<EmployeeDocumentCollection, EmployeeDocumentCollection,
      QAfterSortBy> sortByStatusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.desc);
    });
  }

  QueryBuilder<EmployeeDocumentCollection, EmployeeDocumentCollection,
      QAfterSortBy> sortByUuid() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uuid', Sort.asc);
    });
  }

  QueryBuilder<EmployeeDocumentCollection, EmployeeDocumentCollection,
      QAfterSortBy> sortByUuidDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uuid', Sort.desc);
    });
  }
}

extension EmployeeDocumentCollectionQuerySortThenBy on QueryBuilder<
    EmployeeDocumentCollection, EmployeeDocumentCollection, QSortThenBy> {
  QueryBuilder<EmployeeDocumentCollection, EmployeeDocumentCollection,
      QAfterSortBy> thenByDocumentType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'documentType', Sort.asc);
    });
  }

  QueryBuilder<EmployeeDocumentCollection, EmployeeDocumentCollection,
      QAfterSortBy> thenByDocumentTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'documentType', Sort.desc);
    });
  }

  QueryBuilder<EmployeeDocumentCollection, EmployeeDocumentCollection,
      QAfterSortBy> thenByEmployeeId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'employeeId', Sort.asc);
    });
  }

  QueryBuilder<EmployeeDocumentCollection, EmployeeDocumentCollection,
      QAfterSortBy> thenByEmployeeIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'employeeId', Sort.desc);
    });
  }

  QueryBuilder<EmployeeDocumentCollection, EmployeeDocumentCollection,
      QAfterSortBy> thenByExpiryDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'expiryDate', Sort.asc);
    });
  }

  QueryBuilder<EmployeeDocumentCollection, EmployeeDocumentCollection,
      QAfterSortBy> thenByExpiryDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'expiryDate', Sort.desc);
    });
  }

  QueryBuilder<EmployeeDocumentCollection, EmployeeDocumentCollection,
      QAfterSortBy> thenByFileName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fileName', Sort.asc);
    });
  }

  QueryBuilder<EmployeeDocumentCollection, EmployeeDocumentCollection,
      QAfterSortBy> thenByFileNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fileName', Sort.desc);
    });
  }

  QueryBuilder<EmployeeDocumentCollection, EmployeeDocumentCollection,
      QAfterSortBy> thenByFileUrl() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fileUrl', Sort.asc);
    });
  }

  QueryBuilder<EmployeeDocumentCollection, EmployeeDocumentCollection,
      QAfterSortBy> thenByFileUrlDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fileUrl', Sort.desc);
    });
  }

  QueryBuilder<EmployeeDocumentCollection, EmployeeDocumentCollection,
      QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<EmployeeDocumentCollection, EmployeeDocumentCollection,
      QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<EmployeeDocumentCollection, EmployeeDocumentCollection,
      QAfterSortBy> thenByStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.asc);
    });
  }

  QueryBuilder<EmployeeDocumentCollection, EmployeeDocumentCollection,
      QAfterSortBy> thenByStatusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.desc);
    });
  }

  QueryBuilder<EmployeeDocumentCollection, EmployeeDocumentCollection,
      QAfterSortBy> thenByUuid() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uuid', Sort.asc);
    });
  }

  QueryBuilder<EmployeeDocumentCollection, EmployeeDocumentCollection,
      QAfterSortBy> thenByUuidDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uuid', Sort.desc);
    });
  }
}

extension EmployeeDocumentCollectionQueryWhereDistinct on QueryBuilder<
    EmployeeDocumentCollection, EmployeeDocumentCollection, QDistinct> {
  QueryBuilder<EmployeeDocumentCollection, EmployeeDocumentCollection,
      QDistinct> distinctByDocumentType({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'documentType', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<EmployeeDocumentCollection, EmployeeDocumentCollection,
      QDistinct> distinctByEmployeeId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'employeeId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<EmployeeDocumentCollection, EmployeeDocumentCollection,
      QDistinct> distinctByExpiryDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'expiryDate');
    });
  }

  QueryBuilder<EmployeeDocumentCollection, EmployeeDocumentCollection,
      QDistinct> distinctByFileName({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'fileName', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<EmployeeDocumentCollection, EmployeeDocumentCollection,
      QDistinct> distinctByFileUrl({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'fileUrl', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<EmployeeDocumentCollection, EmployeeDocumentCollection,
      QDistinct> distinctByStatus({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'status', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<EmployeeDocumentCollection, EmployeeDocumentCollection,
      QDistinct> distinctByUuid({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'uuid', caseSensitive: caseSensitive);
    });
  }
}

extension EmployeeDocumentCollectionQueryProperty on QueryBuilder<
    EmployeeDocumentCollection, EmployeeDocumentCollection, QQueryProperty> {
  QueryBuilder<EmployeeDocumentCollection, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<EmployeeDocumentCollection, String, QQueryOperations>
      documentTypeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'documentType');
    });
  }

  QueryBuilder<EmployeeDocumentCollection, String, QQueryOperations>
      employeeIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'employeeId');
    });
  }

  QueryBuilder<EmployeeDocumentCollection, DateTime?, QQueryOperations>
      expiryDateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'expiryDate');
    });
  }

  QueryBuilder<EmployeeDocumentCollection, String, QQueryOperations>
      fileNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'fileName');
    });
  }

  QueryBuilder<EmployeeDocumentCollection, String, QQueryOperations>
      fileUrlProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'fileUrl');
    });
  }

  QueryBuilder<EmployeeDocumentCollection, String, QQueryOperations>
      statusProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'status');
    });
  }

  QueryBuilder<EmployeeDocumentCollection, String, QQueryOperations>
      uuidProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'uuid');
    });
  }
}
