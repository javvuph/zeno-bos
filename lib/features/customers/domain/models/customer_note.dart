class CustomerNote {
  final String id;
  final String content;
  final DateTime createdAt;
  final String authorId;

  const CustomerNote({
    required this.id,
    required this.content,
    required this.createdAt,
    required this.authorId,
  });
}
