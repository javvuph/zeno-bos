enum CampaignType { email, sms, whatsapp, push, multiChannel }

enum CampaignStatus { draft, scheduled, running, completed, paused }

class Campaign {
  final String id;
  final String title;
  final String? description;
  final CampaignType type;
  final CampaignStatus status;
  final double budget;
  final double actualCost;
  final double expectedRevenue;
  final int audienceCount;
  final int conversionCount;
  final DateTime startDate;
  final DateTime? endDate;
  final List<String> targetSegments;
  final Map<String, dynamic> analytics;

  const Campaign({
    required this.id,
    required this.title,
    this.description,
    required this.type,
    this.status = CampaignStatus.draft,
    this.budget = 0.0,
    this.actualCost = 0.0,
    this.expectedRevenue = 0.0,
    this.audienceCount = 0,
    this.conversionCount = 0,
    required this.startDate,
    this.endDate,
    this.targetSegments = const [],
    this.analytics = const {},
  });

  double get roi =>
      actualCost > 0 ? (expectedRevenue - actualCost) / actualCost : 0.0;
}
