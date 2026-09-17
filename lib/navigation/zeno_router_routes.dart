part of 'zeno_router.dart';

Widget? resolveRoutePart1(String route, Map<String, dynamic>? params) {
  switch (route) {
    case 'home':
    case 'dashboard':
      return const PersonalizedDashboardScreen();
    case 'home/tasks':
      return const PlannerScreen();
    case 'home/approvals':
      return const AutomationCommandCenterScreen();
    case 'home/activity':
      return const CRMExecutiveDashboard();

    case 'inventory/products':
    case 'inventory/master':
      return const InventoryWorkspaceScreen();
    case 'inventory/studio':
      return const ProductStudioScreen();
    case 'inventory/categories':
      return const CategoryCommandCenterScreen();
    case 'inventory/brands':
      return const BrandCommandCenterScreen();
    case 'inventory/units':
      return const UnitCommandCenterScreen();
    case 'inventory/variants':
      return const VariantsCommandCenterScreen();
    case 'inventory/warehouses':
      return const WarehouseCommandCenterScreen();
    case 'inventory/rules':
      return const InventoryRulesCommandCenterScreen();
    case 'inventory/reorder':
      return const ProductListScreen(
          filterStatus: 'low_stock', title: 'Reorder Alerts');
    case 'inventory/transfers':
      return const StockOperationsCommandCenterScreen();
    case 'inventory/barcodes':
      return const BarcodeStudioCommandCenterScreen();
    case 'inventory/stock-count':
      return const PhysicalCountScreen();
    case 'inventory/intelligence':
      return const InventoryIntelligenceCommandCenterScreen();
    case 'inventory/reports':
      return const ReportListScreen();

    case 'sales/pos':
      return const BillingStudioScreen();
    case 'sales/new':
      return const NewBillScreen();
    case 'sales/fnb-billing':
      return FnbBillingScreen(
        tableId: params?['tableId'] as String?,
        guestCount: params?['guestCount'] as int?,
      );
    case 'sales/history':
    case 'sales/invoices':
      return const InvoiceListScreen();
    case 'sales/dues':
      return const FinanceDashboardScreen();
    case 'sales/quotations':
      return const QuotationCommandCenterScreen();
    case 'sales/pricing':
      return const PriceManagementScreen(focusType: 'Cost');
    case 'sales/intelligence':
      return const OrderAIHubScreen();
    case 'sales/reports':
      return const UnifiedReportViewerScreen(
          reportTitle: "Sales Performance", module: 'sales');

    case 'orders/dashboard':
      return const OrdersDashboardScreen();
    case 'orders/list':
      return const OrderListScreen();
    case 'orders/new':
      return const SalesOrderFormScreen();
    case 'orders/fulfillment':
      return const OrderFulfillmentScreen(stage: 'Picking');
    case 'orders/returns':
      return const UnifiedReportViewerScreen(
          reportTitle: "Sales Returns \u0026 RMA", module: 'sales');
    case 'orders/intelligence':
      return const OrderAIHubScreen();
    case 'orders/fnb/tables':
      return const FnbTableManagementScreen();
    case 'orders/fnb/kds':
      return FnbKdsScreen(station: params?['station'] as String? ?? "Main Kitchen");
    case 'orders/fnb/reservations':
      return const FnbReservationScreen();
    default:
      return null;
  }
}
