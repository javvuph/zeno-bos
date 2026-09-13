enum BankAccountType { savings, current, creditCard, cash, vault, pettyCash }

class BankAccount {
  final String id;
  final String name;
  final String accountNumber;
  final String bankName;
  final String branchName;
  final BankAccountType type;
  final String currency;
  final double currentBalance;
  final double availableBalance;
  final bool isActive;
  final String? swiftCode;
  final String? ifscCode;

  const BankAccount({
    required this.id,
    required this.name,
    required this.accountNumber,
    required this.bankName,
    required this.branchName,
    required this.type,
    required this.currency,
    this.currentBalance = 0.0,
    this.availableBalance = 0.0,
    this.isActive = true,
    this.swiftCode,
    this.ifscCode,
  });

  BankAccount copyWith({
    double? currentBalance,
    double? availableBalance,
    bool? isActive,
  }) {
    return BankAccount(
      id: id,
      name: name,
      accountNumber: accountNumber,
      bankName: bankName,
      branchName: branchName,
      type: type,
      currency: currency,
      currentBalance: currentBalance ?? this.currentBalance,
      availableBalance: availableBalance ?? this.availableBalance,
      isActive: isActive ?? this.isActive,
      swiftCode: swiftCode,
      ifscCode: ifscCode,
    );
  }
}
