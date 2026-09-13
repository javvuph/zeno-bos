import 'sales_item.dart';

enum InvoiceStatus { unpaid, partiallyPaid, paid, overdue, cancelled }

class SalesInvoice {
  final String id;
  final String orderId;
  final String customerId;
  final String invoiceNumber;
  final DateTime date;
  final DateTime dueDate;
  final List<SalesItem> items;
  final double subtotal;
  final double taxTotal;
  final double totalAmount;
  final String currency;
  final InvoiceStatus status;

  const SalesInvoice({
    required this.id,
    required this.orderId,
    required this.customerId,
    required this.invoiceNumber,
    required this.date,
    required this.dueDate,
    required this.items,
    required this.subtotal,
    required this.taxTotal,
    required this.totalAmount,
    required this.currency,
    this.status = InvoiceStatus.unpaid,
  });
}
