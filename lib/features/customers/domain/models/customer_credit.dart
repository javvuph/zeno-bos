class CustomerCredit {
  final double creditLimit;
  final double currentBalance;
  final bool isBlocked;
  final String? blockReason;

  const CustomerCredit({
    this.creditLimit = 0.0,
    this.currentBalance = 0.0,
    this.isBlocked = false,
    this.blockReason,
  });

  double get availableCredit => creditLimit - currentBalance;
}
