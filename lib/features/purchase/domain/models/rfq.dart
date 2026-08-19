import 'purchase_item.dart';

enum RFQStatus {
  draft,
  open,
  closingSoon,
  awaitingResponses,
  readyToCompare,
  approved,
  converted,
  cancelled
}

enum RFQPriority { low, medium, high, urgent }

class RFQ {
  final String id;
  final String title;
  final String category;
  final String requestedById;
  final String department;
  final List<PurchaseItem> items;
  final List<String> invitedSupplierIds;
  final DateTime createdAt;
  final DateTime closingDate;
  final RFQStatus status;
  final RFQPriority priority;
  final String? termsAndConditions;
  final String? approvalNotes;
  final String? aiRecommendation;

  const RFQ({
    required this.id,
    required this.title,
    required this.category,
    required this.requestedById,
    required this.department,
    required this.items,
    required this.invitedSupplierIds,
    required this.createdAt,
    required this.closingDate,
    this.status = RFQStatus.draft,
    this.priority = RFQPriority.medium,
    this.termsAndConditions,
    this.approvalNotes,
    this.aiRecommendation,
  });

  RFQ copyWith({
    String? title,
    String? category,
    String? requestedById,
    String? department,
    List<PurchaseItem>? items,
    List<String>? invitedSupplierIds,
    DateTime? closingDate,
    RFQStatus? status,
    RFQPriority? priority,
    String? termsAndConditions,
    String? approvalNotes,
    String? aiRecommendation,
  }) {
    return RFQ(
      id: id,
      title: title ?? this.title,
      category: category ?? this.category,
      requestedById: requestedById ?? this.requestedById,
      department: department ?? this.department,
      items: items ?? this.items,
      invitedSupplierIds: invitedSupplierIds ?? this.invitedSupplierIds,
      createdAt: createdAt,
      closingDate: closingDate ?? this.closingDate,
      status: status ?? this.status,
      priority: priority ?? this.priority,
      termsAndConditions: termsAndConditions ?? this.termsAndConditions,
      approvalNotes: approvalNotes ?? this.approvalNotes,
      aiRecommendation: aiRecommendation ?? this.aiRecommendation,
    );
  }
}
