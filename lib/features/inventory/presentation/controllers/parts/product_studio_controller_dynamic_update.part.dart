part of '../product_studio_controller.dart';

extension ProductStudioControllerDynamicUpdate on ProductStudioController {
  void updateFieldById(ProductStudioData p, String fieldId, dynamic value) {
    switch (fieldId) {
      case 'title': p.title = value.toString(); break;
      case 'sku': p.sku = value.toString(); break;
      case 'barcode': p.barcode = value.toString(); break;
      case 'multiBarcodes': {
        if (value is List<String>) {
          p.multiBarcodes = value;
        } else {
          p.multiBarcodes = value.toString().split(',').map((e)=>e.trim()).where((e)=>e.isNotEmpty).toList();
        }
        break;
      }
      case 'description': p.description = value.toString(); break;
      case 'category': p.category = value.toString(); break;
      case 'subcategory': p.subcategory = value.toString(); break;
      case 'brand': p.brand = value.toString(); break;
      case 'supplier': p.supplier = value.toString(); break;
      case 'salesUnit': p.salesUnit = value.toString(); break;
      case 'purchaseUnit': p.purchaseUnit = value.toString(); break;
      case 'stockUnit': p.stockUnit = value.toString(); break;
      case 'costPrice': p.costPrice = double.tryParse(value.toString()) ?? 0; break;
      case 'sellingPrice': p.sellingPrice = double.tryParse(value.toString()) ?? 0; break;
      case 'mrp': p.mrp = double.tryParse(value.toString()) ?? 0; break;
      case 'wholesalePrice': p.wholesalePrice = double.tryParse(value.toString()) ?? 0; break;
      case 'openingStock': p.openingStock = double.tryParse(value.toString()) ?? 0.0; break;
      case 'safetyStock': p.safetyStock = double.tryParse(value.toString()) ?? 0.0; break;
      case 'reorderLevel': p.reorderLevel = double.tryParse(value.toString()) ?? 0; break;
      case 'taxCode': p.taxCode = value.toString(); break;
      case 'rfidTagId': p.rfidTagId = value.toString(); break;
      case 'warehouseLocation': p.warehouseLocation = value.toString(); break;
      case 'pluCode': p.pluCode = value.toString(); break;
      case 'countryOfOrigin': p.countryOfOrigin = value.toString(); break;
      case 'isCatchWeight': p.isCatchWeight = _toBool(value); break;
      case 'freshnessDuration': p.freshnessDuration = int.tryParse(value.toString()) ?? 0; break;
      case 'weight': p.weight = double.tryParse(value.toString()) ?? 0; break;
      case 'wastagePct': p.wastagePct = double.tryParse(value.toString()) ?? 0; break;
      case 'storageCondition': p.storageCondition = value.toString(); break;
      case 'organicCertification': p.organicCertification = value.toString(); break;
      case 'organicCertNo': p.organicCertNo = value.toString(); break;
      case 'farmTraceabilityId': p.farmTraceabilityId = value.toString(); break;
      case 'abv': p.abv = double.tryParse(value.toString()) ?? 0; break;
      case 'volume': p.volume = value.toString(); break;
      case 'barLiquorClass': p.barLiquorClass = value.toString(); break;
      case 'ssccBarcode': p.ssccBarcode = value.toString(); break;
      case 'healthLicense': p.healthLicense = value.toString(); break;
      case 'posAgeGate': p.posAgeGate = _toBool(value); break;
      case 'containerDepositFee': p.containerDepositFee = double.tryParse(value.toString()) ?? 0; break;
      case 'apparelCategory': p.apparelCategory = value.toString(); break;
      case 'unitsPerStrip': p.unitsPerStrip = int.tryParse(value.toString()) ?? 1; break;
      case 'nicotineContent': p.nicotineContent = value.toString(); break;
      case 'importDutyClass': p.importDutyClass = value.toString(); break;
      case 'passportVerificationRequired': p.passportVerificationRequired = _toBool(value); break;
      case 'currency': p.currency = value.toString(); break;
      case 'onlinePrice': p.onlinePrice = double.tryParse(value.toString()) ?? 0; break;
      case 'bakeryType': p.bakeryType = value.toString(); break;
      case 'nutritionalTransFats': p.nutritionalTransFats = double.tryParse(value.toString()) ?? 0; break;
      case 'nutritionalProtein': p.nutritionalProtein = double.tryParse(value.toString()) ?? 0; break;
      case 'coldStorageIndicator': p.coldStorageIndicator = _toBool(value); break;
      case 'floorZone': p.floorZone = value.toString(); break;
      case 'planogramId': p.planogramId = value.toString(); break;
      case 'caseMultiplier': p.caseMultiplier = int.tryParse(value.toString()) ?? 1; break;
      case 'palletStacking': p.palletStacking = int.tryParse(value.toString()) ?? 1; break;
      case 'unitDimensions': p.unitDimensions = value.toString(); break;
      case 'grossWeight': p.grossWeight = double.tryParse(value.toString()) ?? 0; break;
      case 'storageClass': p.storageClass = value.toString(); break;
      case 'allowLooseBilling': p.allowLooseBilling = _toBool(value); break;
      case 'inHouseRepack': p.inHouseRepack = _toBool(value); break;
      case 'conversionFactor': p.conversionFactor = double.tryParse(value.toString()) ?? 1; break;
      case 'ingredients': p.ingredients = value.toString(); break;
      case 'bakeryShelfLife': p.bakeryShelfLife = value.toString(); break;
      case 'fastMovingFlag': p.fastMovingFlag = _toBool(value); break;
      case 'isQuickPOSSale': p.isQuickPOSSale = _toBool(value); break;
      case 'readyToEatItem': p.readyToEatItem = _toBool(value); break;
      case 'ageRestriction': p.ageRestriction = int.tryParse(value.toString()); break;
      case 'isRoomServiceAvailable': p.isRoomServiceAvailable = _toBool(value); break;
      case 'staffCommissionRate': p.staffCommissionRate = double.tryParse(value.toString()) ?? 0; break;
      case 'compatibility': p.compatibility = value.toString(); break;
      case 'recipePrepNotes': p.recipePrepNotes = value.toString(); break;
      case 'visibility': p.visibility = value.toString(); break;
      case 'styleCategory': p.styleCategory = value.toString(); break;
      case 'fitType': p.fitType = value.toString(); break;
      case 'hallmarkCert': p.hallmarkCert = value.toString(); break;
      case 'patternDesign': p.patternDesign = value.toString(); break;
      case 'closureType': p.closureType = value.toString(); break;
      case 'collectionEdition': p.collectionEdition = value.toString(); break;
      case 'manufacturingDate': if (value is DateTime) p.manufacturingDate = value; break;
      case 'harvestDate': if (value is DateTime) p.harvestDate = value; break;
      case 'discontinueDate': if (value is DateTime) p.discontinueDate = value; break;
      case 'priceEffectiveFrom': if (value is DateTime) p.priceEffectiveFrom = value; break;
    }
    notify();
  }

