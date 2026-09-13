class Brand {
  final String id;
  final String name;
  final String? description;
  final String? logoUrl;

  const Brand({
    required this.id,
    required this.name,
    this.description,
    this.logoUrl,
  });
}
