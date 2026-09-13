class FiscalYear {
  final String id;
  final String name; // e.g., FY2026
  final DateTime startDate;
  final DateTime endDate;
  final bool isClosed;

  const FiscalYear({
    required this.id,
    required this.name,
    required this.startDate,
    required this.endDate,
    this.isClosed = false,
  });
}
