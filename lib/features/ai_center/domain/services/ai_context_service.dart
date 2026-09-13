import 'package:get_it/get_it.dart';
import 'package:zeno/features/inventory/domain/repositories/i_inventory_repository.dart';
import 'package:zeno/features/finance/domain/repositories/i_finance_repository.dart';
import 'package:zeno/features/orders/domain/repositories/i_sales_repository.dart';
import 'package:zeno/features/purchase/domain/repositories/i_purchase_repository.dart';
import 'package:zeno/features/customers/domain/repositories/i_customer_repository.dart';
import 'package:zeno/features/suppliers/domain/repositories/i_supplier_repository.dart';
import 'package:zeno/features/staff/domain/repositories/i_staff_repository.dart';
import 'package:zeno/features/delivery/domain/repositories/i_delivery_repository.dart';

import 'package:zeno/features/orders/domain/models/sales_order_status.dart';
import 'package:zeno/features/delivery/domain/models/delivery_order.dart';

class AIContextService {
  Future<Map<String, dynamic>> gatherGlobalContext() async {
    final Map<String, dynamic> context = {};

    try {
      final sl = GetIt.I;
      // 1. Inventory
      final invRepo = sl<IInventoryRepository>();
      final stock = await invRepo.getAllStockLevels();
      context['inventory'] = {
        'total_items': stock.length,
        'critical_low': stock.where((s) => s.physical < 5).toList(),
        'stock_value': stock.fold(
            0.0, (sum, s) => sum + (s.physical * 10.0)), // Mock valuation
      };

      // 2. Finance
      final finRepo = sl<IFinanceRepository>();
      final coa = await finRepo.getChartOfAccounts();
      context['finance'] = {
        'active_accounts': coa.where((a) => a.isActive).length,
        'cash_on_hand': 125000.0, // Mock data
        'pending_payables': 15400.0,
      };

      // 3. Sales & Billing
      final salesRepo = sl<ISalesRepository>();
      final sales = await salesRepo.getOrders();
      context['sales'] = {
        'total_orders': sales.length,
        'pending_orders':
            sales.where((s) => s.status == SalesOrderStatus.confirmed).length,
        'today_revenue': 4200.0, // Mock
      };

      // 4. Purchase
      final purchaseRepo = sl<IPurchaseRepository>();
      final purchaseOrders = await purchaseRepo.getPurchaseOrders();
      context['purchase'] = {
        'active_pos': purchaseOrders.length,
      };

      // 5. Customers & Suppliers
      final customerRepo = sl<ICustomerRepository>();
      final supplierRepo = sl<ISupplierRepository>();
      final customers = await customerRepo.getAllCustomers();
      final suppliers = await supplierRepo.getAllSuppliers();
      context['crm'] = {
        'total_customers': customers.length,
        'total_suppliers': suppliers.length,
      };

      // 6. Staff & Performance
      final staffRepo = sl<IStaffRepository>();
      final staff = await staffRepo.getEmployees();
      context['staff'] = {
        'headcount': staff.length,
        'attendance_rate': 0.94,
      };

      // 7. Delivery
      final deliveryRepo = sl<IDeliveryRepository>();
      final shipments = await deliveryRepo.getPendingDeliveries();
      final now = DateTime.now();
      context['logistics'] = {
        'active_shipments': shipments.length,
        'delayed_count': shipments
            .where((s) =>
                s.status != DeliveryStatus.delivered &&
                s.expectedDeliveryTime != null &&
                s.expectedDeliveryTime!.isBefore(now))
            .length,
      };
    } catch (e) {
      context['error'] = "Partial context gathering failure: $e";
    }

    return context;
  }
}
