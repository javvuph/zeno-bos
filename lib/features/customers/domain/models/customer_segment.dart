class CustomerSegment {
  final String id;
  final String name;
  final String? description;
  final String? color;

  const CustomerSegment({
    required this.id,
    required this.name,
    this.description,
    this.color,
  });
}
