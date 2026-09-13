import '../../../domain/models/product_studio_enums.dart';

final Map<String, AuroraStudioTab> fieldToAuroraTab = {
  // 1. BASIC INFO
  'title': AuroraStudioTab.identity,
  'arabicTitle': AuroraStudioTab.identity,
  'description': AuroraStudioTab.identity,
  'sku': AuroraStudioTab.identity,
  'barcode': AuroraStudioTab.identity,
  'multiBarcodes': AuroraStudioTab.identity,
  'posShortThermalName': AuroraStudioTab.identity,
  'barcodeType': AuroraStudioTab.identity,
  'status': AuroraStudioTab.identity,
  'productLifecycleStatus': AuroraStudioTab.identity,
  'visibility': AuroraStudioTab.identity,
  'countryOfOrigin': AuroraStudioTab.identity,
  'returnPolicy': AuroraStudioTab.identity,
  'taxCode': AuroraStudioTab.identity,

  // 2. DEPARTMENT
  'brand': AuroraStudioTab.planogram,
  'category': AuroraStudioTab.planogram,
  'department': AuroraStudioTab.planogram,
  'subDepartment': AuroraStudioTab.planogram,
  'subcategory': AuroraStudioTab.planogram,
  'sectorId': AuroraStudioTab.planogram,
  'floorZone': AuroraStudioTab.planogram,
  'planogramId': AuroraStudioTab.planogram,
  'planogramAisle': AuroraStudioTab.planogram,
  'planogramBay': AuroraStudioTab.planogram,
  'planogramRack': AuroraStudioTab.planogram,
  'planogramShelf': AuroraStudioTab.planogram,
  'planogramBin': AuroraStudioTab.planogram,
  'storageClass': AuroraStudioTab.planogram,

  // 3. PACK & SIZE
  'unit': AuroraStudioTab.logistics,
  'purchaseUnit': AuroraStudioTab.logistics,
  'conversionFactor': AuroraStudioTab.logistics,
  'innerPackQuantity': AuroraStudioTab.logistics,
  'masterCaseMultiplier': AuroraStudioTab.logistics,
  'palletStacking': AuroraStudioTab.logistics,
  'grossWeight': AuroraStudioTab.logistics,
  'netWeight': AuroraStudioTab.logistics,
  'unitDimensions': AuroraStudioTab.logistics,
  'packaging': AuroraStudioTab.logistics,
  'packageType': AuroraStudioTab.logistics,
  'allowLooseBilling': AuroraStudioTab.logistics,
  'inHouseRepack': AuroraStudioTab.logistics,

  // 4. PRICE & TAX
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
  'gstTaxMode': AuroraStudioTab.pricing,

  // 5. STOCK & SUPPLIER
  'openingStock': AuroraStudioTab.stock,
  'safetyStock': AuroraStudioTab.stock,
  'reorderLevel': AuroraStudioTab.stock,
  'warehouseLocation': AuroraStudioTab.stock,
  'autoReplenish': AuroraStudioTab.stock,
  'leadTimeBuffer': AuroraStudioTab.stock,
  'supplier': AuroraStudioTab.stock,
  'primarySupplierId': AuroraStudioTab.stock,
  'supplierProductCode': AuroraStudioTab.stock,
  'supplierMOQ': AuroraStudioTab.stock,
  'supplierLeadTime': AuroraStudioTab.stock,

  // 6. PHOTOS & ONLINE
  'marketingTitle': AuroraStudioTab.media,
  'metaDescription': AuroraStudioTab.media,
  'urlSlug': AuroraStudioTab.media,
  'featuredProduct': AuroraStudioTab.media,
  'primaryImageUrl': AuroraStudioTab.media,
  'galleryUrls': AuroraStudioTab.media,
  'isQuickPOSSale': AuroraStudioTab.media,
  'showOnPos': AuroraStudioTab.media,
  'showOnApp': AuroraStudioTab.media,
  'showOnWeb': AuroraStudioTab.media,
};

final List<String> auroraEngineFields = [
  // This version consolidates engine fields into specific tabs
];

AuroraStudioTab getTabForField(String fieldId) {
  return fieldToAuroraTab[fieldId] ?? AuroraStudioTab.identity;
}
