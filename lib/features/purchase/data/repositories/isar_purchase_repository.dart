import 'package:zeno/core/database/database_service.dart';
import 'package:zeno/core/database/collections/transaction_collections.dart';
import '../../domain/repositories/i_purchase_repository.dart';
import '../../domain/models/purchase_order.dart';
import '../../domain/models/purchase_requisition.dart';
import '../../domain/models/grn.dart';
import '../../domain/models/purchase_invoice.dart';
import '../../domain/models/rfq.dart';
import '../../domain/models/supplier_quotation.dart';
import '../../domain/models/purchase_item.dart';
import 'package:isar/isar.dart';

part 'parts/isar_purchase_repository_orders.part.dart';
part 'parts/isar_purchase_repository_grn_invoice.part.dart';

class IsarPurchaseRepository implements IPurchaseRepository {
  final DatabaseService db;
  IsarPurchaseRepository(this.db);

  @override
  Future<List<PurchaseRequisition>> getRequisitions() => getRequisitionsImpl();

  @override
  Future<void> saveRequisition(PurchaseRequisition pr) => saveRequisitionImpl(pr);

  @override
  Future<List<RFQ>> getRFQs() => getRFQsImpl();

  @override
  Future<void> saveRFQ(RFQ rfq) => saveRFQImpl(rfq);

  @override
  Future<List<SupplierQuotation>> getQuotations(String rfqId) =>
      getQuotationsImpl(rfqId);

  @override
  Future<void> saveQuotation(SupplierQuotation quotation) =>
      saveQuotationImpl(quotation);

  @override
  Future<List<PurchaseOrder>> getPurchaseOrders() => getPurchaseOrdersImpl();

  @override
  Future<PurchaseOrder?> getPOById(String id) => getPOByIdImpl(id);

  @override
  Future<void> savePO(PurchaseOrder po) => savePOImpl(po);

  @override
  Future<List<GRN>> getGRNs() => getGRNsImpl();

  @override
  Future<void> saveGRN(GRN grn) => saveGRNImpl(grn);

  @override
  Future<List<PurchaseInvoice>> getInvoices() => getInvoicesImpl();

  @override
  Future<void> saveInvoice(PurchaseInvoice invoice) => saveInvoiceImpl(invoice);
}
