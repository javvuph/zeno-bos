class Designation {
  final String id;
  final String title;
  final String? departmentId;
  final int level; // For hierarchy/grading

  const Designation({
    required this.id,
    required this.title,
    this.departmentId,
    this.level = 1,
  });
}
