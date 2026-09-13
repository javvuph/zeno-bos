enum ClosingTaskStatus { pending, inProgress, completed, failed, skipped }

class ClosingTask {
  final String id;
  final String title;
  final String description;
  final String category; // Inventory, Tax, GL, Banking, Assets
  final ClosingTaskStatus status;
  final bool isMandatory;
  final String? assignedTo;
  final DateTime? completedAt;
  final double aiReadinessScore;

  const ClosingTask({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    this.status = ClosingTaskStatus.pending,
    this.isMandatory = true,
    this.assignedTo,
    this.completedAt,
    this.aiReadinessScore = 0.0,
  });

  ClosingTask copyWith({
    ClosingTaskStatus? status,
    DateTime? completedAt,
    double? aiReadinessScore,
  }) {
    return ClosingTask(
      id: id,
      title: title,
      description: description,
      category: category,
      status: status ?? this.status,
      isMandatory: isMandatory,
      assignedTo: assignedTo,
      completedAt: completedAt ?? this.completedAt,
      aiReadinessScore: aiReadinessScore ?? this.aiReadinessScore,
    );
  }
}
