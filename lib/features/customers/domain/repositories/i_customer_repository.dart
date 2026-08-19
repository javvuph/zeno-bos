import '../models/customer.dart';
import '../models/customer_interaction.dart';
import '../models/customer_segment.dart';

import '../models/customer_category.dart';
import '../models/customer_group.dart';
import '../models/sales_territory.dart';
import '../models/quotation.dart';
import '../models/opportunity.dart';
import '../models/sales_order.dart';
import '../models/lead.dart';
import '../models/crm_activity.dart';
import '../models/campaign.dart';
import '../models/ticket.dart';

abstract class ICustomerRepository {
  Future<Customer?> getCustomerById(String id);
  Future<List<Customer>> getAllCustomers();
  Future<List<Customer>> getDeletedCustomers();
  Future<void> saveCustomer(Customer customer);
  Future<void> deleteCustomer(String id);
  Future<void> restoreCustomer(String id);
  Future<List<Customer>> searchCustomers(String query);

  // Interaction methods
  Future<List<CustomerInteraction>> getInteractions(String customerId);
  Future<void> logInteraction(CustomerInteraction interaction);

  Future<void> updateTier(String id, CustomerTier tier);

  // Group methods
  Future<List<CustomerSegment>> getGroups();
  Future<void> saveGroup(CustomerSegment group);

  // Sales Foundation (Phase 8.1)
  Future<List<CustomerCategory>> getCategories();
  Future<void> saveCategory(CustomerCategory category);
  Future<List<CustomerGroup>> getCustomerGroups();
  Future<void> saveCustomerGroup(CustomerGroup group);
  Future<List<SalesTerritory>> getTerritories();
  Future<void> saveTerritory(SalesTerritory territory);

  // Sales Pipeline (Phase 8.2)
  Future<List<Quotation>> getQuotations();
  Future<void> saveQuotation(Quotation quotation);
  Future<List<Opportunity>> getOpportunities();
  Future<void> saveOpportunity(Opportunity opportunity);

  // Sales Orders (Phase 8.3)
  Future<List<SalesOrder>> getSalesOrders();
  Future<void> saveSalesOrder(SalesOrder order);

  // CRM Master (Phase 9)
  Future<List<Lead>> getLeads();
  Future<void> saveLead(Lead lead);
  Future<List<CRMActivity>> getActivities();
  Future<void> saveActivity(CRMActivity activity);
  Future<List<Campaign>> getCampaigns();
  Future<void> saveCampaign(Campaign campaign);
  Future<List<Ticket>> getTickets();
  Future<void> saveTicket(Ticket ticket);
}
