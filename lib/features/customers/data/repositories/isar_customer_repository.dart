import 'package:zeno/core/database/database_service.dart';
import 'package:zeno/core/database/collections/crm_collections.dart';
import 'package:zeno/core/database/collections/transaction_collections.dart';
import '../../domain/repositories/i_customer_repository.dart';
import '../../domain/models/customer.dart';
import '../../domain/models/customer_address.dart';
import '../../domain/models/customer_contact.dart';
import '../../domain/models/customer_credit.dart';
import '../../domain/models/customer_loyalty.dart';
import '../../domain/models/customer_segment.dart';
import '../../domain/models/customer_category.dart';
import '../../domain/models/customer_group.dart';
import '../../domain/models/sales_territory.dart';
import '../../domain/models/quotation.dart';
import '../../domain/models/quotation_item.dart';
import '../../domain/models/opportunity.dart';
import '../../domain/models/sales_order.dart';
import '../../domain/models/sales_order_item.dart';
import '../../domain/models/quotation_status.dart';
import '../../domain/models/opportunity_stage.dart';
import '../../domain/models/sales_order_status.dart';
import '../../domain/models/customer_interaction.dart';
import '../../domain/models/lead.dart';
import '../../domain/models/lead_status.dart';
import '../../domain/models/crm_activity.dart';
import '../../domain/models/campaign.dart';
import '../../domain/models/ticket.dart';
import 'package:isar/isar.dart';
import 'dart:convert';

class IsarCustomerRepository implements ICustomerRepository {
  final DatabaseService db;
  IsarCustomerRepository(this.db);

  IsarCollection<CustomerCollection> get custCol =>
      db.isar.collection<CustomerCollection>();
  IsarCollection<CustomerGroupCollection> get groupCol =>
      db.isar.collection<CustomerGroupCollection>();
  IsarCollection<CustomerCategoryCollection> get catCol =>
      db.isar.collection<CustomerCategoryCollection>();
  IsarCollection<SalesTerritoryCollection> get terrCol =>
      db.isar.collection<SalesTerritoryCollection>();
  IsarCollection<QuotationCollection> get quoteCol =>
      db.isar.collection<QuotationCollection>();
  IsarCollection<OpportunityCollection> get oppCol =>
      db.isar.collection<OpportunityCollection>();
  IsarCollection<SalesOrderCollection> get orderCol =>
      db.isar.collection<SalesOrderCollection>();
  IsarCollection<CustomerInteractionCollection> get interactCol =>
      db.isar.collection<CustomerInteractionCollection>();
  IsarCollection<LeadCollection> get leadCol =>
      db.isar.collection<LeadCollection>();
  IsarCollection<ActivityCollection> get activityCol =>
      db.isar.collection<ActivityCollection>();
  IsarCollection<CampaignCollection> get campaignCol =>
      db.isar.collection<CampaignCollection>();
  IsarCollection<TicketCollection> get ticketCol =>
      db.isar.collection<TicketCollection>();

  @override
  Future<List<Customer>> getAllCustomers() async {
    final results = await custCol.filter().isDeletedEqualTo(false).findAll();
    return results.map((e) => _mapToDomain(e)).toList();
  }

  @override
  Future<Customer?> getCustomerById(String id) async {
    final e = await custCol.filter().uuidEqualTo(id).findFirst();
    return e != null ? _mapToDomain(e) : null;
  }

  @override
  Future<List<Customer>> searchCustomers(String query) async {
    final results = await custCol
        .filter()
        .nameContains(query, caseSensitive: false)
        .or()
        .customerCodeContains(query, caseSensitive: false)
        .or()
        .phoneContains(query)
        .findAll();
    return results.map((e) => _mapToDomain(e)).toList();
  }

  @override
  Future<List<Customer>> getDeletedCustomers() async {
    final results = await custCol.filter().isDeletedEqualTo(true).findAll();
    return results.map((e) => _mapToDomain(e)).toList();
  }

