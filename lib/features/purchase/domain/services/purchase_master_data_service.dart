import '../models/purchase_order.dart';
import '../models/purchase_item.dart';
import '../models/purchase_requisition.dart';
import '../models/rfq.dart';
import '../models/grn.dart';
import '../models/supplier_quotation.dart';
import '../models/vendor_bill.dart';
import '../models/vendor_bill_status.dart';

class PurchaseMasterDataService {
  List<PurchaseOrder> getMockPurchaseOrders() => [
        PurchaseOrder(
          id: 'PO-2026-001',
          poNumber: 'ZN-PO-99121',
          supplierId: 'Global Tech Ltd',
          buyerId: 'USER-EX-01',
          items: [
            const PurchaseItem(
                productId: 'p1',
                variantId: 'v1',
                name: 'Industrial Controller X1',
                quantity: 500,
                unitId: 'u1',
                unitPrice: 850.00,
                taxRate: 18.0),
          ],
          currency: 'INR (₹)',
          orderDate: DateTime.now().subtract(const Duration(days: 2)),
          expectedDeliveryDate: DateTime.now().add(const Duration(days: 5)),
          status: POStatus.ordered,
          approvalStatus: POApprovalStatus.finalApproved,
          warehouseId: 'WH-MAIN',
          branchId: 'B-NORTH',
          totalAmount: 501500.00,
          totalTax: 76500.00,
        ),
      ];

  List<RFQ> getMockRFQs() => [
        RFQ(
          id: 'RFQ-2026-001',
          title: 'Bulk Supply of Core Processors',
          category: 'Electronics',
          requestedById: 'USER-OP-01',
          department: 'Operations',
          items: [
            const PurchaseItem(
                productId: 'p1',
                variantId: 'v1',
                name: 'Z-Processor Core',
                quantity: 1000,
                unitId: 'u1'),
          ],
          invitedSupplierIds: ['SUPP-001', 'SUPP-002', 'SUPP-003'],
          createdAt: DateTime.now().subtract(const Duration(days: 5)),
          closingDate: DateTime.now().add(const Duration(days: 2)),
          status: RFQStatus.open,
          priority: RFQPriority.high,
          aiRecommendation:
              'Supplier SUPP-002 offers best value based on historical reliability.',
        ),
        RFQ(
          id: 'RFQ-2026-002',
          title: 'Standard Office Furniture',
          category: 'General',
          requestedById: 'USER-ADMIN',
          department: 'Administration',
          items: [
            const PurchaseItem(
                productId: 'p8',
                variantId: 'v8',
                name: 'Ergonomic Chair',
                quantity: 50,
                unitId: 'u1'),
          ],
          invitedSupplierIds: ['SUPP-004', 'SUPP-005'],
          createdAt: DateTime.now().subtract(const Duration(days: 10)),
          closingDate: DateTime.now().subtract(const Duration(days: 1)),
          status: RFQStatus.readyToCompare,
          priority: RFQPriority.medium,
        ),
      ];

  List<SupplierQuotation> getMockQuotations(String rfqId) {
    if (rfqId == 'RFQ-2026-001') {
      return [
        SupplierQuotation(
          id: 'QT-001',
          rfqId: rfqId,
          supplierId: 'SUPP-001',
          items: [],
          currency: 'USD',
          quotationDate: DateTime.now().subtract(const Duration(days: 2)),
          validityDate: DateTime.now().add(const Duration(days: 15)),
          subtotal: 10000.0,
          totalAmount: 11000.0,
          leadTimeDays: 7,
          paymentTerms: 'Net 30',
          warrantyTerms: '1 Year',
          qualityRating: 85,
          pastPerformanceScore: 90,
          deliveryReliabilityScore: 88,
        ),
        SupplierQuotation(
          id: 'QT-002',
          rfqId: rfqId,
          supplierId: 'SUPP-002',
          items: [],
          currency: 'USD',
          quotationDate: DateTime.now().subtract(const Duration(days: 1)),
          validityDate: DateTime.now().add(const Duration(days: 30)),
          subtotal: 9500.0,
          totalAmount: 10450.0,
          leadTimeDays: 14,
          paymentTerms: 'Net 45',
          warrantyTerms: '2 Years',
          qualityRating: 92,
          pastPerformanceScore: 95,
          deliveryReliabilityScore: 94,
        ),
      ];
    }
    return [];
  }

