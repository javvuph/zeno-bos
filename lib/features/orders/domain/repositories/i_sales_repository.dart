import '../models/sales_order.dart';
import '../models/sales_quotation.dart';
import '../models/shipment.dart';
import '../models/sales_invoice.dart';
import '../models/rma_credit.dart';

abstract class ISalesRepository {
  Future<List<SalesOrder>> getOrders();
  Future<SalesOrder?> getOrderById(String id);
  Future<void> saveOrder(SalesOrder order);
  Future<void> deleteOrder(String id);

  Future<List<SalesQuotation>> getQuotations();
  Future<void> saveQuotation(SalesQuotation quotation);

  Future<List<Shipment>> getShipments(String orderId);
  Future<void> saveShipment(Shipment shipment);

  Future<List<SalesInvoice>> getInvoices();
  Future<void> saveInvoice(SalesInvoice invoice);

  Future<void> createRMA(SalesReturn rma);
}