  @override
  Future<void> saveCustomer(Customer customer) async {
    final existing =
        await custCol.filter().uuidEqualTo(customer.id).findFirst();
    final c = (existing ?? CustomerCollection())
      ..uuid = customer.id
      ..customerCode = customer.customerCode
      ..type = customer.type.name
      ..name = customer.name
      ..companyName = customer.companyName
      ..taxId = customer.taxId
      ..email = customer.email
      ..phone = customer.phone
      ..whatsapp = customer.whatsapp
      ..tier = customer.tier.name
      ..categoryId = customer.categoryId
      ..segmentId = customer.segmentId
      ..territoryId = customer.territoryId
      ..salesRepId = customer.salesRepId
      ..groupIds = customer.groupIds
      ..outstandingBalance = customer.credit.currentBalance
      ..creditLimit = customer.credit.creditLimit
      ..isCreditBlocked = customer.credit.isBlocked
      ..loyaltyPoints = customer.loyalty.points.toInt()
      ..lifetimeSpent = customer.loyalty.totalSpent
      ..tags = customer.tags
      ..branchId = customer.branchId
      ..companyId = customer.companyId
      ..lastPurchaseAt = customer.lastPurchaseAt
      ..updatedAt = DateTime.now();

    c.addresses = customer.addresses
        .map((a) => CustomerAddressEmbedded()
          ..uuid = a.id
          ..label = a.label
          ..addressLine1 = a.addressLine1
          ..addressLine2 = a.addressLine2
          ..city = a.city
          ..state = a.state
          ..zipCode = a.zipCode
          ..country = a.country
          ..type = a.type.name
          ..isDefault = a.isDefault)
        .toList();

    c.contacts = customer.contacts
        .map((con) => CustomerContactEmbedded()
          ..uuid = con.id
          ..name = con.name
          ..role = con.role ?? ''
          ..email = con.email
          ..phone = con.phone
          ..isPrimary = con.isPrimary)
        .toList();

    await db.isar.writeTxn(() async {
      await custCol.put(c);
    });
  }

  @override
  Future<void> updateTier(String id, CustomerTier tier) async {
    final existing = await custCol.filter().uuidEqualTo(id).findFirst();
    if (existing != null) {
      existing.tier = tier.name;
      await db.isar.writeTxn(() async {
        await custCol.put(existing);
      });
    }
  }

  @override
  Future<void> deleteCustomer(String id) async {
    final existing = await custCol.filter().uuidEqualTo(id).findFirst();
    if (existing != null) {
      existing.isDeleted = true;
      await db.isar.writeTxn(() async {
        await custCol.put(existing);
      });
    }
  }

  @override
  Future<void> restoreCustomer(String id) async {
    final existing = await custCol.filter().uuidEqualTo(id).findFirst();
    if (existing != null) {
      existing.isDeleted = false;
      await db.isar.writeTxn(() async {
        await custCol.put(existing);
      });
    }
  }

  @override
  Future<List<CustomerInteraction>> getInteractions(String customerId) async {
    final results =
        await interactCol.filter().customerIdEqualTo(customerId).findAll();
    return results
        .map((e) => CustomerInteraction(
              id: e.uuid,
              customerId: e.customerId,
              type: InteractionType.values.firstWhere((t) => t.name == e.type,
                  orElse: () => InteractionType.note),
              summary: e.summary,
              details: e.details,
              timestamp: e.timestamp,
              userId: e.userId,
            ))
        .toList();
  }

  @override
  Future<void> logInteraction(CustomerInteraction interaction) async {
    final i = CustomerInteractionCollection()
      ..uuid = interaction.id
      ..customerId = interaction.customerId
      ..type = interaction.type.name
      ..summary = interaction.summary
      ..details = interaction.details
      ..timestamp = interaction.timestamp
      ..userId = interaction.userId;
    await db.isar.writeTxn(() async {
      await interactCol.put(i);
    });
  }

  @override
  Future<List<CustomerSegment>> getGroups() async => []; // Legacy

  @override
  Future<void> saveGroup(CustomerSegment group) async {} // Legacy

  @override
  Future<List<CustomerCategory>> getCategories() async {
    final results = await catCol.where().findAll();
    return results
        .map((e) => CustomerCategory(id: e.uuid, code: e.code, name: e.name))
        .toList();
  }

  @override
  Future<void> saveCategory(CustomerCategory category) async {
    final c = CustomerCategoryCollection()
      ..uuid = category.id
      ..code = category.code
      ..name = category.name;
    await db.isar.writeTxn(() async {
      await catCol.put(c);
    });
  }

  @override
  Future<List<CustomerGroup>> getCustomerGroups() async {
    final results = await groupCol.where().findAll();
    return results
        .map((e) => CustomerGroup(
            id: e.uuid, name: e.name, parentId: e.parentId, color: e.color))
        .toList();
  }

  @override
  Future<void> saveCustomerGroup(CustomerGroup group) async {
    final g = CustomerGroupCollection()
      ..uuid = group.id
      ..name = group.name
      ..parentId = group.parentId
      ..color = group.color;
    await db.isar.writeTxn(() async {
      await groupCol.put(g);
    });
  }

  @override
  Future<List<SalesTerritory>> getTerritories() async {
    final results = await terrCol.where().findAll();
    return results
        .map((e) => SalesTerritory(
            id: e.uuid,
            code: e.code,
            name: e.name,
            region: e.region,
            parentId: e.parentId))
        .toList();
  }

  @override
  Future<void> saveTerritory(SalesTerritory territory) async {
    final t = SalesTerritoryCollection()
      ..uuid = territory.id
      ..code = territory.code
      ..name = territory.name
      ..region = territory.region
      ..parentId = territory.parentId;
    await db.isar.writeTxn(() async {
      await terrCol.put(t);
    });
  }

