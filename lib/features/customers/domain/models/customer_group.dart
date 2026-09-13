class CustomerGroup {
  final String id;
  final String name;
  final String? parentId;
  final String? color;

  const CustomerGroup({
    required this.id,
    required this.name,
    this.parentId,
    this.color,
  });
}
