import 'package:zeno/core/database/database_service.dart';
import 'package:zeno/core/database/collections/crm_collections.dart';
import '../../domain/repositories/i_supplier_repository.dart';
import '../../domain/models/supplier.dart';
import '../../domain/models/supplier_address.dart';
import '../../domain/models/supplier_rating.dart';
import 'package:isar/isar.dart';

class IsarSupplierRepository implements ISupplierRepository {
  final DatabaseService db;
  IsarSupplierRepository(this.db);

  IsarCollection<SupplierCollection> get collection =>
      db.isar.collection<SupplierCollection>();

  @override
  Future<Supplier?> getSupplierById(String id) async {
    final s = await collection.where().uuidEqualTo(id).findFirst();
    if (s == null) return null;
    return _toDomain(s);
  }

  @override
  Future<List<Supplier>> getAllSuppliers() async {
    final results = await collection.filter().isDeletedEqualTo(false).findAll();
    return results.map((s) => _toDomain(s)).toList();
  }

  @override
  Future<List<Supplier>> getDeletedSuppliers() async {
    final results = await collection.filter().isDeletedEqualTo(true).findAll();
    return results.map((s) => _toDomain(s)).toList();
  }

  @override
  Future<void> saveSupplier(Supplier supplier) async {
    final existing =
        await collection.where().uuidEqualTo(supplier.id).findFirst();

    final s = (existing ?? SupplierCollection())
      ..uuid = supplier.id
      ..supplierCode = supplier.supplierCode
      ..type = supplier.type.name
      ..name = supplier.name
      ..legalName = supplier.legalName
      ..category = supplier.category
      ..email = supplier.email
      ..phone = supplier.phone
      ..currency = supplier.currency
      ..address =
          supplier.addresses.isNotEmpty ? supplier.addresses.first.street : null
      ..city =
          supplier.addresses.isNotEmpty ? supplier.addresses.first.city : null
      ..isPreferred = supplier.isPreferred
      ..creditLimit = supplier.creditLimit
      ..averageLeadTime = supplier.averageLeadTime
      ..ratingScore = supplier.rating.overallScore
      ..isDeleted = false
      ..updatedAt = DateTime.now();

    if (existing == null) {
      s.createdAt = supplier.createdAt;
    }

    await db.isar.writeTxn(() async {
      await collection.put(s);
    });
  }

  @override
  Future<void> deleteSupplier(String id) async {
    final s = await collection.where().uuidEqualTo(id).findFirst();
    if (s != null) {
      await db.isar.writeTxn(() async {
        s.isDeleted = true;
        s.updatedAt = DateTime.now();
        await collection.put(s);
      });
    }
  }

  @override
  Future<void> restoreSupplier(String id) async {
    final s = await collection.where().uuidEqualTo(id).findFirst();
    if (s != null) {
      await db.isar.writeTxn(() async {
        s.isDeleted = false;
        s.updatedAt = DateTime.now();
        await collection.put(s);
      });
    }
  }

  @override
  Future<List<Supplier>> searchSuppliers(String query) async {
    if (query.isEmpty) return getAllSuppliers();

    final results = await collection
        .filter()
        .isDeletedEqualTo(false)
        .and()
        .group((q) => q
            .nameContains(query, caseSensitive: false)
            .or()
            .emailContains(query, caseSensitive: false)
            .or()
            .phoneContains(query, caseSensitive: false)
            .or()
            .categoryContains(query, caseSensitive: false))
        .findAll();

    return results.map((s) => _toDomain(s)).toList();
  }

  @override
  Future<List<Supplier>> getSuppliersByCategory(String category) async {
    final results = await collection
        .filter()
        .isDeletedEqualTo(false)
        .and()
        .categoryEqualTo(category, caseSensitive: false)
        .findAll();
    return results.map((s) => _toDomain(s)).toList();
  }

  Supplier _toDomain(SupplierCollection s) {
    return Supplier(
      id: s.uuid,
      supplierCode: s.supplierCode,
      type: SupplierType.values.firstWhere((e) => e.name == s.type,
          orElse: () => SupplierType.company),
      name: s.name,
      legalName: s.legalName,
      category: s.category,
      email: s.email,
      phone: s.phone,
      currency: s.currency,
      isPreferred: s.isPreferred,
      creditLimit: s.creditLimit,
      averageLeadTime: s.averageLeadTime,
      addresses: s.address != null
          ? [
              SupplierAddress(
                id: '${s.uuid}_addr',
                street: s.address!,
                city: s.city ?? '',
                label: 'PRIMARY',
                state: '',
                country: '',
                postalCode: '',
                type: SupplierAddressType.office,
                isDefault: true,
              )
            ]
          : [],
      rating: SupplierRating(overallScore: s.ratingScore),
      createdAt: s.createdAt,
      updatedAt: s.updatedAt,
    );
  }
}