  List<VendorBill> getMockVendorBills() => [
        VendorBill(
          id: 'BILL-2026-001',
          supplierId: 'Global Tech Ltd',
          invoiceNumber: 'INV-GTECH-9912',
          poId: 'PO-2026-001',
          grnId: 'GRN-2026-001',
          invoiceDate: DateTime.now().subtract(const Duration(days: 1)),
          dueDate: DateTime.now().add(const Duration(days: 29)),
          currency: 'USD',
          subtotal: 10000.0,
          gstAmount: 1800.0,
          totalAmount: 11800.0,
          balanceDue: 11800.0,
          status: VendorBillStatus.verified,
          items: [
            const VendorBillItem(
              productId: 'p1',
              name: 'Z-Processor Core',
              quantity: 1000,
              unitPrice: 10.0,
              taxRate: 18.0,
              taxAmount: 1800.0,
              totalAmount: 11800.0,
            ),
          ],
          aiMatchScore: 98.0,
          is3WayMatched: true,
        ),
      ];

  List<PurchaseRequisition> getMockRequisitions() => [
        PurchaseRequisition(
          id: 'PR-101',
          items: [
            const PurchaseItem(
                productId: 'p2',
                variantId: 'v2',
                name: 'MacBook Pro 14',
                quantity: 5,
                unitId: 'u1'),
          ],
          requestedById: 'user_exec',
          department: 'Technology',
          requestedDate: DateTime.now(),
          requiredDate: DateTime.now().add(const Duration(days: 14)),
        ),
      ];

  List<GRN> getMockGRNs() => [
        GRN(
          id: 'GRN-2026-001',
          poId: 'PO-2026-001',
          supplierId: 'Global Tech Ltd',
          warehouseId: 'WH-MAIN',
          branchId: 'B-NORTH',
          receivedItems: [
            const GRNItem(
              orderItem: PurchaseItem(
                  productId: 'p1',
                  variantId: 'v1',
                  name: 'Z-Processor Core',
                  quantity: 1000,
                  unitId: 'pcs',
                  unitPrice: 15.0),
              receivedQuantity: 1000,
              acceptedQuantity: 980,
              rejectedQuantity: 20,
              shortQuantity: 0,
              damagedQuantity: 15,
              inspectionStatus: QualityStatus.passed,
            ),
          ],
          receivedDate: DateTime.now().subtract(const Duration(hours: 2)),
          receivedById: 'USER-WH-01',
          status: GRNStatus.completed,
          qualityStatus: QualityStatus.passed,
          totalReceivedValue: 14700.0,
        ),
        GRN(
          id: 'GRN-2026-002',
          poId: 'PO-2026-045',
          supplierId: 'North Apparel Hub',
          warehouseId: 'WH-MAIN',
          branchId: 'B-NORTH',
          receivedItems: [
            const GRNItem(
              orderItem: PurchaseItem(
                  productId: 'p5',
                  variantId: 'v10',
                  name: 'Tactical Vest',
                  quantity: 50,
                  unitId: 'pcs',
                  unitPrice: 45.0),
              receivedQuantity: 30,
              acceptedQuantity: 0,
              rejectedQuantity: 0,
              shortQuantity: 20,
              inspectionStatus: QualityStatus.pending,
            ),
          ],
          receivedDate: DateTime.now(),
          receivedById: 'USER-WH-02',
          status: GRNStatus.partial,
          qualityStatus: QualityStatus.pending,
        ),
      ];
}
