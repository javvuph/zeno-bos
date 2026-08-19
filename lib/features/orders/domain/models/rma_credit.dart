import 'sales_item.dart';

enum RMAStatus { pending, authorized, received, inspected, resolved, rejected }

class SalesReturn {
  final String id;
  final String orderId;
  final String customerId;
  final List<SalesItem> returnedItems;
  final DateTime requestDate;
  final String reason;
  final RMAStatus status;

  const SalesReturn({
    required this.id,
    required this.orderId,
    required this.customerId,
    required this.returnedItems,
    required this.requestDate,
    required this.reason,
    this.status = RMAStatus.pending,
  });
}

class CreditNote {
  final String id;
  final String customerId;
  final String referenceId; // RMA or Invoice ID
  final double amount;
  final String currency;
  final DateTime date;
  final String reason;

  const CreditNote({
    required this.id,
    required this.customerId,
    required this.referenceId,
    required this.amount,
    required this.currency,
    required this.date,
    required this.reason,
  });
}
