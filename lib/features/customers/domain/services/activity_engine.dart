import '../models/crm_activity.dart';

class ActivityEngine {
  /// Detects overdue activities
  List<CRMActivity> getOverdue(List<CRMActivity> activities) {
    return activities
        .where((a) =>
            a.status != ActivityStatus.completed &&
            a.status != ActivityStatus.cancelled &&
            a.scheduledAt.isBefore(DateTime.now()))
        .toList();
  }

  /// Recommends follow-up date for a lead (Mock)
  DateTime recommendFollowUp(DateTime lastInteraction) {
    return lastInteraction.add(const Duration(days: 3));
  }

  /// Checks if a reminder should trigger
  bool shouldNotify(CRMActivity activity) {
    if (!activity.reminderEnabled || activity.reminderAt == null) return false;
    return activity.reminderAt!.isBefore(DateTime.now()) &&
        activity.status == ActivityStatus.pending;
  }
}
