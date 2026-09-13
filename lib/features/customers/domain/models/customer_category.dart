class CustomerCategory {
  final String id;
  final String code;
  final String name;
  final String? description;

  const CustomerCategory({
    required this.id,
    required this.code,
    required this.name,
    this.description,
  });
}
