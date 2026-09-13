import 'media_asset.dart';
import 'product_studio_enums.dart';

class VariantMatrixItem {
  final String size;
  final String color;
  bool isSelected;
  String sku;
  String barcode;
  double price; // Represents Selling Price
  double purchasePrice;
  double mrp;
  double wholesalePrice;
  int stock;
  int safetyStock;
  double reorderLevel;
  String warehouseLocation;

  // New Discount Fields
  String discountType; // "Percentage" or "Amount"
  double discountValue;

  // Advanced Fields
  String taxStatus;
  String taxCategory;
  String taxJurisdiction;
  String hsnCode;
  String primarySupplier;
  String supplierSku;
  double supplierPurchaseCost;
  int moq;
  int leadTime;
  String marketingTitle;
  String urlSlug;
  String metaDescription;
  String status;
  String productRelationship;
  String warrantyInfo;

  MediaMode mediaMode;
  List<MediaAsset>? customMedia;

  VariantMatrixItem({
    required this.size,
    required this.color,
    this.isSelected = false,
    required this.sku,
    this.barcode = "",
    required this.price,
    this.purchasePrice = 0,
    this.mrp = 0,
    this.wholesalePrice = 0,
    required this.stock,
    this.safetyStock = 0,
    this.reorderLevel = 0,
    this.warehouseLocation = "",
    this.discountType = "Percentage",
    this.discountValue = 0,
    this.taxStatus = "Taxable",
    this.taxCategory = "Standard",
    this.taxJurisdiction = "Default",
    this.hsnCode = "",
    this.primarySupplier = "",
    this.supplierSku = "",
    this.supplierPurchaseCost = 0,
    this.moq = 1,
    this.leadTime = 0,
    this.marketingTitle = "",
    this.urlSlug = "",
    this.metaDescription = "",
    this.status = "Active",
    this.productRelationship = "",
    this.warrantyInfo = "",
    this.mediaMode = MediaMode.inherited,
    this.customMedia,
  });
}
