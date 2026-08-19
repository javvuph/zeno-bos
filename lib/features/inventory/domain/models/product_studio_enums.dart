enum ProductCreationMode { manual, scan, bulkScan, import }

enum BusinessScale { small, growing, enterprise }

enum AuroraStudioTab { 
  identity,    // 🏷️ Identity
  planogram,   // 📍 Planogram
  logistics,   // 📦 Logistics
  pricing,     // 💰 Pricing
  stock,       // 📊 Stock
  vendors,     // 🚚 Vendors
  tax,         // 🧾 Tax
  media        // 🌐 Media
}

enum ProductStudioSection {
  basic,
  fashionBasic,
  fashionSpecs,
  fnbDish,
  fnbKitchen,
  fashionSizeCurve,
  fashionMarkdown,
  fashionReturns,
  fashionMerchandising,
  electronicsBasic,
  electronicsSpecs,
  electronicsSerial,
  healthcareBasic,
  healthcareClinical,
  serviceBasic,
  serviceExecution,
  wholesaleBasic,
  wholesaleB2B,
  retailPackaging,
  retailWms,
  retailPromotions,
  retailProcurement,
  retailReplenishment,
  retailOmnichannel,
  retailMerchandising,
  retailColdChain,
  retailTraceability,
  retailPricingEnterprise,
  retailStoreOverrides,
  inventoryPrice,
  media,
  variants,
  tax,
  suppliers,
  industry,
  marketing,
  inventoryAdmin,
  packaging,
  unitsConversion,
  batch,
  expiry,
  advanced
}

enum VariantSizeType { alpha, alphabetic, numeric, numericUK, numericEU, waist, kids, custom }

enum ProductLifecycleState {
  draft,
  aiReviewed,
  pendingApproval,
  approved,
  published,
  availablePOS,
  availableOnline,
  discontinued,
  archived
}

enum MediaMode { inherited, overridden }

enum BulkScanStatus { ready, review, duplicate, notFound, completed }

enum ScanItemStatus {
  exists,
  foundExternal,
  notFound,
  added
}
