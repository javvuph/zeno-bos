enum RetailSubBusiness {
  hypermarket,
  supermarket,
  groceryKirana,
  miniMarket,
  freshProduce,
  butcheryMeat,
  fishSeafood,
  organicStore,
  liquorWine,
  tobaccoStore,
  dutyFree,
  convenienceStore,
  departmentStore,
  dairyBooth,
}

class RetailCategoryConfig {
  final String tabTitle;
  final String defaultUom;
  final bool isWeighedItemDefault;
  final bool requiresAgeGate;
  final String defaultDepartment;
  final String defaultHsnCode;

  const RetailCategoryConfig({
    required this.tabTitle,
    required this.defaultUom,
    this.isWeighedItemDefault = false,
    this.requiresAgeGate = false,
    required this.defaultDepartment,
    required this.defaultHsnCode,
  });
}

final Map<RetailSubBusiness, RetailCategoryConfig> retailConfigMap = {
  RetailSubBusiness.hypermarket: const RetailCategoryConfig(
    tabTitle: 'HYPERMARKET & PLANOGRAM', defaultUom: 'Piece', defaultDepartment: 'FMCG', defaultHsnCode: '1904',
  ),
  RetailSubBusiness.supermarket: const RetailCategoryConfig(
    tabTitle: 'SUPERMARKET & SHELF', defaultUom: 'Piece', defaultDepartment: 'Packaged Foods', defaultHsnCode: '1904',
  ),
  RetailSubBusiness.groceryKirana: const RetailCategoryConfig(
    tabTitle: 'BULK & REPACK SPECS', defaultUom: 'Kg', defaultDepartment: 'Staples', defaultHsnCode: '1006',
  ),
  RetailSubBusiness.miniMarket: const RetailCategoryConfig(
    tabTitle: 'MINI MARKET & SHELF', defaultUom: 'Piece', defaultDepartment: 'Daily Essentials', defaultHsnCode: '2106',
  ),
  RetailSubBusiness.freshProduce: const RetailCategoryConfig(
    tabTitle: 'SCALE & PRODUCE SPECS', defaultUom: 'Kg', isWeighedItemDefault: true, defaultDepartment: 'Fresh Produce', defaultHsnCode: '0709',
  ),
  RetailSubBusiness.butcheryMeat: const RetailCategoryConfig(
    tabTitle: 'BUTCHERY & CATCH WEIGHT', defaultUom: 'Kg', isWeighedItemDefault: true, defaultDepartment: 'Meat & Poultry', defaultHsnCode: '0201',
  ),
  RetailSubBusiness.fishSeafood: const RetailCategoryConfig(
    tabTitle: 'SEAFOOD & COLD CHAIN', defaultUom: 'Kg', isWeighedItemDefault: true, defaultDepartment: 'Fresh Fish', defaultHsnCode: '0302',
  ),
  RetailSubBusiness.organicStore: const RetailCategoryConfig(
    tabTitle: 'ORGANIC & TRACEABILITY', defaultUom: 'Piece', defaultDepartment: 'Organic Staples', defaultHsnCode: '1001',
  ),
  RetailSubBusiness.liquorWine: const RetailCategoryConfig(
    tabTitle: 'LIQUOR & AGE GATE', defaultUom: 'Bottle', requiresAgeGate: true, defaultDepartment: 'Beverages', defaultHsnCode: '2204',
  ),
  RetailSubBusiness.tobaccoStore: const RetailCategoryConfig(
    tabTitle: 'TOBACCO & REGULATORY', defaultUom: 'Pack', requiresAgeGate: true, defaultDepartment: 'Tobacco', defaultHsnCode: '2402',
  ),
  RetailSubBusiness.dutyFree: const RetailCategoryConfig(
    tabTitle: 'DUTY FREE & TRAVEL', defaultUom: 'Piece', defaultDepartment: 'Duty Free Goods', defaultHsnCode: '9999',
  ),
  RetailSubBusiness.convenienceStore: const RetailCategoryConfig(
    tabTitle: 'CONVENIENCE & QUICK POS', defaultUom: 'Piece', defaultDepartment: 'Grab & Go', defaultHsnCode: '2106',
  ),
  RetailSubBusiness.departmentStore: const RetailCategoryConfig(
    tabTitle: 'DEPARTMENT & CONCESSION', defaultUom: 'Piece', defaultDepartment: 'General Merchandise', defaultHsnCode: '9403',
  ),
  RetailSubBusiness.dairyBooth: const RetailCategoryConfig(
    tabTitle: 'DAIRY & COLD STORAGE', defaultUom: 'Pouch', defaultDepartment: 'Fresh Dairy', defaultHsnCode: '0401',
  ),
};

RetailSubBusiness getRetailSubBusiness(String category) {
  if (category.contains("Fresh Produce") || category.contains("Vegetables") || category.contains("Fruit")) return RetailSubBusiness.freshProduce;
  if (category.contains("Meat") || category.contains("Butchery") || category.contains("Poultry")) return RetailSubBusiness.butcheryMeat;
  if (category.contains("Fish") || category.contains("Seafood")) return RetailSubBusiness.fishSeafood;
  if (category.contains("Organic")) return RetailSubBusiness.organicStore;
  if (category.contains("Liquor") || category.contains("Wine") || category.contains("Alcohol")) return RetailSubBusiness.liquorWine;
  if (category.contains("Tobacco") || category.contains("Cigarette")) return RetailSubBusiness.tobaccoStore;
  if (category.contains("Duty Free")) return RetailSubBusiness.dutyFree;
  if (category.contains("Convenience")) return RetailSubBusiness.convenienceStore;
  if (category.contains("Dairy") || category.contains("Milk")) return RetailSubBusiness.dairyBooth;
  if (category.contains("Kirana") || category.contains("Grocery")) return RetailSubBusiness.groceryKirana;
  if (category.contains("Supermarket")) return RetailSubBusiness.supermarket;
  if (category.contains("Mini Market")) return RetailSubBusiness.miniMarket;
  if (category.contains("Department")) return RetailSubBusiness.departmentStore;
  return RetailSubBusiness.hypermarket;
}
