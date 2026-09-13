import 'journal_line.dart';

enum JournalEntryStatus { draft, posted, cancelled }

class JournalEntry {
  final String id;
  final String referenceNumber;
  final DateTime date;
  final String description;
  final List<JournalLine> lines;
  final JournalEntryStatus status;
  final String currency;
  final double exchangeRate;
  final String createdById;
  final String? approvedById;
  final String sourceModule; // e.g., 'billing', 'purchase'
  final String? sourceDocumentId;

  const JournalEntry({
    required this.id,
    required this.referenceNumber,
    required this.date,
    required this.description,
    required this.lines,
    this.status = JournalEntryStatus.posted,
    this.currency = 'USD',
    this.exchangeRate = 1.0,
    required this.createdById,
    this.approvedById,
    required this.sourceModule,
    this.sourceDocumentId,
  });

  bool get isBalanced {
    double totalDebit = lines.fold(0, (sum, line) => sum + line.debit);
    double totalCredit = lines.fold(0, (sum, line) => sum + line.credit);
    return (totalDebit - totalCredit).abs() < 0.0001;
  }
}
