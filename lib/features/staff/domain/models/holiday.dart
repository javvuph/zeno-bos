class Holiday {
  final String id;
  final String name;
  final DateTime date;
  final String? branchId; // For branch-specific holidays

  const Holiday({
    required this.id,
    required this.name,
    required this.date,
    this.branchId,
  });
}
