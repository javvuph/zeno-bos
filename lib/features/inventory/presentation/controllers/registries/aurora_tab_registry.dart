import '../../../domain/models/product_studio_enums.dart';

final Map<String, AuroraStudioTab> fieldToAuroraTab = {
  // IDENTITY
  'title': AuroraStudioTab.identity,
  'arabicTitle': AuroraStudioTab.identity,
  'description': AuroraStudioTab.identity,
  'sku': AuroraStudioTab.identity,
  'barcode': AuroraStudioTab.identity,
  'multiBarcodes': AuroraStudioTab.identity,
  'posShortThermalName': AuroraStudioTab.identity,
  'barcodeType': AuroraStudioTab.identity,
  'eslId': AuroraStudioTab.identity,
  'productClassification': AuroraStudioTab.identity,
  'brandType': AuroraStudioTab.identity,
  'brand': AuroraStudioTab.identity,
  'category': AuroraStudioTab.identity,
  'subcategory': AuroraStudioTab.identity,
  'subDepartment': AuroraStudioTab.identity,
  'department': AuroraStudioTab.identity,
  'returnPolicy': AuroraStudioTab.identity,
  'productLifecycleStatus': AuroraStudioTab.identity,
  'status': AuroraStudioTab.identity,
  'gender': AuroraStudioTab.identity,
  'targetAgeGroup': AuroraStudioTab.identity,
  'countryOfOrigin': AuroraStudioTab.identity,
  'season': AuroraStudioTab.identity,
  'collectionEdition': AuroraStudioTab.identity,
  'healthLicense': AuroraStudioTab.identity,
  'genericSalt': AuroraStudioTab.identity,
  'potency': AuroraStudioTab.identity,
  'dosageForm': AuroraStudioTab.identity,
  'fineDiningCourse': AuroraStudioTab.identity,
  'foodClass': AuroraStudioTab.identity,
  'spiceLevel': AuroraStudioTab.identity,
  'prepTime': AuroraStudioTab.identity,
  'packagingSurcharge': AuroraStudioTab.identity,
  'freshnessDuration': AuroraStudioTab.identity,
  'freshnessUnit': AuroraStudioTab.identity,
  'coldStorageIndicator': AuroraStudioTab.identity,

  // PRICING
  'costPrice': AuroraStudioTab.pricing,
  'sellingPrice': AuroraStudioTab.pricing,
  'mrp': AuroraStudioTab.pricing,
  'wholesalePrice': AuroraStudioTab.pricing,
  'discountValue': AuroraStudioTab.pricing,
  'discountType': AuroraStudioTab.pricing,
  'taxStatus': AuroraStudioTab.pricing,
  'taxCategory': AuroraStudioTab.pricing,
  'taxRate': AuroraStudioTab.pricing,
  'taxJurisdiction': AuroraStudioTab.pricing,
  'taxCode': AuroraStudioTab.pricing,
  'gstTaxMode': AuroraStudioTab.pricing,

  // STOCK
  'openingStock': AuroraStudioTab.stock,
  'safetyStock': AuroraStudioTab.stock,
  'reorderLevel': AuroraStudioTab.stock,
  'warehouseLocation': AuroraStudioTab.stock,
  'supplier': AuroraStudioTab.stock,
  'supplierProductCode': AuroraStudioTab.stock,
  'supplierPurchaseCost': AuroraStudioTab.stock,
  'supplierMOQ': AuroraStudioTab.stock,
  'supplierLeadTime': AuroraStudioTab.stock,
  'secondarySupplier': AuroraStudioTab.stock,
  'floorZone': AuroraStudioTab.stock,
  'planogramId': AuroraStudioTab.stock,
  'planogramAisle': AuroraStudioTab.stock,
  'planogramBay': AuroraStudioTab.stock,
  'planogramRack': AuroraStudioTab.stock,
  'planogramShelf': AuroraStudioTab.stock,
  'planogramBin': AuroraStudioTab.stock,
  'palletStacking': AuroraStudioTab.stock,
  'unitDimensions': AuroraStudioTab.stock,
  'grossWeight': AuroraStudioTab.stock,
  'storageClass': AuroraStudioTab.stock,
  'minDisplayQty': AuroraStudioTab.stock,
  'maxDisplayQty': AuroraStudioTab.stock,

  // MEDIA & CHANNELS
  'marketingTitle': AuroraStudioTab.media,
  'metaDescription': AuroraStudioTab.media,
  'urlSlug': AuroraStudioTab.media,
  'featuredProduct': AuroraStudioTab.media,
  'isQuickPOSSale': AuroraStudioTab.media,
  'visibility': AuroraStudioTab.media,
};

final List<String> auroraEngineFields = [
  // F&B Engine (KitchenRecipeSpecsTab)
  'kotStation', 'kdsCategory', 'courseFireDelay', 'recipeVersion', 'targetFoodCostPct', 'recipePrepNotes',
  // Retail Engine (RetailPackagingTab)
  'unit', 'purchaseUnit', 'conversionFactor', 'unitsPerStrip', 'masterOuterBarcode', 'palletStacking', 
  'grossWeight', 'unitDimensions', 'isEasTagRequired', 'allowLooseBilling', 'inHouseRepack', 'containerDepositFee',
  // Healthcare Engine (Batch & Expiry Sections)
  'enableBatchTracking', 'enableExpiryTracking', 'expiryWarningThreshold', 'freshnessDuration', 'freshnessUnit', 'coldStorageIndicator',
];

AuroraStudioTab getTabForField(String fieldId) {
  return fieldToAuroraTab[fieldId] ?? AuroraStudioTab.identity;
}
