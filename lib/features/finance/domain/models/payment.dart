import 'payment_status.dart';

enum PaymentMethod { cash, bankTransfer, upi, cheque, rtgs, neft, imps, swift }

class Payment {
  final String id;
  final String payableId;
  final String supplierId;
  final double amount;
  final String currency;
  final double exchangeRate;
  final PaymentMethod method;
  final String? referenceNumber;
  final String? bankAccountId;
  final DateTime paymentDate;
  final PaymentStatus status;
  final String? recordedById;

  const Payment({
    required this.id,
    required this.payableId,
    required this.supplierId,
    required this.amount,
    required this.currency,
    this.exchangeRate = 1.0,
    required this.method,
    this.referenceNumber,
    this.bankAccountId,
    required this.paymentDate,
    this.status = PaymentStatus.scheduled,
    this.recordedById,
  });
}
