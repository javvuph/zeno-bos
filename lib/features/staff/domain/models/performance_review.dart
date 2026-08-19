class PerformanceReview {
  final String id;
  final String employeeId;
  final String reviewerId;
  final DateTime reviewDate;
  final double rating; // 1.0 - 5.0
  final String feedback;
  final Map<String, dynamic> metrics; // AI-driven metric breakdown

  const PerformanceReview({
    required this.id,
    required this.employeeId,
    required this.reviewerId,
    required this.reviewDate,
    required this.rating,
    required this.feedback,
    this.metrics = const {},
  });
}