  // Sales Pipeline (Phase 8.2)
  @override
  Future<List<Quotation>> getQuotations() async {
    final results = await quoteCol.where().findAll();
    return results
        .map((e) => Quotation(
              id: e.uuid,
              quotationNumber: e.quotationNumber,
              customerId: e.customerId,
              opportunityId: e.opportunityId,
              items: e.items
                      ?.map((i) => QuotationItem(
                            id: '',
                            productId: i.productId,
                            sku: i.sku,
                            name: i.description,
                            quantity: i.quantity,
                            unitPrice: i.unitPrice,
                            totalAmount: i.subtotal,
                          ))
                      .toList() ??
                  <QuotationItem>[],
              subTotal: e.subTotal,
              totalDiscount: e.totalDiscount,
              totalTax: e.totalTax,
              grandTotal: e.grandTotal,
              status: QuotationStatus.values.firstWhere(
                  (s) => s.name == e.status,
                  orElse: () => QuotationStatus.draft),
              revision: e.revision,
              expiryDate: e.expiryDate,
              representativeId: e.representativeId,
              branchId: e.branchId,
              companyId: e.companyId,
              createdAt: e.createdAt,
            ))
        .toList();
  }

  @override
  Future<void> saveQuotation(Quotation quotation) async {
    final existing =
        await quoteCol.filter().uuidEqualTo(quotation.id).findFirst();
    final entry = (existing ?? QuotationCollection())
      ..uuid = quotation.id
      ..quotationNumber = quotation.quotationNumber
      ..customerId = quotation.customerId
      ..opportunityId = quotation.opportunityId
      ..subTotal = quotation.subTotal
      ..totalDiscount = quotation.totalDiscount
      ..totalTax = quotation.totalTax
      ..grandTotal = quotation.grandTotal
      ..status = quotation.status.name
      ..revision = quotation.revision
      ..expiryDate = quotation.expiryDate
      ..representativeId = quotation.representativeId
      ..branchId = quotation.branchId
      ..companyId = quotation.companyId
      ..createdAt = quotation.createdAt
      ..items = quotation.items
          .map((i) => TransactionItem()
            ..productId = i.productId
            ..sku = i.sku
            ..description = i.name
            ..quantity = i.quantity
            ..fulfilledQuantity = 0.0
            ..unitPrice = i.unitPrice
            ..taxRate = 0.0
            ..subtotal = i.totalAmount)
          .toList();

    await db.isar.writeTxn(() async {
      await quoteCol.put(entry);
    });
  }

  @override
  Future<List<Opportunity>> getOpportunities() async {
    final results = await oppCol.where().findAll();
    return results
        .map((e) => Opportunity(
              id: e.uuid,
              title: e.title,
              customerId: e.customerId,
              expectedRevenue: e.expectedRevenue,
              probability: e.probability,
              stage: OpportunityStage.values.firstWhere(
                  (s) => s.name == e.stage,
                  orElse: () => OpportunityStage.prospecting),
              expectedCloseDate: e.expectedCloseDate,
              leadSource: e.leadSource,
              competitorName: e.competitorName,
              lostReason: e.lostReason,
              representativeId: e.representativeId,
              createdAt: e.createdAt,
            ))
        .toList();
  }

  @override
  Future<void> saveOpportunity(Opportunity opportunity) async {
    final existing =
        await oppCol.filter().uuidEqualTo(opportunity.id).findFirst();
    final entry = (existing ?? OpportunityCollection())
      ..uuid = opportunity.id
      ..title = opportunity.title
      ..customerId = opportunity.customerId
      ..expectedRevenue = opportunity.expectedRevenue
      ..probability = opportunity.probability
      ..stage = opportunity.stage.name
      ..expectedCloseDate = opportunity.expectedCloseDate
      ..leadSource = opportunity.leadSource
      ..competitorName = opportunity.competitorName
      ..lostReason = opportunity.lostReason
      ..representativeId = opportunity.representativeId
      ..createdAt = opportunity.createdAt;

    await db.isar.writeTxn(() async {
      await oppCol.put(entry);
    });
  }

