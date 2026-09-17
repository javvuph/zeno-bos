import 'dart:convert';
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

part 'parts/isar_customer_repository_core.part.dart';
part 'parts/isar_customer_repository_pipeline.part.dart';
part 'parts/isar_customer_repository_crm.part.dart';

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
  Future<List<Customer>> getAllCustomers() => getAllCustomersImpl();

  @override
  Future<Customer?> getCustomerById(String id) => getCustomerByIdImpl(id);

  @override
  Future<List<Customer>> searchCustomers(String query) => searchCustomersImpl(query);

  @override
  Future<List<Customer>> getDeletedCustomers() => getDeletedCustomersImpl();

  @override
  Future<void> saveCustomer(Customer customer) => saveCustomerImpl(customer);

  @override
  Future<void> updateTier(String id, CustomerTier tier) => updateTierImpl(id, tier);

  @override
  Future<void> deleteCustomer(String id) => deleteCustomerImpl(id);

  @override
  Future<void> restoreCustomer(String id) => restoreCustomerImpl(id);

  @override
  Future<List<CustomerInteraction>> getInteractions(String customerId) =>
      getInteractionsImpl(customerId);

  @override
  Future<void> logInteraction(CustomerInteraction interaction) =>
      logInteractionImpl(interaction);

  @override
  Future<List<CustomerSegment>> getGroups() async => [];

  @override
  Future<void> saveGroup(CustomerSegment group) async {}

  @override
  Future<List<CustomerCategory>> getCategories() => getCategoriesImpl();

  @override
  Future<void> saveCategory(CustomerCategory category) => saveCategoryImpl(category);

  @override
  Future<List<CustomerGroup>> getCustomerGroups() => getCustomerGroupsImpl();

  @override
  Future<void> saveCustomerGroup(CustomerGroup group) => saveCustomerGroupImpl(group);

  @override
  Future<List<SalesTerritory>> getTerritories() => getTerritoriesImpl();

  @override
  Future<void> saveTerritory(SalesTerritory territory) => saveTerritoryImpl(territory);

  @override
  Future<List<Quotation>> getQuotations() => getQuotationsImpl();

  @override
  Future<void> saveQuotation(Quotation quotation) => saveQuotationImpl(quotation);

  @override
  Future<List<Opportunity>> getOpportunities() => getOpportunitiesImpl();

  @override
  Future<void> saveOpportunity(Opportunity opportunity) => saveOpportunityImpl(opportunity);

  @override
  Future<List<SalesOrder>> getSalesOrders() => getSalesOrdersImpl();

  @override
  Future<void> saveSalesOrder(SalesOrder order) => saveSalesOrderImpl(order);

  @override
  Future<List<Lead>> getLeads() => getLeadsImpl();

  @override
  Future<void> saveLead(Lead lead) => saveLeadImpl(lead);

  @override
  Future<List<CRMActivity>> getActivities() => getActivitiesImpl();

  @override
  Future<void> saveActivity(CRMActivity activity) => saveActivityImpl(activity);

  @override
  Future<List<Campaign>> getCampaigns() => getCampaignsImpl();

  @override
  Future<void> saveCampaign(Campaign campaign) => saveCampaignImpl(campaign);

  @override
  Future<List<Ticket>> getTickets() => getTicketsImpl();

  @override
  Future<void> saveTicket(Ticket ticket) => saveTicketImpl(ticket);
}
