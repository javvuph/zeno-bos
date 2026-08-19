import 'lead_status.dart';

class Lead {
  final String id;
  final String name;
  final String? companyName;
  final String email;
  final String phone;
  final String? source;
  final LeadStatus status;
  final double score; // 0-100
  final String? representativeId;
  final String? territoryId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final Map<String, dynamic> aiInsights;

  const Lead({
    required this.id,
    required this.name,
    this.companyName,
    required this.email,
    required this.phone,
    this.source,
    this.status = LeadStatus.new_lead,
    this.score = 0.0,
    this.representativeId,
    this.territoryId,
    required this.createdAt,
    required this.updatedAt,
    this.aiInsights = const {},
  });
}
