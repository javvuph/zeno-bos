import 'package:flutter/material.dart';
import '../../domain/models/supplier.dart';
import '../../domain/repositories/i_supplier_repository.dart';
import '../../domain/services/supplier_business_logic.dart';

class SupplierController extends ChangeNotifier {
  final ISupplierRepository _repository;
  final SupplierBusinessLogic _logic = SupplierBusinessLogic();

  SupplierController(this._repository) {
    loadSuppliers();
  }

  List<Supplier> _suppliers = [];
  List<Supplier> get suppliers => _suppliers;

  List<Supplier> _deletedSuppliers = [];
  List<Supplier> get deletedSuppliers => _deletedSuppliers;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _error;
  String? get error => _error;

  // Analytics Bridges
  int get preferredCount => suppliers.where((s) => s.isPreferred).length;
  double get avgReliability => suppliers.isEmpty
      ? 0
      : suppliers.fold(0.0, (sum, s) => sum + s.rating.overallScore) /
          suppliers.length;

  /// Performs an in-memory search across key fields
  List<Supplier> search(String query) {
    if (query.isEmpty) return suppliers;
    final q = query.toLowerCase();
    return suppliers
        .where((s) =>
            s.name.toLowerCase().contains(q) ||
            s.email.toLowerCase().contains(q) ||
            s.category.toLowerCase().contains(q) ||
            s.id.toLowerCase().contains(q))
        .toList();
  }

  /// Calculates profile completion for a supplier
  double getReadiness(Supplier supplier) => _logic.calculateReadiness(supplier);

  Future<void> loadSuppliers() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _suppliers = await _repository.getAllSuppliers();
      _deletedSuppliers = await _repository.getDeletedSuppliers();
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> deleteSupplier(String id) async {
    _isLoading = true;
    notifyListeners();
    try {
      await _repository.deleteSupplier(id);
      await loadSuppliers();
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> restoreSupplier(String id) async {
    _isLoading = true;
    notifyListeners();
    try {
      await _repository.restoreSupplier(id);
      await loadSuppliers();
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> saveSupplier(Supplier supplier) async {
    // Auto-evaluate preferred status before saving
    final updatedSupplier = supplier.copyWith(
      isPreferred: _logic.evaluatePreferredStatus(supplier),
      updatedAt: DateTime.now(),
    );

    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      await _repository.saveSupplier(updatedSupplier);
      await loadSuppliers();
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
