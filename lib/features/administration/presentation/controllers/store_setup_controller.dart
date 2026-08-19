import 'dart:math';
import 'package:flutter/material.dart';
import 'package:zeno/features/administration/domain/models/store_branch.dart';
import 'package:zeno/features/administration/data/services/store_sync_service.dart';

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
      industry: "Fashion & Apparel",
      subType: "Clothing Store",
      country: "India",
      state: "Kerala",
      currency: "INR (₹)",
      taxEngine: "GST",
      taxId: "32AAAAA0000A1Z5",
      isTaxExempt: false,
      status: "Active",
      qrUrl: "https://zeno.store/str-9821-ind",
    ),
  ];

  List<StoreBranch> get stores => List.unmodifiable(_stores);

  final List<String> industries = [
    'Retail & General Trading',
    'Supermarket & Grocery',
    'Food & Beverage',
    'Pharmacy & Healthcare',
    'Fashion & Apparel',
    'Electronics',
    'Hardware',
    'Automotive',
    'Wholesale',
    'Manufacturing',
    'Services',
    'Books & Stationery',
    'Beauty & Cosmetics',
    'Jewelry & Watches',
    'Home & Furniture',
    'Pet Supplies',
    'Sports & Outdoors',
    'Toy Store',
    'Optical & Eye Care',
    'Footwear',
    'Electronics & IT',
    'Gift & Souvenir',
    'Digital Products',
    'Telecommunications',
    'Hospitality',
    'Real Estate',
    'Logistics & Shipping',
    'Education',
    'Agriculture',
    'Other'
  ];

  final Map<String, List<String>> industryMatrix = {
    'Retail & General Trading': [
      'General Retail',
      'Boutique',
      'Kiosk',
      'Department Store'
    ],
    'Supermarket & Grocery': [
      'Convenience Store',
      'Organic Market',
      'Hypermarket',
      'Specialty Grocery'
    ],
    'Food & Beverage': [
      'Restaurant',
      'Cafe',
      'Fast Food',
      'Bakery',
      'Bar/Lounge',
      'Food Truck'
    ],
    'Pharmacy & Healthcare': [
      'Retail Pharmacy',
      'Clinic',
      'Wellness Center',
      'Medical Supplies'
    ],
    'Fashion & Apparel': [
      'Clothing Store',
      'Footwear',
      'Accessories',
      'Kids Wear'
    ],
    'Electronics': [
      'Mobile & Gadgets',
      'Home Appliances',
      'Computer Hardware',
      'Audio/Video'
    ],
    'Hardware': ['Construction Supplies', 'Tools', 'Plumbing', 'Electrical'],
    'Automotive': ['Spare Parts', 'Service Center', 'Car Wash', 'Tyre Shop'],
    'Wholesale': [
      'FMCG Wholesale',
      'Industrial Wholesale',
      'Distribution Center'
    ],
    'Manufacturing': ['Small Scale Mfg', 'Custom Fabrication', 'Assembly Unit'],
    'Services': ['Salon & Spa', 'Laundry', 'Repair Services', 'Consulting'],
    'Books & Stationery': ['Bookstore', 'Office Supplies', 'Art Gallery'],
    'Beauty & Cosmetics': [
      'Cosmetic Shop',
      'Skincare Boutique',
      'Fragrance Store'
    ],
    'Jewelry & Watches': ['Fine Jewelry', 'Watch Store', 'Fashion Accessories'],
    'Home & Furniture': [
      'Furniture Showroom',
      'Interior Decor',
      'Bedding & Linen'
    ],
    'Pet Supplies': [
      'Pet Food & Accessories',
      'Grooming Center',
      'Veterinary Clinic'
    ],
    'Sports & Outdoors': ['Sports Equipment', 'Gym Gear', 'Outdoor Adventure'],
    'Toy Store': ['Educational Toys', 'Hobby Shop', 'Gift Toys'],
    'Optical & Eye Care': ['Eyewear Boutique', 'Contact Lens Clinic'],
    'Footwear': ['Shoe Store', 'Luxury Footwear', 'Sports Shoes'],
    'Electronics & IT': [
      'Software Sales',
      'Networking Equipment',
      'IT Services'
    ],
    'Gift & Souvenir': ['Gift Shop', 'Antique Store', 'Local Crafts'],
    'Digital Products': ['Software Licenses', 'Digital Content', 'Gaming'],
    'Telecommunications': [
      'Mobile Service Point',
      'SIM & Recharge',
      'Network Solutions'
    ],
    'Hospitality': ['Hotel', 'Guesthouse', 'Resort', 'Event Management'],
    'Real Estate': [
      'Property Agency',
      'Facility Management',
      'Co-working Space'
    ],
    'Logistics & Shipping': [
      'Courier Service',
      'Freight Forwarding',
      'Warehousing'
    ],
    'Education': ['Training Center', 'Coaching Institute', 'School Supplies'],
    'Agriculture': ['Farm Supplies', 'Nursery', 'Agri-Tech Services'],
    'Other': ['Custom Business', 'Non-Profit', 'Miscellaneous'],
  };

  final List<String> businessSizes = [
    'Small (SMB)',
    'Medium (Mid-Market)',
    'Large (Enterprise)'
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
    return industryMatrix[industry] ??
        ['General Retail', 'Wholesale', 'Service Point'];
  }
}
