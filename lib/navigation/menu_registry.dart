import 'menu/menu_items_core.dart';
import 'menu/menu_items_enterprise.dart';
import 'menu/menu_models.dart';

export 'menu/menu_models.dart';

class MenuRegistry {
  static final List<ZenoMenuCategory> all = [
    coreMenuCategories[0],       // Home
    enterpriseMenuCategories[0], // Inventory
    coreMenuCategories[1],       // Sales
    coreMenuCategories[2],       // Orders
    enterpriseMenuCategories[1], // Procurement
    coreMenuCategories[3],       // CRM
    coreMenuCategories[4],       // HR
    enterpriseMenuCategories[2], // Reports
    enterpriseMenuCategories[3], // Finance
    enterpriseMenuCategories[4], // AI
    enterpriseMenuCategories[5], // Admin
  ];
}
