class SupplierBankDetails {
  final String bankName;
  final String accountName;
  final String accountNumber;
  final String? routingNumber;
  final String? swiftCode;
  final String currency;

  const SupplierBankDetails({
    required this.bankName,
    required this.accountName,
    required this.accountNumber,
    this.routingNumber,
    this.swiftCode,
    required this.currency,
  });
}
