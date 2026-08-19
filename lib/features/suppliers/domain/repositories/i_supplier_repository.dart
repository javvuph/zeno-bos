import '../models/supplier.dart';

abstract class ISupplierRepository {
  Future<Supplier?> getSupplierById(String id);
  Future<List<Supplier>> getAllSuppliers();
  Future<void> saveSupplier(Supplier supplier);
  Future<void> deleteSupplier(String id);
  Future<void> restoreSupplier(String id);
  Future<List<Supplier>> searchSuppliers(String query);
  Future<List<Supplier>> getSuppliersByCategory(String category);
  Future<List<Supplier>> getDeletedSuppliers();
}
