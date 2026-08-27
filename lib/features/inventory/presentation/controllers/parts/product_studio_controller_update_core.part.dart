part of '../product_studio_controller.dart';

extension ProductStudioControllerUpdateCore on ProductStudioController {
  void _updateCoreFields(ProductStudioData p, {
    String? title, String? arabicTitle, String? sku, String? barcode, List<String>? multiBarcodes,
    String? category, String? subcategory,
    String? brand, String? subBrand, String? manufacturer,
    String? status, String? productLifecycleStatus, String? visibility,
    String? countryOfOrigin, String? manufacturerPartNumber, String? vendorSku, String? internalBarcode,
    DateTime? launchDate, DateTime? discontinueDate,
    String? marketingTitle, String? shortDescription, String? description, String? metaDescription,
    String? urlSlug, String? tags, List<String>? searchKeywords, String? promotionalBadges,
    String? primaryImageUrl, List<String>? galleryUrls, bool? featuredProduct, String? targetAudience,
    String? seoTitle, String? sectorId, String? departmentId, String? subDepartmentId,
    String? productType, String? segment,
    bool? appVisibility, bool? b2bVisibility,
  }) {
    if (title != null) p.title = title;
    if (arabicTitle != null) p.arabicTitle = arabicTitle;
    if (sku != null) p.sku = sku;
    if (barcode != null) p.barcode = barcode;
    if (multiBarcodes != null) p.multiBarcodes = multiBarcodes;
    if (category != null) p.category = category;
    if (subcategory != null) p.subcategory = subcategory;
    if (brand != null) p.brand = brand;
    if (subBrand != null) p.subBrand = subBrand;
    if (manufacturer != null) p.manufacturer = manufacturer;
    if (status != null) p.status = status;
    if (productLifecycleStatus != null) p.productLifecycleStatus = productLifecycleStatus;
    if (visibility != null) p.visibility = visibility;
    if (countryOfOrigin != null) p.countryOfOrigin = countryOfOrigin;
    if (manufacturerPartNumber != null) p.manufacturerPartNumber = manufacturerPartNumber;
    if (vendorSku != null) p.vendorSku = vendorSku;
    if (internalBarcode != null) p.internalBarcode = internalBarcode;
    if (launchDate != null) p.launchDate = launchDate;
    if (discontinueDate != null) p.discontinueDate = discontinueDate;
    if (marketingTitle != null) p.marketingTitle = marketingTitle;
    if (shortDescription != null) p.shortDescription = shortDescription;
    if (description != null) p.description = description;
    if (metaDescription != null) p.metaDescription = metaDescription;
    if (urlSlug != null) p.urlSlug = urlSlug;
    if (tags != null) p.tags = tags;
    if (searchKeywords != null) p.searchKeywords = searchKeywords;
    if (promotionalBadges != null) p.promotionalBadges = promotionalBadges;
    if (primaryImageUrl != null) p.primaryImageUrl = primaryImageUrl;
    if (galleryUrls != null) p.galleryUrls = galleryUrls;
    if (featuredProduct != null) p.featuredProduct = featuredProduct;
    if (targetAudience != null) p.targetAudience = targetAudience;
    if (seoTitle != null) p.seoTitle = seoTitle;
    if (sectorId != null) p.sectorId = sectorId;
    if (departmentId != null) p.departmentId = departmentId;
    if (subDepartmentId != null) p.subDepartmentId = subDepartmentId;
    if (productType != null) p.productType = productType;
    if (segment != null) p.segment = segment;
    if (appVisibility != null) p.appVisibility = appVisibility;
    if (b2bVisibility != null) p.b2bVisibility = b2bVisibility;
  }

