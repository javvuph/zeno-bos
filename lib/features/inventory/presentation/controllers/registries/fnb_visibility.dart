import 'shared_visibility.dart';

final Map<String, List<String>> fnbProfileFields = {
  "Fine Dining": [
    ...fnbStandard, "cuisineType", "winePairing", "kotStation", "recipeVersion",
    "targetFoodCostPct", "servingTemperature", "courseSequence", "platingStyle", "sommelierNotes",
  ],
  "Casual Dining": [
    ...fnbStandard, "cuisineType", "kdsCategory", "courseFireDelay", "recipeVersion",
    "recipePrepNotes", "targetFoodCostPct", "kitchenStation", "foodCost",
  ],
  "Express QSR": [...fnbStandard, "aggregatorSku", "packaging", "tamperSeal", "oosBehavior", "expressDispatch", "isCombo"],
  "Cloud Delivery": [
    ...fnbStandard, "virtualBrandId", "multiAggregatorSkuMatrix", "packagingContainer",
    "insulationPack", "stagingShelf", "aggregatorSku", "oosBehavior",
  ],
  "Bakery & Pastry": [
    ...fnbStandard, "flavor", "cakeSize", "sponge", "storageTemperature", "shelfLife",
    "customMessage", "photoPrint", "eggless", "bakeryType",
  ],
  "Cafe / Barista": [
    ...fnbStandard, "cupVolume", "extractionMethod", "steamingTemperature", "beanRoast",
    "origin", "plantMilk", "extraShot",
  ],
  "Juice & Beverage": [...fnbStandard, "volume", "sugar", "ice", "addIns", "coldPressed"],
  "Pizzeria": [...fnbStandard, "size", "crust", "sauce", "cheeseDip", "seasoning"],
  "Bar & Pub": [...fnbStandard, "abv", "pourVolume", "liquorClass", "exciseId", "happyHour", "ageGate"],
  "Ice Cream & Gelato": [...fnbStandard, "base", "servingFormat", "coneCup", "dryIce"],
  "Sweet Shop / Mithai": [...fnbStandard, "sellingMetric", "fatBase", "shelfLife", "storage", "tare"],
  "Banquet & Catering": [...fnbStandard, "minimumPax", "perHeadCost", "serviceSetup", "liveStation", "hotBoxTransport"],
  "Shisha Lounge": [...fnbStandard, "flavor", "baseLiquid", "duration", "disposablePipe", "ageGate"],
};
