import 'purchase_item.dart';

enum PRStatus { draft, pending, approved, rejected, converted }

class PurchaseRequisition {
  final String id;
  final List<PurchaseItem> items;
  final String requestedById;
  final String? department;
  final DateTime requestedDate;
  final DateTime requiredDate;
  final PRStatus status;
  final String? notes;
  final Map<String, dynamic> aiFields;

  const PurchaseRequisition({
    required this.id,
    required this.items,
    required this.requestedById,
    this.department,
    required this.requestedDate,
    required this.requiredDate,
    this.status = PRStatus.draft,
    this.notes,
    this.aiFields = const {},
  });
}
