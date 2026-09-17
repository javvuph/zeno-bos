enum ApprovalStatus { pending, approved, rejected }

class ApprovalStep {
  final int level;
  final String roleId;
  final String? userId;
  final ApprovalStatus status;
  final DateTime? actionDate;
  final String? comments;

  const ApprovalStep({
    required this.level,
    required this.roleId,
    this.userId,
    this.status = ApprovalStatus.pending,
    this.actionDate,
    this.comments,
  });
}

class ApprovalWorkflow {
  final String id;
  final List<ApprovalStep> steps;
  final bool isCompleted;

  const ApprovalWorkflow({
    required this.id,
    required this.steps,
    this.isCompleted = false,
  });

  ApprovalStatus get currentStatus {
    if (steps.any((s) => s.status == ApprovalStatus.rejected)) {
      return ApprovalStatus.rejected;
    }
    if (steps.every((s) => s.status == ApprovalStatus.approved)) {
      return ApprovalStatus.approved;
    }
    return ApprovalStatus.pending;
  }
}
