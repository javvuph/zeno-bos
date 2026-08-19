import 'purchase_item.dart';

enum InvoiceStatus { unpaid, partially_paid, paid, cancelled }

class PurchaseInvoice {
  final String id;
  final String poId;
  final String? grnId;
  final String supplierId;
  final String invoiceNumber;
  final DateTime invoiceDate;
  final DateTime dueDate;
  final List<PurchaseItem> items;
  final double subtotal;
  final double taxTotal;
  final double totalAmount;
  final String currency;
  final InvoiceStatus status;

  const PurchaseInvoice({
    required this.id,
    required this.poId,
    this.grnId,
    required this.supplierId,
    required this.invoiceNumber,
    required this.invoiceDate,
    required this.dueDate,
    required this.items,
    required this.subtotal,
    required this.taxTotal,
    required this.totalAmount,
    required this.currency,
    this.status = InvoiceStatus.unpaid,
  });
}
