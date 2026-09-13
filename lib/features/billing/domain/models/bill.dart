import 'package:equatable/equatable.dart';
import 'package:zeno/features/billing/domain/models/bill_item.dart';
import 'package:zeno/features/billing/domain/models/billing_customer.dart';
import 'package:zeno/features/billing/domain/models/payment.dart';

/// Represents a complete billing transaction.
class Bill extends Equatable {
  final String id;
  final DateTime timestamp;
  final BillingCustomer? customer;
  final List<BillItem> items;
  final List<Payment> payments;

  final double subtotal;
  final double totalTax;
  final double totalDiscount;
  final double grandTotal;
  final String status; // Draft, Held, Completed, Cancelled

  final bool isLocked;
  final List<String> auditTrail;

  const Bill({
    required this.id,
    required this.timestamp,
    this.customer,
    this.items = const [],
    this.payments = const [],
    this.subtotal = 0.0,
    this.totalTax = 0.0,
    this.totalDiscount = 0.0,
    this.grandTotal = 0.0,
    this.status = 'Draft',
    this.isLocked = false,
    this.auditTrail = const [],
  });

  Bill copyWith({
    String? id,
    DateTime? timestamp,
    BillingCustomer? customer,
    List<BillItem>? items,
    List<Payment>? payments,
    double? subtotal,
    double? totalTax,
    double? totalDiscount,
    double? grandTotal,
    String? status,
    bool? isLocked,
    List<String>? auditTrail,
  }) {
    return Bill(
      id: id ?? this.id,
      timestamp: timestamp ?? this.timestamp,
      customer: customer ?? this.customer,
      items: items ?? this.items,
      payments: payments ?? this.payments,
      subtotal: subtotal ?? this.subtotal,
      totalTax: totalTax ?? this.totalTax,
      totalDiscount: totalDiscount ?? this.totalDiscount,
      grandTotal: grandTotal ?? this.grandTotal,
      status: status ?? this.status,
      isLocked: isLocked ?? this.isLocked,
      auditTrail: auditTrail ?? this.auditTrail,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'timestamp': timestamp.toIso8601String(),
      'items': items.map((i) => i.productId).toList(),
      'grandTotal': grandTotal,
      'status': status,
    };
  }

  @override
  List<Object?> get props => [
        id,
        timestamp,
        customer,
        items,
        payments,
        subtotal,
        totalTax,
        totalDiscount,
        grandTotal,
        status,
        isLocked,
        auditTrail,
      ];
}
