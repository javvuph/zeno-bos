import '../models/sales_order.dart';
import '../models/sales_item.dart';
import '../models/sales_order_status.dart';
import '../models/sales_quotation.dart';

class SalesMasterDataService {
  List<SalesOrder> getMockOrders() => [
        SalesOrder(
          id: 'ORD-5521',
          customerId: 'CUST-1001',
          warehouseId: 'wh_1',
          items: [
            const SalesItem(
                productId: 'p1',
                variantId: 'v1',
                sku: 'TS-WHITE-S',
                description: 'Cotton T-Shirt',
                quantity: 10,
                unit: 'Pc',
                unitPrice: 15.99,
                taxRate: 5.0),
          ],
          currency: 'USD',
          orderDate: DateTime.now().subtract(const Duration(minutes: 5)),
          status: SalesOrderStatus.processing,
          totalAmount: 167.90,
        ),
        SalesOrder(
          id: 'ORD-5520',
          customerId: 'CUST-1002',
          warehouseId: 'wh_1',
          items: [
            const SalesItem(
                productId: 'p2',
                variantId: 'v2',
                sku: 'MBP-14-SG',
                description: 'MacBook Pro 14',
                quantity: 2,
                unit: 'Pc',
                unitPrice: 1999.00,
                taxRate: 12.0),
          ],
          currency: 'USD',
          orderDate: DateTime.now().subtract(const Duration(minutes: 45)),
          status: SalesOrderStatus.packing,
          totalAmount: 4477.76,
        ),
      ];

  List<SalesQuotation> getMockQuotations() => [
        SalesQuotation(
          id: 'QT-882',
          customerId: 'CUST-1004',
          date: DateTime.now().subtract(const Duration(days: 1)),
          expiryDate: DateTime.now().add(const Duration(days: 6)),
          items: [],
          currency: 'USD',
          totalAmount: 2500.00,
        ),
      ];
}
