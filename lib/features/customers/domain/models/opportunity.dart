import 'opportunity_stage.dart';

class Opportunity {
  final String id;
  final String title;
  final String customerId;
  final double expectedRevenue;
  final double probability; // 0-100
  final OpportunityStage stage;
  final DateTime expectedCloseDate;
  final String? leadSource;
  final String? competitorName;
  final String? lostReason;
  final String? representativeId;
  final DateTime createdAt;

  const Opportunity({
    required this.id,
    required this.title,
    required this.customerId,
    required this.expectedRevenue,
    required this.probability,
    this.stage = OpportunityStage.prospecting,
    required this.expectedCloseDate,
    this.leadSource,
    this.competitorName,
    this.lostReason,
    this.representativeId,
    required this.createdAt,
  });

  double get weightedRevenue => (expectedRevenue * probability) / 100;
}
