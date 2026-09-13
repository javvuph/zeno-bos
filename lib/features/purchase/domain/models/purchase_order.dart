import 'purchase_item.dart';

enum POStatus {
  draft,
  pendingApproval,
  approved,
  ordered,
  partiallyReceived,
  received,
  cancelled,
  closed
}

enum POApprovalStatus {
  draft,
  pending,
  level1,
  level2,
  finalApproved,
  rejected
}

class PurchaseOrder {
  final String id;
  final String poNumber;
  final String supplierId;
  final String buyerId;
  final List<PurchaseItem> items;
  final String currency;
  final double exchangeRate;
  final DateTime orderDate;
  final DateTime expectedDeliveryDate;
  final POStatus status;
  final POApprovalStatus approvalStatus;
  final String warehouseId;
  final String branchId;
  final bool isDropShipment;
  final String? shippingAddressId;
  final double totalTax;
  final double totalAmount;
  final int priority; // 0-High, 1-Normal, 2-Low
  final Map<String, dynamic> aiMetadata; // Risk, delay prediction, savings recs
  final List<String> auditTrail;

  const PurchaseOrder({
    required this.id,
    required this.poNumber,
    required this.supplierId,
    required this.buyerId,
    required this.items,
    required this.currency,
    this.exchangeRate = 1.0,
    required this.orderDate,
    required this.expectedDeliveryDate,
    this.status = POStatus.draft,
    this.approvalStatus = POApprovalStatus.draft,
    required this.warehouseId,
    required this.branchId,
    this.isDropShipment = false,
    this.shippingAddressId,
    this.totalTax = 0.0,
    this.totalAmount = 0.0,
    this.priority = 1,
    this.aiMetadata = const {},
    this.auditTrail = const [],
  });

  double get totalOrderedQty =>
      items.fold(0, (sum, item) => sum + item.quantity);
  double get totalReceivedQty =>
      items.fold(0, (sum, item) => sum + item.receivedQuantity);
  double get totalPendingQty => totalOrderedQty - totalReceivedQty;

  PurchaseOrder copyWith({
    POStatus? status,
    POApprovalStatus? approvalStatus,
    List<PurchaseItem>? items,
    DateTime? expectedDeliveryDate,
    double? totalAmount,
    double? totalTax,
  }) {
    return PurchaseOrder(
      id: id,
      poNumber: poNumber,
      supplierId: supplierId,
      buyerId: buyerId,
      items: items ?? this.items,
      currency: currency,
      exchangeRate: exchangeRate,
      orderDate: orderDate,
      expectedDeliveryDate: expectedDeliveryDate ?? this.expectedDeliveryDate,
      status: status ?? this.status,
      approvalStatus: approvalStatus ?? this.approvalStatus,
      warehouseId: warehouseId,
      branchId: branchId,
      isDropShipment: isDropShipment,
      shippingAddressId: shippingAddressId,
      totalTax: totalTax ?? this.totalTax,
      totalAmount: totalAmount ?? this.totalAmount,
      priority: priority,
      aiMetadata: aiMetadata,
      auditTrail: auditTrail,
    );
  }
}
