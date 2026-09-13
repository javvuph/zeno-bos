class Department {
  final String id;
  final String name;
  final String? managerId;
  final bool isActive;

  const Department({
    required this.id,
    required this.name,
    this.managerId,
    this.isActive = true,
  });
}
