part of '../product_studio_data.dart';

/// Core identity, taxonomy, and marketing fields.
mixin ProductStudioDataCore {
  String id = "";
  String title = "";
  String arabicTitle = "";
  String sku = "";
  String barcode = "";
  String barcodeType = "EAN-13";
  List<String> multiBarcodes = [];
  String category = "";
  String subcategory = "";
  String brand = "";
  String sectorId = "";
  String departmentId = "";
  String subDepartmentId = "";
  String brandType = "";
  String status = "Active";
  String productLifecycleStatus = "Draft";
  String visibility = "Public";
  String countryOfOrigin = "";
  String manufacturerName = "";
  DateTime? launchDate;
  DateTime? discontinueDate;

  // Aliases for legacy compatibility
  String get productName => title;
  set productName(String v) => title = v;
  String get masterSku => sku;
  set masterSku(String v) => sku = v;
  String get primaryBarcode => barcode;
  set primaryBarcode(String v) => barcode = v;
  String get categoryId => category;
  set categoryId(String v) => category = v;
  String get subCategoryId => subcategory;
  set subCategoryId(String v) => subcategory = v;
  String get brandId => brand;
  set brandId(String v) => brand = v;

  // Global marketing fields
  String marketingTitle = "";
  String shortDescription = "";
  String description = "";
  String metaDescription = "";
  String urlSlug = "";
  String tags = "";
  List<String> searchKeywords = [];
  String promotionalBadges = "";
  String primaryImageUrl = "";
  List<String> galleryUrls = [];
  bool featuredProduct = false;
  String targetAudience = "";
  String seoTitle = "";

  // Audit and Lifecycle
  Map<String, dynamic> auditLog = {};
  ProductLifecycleState lifecycleState = ProductLifecycleState.draft;
}
