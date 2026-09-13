import 'purchase_item.dart';

class PurchaseReturn {
  final String id;
  final String poId;
  final String? grnId;
  final String supplierId;
  final List<PurchaseItem> returnedItems;
  final DateTime returnDate;
  final String reason;
  final String? debitNoteId;

  const PurchaseReturn({
    required this.id,
    required this.poId,
    this.grnId,
    required this.supplierId,
    required this.returnedItems,
    required this.returnDate,
    required this.reason,
    this.debitNoteId,
  });
}
