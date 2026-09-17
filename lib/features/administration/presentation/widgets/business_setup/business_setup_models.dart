import 'package:flutter/material.dart';

enum BusinessScale { none, small, growing, enterprise }

class BusinessSetupData extends ChangeNotifier {
  // Step 1: Store & Business Identity
  String storeName = "Tagsole Main";
  String legalName = "Tagsole Apparel Private Limited";
  String phone = "+91";
  String email = "branch@zeno.store";
  String selectedMainBusiness = "FASHION";
  List<String> selectedSubBusinesses = ["Clothing (Shirts, Pants, T-Shirts)", "Footwear"];
  BusinessScale selectedScale = BusinessScale.small;

  // Step 2: Regional & Tax
  String country = "India";
  String state = "Kerala";
  String taxId = "32AAAAAA000A1Z5";
  String address = "Building 12, Commercial Street";
  String city = "Calicut";
  String zipCode = "673001";
  String timezone = "Asia/Kolkata";
  bool isTaxInclusive = true;

  // Step 3: Operations & POS
  String terminalType = "Terminal 1";
  String hardwareType = "Touchscreen POS";
  String operationMode = "Counter-Service";
  String receiptTemplate = "Thermal 80mm Standard";
  String barcodeTemplate = "EAN-13 Standard";
  String costingMethod = "FIFO";
  List<String> paymentMethods = ["Cash", "Credit Card", "Debit Card", "UPI"];
  String invoicePrefix = "INV";
  String orderPrefix = "ORD";
  String receiptPrefix = "REC";
  String purchasePrefix = "PUR";

  // Step 4: Online Store & QR
  String systemId = "STR-9821-IND";
  String storeUrl = "https://zeno.store/str-9821-ind";
  bool autoPrintPos = false;

  // Step 5: Team & Access
  String staffEmail = "cashier@zeno.store";
  String staffPin = "1234";
  String staffRole = "Cashier";

  // Step 6: Enterprise Workflows
  List<String> selectedAiConfigs = ["Demand Forecasting", "Smart Stock Replenishment"];
  List<String> selectedWorkflowApprovals = ["Discount Overrides", "Inventory Adjustments"];

  void notifyDataChanged() {
    notifyListeners();
  }

  int getFilledFieldsCount() {
    int filled = 0;

    // Step 1 Fields (4)
    if (storeName.trim().isNotEmpty) filled++;
    if (selectedMainBusiness.trim().isNotEmpty) filled++;
    if (selectedSubBusinesses.isNotEmpty) filled++;
    if (selectedScale != BusinessScale.none) filled++;

    // Step 2 Fields (6)
    if (country.trim().isNotEmpty) filled++;
    if (state.trim().isNotEmpty) filled++;
    if (taxId.trim().isNotEmpty) filled++;
    if (address.trim().isNotEmpty) filled++;
    if (city.trim().isNotEmpty) filled++;
    if (zipCode.trim().isNotEmpty) filled++;

    // Step 3 Fields (9)
    if (terminalType.trim().isNotEmpty) filled++;
    if (hardwareType.trim().isNotEmpty) filled++;
    if (operationMode.trim().isNotEmpty) filled++;
    if (costingMethod.trim().isNotEmpty) filled++;
    if (paymentMethods.isNotEmpty) filled++;
    if (invoicePrefix.trim().isNotEmpty) filled++;
    if (orderPrefix.trim().isNotEmpty) filled++;
    if (receiptPrefix.trim().isNotEmpty) filled++;
    if (purchasePrefix.trim().isNotEmpty) filled++;

    // Step 4 Fields (2)
    if (systemId.trim().isNotEmpty) filled++;
    if (storeUrl.trim().isNotEmpty) filled++;

    // Step 5 Fields (3)
    if (staffEmail.trim().isNotEmpty) filled++;
    if (staffPin.trim().isNotEmpty) filled++;
    if (staffRole.trim().isNotEmpty) filled++;

    // Step 6 Fields (2)
    if (selectedAiConfigs.isNotEmpty) filled++;
    if (selectedWorkflowApprovals.isNotEmpty) filled++;

    return filled;
  }

  int getTotalFieldsCount() {
    return 26; // Total tracked fields across all 6 steps
  }

  double getProgressPercentage() {
    final total = getTotalFieldsCount();
    if (total == 0) return 0.0;
    final filled = getFilledFieldsCount();
    final pct = (filled / total) * 100;
    return pct.clamp(0.0, 100.0);
  }
}
