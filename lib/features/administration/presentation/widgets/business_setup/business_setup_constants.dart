import 'package:zeno/features/inventory/presentation/controllers/registries/sub_business_registry.dart';

class BusinessSetupConstants {
  static List<String> get mainBusinesses =>
      businessCategoryMap.keys.toList(growable: false);

  static List<String> getSubBusinesses(String mainBusiness) {
    final key = businessCategoryMap.keys.firstWhere(
      (k) => k.toUpperCase() == mainBusiness.toUpperCase(),
      orElse: () => mainBusiness,
    );
    return List.unmodifiable(businessCategoryMap[key] ?? const <String>[]);
  }

  static const List<String> terminalTypes = [
    "Terminal 1",
    "Terminal 2",
    "Main HQ Terminal",
    "Mobile POS",
  ];

  static const List<String> hardwareTypes = [
    "Touchscreen POS",
    "Desktop PC",
    "Android Tablet",
    "Handheld Scanner",
  ];

  static const List<String> operationModes = [
    "Counter-Service",
    "Table Service",
    "Self-Checkout",
    "Multi-Register",
  ];

  static const List<String> receiptTemplates = [
    "Thermal 80mm Standard",
    "Thermal 58mm Compact",
    "A4 Enterprise Invoice",
    "Digital e-Receipt",
  ];

  static const List<String> barcodeTemplates = [
    "EAN-13 Standard",
    "UPC-A Standard",
    "Code-128 Custom",
    "QR Code Direct",
  ];

  static const List<String> costingMethods = [
    "FIFO",
    "LIFO",
    "Weighted Average",
    "Manual",
  ];

  static const List<String> paymentMethodOptions = [
    "Cash",
    "Credit Card",
    "Debit Card",
    "UPI",
    "Digital Wallet",
    "Bank Transfer",
    "Credit/Line of Credit",
  ];

  static const List<String> staffRoles = [
    "Cashier",
    "Store Manager",
    "Accountant",
    "Inventory Lead",
  ];

  static const List<String> aiConfigOptions = [
    "Demand Forecasting",
    "Smart Stock Replenishment",
    "Customer Sentiment",
    "Dynamic Pricing",
  ];

  static const List<String> workflowApprovalOptions = [
    "Multi-Level Purchase",
    "Discount Overrides",
    "Inventory Adjustments",
    "Refund Approvals",
  ];
}
