import '../models/purchase_requisition.dart';
import '../models/purchase_order.dart';
import '../models/grn.dart';
import '../models/purchase_invoice.dart';
import '../models/rfq.dart';
import '../models/supplier_quotation.dart';

abstract class IPurchaseRepository {
  Future<List<PurchaseRequisition>> getRequisitions();
  Future<void> saveRequisition(PurchaseRequisition pr);

  Future<List<RFQ>> getRFQs();
  Future<void> saveRFQ(RFQ rfq);

  Future<List<SupplierQuotation>> getQuotations(String rfqId);
  Future<void> saveQuotation(SupplierQuotation quotation);

  Future<List<PurchaseOrder>> getPurchaseOrders();
  Future<PurchaseOrder?> getPOById(String id);
  Future<void> savePO(PurchaseOrder po);

  Future<List<GRN>> getGRNs();
  Future<void> saveGRN(GRN grn);

  Future<List<PurchaseInvoice>> getInvoices();
  Future<void> saveInvoice(PurchaseInvoice invoice);
}
