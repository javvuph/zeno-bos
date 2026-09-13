import 'export_job.dart';

enum Frequency { daily, weekly, monthly }

class ScheduledReport {
  final String id;
  final String reportId;
  final Frequency frequency;
  final List<String> recipientEmails;
  final ExportFormat format;
  final bool isActive;

  const ScheduledReport({
    required this.id,
    required this.reportId,
    required this.frequency,
    required this.recipientEmails,
    this.format = ExportFormat.pdf,
    this.isActive = true,
  });
}
