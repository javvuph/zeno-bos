part of '../isar_customer_repository.dart';

extension IsarCustomerRepositoryCrmPart on IsarCustomerRepository {
  Future<List<Lead>> getLeadsImpl() async {
    final results = await leadCol.where().findAll();
    return results
        .map((e) => Lead(
              id: e.uuid,
              name: e.name,
              companyName: e.companyName,
              email: e.email,
              phone: e.phone,
              source: e.source,
              status: LeadStatus.values.firstWhere((s) => s.name == e.status,
                  orElse: () => LeadStatus.new_lead),
              score: e.score,
              representativeId: e.representativeId,
              territoryId: e.territoryId,
              createdAt: e.createdAt,
              updatedAt: e.updatedAt,
              aiInsights: e.aiInsightsJson != null
                  ? jsonDecode(e.aiInsightsJson!)
                  : const {},
            ))
        .toList();
  }

  Future<void> saveLeadImpl(Lead lead) async {
    final existing = await leadCol.filter().uuidEqualTo(lead.id).findFirst();
    final entry = (existing ?? LeadCollection())
      ..uuid = lead.id
      ..name = lead.name
      ..companyName = lead.companyName
      ..email = lead.email
      ..phone = lead.phone
      ..source = lead.source
      ..status = lead.status.name
      ..score = lead.score
      ..representativeId = lead.representativeId
      ..territoryId = lead.territoryId
      ..updatedAt = DateTime.now()
      ..aiInsightsJson = jsonEncode(lead.aiInsights);

    await db.isar.writeTxn(() async {
      await leadCol.put(entry);
    });
  }

  Future<List<CRMActivity>> getActivitiesImpl() async {
    final results = await activityCol.where().findAll();
    return results
        .map((e) => CRMActivity(
              id: e.uuid,
              title: e.title,
              description: e.description,
              type: ActivityType.values.firstWhere((t) => t.name == e.type,
                  orElse: () => ActivityType.task),
              priority: ActivityPriority.values.firstWhere(
                  (p) => p.name == e.priority,
                  orElse: () => ActivityPriority.medium),
              status: ActivityStatus.values.firstWhere(
                  (s) => s.name == e.status,
                  orElse: () => ActivityStatus.pending),
              scheduledAt: e.scheduledAt,
              completedAt: e.completedAt,
              assignedToId: e.assignedToId,
              customerId: e.customerId,
              leadId: e.leadId,
              opportunityId: e.opportunityId,
              ticketId: e.ticketId,
              salesOrderId: e.salesOrderId,
              reminderEnabled: e.reminderEnabled,
              reminderAt: e.reminderAt,
            ))
        .toList();
  }

  Future<void> saveActivityImpl(CRMActivity activity) async {
    final existing =
        await activityCol.filter().uuidEqualTo(activity.id).findFirst();
    final entry = (existing ?? ActivityCollection())
      ..uuid = activity.id
      ..title = activity.title
      ..description = activity.description
      ..type = activity.type.name
      ..priority = activity.priority.name
      ..status = activity.status.name
      ..scheduledAt = activity.scheduledAt
      ..completedAt = activity.completedAt
      ..assignedToId = activity.assignedToId
      ..customerId = activity.customerId
      ..leadId = activity.leadId
      ..opportunityId = activity.opportunityId
      ..ticketId = activity.ticketId
      ..salesOrderId = activity.salesOrderId
      ..reminderEnabled = activity.reminderEnabled
      ..reminderAt = activity.reminderAt;

    await db.isar.writeTxn(() async {
      await activityCol.put(entry);
    });
  }

  Future<List<Campaign>> getCampaignsImpl() async {
    final results = await campaignCol.where().findAll();
    return results
        .map((e) => Campaign(
              id: e.uuid,
              title: e.title,
              description: e.description,
              type: CampaignType.values.firstWhere((t) => t.name == e.type,
                  orElse: () => CampaignType.email),
              status: CampaignStatus.values.firstWhere(
                  (s) => s.name == e.status,
                  orElse: () => CampaignStatus.draft),
              budget: e.budget,
              actualCost: e.actualCost,
              expectedRevenue: e.expectedRevenue,
              audienceCount: e.audienceCount,
              conversionCount: e.conversionCount,
              startDate: e.startDate,
              endDate: e.endDate,
              targetSegments: e.targetSegments,
              analytics: e.analyticsJson != null
                  ? jsonDecode(e.analyticsJson!)
                  : const {},
            ))
        .toList();
  }

  Future<void> saveCampaignImpl(Campaign campaign) async {
    final existing =
        await campaignCol.filter().uuidEqualTo(campaign.id).findFirst();
    final entry = (existing ?? CampaignCollection())
      ..uuid = campaign.id
      ..title = campaign.title
      ..description = campaign.description
      ..type = campaign.type.name
      ..status = campaign.status.name
      ..budget = campaign.budget
      ..actualCost = campaign.actualCost
      ..expectedRevenue = campaign.expectedRevenue
      ..audienceCount = campaign.audienceCount
      ..conversionCount = campaign.conversionCount
      ..startDate = campaign.startDate
      ..endDate = campaign.endDate
      ..targetSegments = campaign.targetSegments
      ..analyticsJson = jsonEncode(campaign.analytics);

    await db.isar.writeTxn(() async {
      await campaignCol.put(entry);
    });
  }

  Future<List<Ticket>> getTicketsImpl() async {
    final results = await ticketCol.where().findAll();
    return results
        .map((e) => Ticket(
              id: e.uuid,
              ticketNumber: e.ticketNumber,
              subject: e.subject,
              description: e.description,
              customerId: e.customerId,
              priority: TicketPriority.values.firstWhere(
                  (p) => p.name == e.priority,
                  orElse: () => TicketPriority.medium),
              status: TicketStatus.values.firstWhere((s) => s.name == e.status,
                  orElse: () => TicketStatus.new_ticket),
              category: e.category,
              assignedToId: e.assignedToId,
              createdAt: e.createdAt,
              resolvedAt: e.resolvedAt,
              slaDeadline: e.slaDeadline,
              isSlaBreached: e.isSlaBreached,
              resolutionNotes: e.resolutionNotes,
            ))
        .toList();
  }

  Future<void> saveTicketImpl(Ticket ticket) async {
    final existing =
        await ticketCol.filter().uuidEqualTo(ticket.id).findFirst();
    final entry = (existing ?? TicketCollection())
      ..uuid = ticket.id
      ..ticketNumber = ticket.ticketNumber
      ..subject = ticket.subject
      ..description = ticket.description
      ..customerId = ticket.customerId
      ..priority = ticket.priority.name
      ..status = ticket.status.name
      ..category = ticket.category
      ..assignedToId = ticket.assignedToId
      ..createdAt = ticket.createdAt
      ..resolvedAt = ticket.resolvedAt
      ..slaDeadline = ticket.slaDeadline
      ..isSlaBreached = ticket.isSlaBreached
      ..resolutionNotes = ticket.resolutionNotes;

    await db.isar.writeTxn(() async {
      await ticketCol.put(entry);
    });
  }
}
