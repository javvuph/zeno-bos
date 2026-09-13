enum ExportFormat { pdf, excel, csv }

enum ExportStatus { pending, processing, completed, failed }

class ExportJob {
  final String id;
  final String reportId;
  final ExportFormat format;
  final ExportStatus status;
  final DateTime createdAt;
  final String? downloadUrl;

  const ExportJob({
    required this.id,
    required this.reportId,
    required this.format,
    this.status = ExportStatus.pending,
    required this.createdAt,
    this.downloadUrl,
  });
}