  @override
  Future<List<SalesOrder>> getSalesOrders() async {
    final results = await orderCol.where().findAll();
    return results
        .map((e) => SalesOrder(
              id: e.uuid,
              orderNumber: e.orderNumber,
              customerId: e.customerId,
              quotationId: e.quotationId,
              items: e.items
                      ?.map((i) => SalesOrderItem(
                            id: '',
                            productId: i.productId,
                            sku: i.sku,
                            name: i.description,
                            quantity: i.quantity,
                            fulfilledQuantity: i.fulfilledQuantity,
                            unitPrice: i.unitPrice,
                            totalAmount: i.subtotal,
                          ))
                      .toList() ??
                  <SalesOrderItem>[],
              subTotal: e.subTotal,
              totalDiscount: e.totalDiscount,
              totalTax: e.totalTax,
              grandTotal: e.totalAmount,
              status: SalesOrderStatus.values.firstWhere(
                  (s) => s.name == e.status,
                  orElse: () => SalesOrderStatus.draft),
              orderDate: e.date,
              expectedDeliveryDate: e.expectedDeliveryDate,
              shippingAddressId: e.shippingAddressId,
              billingAddressId: e.billingAddressId,
              representativeId: e.representativeId,
              branchId: e.branchId,
              companyId: e.companyId,
            ))
        .toList();
  }

  @override
  Future<void> saveSalesOrder(SalesOrder order) async {
    final existing = await orderCol.filter().uuidEqualTo(order.id).findFirst();
    final entry = (existing ?? SalesOrderCollection())
      ..uuid = order.id
      ..orderNumber = order.orderNumber
      ..customerId = order.customerId
      ..quotationId = order.quotationId
      ..subTotal = order.subTotal
      ..totalDiscount = order.totalDiscount
      ..totalTax = order.totalTax
      ..totalAmount = order.grandTotal
      ..status = order.status.name
      ..date = order.orderDate
      ..expectedDeliveryDate = order.expectedDeliveryDate
      ..shippingAddressId = order.shippingAddressId
      ..billingAddressId = order.billingAddressId
      ..representativeId = order.representativeId
      ..branchId = order.branchId
      ..companyId = order.companyId
      ..warehouseId = 'MAIN-WH'
      ..currency = 'USD'
      ..exchangeRate = 1.0
      ..updatedAt = DateTime.now()
      ..items = order.items
          .map((i) => TransactionItem()
            ..productId = i.productId
            ..sku = i.sku
            ..description = i.name
            ..quantity = i.quantity
            ..fulfilledQuantity = i.fulfilledQuantity
            ..unitPrice = i.unitPrice
            ..taxRate = 0.0
            ..subtotal = i.totalAmount)
          .toList();

    await db.isar.writeTxn(() async {
      await orderCol.put(entry);
    });
  }

  // CRM Master (Phase 9)
  @override
  Future<List<Lead>> getLeads() async {
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

  @override
  Future<void> saveLead(Lead lead) async {
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

  @override
  Future<List<CRMActivity>> getActivities() async {
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

  @override
  Future<void> saveActivity(CRMActivity activity) async {
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

  @override
  Future<List<Campaign>> getCampaigns() async {
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

  @override
  Future<void> saveCampaign(Campaign campaign) async {
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

  @override
  Future<List<Ticket>> getTickets() async {
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

  @override
  Future<void> saveTicket(Ticket ticket) async {
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

  Customer _mapToDomain(CustomerCollection e) {
    return Customer(
      id: e.uuid,
      customerCode: e.customerCode,
      type: CustomerType.values.firstWhere((t) => t.name == e.type,
          orElse: () => CustomerType.individual),
      name: e.name,
      companyName: e.companyName,
      taxId: e.taxId,
      email: e.email,
      phone: e.phone,
      whatsapp: e.whatsapp,
      tier: CustomerTier.values.firstWhere((t) => t.name == e.tier,
          orElse: () => CustomerTier.standard),
      categoryId: e.categoryId,
      segmentId: e.segmentId,
      territoryId: e.territoryId,
      salesRepId: e.salesRepId,
      groupIds: e.groupIds,
      addresses: e.addresses
              ?.map((a) => CustomerAddress(
                    id: a.uuid,
                    label: a.label,
                    addressLine1: a.addressLine1,
                    addressLine2: a.addressLine2,
                    city: a.city,
                    state: a.state,
                    zipCode: a.zipCode,
                    country: a.country,
                    type: AddressType.values.firstWhere((t) => t.name == a.type,
                        orElse: () => AddressType.billing),
                    isDefault: a.isDefault,
                  ))
              .toList() ??
          [],
      contacts: e.contacts
              ?.map((c) => CustomerContact(
                    id: c.uuid,
                    name: c.name,
                    role: c.role,
                    email: c.email,
                    phone: c.phone,
                    isPrimary: c.isPrimary,
                  ))
              .toList() ??
          [],
      credit: CustomerCredit(
        currentBalance: e.outstandingBalance,
        creditLimit: e.creditLimit,
        isBlocked: e.isCreditBlocked,
      ),
      loyalty: CustomerLoyalty(
        points: e.loyaltyPoints.toDouble(),
        totalSpent: e.lifetimeSpent,
      ),
      createdAt: e.createdAt,
      updatedAt: e.updatedAt,
      lastPurchaseAt: e.lastPurchaseAt,
    );
  }
}
