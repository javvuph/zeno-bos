class Category {
  final String id;
  final String name;
  final String? parentId;
  final String? description;

  const Category({
    required this.id,
    required this.name,
    this.parentId,
    this.description,
  });
}
