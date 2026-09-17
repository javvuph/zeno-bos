import 'dart:convert';

import 'package:zeno/core/database/collections/inventory_collections.dart';
import '../../../domain/models/product.dart';
import '../../../domain/models/sku.dart';
import '../../../domain/models/barcode.dart';
import '../../../domain/models/category.dart';
import '../../../domain/models/brand.dart';
import '../../../domain/models/unit.dart';
import '../../../domain/models/batch.dart';
import '../../../domain/models/supplier_relationship.dart';
import '../../../domain/models/recipe_ingredient.dart';
import '../../../domain/models/product_enums.dart';
import '../../../domain/models/product_industry_fields.dart';
import '../../../domain/models/combo_item.dart';
import '../../../domain/models/product_variant.dart';

class ProductMapper {
  static Product mapToDomain(ProductCollection pc) {
    return Product(
      id: pc.uuid, name: pc.name, description: pc.description, sku: SKU(pc.sku),
      barcode: pc.barcode != null ? Barcode(pc.barcode!) : null,
      unit: Unit(id: '', name: pc.unit, symbol: pc.unit),
      category: Category(id: pc.categoryId, name: pc.categoryId),
      brand: pc.brandId != null ? Brand(id: pc.brandId!, name: pc.brandId!) : null,
      basePrice: pc.basePrice,
      baseCost: pc.supplierPurchaseCost ?? 0.0,
      openingStock: (pc.variants != null && pc.variants!.isNotEmpty)
          ? pc.variants!.fold<double>(0.0, (sum, v) => sum + (v.stockLevel ?? 0.0))
          : (pc.openingStock ?? 0.0),
      itemType: ItemType.values.firstWhere((e) => e.name == pc.itemType, orElse: () => ItemType.stockProduct),
      status: ProductStatus.values.firstWhere((e) => e.name == pc.status, orElse: () => ProductStatus.active),
      businessType: pc.businessType ?? "Retail", businessCategory: pc.businessCategory ?? "Supermarket",
      gstTaxMode: pc.gstTaxMode ?? "Intra-State", supplierIds: pc.supplierIds ?? [],
      supplierProductName: pc.supplierProductName, supplierProductCode: pc.supplierProductCode,
      supplierPurchaseCost: pc.supplierPurchaseCost ?? 0.0, supplierMOQ: pc.supplierMOQ ?? 0,
      supplierLeadTime: pc.supplierLeadTime ?? 0, secondarySupplier: pc.secondarySupplier,
      supplierPaymentTerms: pc.supplierPaymentTerms, supplierContact: pc.supplierContact,
      supplierNotes: pc.supplierNotes, packageType: pc.packageType, unitsPerPackage: pc.unitsPerPackage ?? 1,
      packageQuantity: pc.packageQuantity ?? 0.0, stockUnit: pc.stockUnit, conversionFactor: pc.conversionFactor ?? 1.0,
      industry: ProductIndustryFields(
        material: pc.material, metalType: pc.metalType, purity: pc.purity, weight: pc.weight,
        stoneType: pc.stoneType, stoneWeight: pc.stoneWeight, jewelrySize: pc.jewelrySize,
        shade: pc.shade, skinType: pc.skinType, hairType: pc.hairType, volume: pc.volume,
        ingredients: pc.ingredients, usageInfo: pc.usageInfo, fragranceFamily: pc.fragranceFamily,
        concentration: pc.concentration, gender: pc.gender, scentNotes: pc.scentNotes,
        serialNumber: pc.serialNumber, imei: pc.imei, modelNumber: pc.modelNumber,
        partNumber: pc.partNumber, oemNumber: pc.oemNumber, compatibility: pc.compatibility,
        vehicleMake: pc.vehicleMake, vehicleModel: pc.vehicleModel, styleCategory: pc.styleCategory,
        season: pc.season, soleMaterial: pc.soleMaterial, closureType: pc.closureType,
        widthFit: pc.widthFit, sizeStandard: pc.sizeStandard, apparelCategory: pc.apparelCategory,
        patternDesign: pc.patternDesign, fitType: pc.fitType, sleeveNeckType: pc.sleeveNeckType,
        careGuide: pc.careGuide, artisanLabel: pc.artisanLabel, collectionEdition: pc.collectionEdition,
        productionLeadTime: pc.productionLeadTime, exclusiveSinglePiece: pc.exclusiveSinglePiece ?? false,
        madeToOrder: pc.madeToOrder ?? false, measurementBust: pc.measurementBust,
        measurementWaist: pc.measurementWaist, measurementHip: pc.measurementHip,
        measurementFullLength: pc.measurementFullLength, gemstoneCount: pc.gemstoneCount,
        hallmarkCert: pc.hallmarkCert, makingChargeMode: pc.makingChargeMode,
        makingChargeRate: pc.makingChargeRate, wastagePct: pc.wastagePct, liveRateLink: pc.liveRateLink,
        brandRange: pc.brandRange, shadeHexColor: pc.shadeHexColor, safetyCertifications: pc.safetyCertifications ?? [],
        periodAfterOpening: pc.periodAfterOpening, perfumeHouse: pc.perfumeHouse, topNotes: pc.topNotes,
        middleNotes: pc.middleNotes, baseNotes: pc.baseNotes, aisleLocation: pc.aisleLocation,
        countryOfOrigin: pc.countryOfOrigin, variableWeightPLU: pc.variableWeightPLU ?? false,
        pluCode: pc.pluCode, tareWeight: pc.tareWeight ?? 0.0, onlinePrice: pc.onlinePrice ?? 0.0,
        maxDiscountPct: pc.maxDiscountPct ?? 0.0, channelEligibility: pc.channelEligibility ?? [],
        expiryWarningThreshold: pc.expiryWarningThreshold ?? 0, searchKeywords: pc.searchKeywords ?? [],
        promotionalBadges: pc.promotionalBadges, division: pc.division, privateLabel: pc.privateLabel ?? false,
        seasonalProduct: pc.seasonalProduct ?? false, masterCaseRatio: pc.masterCaseRatio ?? 1.0,
        grossWeight: pc.grossWeight ?? 0.0, unitDimensions: pc.unitDimensions,
        packagingDeposit: pc.packagingDeposit ?? 0.0, importDutyClass: pc.importDutyClass,
        memberLoyaltyPrice: pc.memberLoyaltyPrice ?? 0.0, loyaltyPointsMultiplier: pc.loyaltyPointsMultiplier ?? 1.0,
        storageClass: pc.storageClass, floorZone: pc.floorZone, organicCertified: pc.organicCertified ?? false,
        foodCategory: pc.foodCategory, ingredientsSummary: pc.ingredientsSummary,
        storageCondition: pc.storageCondition, dietaryBadges: pc.dietaryBadges ?? [],
        fastMovingFlag: pc.fastMovingFlag ?? false, posHotkeyEnabled: pc.posHotkeyEnabled ?? false,
        posHotkeyColor: pc.posHotkeyColor, ageRestriction: pc.ageRestriction,
        readyToEatItem: pc.readyToEatItem ?? false, coldStorageIndicator: pc.coldStorageIndicator ?? false,
        multiBarcodes: pc.multiBarcodes ?? [], marketingTitle: pc.marketingTitle,
        metaDescription: pc.metaDescription, urlSlug: pc.urlSlug, featuredProduct: pc.featuredProduct ?? false,
        productRelationship: pc.productRelationship, warrantyInfo: pc.warrantyInfo,
        warrantyAvailable: pc.warrantyAvailable ?? false, warrantyDuration: pc.warrantyDuration,
        warrantyUnit: pc.warrantyUnit, cuisineType: pc.cuisineType, kotStation: pc.kotStation,
        foodClass: pc.foodClass, spiceLevel: pc.spiceLevel, allergens: pc.allergens ?? [],
        calories: pc.calories ?? 0.0,
        recipeBOM: pc.recipeBOM?.map((r) => RecipeIngredient(id: r.uuid ?? '', ingredientName: r.ingredientName ?? '', quantity: r.quantity ?? 0.0, unit: r.unit ?? 'Piece (Pc)', yieldPercentage: r.yieldPercentage ?? 100.0, cost: r.cost ?? 0.0)).toList() ?? [],
        portionSize: pc.portionSize, prepTime: pc.prepTime ?? 0, takeawaySurcharge: pc.takeawaySurcharge ?? 0.0,
        serviceChargePct: pc.serviceChargePct ?? 0.0, cafeCategory: pc.cafeCategory,
        temperatureProfile: pc.temperatureProfile, cupSizes: pc.cupSizes ?? [],
        milkOptions: pc.milkOptions ?? [], sugarLevels: pc.sugarLevels ?? [],
        bakeryType: pc.bakeryType, flavorProfile: pc.flavorProfile, bakeTimestamp: pc.bakeTimestamp,
        freshnessDuration: pc.freshnessDuration ?? 0, freshnessUnit: pc.freshnessUnit,
        juiceCategory: pc.juiceCategory, fruitBases: pc.fruitBases ?? [], isCombo: pc.isCombo ?? false,
        comboItems: pc.comboItems?.map((s) => ComboItem(sku: s)).toList() ?? [],
        hotelDepartment: pc.hotelDepartment,
        allowRoomFolio: pc.allowRoomFolio ?? false, roomDeliveryCharge: pc.roomDeliveryCharge ?? 0.0,
        virtualBrand: pc.virtualBrand, aggregatorMappings: pc.aggregatorMappings ?? {},
        containerType: pc.containerType, packagingCost: pc.packagingCost ?? 0.0,
        stallAssignment: pc.stallAssignment, managementRoyaltyPct: pc.managementRoyaltyPct ?? 0.0,
      ),
      variants: pc.variants?.map((v) => ProductVariant(
        id: v.uuid ?? '',
        productId: v.productId ?? pc.uuid,
        sku: SKU(v.sku ?? ''),
        barcode: (v.barcode?.isNotEmpty ?? false) ? Barcode(v.barcode!) : null,
        attributes: {
          "Color": v.color ?? '',
          "Size": v.size ?? '',
        },
        priceAdjustment: v.priceAdjustment ?? 0.0,
        stockLevel: v.stockLevel ?? 0.0,
      )).toList() ?? [],
      batches: pc.batches?.map((b) => Batch(id: b.uuid ?? '', batchNumber: b.batchNumber ?? '', manufacturingDate: b.manufacturingDate ?? DateTime.now(), expiryDate: b.expiryDate, quantity: b.quantity ?? 0.0, purchaseCost: b.purchaseCost ?? 0.0, sellingPrice: b.sellingPrice ?? 0.0, mrp: b.mrp ?? 0.0, supplier: b.supplier, warehouse: b.warehouse, notes: b.notes)).toList() ?? [],
      supplierRelationships: pc.supplierRelationships?.map((s) => SupplierRelationship(id: s.uuid ?? '', supplierName: s.supplierName ?? '', supplierSku: s.supplierSku, supplierProductName: s.supplierProductName, purchaseCost: s.purchaseCost ?? 0.0, moq: s.moq ?? 0, leadTime: s.leadTime ?? 0, paymentTerms: s.paymentTerms, notes: s.notes, isPrimary: s.isPrimary ?? false)).toList() ?? [],
      reorderLevel: pc.reorderLevel ?? 0.0, minStock: pc.minStock ?? 0.0, maxStock: pc.maxStock ?? 0.0, createdAt: pc.createdAt, updatedAt: pc.updatedAt,
      customFields: pc.customFieldsJson?.isNotEmpty == true
          ? Map<String, dynamic>.from(jsonDecode(pc.customFieldsJson!))
          : const {},
    );
  }

