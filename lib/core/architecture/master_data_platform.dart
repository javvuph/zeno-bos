import 'package:flutter/material.dart';
import 'package:zeno/features/inventory/domain/models/category.dart';
import 'package:zeno/features/inventory/domain/models/brand.dart';
import 'package:zeno/features/inventory/domain/models/unit.dart';
import 'package:zeno/features/inventory/domain/models/warehouse.dart';
import 'package:zeno/features/inventory/domain/models/inventory_rule.dart';
import 'package:zeno/features/suppliers/domain/models/supplier.dart';

/// MasterDataPlatform (MDP) v1.2
/// Universal centralized platform for all ZENO BOS master data domains.
class MasterDataPlatform extends ChangeNotifier {
  static final MasterDataPlatform _instance = MasterDataPlatform._internal();
  factory MasterDataPlatform() => _instance;
  MasterDataPlatform._internal();

  // --- 1. INVENTORY DOMAIN ---
  final Map<String, Category> _categories = {};
  final Map<String, Brand> _brands = {};
  final Map<String, Unit> _units = {};
  final Map<String, Warehouse> _warehouses = {};
  final Map<String, InventoryRule> _inventoryRules = {};

  // --- 2. BUSINESS DOMAIN ---
  final List<String> branches = [
    'Main HQ',
    'North Retail',
    'South Distribution'
  ];
  final List<String> departments = [
    'Operations',
    'Sales',
    'Finance',
    'HR',
    'IT'
  ];

  // --- 3. CRM DOMAIN ---
  final List<String> customerGroups = [
    'Retail',
    'Wholesale',
    'VIP',
    'Government'
  ];

  // --- 4. PROCUREMENT DOMAIN ---
  final Map<String, Supplier> _suppliers = {};
  final List<String> supplierCategories = [
    'Manufacturer',
    'Wholesaler',
    'Distributor',
    'Importer',
    'Local Vendor'
  ];

  // --- INVENTORY ACCESSORS ---
  List<Category> get categories => _categories.values.toList();
  List<Brand> get brands => _brands.values.toList();
  List<Unit> get units => _units.values.toList();
  List<Warehouse> get warehouses => _warehouses.values.toList();
  List<InventoryRule> get inventoryRules => _inventoryRules.values.toList();

  // --- PROCUREMENT ACCESSORS ---
  List<Supplier> get suppliers => _suppliers.values.toList();

  // --- REGISTRATION ---
  void registerWarehouses(List<Warehouse> list) {
    for (var w in list) {
      _warehouses[w.id] = w;
    }
    notifyListeners();
  }

  void registerCategories(List<Category> list) {
    for (var c in list) {
      _categories[c.id] = c;
    }
    notifyListeners();
  }

  void registerInventoryRules(List<InventoryRule> list) {
    for (var r in list) {
      _inventoryRules[r.id] = r;
    }
    notifyListeners();
  }

  void registerSuppliers(List<Supplier> list) {
    for (var s in list) {
      _suppliers[s.id] = s;
    }
    notifyListeners();
  }

  // --- RESOLVERS ---
  Warehouse? resolveWarehouse(String id) => _warehouses[id];
  Category? resolveCategory(String? id) => _categories[id];
  InventoryRule? resolveInventoryRule(String id) => _inventoryRules[id];
  Supplier? resolveSupplier(String id) => _suppliers[id];
}
