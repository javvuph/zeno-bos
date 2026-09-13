import 'package:equatable/equatable.dart';

enum PaymentMethod {
  cash,
  card,
  upi,
  wallet,
  creditNote,
  bankTransfer,
  roomCharge,
}

/// Represents a payment transaction linked to a Bill.
class Payment extends Equatable {
  final String transactionId;
  final PaymentMethod method;
  final double amount;
  final DateTime timestamp;
  final String status; // Pending, Completed, Failed

  const Payment({
    required this.transactionId,
    required this.method,
    required this.amount,
    required this.timestamp,
    required this.status,
  });

  @override
  List<Object?> get props => [transactionId, method, amount, timestamp, status];
}
