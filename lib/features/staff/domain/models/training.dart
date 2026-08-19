class TrainingProgram {
  final String id;
  final String title;
  final String description;
  final DateTime startDate;
  final DateTime endDate;
  final List<String> enrolledEmployeeIds;

  const TrainingProgram({
    required this.id,
    required this.title,
    required this.description,
    required this.startDate,
    required this.endDate,
    this.enrolledEmployeeIds = const [],
  });
}
