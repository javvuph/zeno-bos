import '../models/purchase_order.dart';
import '../models/purchase_requisition.dart';
import '../models/rfq.dart';
import '../models/grn.dart';
import '../models/supplier_quotation.dart';
import '../models/vendor_bill.dart';

class PurchaseMasterDataService {
  List<PurchaseOrder> getMockPurchaseOrders() => [];

  List<RFQ> getMockRFQs() => [];

  List<SupplierQuotation> getMockQuotations(String rfqId) => [];

  List<VendorBill> getMockVendorBills() => [];

  List<PurchaseRequisition> getMockRequisitions() => [];

  List<GRN> getMockGRNs() => [];
}
