import 'shared_visibility.dart';

final Map<String, List<String>> fashionProfileFields = {
  "Clothing": [
    ...fashionStandard, "apparelCategory", "patternDesign", "fitType", "sleeveNeckType",
    "careGuide", "fabric", "sizeScale", "color", "hex", "childSku", "barcodeRegistry",
  ],
  "Footwear": [
    ...fashionStandard, "material", "soleMaterial", "closureType", "widthFit", "sizeStandard",
    "apparelCategory", "upper", "outsole", "heel", "toe", "occasion", "pairWeight", "childSku", "barcode",
  ],
  "Jewelry & Metals": [
    ...fashionStandard, "metalType", "purity", "stoneType", "stoneWeight", "gemstoneCount",
    "hallmarkCert", "makingChargeMode", "makingChargeRate", "wastagePct", "grossWeight", "netWeight",
  ],
  "Watches": [
    ...fashionStandard, "material", "closureType", "styleCategory", "movement", "caliber",
    "case", "diameter", "thickness", "strap", "glass", "waterResistance", "powerReserve",
  ],
  "Eyewear": [...fashionStandard, "styleCategory", "lensIndex", "frameParameters", "shape", "material", "coatings", "rx"],
  "Cosmetics": [
    ...fashionStandard, "shade", "shadeHexColor", "skinType", "periodAfterOpening", "finish",
    "volumeWeight", "pao", "crueltyFree", "vegan",
  ],
  "Perfume": [...fashionStandard, "fragranceFamily", "concentration", "volume", "topNotes", "middleNotes", "baseNotes"],
  "Boutique": [
    ...fashionStandard, "artisanLabel", "madeToOrder", "collectionEdition", "exclusiveSinglePiece",
    "designer", "measurementProfile", "rfid", "alteration", "graceDays", "trial", "delivery",
  ],
  "Bridal Wear": [
    ...fashionStandard, "artisanLabel", "madeToOrder", "collectionEdition", "fabricComposition",
    "designer", "embroidery", "measurementLedger", "rfid", "customization", "trial", "delivery",
  ],
  "Bags & Luggage": [
    ...fashionStandard, "apparelCategory", "material", "volume", "style", "capacity", "tsa",
    "compartments", "laptopSleeve",
  ],
  "Accessories": [...fashionStandard, "material", "styleCategory", "classification", "giftBox"],
  "Innerwear": [
    ...fashionStandard, "material", "apparelCategory", "careGuide", "silhouette", "coverage",
    "support", "fabricComposition", "antimicrobial", "bandCupMatrix", "childSku", "barcode",
  ],
  "Kids Fashion": [
    ...fashionStandard, "targetAgeGroup", "material", "careGuide", "ageGrowth", "closure",
    "oekoTex", "organicCotton", "nickelFree", "growthSizeGrid", "childSku", "barcode",
  ],
  "Sportswear": [
    ...fashionStandard, "material", "fitType", "patternDesign", "activity", "compression",
    "moistureWicking", "stretch", "quickDry", "upf", "antiOdor", "sizeColorMatrix", "childSku", "barcode",
  ],
};