  static ProductCollection mapToCollection(Product product, {ProductCollection? existing}) {
    final normalizedSku = product.sku.value.trim();
    final normalizedBarcode = product.barcode?.value.trim();

    final pc = (existing ?? ProductCollection())
      ..uuid = product.id..name = product.name..sku = normalizedSku.isEmpty ? product.id : normalizedSku..barcode = normalizedBarcode != null && normalizedBarcode.isNotEmpty ? normalizedBarcode : null
      ..description = product.description ?? ''..unit = product.unit.name..categoryId = product.category?.name ?? product.category?.id ?? ''
      ..brandId = product.brand?.name ?? product.brand?.id..basePrice = product.basePrice..taxRate = product.taxProfile?.rate ?? 0.0
      ..itemType = product.itemType.name..status = product.status.name..businessType = product.businessType
      ..businessCategory = product.businessCategory..gstTaxMode = product.gstTaxMode..supplierIds = product.supplierIds
      ..supplierProductName = product.supplierProductName..supplierPaymentTerms = product.supplierPaymentTerms
      ..supplierContact = product.supplierContact..supplierNotes = product.supplierNotes..supplierProductCode = product.supplierProductCode
      ..supplierPurchaseCost = product.supplierPurchaseCost..supplierMOQ = product.supplierMOQ..supplierLeadTime = product.supplierLeadTime
      ..secondarySupplier = product.secondarySupplier..packageType = product.packageType..unitsPerPackage = product.unitsPerPackage
      ..packageQuantity = product.packageQuantity..stockUnit = product.stockUnit..conversionFactor = product.conversionFactor
      ..openingStock = product.openingStock;
    
    pc..material = product.material..metalType = product.metalType..purity = product.purity..weight = product.weight
      ..stoneType = product.stoneType..stoneWeight = product.stoneWeight..jewelrySize = product.jewelrySize..shade = product.shade
      ..skinType = product.skinType..hairType = product.hairType..volume = product.volume..ingredients = product.ingredients
      ..usageInfo = product.usageInfo..fragranceFamily = product.fragranceFamily..concentration = product.concentration
      ..gender = product.gender..scentNotes = product.scentNotes..serialNumber = product.serialNumber..imei = product.imei
      ..modelNumber = product.modelNumber..partNumber = product.partNumber..oemNumber = product.oemNumber..compatibility = product.compatibility
      ..vehicleMake = product.vehicleMake..vehicleModel = product.vehicleModel..styleCategory = product.styleCategory..season = product.season
      ..soleMaterial = product.soleMaterial..closureType = product.closureType..widthFit = product.widthFit..sizeStandard = product.sizeStandard
      ..apparelCategory = product.apparelCategory..patternDesign = product.patternDesign..fitType = product.fitType..sleeveNeckType = product.sleeveNeckType
      ..careGuide = product.careGuide..artisanLabel = product.artisanLabel..collectionEdition = product.collectionEdition..productionLeadTime = product.productionLeadTime
      ..exclusiveSinglePiece = product.exclusiveSinglePiece..madeToOrder = product.madeToOrder..measurementBust = product.measurementBust
      ..measurementWaist = product.measurementWaist..measurementHip = product.measurementHip..measurementFullLength = product.measurementFullLength
      ..gemstoneCount = product.gemstoneCount..hallmarkCert = product.hallmarkCert..makingChargeMode = product.makingChargeMode
      ..makingChargeRate = product.makingChargeRate..wastagePct = product.wastagePct..liveRateLink = product.liveRateLink..brandRange = product.brandRange
      ..shadeHexColor = product.shadeHexColor..safetyCertifications = product.safetyCertifications..periodAfterOpening = product.periodAfterOpening
      ..perfumeHouse = product.perfumeHouse..topNotes = product.topNotes..middleNotes = product.middleNotes..baseNotes = product.baseNotes
      ..aisleLocation = product.aisleLocation..countryOfOrigin = product.countryOfOrigin..variableWeightPLU = product.variableWeightPLU
      ..pluCode = product.pluCode..tareWeight = product.tareWeight..onlinePrice = product.onlinePrice..maxDiscountPct = product.maxDiscountPct
      ..channelEligibility = product.channelEligibility..expiryWarningThreshold = product.expiryWarningThreshold..searchKeywords = product.searchKeywords
      ..promotionalBadges = product.promotionalBadges..division = product.division..privateLabel = product.privateLabel..seasonalProduct = product.seasonalProduct
      ..masterCaseRatio = product.masterCaseRatio..grossWeight = product.grossWeight..unitDimensions = product.unitDimensions..packagingDeposit = product.packagingDeposit
      ..importDutyClass = product.importDutyClass..memberLoyaltyPrice = product.memberLoyaltyPrice..loyaltyPointsMultiplier = product.loyaltyPointsMultiplier
      ..storageClass = product.storageClass..floorZone = product.floorZone..organicCertified = product.organicCertified..foodCategory = product.foodCategory
      ..ingredientsSummary = product.ingredientsSummary..storageCondition = product.storageCondition..dietaryBadges = product.dietaryBadges
      ..fastMovingFlag = product.fastMovingFlag..posHotkeyEnabled = product.posHotkeyEnabled..posHotkeyColor = product.posHotkeyColor..ageRestriction = product.ageRestriction
      ..readyToEatItem = product.readyToEatItem..coldStorageIndicator = product.coldStorageIndicator..multiBarcodes = product.multiBarcodes
      ..marketingTitle = product.marketingTitle..metaDescription = product.metaDescription..urlSlug = product.urlSlug..featuredProduct = product.featuredProduct
      ..productRelationship = product.productRelationship..warrantyInfo = product.warrantyInfo..warrantyAvailable = product.warrantyAvailable
      ..warrantyDuration = product.warrantyDuration..warrantyUnit = product.warrantyUnit..cuisineType = product.cuisineType..kotStation = product.kotStation
      ..foodClass = product.foodClass..spiceLevel = product.spiceLevel..allergens = product.allergens..calories = product.calories
      ..recipeBOM = product.recipeBOM.map((r) => RecipeIngredientEmbed()..uuid = r.id..ingredientName = r.ingredientName..quantity = r.quantity..unit = r.unit..yieldPercentage = r.yieldPercentage..cost = r.cost).toList()
      ..portionSize = product.portionSize..prepTime = product.prepTime..takeawaySurcharge = product.takeawaySurcharge..serviceChargePct = product.serviceChargePct
      ..cafeCategory = product.cafeCategory..temperatureProfile = product.temperatureProfile..cupSizes = product.cupSizes..milkOptions = product.milkOptions
      ..sugarLevels = product.sugarLevels..bakeryType = product.bakeryType..flavorProfile = product.flavorProfile..bakeTimestamp = product.bakeTimestamp
      ..freshnessDuration = product.freshnessDuration..freshnessUnit = product.freshnessUnit..juiceCategory = product.juiceCategory..fruitBases = product.fruitBases
      ..isCombo = product.isCombo..comboItems = product.comboItems.map((e) => e.sku).toList()..hotelDepartment = product.hotelDepartment..allowRoomFolio = product.allowRoomFolio
      ..roomDeliveryCharge = product.roomDeliveryCharge..virtualBrand = product.virtualBrand..aggregatorMappings = product.aggregatorMappings..containerType = product.containerType
      ..packagingCost = product.packagingCost..stallAssignment = product.stallAssignment..managementRoyaltyPct = product.managementRoyaltyPct
      ..variants = product.variants.map((v) => ProductVariantEmbed()
        ..uuid = v.id
        ..productId = v.productId
        ..sku = v.sku.value
        ..barcode = v.barcode?.value
        ..color = v.attributes["Color"]
        ..size = v.attributes["Size"]
        ..priceAdjustment = v.priceAdjustment
        ..stockLevel = v.stockLevel
      ).toList()
      ..customFieldsJson = jsonEncode(product.customFields)
      ..batches = product.batches.map((b) => BatchEmbed()..uuid = b.id..batchNumber = b.batchNumber..manufacturingDate = b.manufacturingDate..expiryDate = b.expiryDate..quantity = b.quantity..purchaseCost = b.purchaseCost..sellingPrice = b.sellingPrice..mrp = b.mrp..supplier = b.supplier..warehouse = b.warehouse..notes = b.notes).toList()
      ..supplierRelationships = product.supplierRelationships.map((s) => SupplierRelationshipEmbed()..uuid = s.id..supplierName = s.supplierName..supplierSku = s.supplierSku..supplierProductName = s.supplierProductName..purchaseCost = s.purchaseCost..moq = s.moq..leadTime = s.leadTime..paymentTerms = s.paymentTerms..notes = s.notes..isPrimary = s.isPrimary).toList();

    pc.updatedAt = DateTime.now();
    pc.minStock = product.minStock;
    pc.maxStock = product.maxStock;
    pc.reorderLevel = product.reorderLevel;
    return pc;
  }
}
