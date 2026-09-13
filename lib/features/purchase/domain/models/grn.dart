import 'purchase_item.dart';

enum GRNStatus {
  expected,
  receiving,
  partial,
  completed,
  rejected,
  qualityHold,
  cancelled
}

enum QualityStatus { pending, passed, failed, conditional }

class GRN {
  final String id;
  final String poId;
  final String supplierId;
  final String warehouseId;
  final String branchId;
  final List<GRNItem> receivedItems;
  final DateTime receivedDate;
  final String receivedById;
  final GRNStatus status;
  final QualityStatus qualityStatus;
  final String? deliveryNoteRef;
  final String? gatePassRef;
  final String? remarks;

  // Financial prepares
  final double totalReceivedValue;
  final double taxAmount;
  final double landedCosts;

  // AI Intel
  final double aiReceivingScore;
  final List<String> aiFlags;

  const GRN({
    required this.id,
    required this.poId,
    required this.supplierId,
    required this.warehouseId,
    required this.branchId,
    required this.receivedItems,
    required this.receivedDate,
    required this.receivedById,
    this.status = GRNStatus.expected,
    this.qualityStatus = QualityStatus.pending,
    this.deliveryNoteRef,
    this.gatePassRef,
    this.remarks,
    this.totalReceivedValue = 0.0,
    this.taxAmount = 0.0,
    this.landedCosts = 0.0,
    this.aiReceivingScore = 1.0,
    this.aiFlags = const [],
  });

  double get totalReceivedQuantity =>
      receivedItems.fold(0, (sum, item) => sum + item.receivedQuantity);
  double get totalRejectedQuantity =>
      receivedItems.fold(0, (sum, item) => sum + item.rejectedQuantity);

  GRN copyWith({
    GRNStatus? status,
    QualityStatus? qualityStatus,
    List<GRNItem>? receivedItems,
    String? remarks,
    double? totalReceivedValue,
  }) {
    return GRN(
      id: id,
      poId: poId,
      supplierId: supplierId,
      warehouseId: warehouseId,
      branchId: branchId,
      receivedItems: receivedItems ?? this.receivedItems,
      receivedDate: receivedDate,
      receivedById: receivedById,
      status: status ?? this.status,
      qualityStatus: qualityStatus ?? this.qualityStatus,
      deliveryNoteRef: deliveryNoteRef,
      gatePassRef: gatePassRef,
      remarks: remarks ?? this.remarks,
      totalReceivedValue: totalReceivedValue ?? this.totalReceivedValue,
      taxAmount: taxAmount,
      landedCosts: landedCosts,
      aiReceivingScore: aiReceivingScore,
      aiFlags: aiFlags,
    );
  }
}

class GRNItem {
  final PurchaseItem orderItem;
  final double receivedQuantity;
  final double acceptedQuantity;
  final double rejectedQuantity;
  final double shortQuantity;
  final double damagedQuantity;

  // Warehouse Mapping
  final String? zoneId;
  final String? binId;

  // Compliance
  final String? batchId;
  final List<String> serialNumbers;
  final DateTime? expiryDate;

  final QualityStatus inspectionStatus;
  final String? inspectionNotes;

  const GRNItem({
    required this.orderItem,
    required this.receivedQuantity,
    this.acceptedQuantity = 0.0,
    this.rejectedQuantity = 0.0,
    this.shortQuantity = 0.0,
    this.damagedQuantity = 0.0,
    this.zoneId,
    this.binId,
    this.batchId,
    this.serialNumbers = const [],
    this.expiryDate,
    this.inspectionStatus = QualityStatus.pending,
    this.inspectionNotes,
  });

  GRNItem copyWith({
    double? acceptedQuantity,
    double? rejectedQuantity,
    double? damagedQuantity,
    QualityStatus? inspectionStatus,
    String? binId,
  }) {
    return GRNItem(
      orderItem: orderItem,
      receivedQuantity: receivedQuantity,
      acceptedQuantity: acceptedQuantity ?? this.acceptedQuantity,
      rejectedQuantity: rejectedQuantity ?? this.rejectedQuantity,
      shortQuantity: shortQuantity,
      damagedQuantity: damagedQuantity ?? this.damagedQuantity,
      zoneId: zoneId,
      binId: binId ?? this.binId,
      batchId: batchId,
      serialNumbers: serialNumbers,
      expiryDate: expiryDate,
      inspectionStatus: inspectionStatus ?? this.inspectionStatus,
      inspectionNotes: inspectionNotes,
    );
  }
}
