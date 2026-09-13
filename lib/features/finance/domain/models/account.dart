import 'account_type.dart';
export 'account_type.dart';

class Account {
  final String id;
  final String code; // e.g., 1000
  final String name;
  final AccountCategory category;
  final AccountType type;
  final String? parentId;
  final String currency;
  final bool isActive;
  final bool isSystemAccount;
  final double currentBalance;

  const Account({
    required this.id,
    required this.code,
    required this.name,
    required this.category,
    required this.type,
    this.parentId,
    this.currency = 'USD',
    this.isActive = true,
    this.isSystemAccount = false,
    this.currentBalance = 0.0,
  });

  Account copyWith({
    String? name,
    bool? isActive,
    double? currentBalance,
  }) {
    return Account(
      id: id,
      code: code,
      name: name ?? this.name,
      category: category,
      type: type,
      parentId: parentId,
      currency: currency,
      isActive: isActive ?? this.isActive,
      isSystemAccount: isSystemAccount,
      currentBalance: currentBalance ?? this.currentBalance,
    );
  }
}
