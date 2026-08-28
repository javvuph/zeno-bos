import 'dart:math';
import 'package:flutter/material.dart';
import 'package:zeno/features/administration/domain/models/store_branch.dart';
import 'package:zeno/features/administration/data/services/store_sync_service.dart';
import 'package:zeno/features/inventory/presentation/controllers/registries/sub_business_registry.dart';

export 'package:zeno/features/administration/domain/models/store_branch.dart';

class StoreSetupController extends ChangeNotifier {
  static final StoreSetupController _instance =
      StoreSetupController._internal();
  factory StoreSetupController() => _instance;
  StoreSetupController._internal();

  final _syncService = StoreSyncService();
  bool _isSyncing = false;
  bool get isSyncing => _isSyncing;

  final List<StoreBranch> _stores = [
    StoreBranch(
      id: "STR-9821-IND",
      name: "Tagsole Main",
      legalName: "Tagsole Apparel Private Limited",
      industry: "FASHION",
      subType: "Clothing",
      enabledSubTypes: ["Clothing", "Footwear"],
      country: "India",
      state: "Kerala",
      currency: "INR (₹)",
      taxEngine: "GST",
      taxId: "32AAAAA0000A1Z5",
      isTaxExempt: false,
      status: "Active",
      qrUrl: "https://zeno.store/str-9821-ind",
      businessSize: "SMALL",
    ),
  ];

  List<StoreBranch> get stores => List.unmodifiable(_stores);

  final List<String> industries = [
    'RETAIL',
    'FOOD & BEVERAGE',
    'FASHION',
    'HEALTHCARE',
    'SERVICES',
    'WHOLESALE',
    'ELECTRONICS',
    'FURNITURE',
    'HARDWARE',
    'AUTOMOBILE',
    'AGRICULTURE',
    'PET SHOP',
    'STATIONERY',
    'BOOK STORE',
    'TOY STORE',
    'SPORTS STORE',
    'HOME DECOR',
    'GENERAL / STANDARD'
  ];

  final Map<String, List<String>> industryMatrix = businessCategoryMap;

  final List<String> businessSizes = [
    'SMALL',
    'GROWING',
    'ENTERPRISE'
  ];

  final List<String> operationModes = [
    'Counter-Service',
    'Self-Service',
    'Delivery-Only',
    'Appointment-Based'
  ];
  final List<String> inventoryMethods = [
    'FIFO',
    'LIFO',
    'Weighted Average',
    'Manual'
  ];
  final List<String> paymentMethods = [
    'Cash',
    'Credit/Debit Card',
    'UPI/QR',
    'Wallet',
    'Bank Transfer',
    'Credit'
  ];
  final List<String> barcodeTemplates = [
    'EAN-13 Standard',
    'Code-128 Retail',
    'QR-Optimized'
  ];
  final List<String> receiptTemplates = [
    'Thermal 80mm Standard',
    'Thermal 58mm Slim',
    'A4 Professional',
    'Digital-Only'
  ];
  final List<String> aiConfigs = [
    'Demand Forecasting',
    'Smart Stock Replenishment',
    'Customer Sentiment Analysis',
    'Dynamic Pricing'
  ];
  final List<String> workflowApprovals = [
    'Multi-Level Purchase',
    'Discount Overrides',
    'Inventory Adjustments',
    'Refund Approvals'
  ];

  final List<String> countries = [
    'India',
    'UAE',
    'USA',
    'UK',
    'Saudi Arabia',
    'Singapore',
    'Malaysia',
    'Australia'
  ];

  String generateStoreId(String countryName) {
    final countryCode = countryName.length >= 3
        ? countryName.substring(0, 3).toUpperCase()
        : 'GEN';
    final random = Random().nextInt(9000) + 1000;
    return "STR-$random-$countryCode";
  }

  Future<void> saveStore(StoreBranch store) async {
    _isSyncing = true;
    notifyListeners();

    try {
      // 1. Sync to "Backend"
      await _syncService.syncStore(store);

      // 2. Persist Locally
      final index = _stores.indexWhere((s) => s.id == store.id);
      if (index != -1) {
        _stores[index] = store;
      } else {
        _stores.add(store);
      }
    } finally {
      _isSyncing = false;
      notifyListeners();
    }
  }

  void deleteStore(String id) {
    _stores.removeWhere((s) => s.id == id);
    notifyListeners();
  }

  void duplicateStore(String id) {
    final index = _stores.indexWhere((s) => s.id == id);
    if (index != -1) {
      final original = _stores[index];
      final newId = generateStoreId(original.country);

      // Update with new ID and slightly modified name
      final newStore = original.copy(
        id: newId,
        name: "${original.name} (Copy)",
        status: "Draft",
        qrUrl: "https://zeno.store/${newId.toLowerCase()}",
      );

      _stores.add(newStore);
      notifyListeners();
    }
  }

  Map<String, String> getDefaultsForCountry(String country) {
    switch (country) {
      case 'India':
        return {'currency': 'INR (₹)', 'taxEngine': 'GST'};
      case 'UAE':
      case 'Saudi Arabia':
        return {'currency': 'AED (د.إ)', 'taxEngine': 'VAT'};
      case 'USA':
        return {'currency': 'USD (\$)', 'taxEngine': 'State Sales Tax'};
      case 'UK':
        return {'currency': 'GBP (£)', 'taxEngine': 'VAT'};
      default:
        return {'currency': 'USD (\$)', 'taxEngine': 'Flat / Custom Tax'};
    }
  }

  List<String> getStates(String country) {
    if (country == 'India') {
      return ['Kerala', 'Karnataka', 'Maharashtra', 'Tamil Nadu', 'Delhi'];
    }
    if (country == 'USA') {
      return ['California', 'Texas', 'New York', 'Florida', 'Washington'];
    }
    if (country == 'UAE') {
      return ['Dubai', 'Abu Dhabi', 'Sharjah', 'Ajman'];
    }
    return ['Region A', 'Region B', 'Region C'];
  }

  List<String> getSubTypes(String industry) {
    // Case-insensitive lookup
    final normalizedIndustry = industry.toUpperCase();
    for (var key in industryMatrix.keys) {
      if (key.toUpperCase() == normalizedIndustry) {
        return industryMatrix[key]!;
      }
    }
    return ['General Retail', 'Wholesale', 'Service Point'];
  }
}
