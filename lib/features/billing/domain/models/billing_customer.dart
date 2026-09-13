import 'package:equatable/equatable.dart';

/// Represents a customer context in the billing studio.
class BillingCustomer extends Equatable {
  final String id;
  final String name;
  final String phone;
  final String loyaltyTier;
  final double creditLimit;
  final double currentBalance;

  const BillingCustomer({
    required this.id,
    required this.name,
    required this.phone,
    this.loyaltyTier = 'Retail',
    this.creditLimit = 0.0,
    this.currentBalance = 0.0,
  });

  @override
  List<Object?> get props =>
      [id, name, phone, loyaltyTier, creditLimit, currentBalance];
}