  void _updateEnterpriseFields(ProductStudioData p, {
    double? costPrice, double? sellingPrice, double? mrp, double? wholesalePrice,
    double? onlinePrice, double? memberLoyaltyPrice, double? loyaltyPointsMultiplier,
    String? discountType, double? discountValue, double? maxDiscountPct,
    bool? autoComputeLandedCost, bool? isLiveMarketPrice, DateTime? priceEffectiveFrom,
    String? currency, double? targetMarginPct, double? targetMarkupPct, double? branchSellingPrice,
    bool? trackInventory, bool? allowNegativeStock, int? openingStock,
    int? minStock, int? safetyStock,
    int? maxStock, double? reorderLevel, String? warehouseLocation, String? stockUnit,
    String? salesUnit, String? purchaseUnit, double? conversionFactor,
    double? grossWeight, double? netWeight, double? tareWeight, String? unitDimensions,
    String? packageType, int? unitsPerPackage, double? packageQuantity,
    double? packagingDeposit, double? packagingCost, double? containerDepositFee,
    String? storageClass, String? storageCondition, String? floorZone,
    bool? coldStorageIndicator, bool? coldChainRequired, String? logisticsSlab,
    String? volumetricWeight, String? countryRestrictions, String? valuationMethod,
    int? leadTimeBuffer, bool? autoReplenish, int? innerPackQuantity,
    String? taxStatus, String? taxCategory, double? taxRate, String? taxJurisdiction,
    String? taxCode, String? gstTaxMode, String? taxTreatment, String? vatCategory,
    String? selectiveExciseTax, String? zatcaCode, String? sacCode, String? hsnCode,
    String? taxExemptionNo, String? importDutyClass,
    String? supplier, String? secondarySupplier, String? supplierProductCode,
    String? supplierProductName, double? supplierPurchaseCost, int? supplierMOQ,
    int? supplierLeadTime, String? supplierPaymentTerms, String? supplierContact,
    String? supplierNotes, String? primarySupplierId, String? supplierSku,
    double? vendorContractCost, double? supplierMoq,
    String? pluCode, String? unit, String? posShortThermalName, String? posReceiptName,
    bool? isQuickPOSSale, bool? posHotkeyEnabled, bool? posAgeGate,
    String? posManualDiscount, String? posPriceOverride, String? eslId,
    String? rfidTagId, String? aisleLocation, String? planogramId,
    int? minDisplayQty, int? maxDisplayQty, bool? isEasTagRequired, bool? mandatorySerialScan,
    String? planogramAisle, String? planogramBay, String? planogramRack, String? planogramShelf,
    String? planogramBin, String? planogramEndcap, bool? cashierOverride, double? maxCashierDisc,
    bool? priceFloorLock, double? promotionalPrice,
  }) {
    if (costPrice != null) p.costPrice = costPrice;
    if (sellingPrice != null) p.sellingPrice = sellingPrice;
    if (mrp != null) p.mrp = mrp;
    if (wholesalePrice != null) p.wholesalePrice = wholesalePrice;
    if (onlinePrice != null) p.onlinePrice = onlinePrice;
    if (memberLoyaltyPrice != null) p.memberLoyaltyPrice = memberLoyaltyPrice;
    if (loyaltyPointsMultiplier != null) p.loyaltyPointsMultiplier = loyaltyPointsMultiplier;
    if (discountType != null) p.discountType = discountType;
    if (discountValue != null) p.discountValue = discountValue;
    if (maxDiscountPct != null) p.maxDiscountPct = maxDiscountPct;
    if (autoComputeLandedCost != null) p.autoComputeLandedCost = autoComputeLandedCost;
    if (isLiveMarketPrice != null) p.isLiveMarketPrice = isLiveMarketPrice;
    if (priceEffectiveFrom != null) p.priceEffectiveFrom = priceEffectiveFrom;
    if (currency != null) p.currency = currency;
    if (targetMarginPct != null) p.targetMarginPct = targetMarginPct;
    if (targetMarkupPct != null) p.targetMarkupPct = targetMarkupPct;
    if (branchSellingPrice != null) p.branchSellingPrice = branchSellingPrice;
    if (trackInventory != null) p.trackInventory = trackInventory;
    if (allowNegativeStock != null) p.allowNegativeStock = allowNegativeStock;
    if (openingStock != null) p.openingStock = openingStock.toDouble();
    if (minStock != null) p.minStock = minStock.toDouble();
    if (safetyStock != null) p.safetyStock = safetyStock.toDouble();
    if (maxStock != null) p.maxStock = maxStock.toDouble();
    if (reorderLevel != null) p.reorderLevel = reorderLevel;
    if (warehouseLocation != null) p.warehouseLocation = warehouseLocation;
    if (stockUnit != null) p.stockUnit = stockUnit;
    if (salesUnit != null) p.salesUnit = salesUnit;
    if (purchaseUnit != null) p.purchaseUnit = purchaseUnit;
    if (conversionFactor != null) p.conversionFactor = conversionFactor;
    if (grossWeight != null) p.grossWeight = grossWeight;
    if (netWeight != null) p.netWeight = netWeight;
    if (tareWeight != null) p.tareWeight = tareWeight;
    if (unitDimensions != null) p.unitDimensions = unitDimensions;
    if (packageType != null) p.packageType = packageType;
    if (unitsPerPackage != null) p.unitsPerPackage = unitsPerPackage;
    if (packageQuantity != null) p.packageQuantity = packageQuantity;
    if (packagingDeposit != null) p.packagingDeposit = packagingDeposit;
    if (packagingCost != null) p.packagingCost = packagingCost;
    if (containerDepositFee != null) p.containerDepositFee = containerDepositFee;
    if (storageClass != null) p.storageClass = storageClass;
    if (storageCondition != null) p.storageCondition = storageCondition;
    if (floorZone != null) p.floorZone = floorZone;
    if (coldStorageIndicator != null) p.coldStorageIndicator = coldStorageIndicator;
    if (coldChainRequired != null) p.coldChainRequired = coldChainRequired;
    if (logisticsSlab != null) p.logisticsSlab = logisticsSlab;
    if (volumetricWeight != null) p.volumetricWeight = volumetricWeight;
    if (countryRestrictions != null) p.countryRestrictions = countryRestrictions;
    if (valuationMethod != null) p.valuationMethod = valuationMethod;
    if (leadTimeBuffer != null) p.leadTimeBuffer = leadTimeBuffer;
    if (autoReplenish != null) p.autoReplenish = autoReplenish;
    if (innerPackQuantity != null) p.innerPackQuantity = innerPackQuantity;
    if (taxStatus != null) p.taxStatus = taxStatus;
    if (taxCategory != null) p.taxCategory = taxCategory;
    if (taxRate != null) p.taxRate = taxRate;
    if (taxJurisdiction != null) p.taxJurisdiction = taxJurisdiction;
    if (taxCode != null) p.taxCode = taxCode;
    if (gstTaxMode != null) p.gstTaxMode = gstTaxMode;
    if (taxTreatment != null) p.taxTreatment = taxTreatment;
    if (vatCategory != null) p.vatCategory = vatCategory;
    if (selectiveExciseTax != null) p.selectiveExciseTax = selectiveExciseTax;
    if (zatcaCode != null) p.zatcaCode = zatcaCode;
    if (sacCode != null) p.sacCode = sacCode;
    if (hsnCode != null) p.hsnCode = hsnCode;
    if (taxExemptionNo != null) p.taxExemptionNo = taxExemptionNo;
    if (importDutyClass != null) p.importDutyClass = importDutyClass;
    if (supplier != null) p.supplier = supplier;
    if (secondarySupplier != null) p.secondarySupplier = secondarySupplier;
    if (supplierProductCode != null) p.supplierProductCode = supplierProductCode;
    if (supplierProductName != null) p.supplierProductName = supplierProductName;
    if (supplierPurchaseCost != null) p.supplierPurchaseCost = supplierPurchaseCost;
    if (supplierMOQ != null) p.supplierMOQ = supplierMOQ;
    if (supplierLeadTime != null) p.supplierLeadTime = supplierLeadTime;
    if (supplierPaymentTerms != null) p.supplierPaymentTerms = supplierPaymentTerms;
    if (supplierContact != null) p.supplierContact = supplierContact;
    if (supplierNotes != null) p.supplierNotes = supplierNotes;
    if (primarySupplierId != null) p.primarySupplierId = primarySupplierId;
    if (supplierSku != null) p.supplierSku = supplierSku;
    if (vendorContractCost != null) p.vendorContractCost = vendorContractCost;
    if (supplierMoq != null) p.supplierMoq = supplierMoq;
    if (pluCode != null) p.pluCode = pluCode;
    if (unit != null) p.unit = unit;
    if (posShortThermalName != null) p.posShortThermalName = posShortThermalName;
    if (posReceiptName != null) p.posReceiptName = posReceiptName;
    if (isQuickPOSSale != null) p.isQuickPOSSale = isQuickPOSSale;
    if (posHotkeyEnabled != null) p.posHotkeyEnabled = posHotkeyEnabled;
    if (posAgeGate != null) p.posAgeGate = posAgeGate;
    if (posManualDiscount != null) p.posManualDiscount = posManualDiscount;
    if (posPriceOverride != null) p.posPriceOverride = posPriceOverride;
    if (eslId != null) p.eslId = eslId;
    if (rfidTagId != null) p.rfidTagId = rfidTagId;
    if (aisleLocation != null) p.aisleLocation = aisleLocation;
    if (planogramId != null) p.planogramId = planogramId;
    if (minDisplayQty != null) p.minDisplayQty = minDisplayQty;
    if (maxDisplayQty != null) p.maxDisplayQty = maxDisplayQty;
    if (isEasTagRequired != null) p.isEasTagRequired = isEasTagRequired;
    if (mandatorySerialScan != null) p.mandatorySerialScan = mandatorySerialScan;
    if (planogramAisle != null) p.planogramAisle = planogramAisle;
    if (planogramBay != null) p.planogramBay = planogramBay;
    if (planogramRack != null) p.planogramRack = planogramRack;
    if (planogramShelf != null) p.planogramShelf = planogramShelf;
    if (planogramBin != null) p.planogramBin = planogramBin;
    if (planogramEndcap != null) p.planogramEndcap = planogramEndcap;
    if (cashierOverride != null) p.cashierOverride = cashierOverride;
    if (maxCashierDisc != null) p.maxCashierDisc = maxCashierDisc;
    if (priceFloorLock != null) p.priceFloorLock = priceFloorLock;
    if (promotionalPrice != null) p.promotionalPrice = promotionalPrice;
  }
}