  dynamic getFieldValueById(ProductStudioData p, String fieldId) {
    switch (fieldId) {
      case 'title': return p.title;
      case 'sku': return p.sku;
      case 'barcode': return p.barcode;
      case 'description': return p.description;
      case 'category': return p.category;
      case 'subcategory': return p.subcategory;
      case 'brand': return p.brand;
      case 'supplier': return p.supplier;
      case 'salesUnit': return p.salesUnit;
      case 'purchaseUnit': return p.purchaseUnit;
      case 'stockUnit': return p.stockUnit;
      case 'costPrice': return p.costPrice;
      case 'sellingPrice': return p.sellingPrice;
      case 'mrp': return p.mrp;
      case 'wholesalePrice': return p.wholesalePrice;
      case 'openingStock': return p.openingStock;
      case 'safetyStock': return p.safetyStock;
      case 'reorderLevel': return p.reorderLevel;
      case 'taxCode': return p.taxCode;
      case 'rfidTagId': return p.rfidTagId;
      case 'warehouseLocation': return p.warehouseLocation;
      case 'pluCode': return p.pluCode;
      case 'countryOfOrigin': return p.countryOfOrigin;
      case 'isCatchWeight': return p.isCatchWeight;
      case 'freshnessDuration': return p.freshnessDuration;
      case 'weight': return p.weight;
      case 'wastagePct': return p.wastagePct;
      case 'storageCondition': return p.storageCondition;
      case 'organicCertification': return p.organicCertification;
      case 'organicCertNo': return p.organicCertNo;
      case 'farmTraceabilityId': return p.farmTraceabilityId;
      case 'abv': return p.abv;
      case 'volume': return p.volume;
      case 'barLiquorClass': return p.barLiquorClass;
      case 'ssccBarcode': return p.ssccBarcode;
      case 'healthLicense': return p.healthLicense;
      case 'posAgeGate': return p.posAgeGate;
      case 'containerDepositFee': return p.containerDepositFee;
      case 'apparelCategory': return p.apparelCategory;
      case 'unitsPerStrip': return p.unitsPerStrip;
      case 'nicotineContent': return p.nicotineContent;
      case 'importDutyClass': return p.importDutyClass;
      case 'passportVerificationRequired': return p.passportVerificationRequired;
      case 'currency': return p.currency;
      case 'onlinePrice': return p.onlinePrice;
      case 'bakeryType': return p.bakeryType;
      case 'nutritionalTransFats': return p.nutritionalTransFats;
      case 'nutritionalProtein': return p.nutritionalProtein;
      case 'coldStorageIndicator': return p.coldStorageIndicator;
      case 'floorZone': return p.floorZone;
      case 'planogramId': return p.planogramId;
      case 'caseMultiplier': return p.caseMultiplier;
      case 'palletStacking': return p.palletStacking;
      case 'unitDimensions': return p.unitDimensions;
      case 'grossWeight': return p.grossWeight;
      case 'storageClass': return p.storageClass;
      case 'allowLooseBilling': return p.allowLooseBilling;
      case 'inHouseRepack': return p.inHouseRepack;
      case 'conversionFactor': return p.conversionFactor;
      case 'ingredients': return p.ingredients;
      case 'bakeryShelfLife': return p.bakeryShelfLife;
      case 'fastMovingFlag': return p.fastMovingFlag;
      case 'isQuickPOSSale': return p.isQuickPOSSale;
      case 'readyToEatItem': return p.readyToEatItem;
      case 'ageRestriction': return p.ageRestriction;
      case 'isRoomServiceAvailable': return p.isRoomServiceAvailable;
      case 'staffCommissionRate': return p.staffCommissionRate;
      case 'compatibility': return p.compatibility;
      case 'recipePrepNotes': return p.recipePrepNotes;
      case 'visibility': return p.visibility;
      case 'styleCategory': return p.styleCategory;
      case 'fitType': return p.fitType;
      case 'hallmarkCert': return p.hallmarkCert;
      case 'patternDesign': return p.patternDesign;
      case 'closureType': return p.closureType;
      case 'collectionEdition': return p.collectionEdition;
      case 'manufacturingDate': return p.manufacturingDate;
      case 'harvestDate': return p.harvestDate;
      case 'discontinueDate': return p.discontinueDate;
      case 'priceEffectiveFrom': return p.priceEffectiveFrom;
      default: return "";
    }
  }

  bool _toBool(dynamic v) => v == true || v.toString().toLowerCase() == "true";
}
