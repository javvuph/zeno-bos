enum BankTransactionType {
  deposit,
  withdrawal,
  transfer,
  bankFee,
  interest,
  bounce
}

enum BankTransactionStatus { pending, cleared, reconciled, failed, cancelled }

class BankTransaction {
  final String id;
  final String bankAccountId;
  final DateTime date;
  final String description;
  final double amount;
  final BankTransactionType type;
  final BankTransactionStatus status;
  final String? referenceNumber;
  final String? category;
  final String? sourceDocumentId;
  final String? counterPartyName;
  final bool isAIAnalyzed;
  final double aiFraudScore;

  const BankTransaction({
    required this.id,
    required this.bankAccountId,
    required this.date,
    required this.description,
    required this.amount,
    required this.type,
    this.status = BankTransactionStatus.pending,
    this.referenceNumber,
    this.category,
    this.sourceDocumentId,
    this.counterPartyName,
    this.isAIAnalyzed = false,
    this.aiFraudScore = 0.0,
  });

  BankTransaction copyWith({
    BankTransactionStatus? status,
    bool? isAIAnalyzed,
    double? aiFraudScore,
  }) {
    return BankTransaction(
      id: id,
      bankAccountId: bankAccountId,
      date: date,
      description: description,
      amount: amount,
      type: type,
      status: status ?? this.status,
      referenceNumber: referenceNumber,
      category: category,
      sourceDocumentId: sourceDocumentId,
      counterPartyName: counterPartyName,
      isAIAnalyzed: isAIAnalyzed ?? this.isAIAnalyzed,
      aiFraudScore: aiFraudScore ?? this.aiFraudScore,
    );
  }
}
