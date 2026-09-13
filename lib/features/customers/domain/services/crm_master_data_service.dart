import '../models/customer.dart';
import '../models/customer_segment.dart';
import '../models/customer_category.dart';
import '../models/customer_group.dart';
import '../models/sales_territory.dart';
import '../models/quotation.dart';
import '../models/quotation_item.dart';
import '../models/quotation_status.dart';
import '../models/opportunity.dart';
import '../models/opportunity_stage.dart';
import '../models/sales_order.dart';
import '../models/sales_order_item.dart';
import '../models/sales_order_status.dart';
import '../models/lead.dart';
import '../models/lead_status.dart';
import '../models/crm_activity.dart';
import '../models/campaign.dart';
import '../models/ticket.dart';

class CRMMasterDataService {
  List<Customer> getMockCustomers() => [
        Customer(
          id: 'CUST-001',
          customerCode: 'Z-C-1001',
          type: CustomerType.individual,
          name: 'Rahul Sharma',
          email: 'rahul.s@zeno.com',
          phone: '+91 98765 43210',
          tier: CustomerTier.gold,
          createdAt: DateTime(2024, 1, 1),
          updatedAt: DateTime.now(),
          aiProfile: const {'health_score': 88.0},
        ),
        Customer(
          id: 'CUST-002',
          customerCode: 'Z-C-1002',
          type: CustomerType.business,
          name: 'Amit Patel',
          companyName: 'Global Tech Ltd',
          email: 'amit@globaltech.com',
          phone: '+91 91234 56789',
          tier: CustomerTier.vip,
          createdAt: DateTime(2023, 11, 15),
          updatedAt: DateTime.now(),
          aiProfile: const {'health_score': 94.0},
          lastPurchaseAt: DateTime.now().subtract(const Duration(days: 2)),
        ),
      ];

  List<CustomerSegment> getSegments() => [
        const CustomerSegment(
            id: 'seg_high_value', name: 'High Value', color: 'green'),
        const CustomerSegment(
            id: 'seg_churn_risk', name: 'Churn Risk', color: 'red'),
      ];

  List<CustomerCategory> getCategories() => [
        const CustomerCategory(id: 'cat_retail', code: 'RET', name: 'Retail'),
        const CustomerCategory(id: 'cat_whsl', code: 'WHL', name: 'Wholesale'),
      ];

  List<CustomerGroup> getGroups() => [
        const CustomerGroup(
            id: 'grp_cor', name: 'Corporate Clients', color: 'blue'),
        const CustomerGroup(
            id: 'grp_gov', name: 'Government Entities', color: 'purple'),
      ];

  List<SalesTerritory> getTerritories() => [
        const SalesTerritory(
            id: 'ter_north',
            code: 'T-NORTH',
            name: 'North Region',
            region: 'India'),
        const SalesTerritory(
            id: 'ter_south',
            code: 'T-SOUTH',
            name: 'South Region',
            region: 'India'),
      ];

  List<Quotation> getMockQuotations() => [
        Quotation(
          id: 'QT-1001',
          quotationNumber: 'QT/2026/001',
          customerId: 'CUST-001',
          items: [
            const QuotationItem(
                id: '1',
                productId: 'P1',
                sku: 'MAC-PRO',
                name: 'MacBook Pro',
                quantity: 1,
                unitPrice: 245000,
                totalAmount: 245000),
          ],
          subTotal: 245000,
          totalDiscount: 5000,
          totalTax: 43200,
          grandTotal: 283200,
          status: QuotationStatus.approved,
          revision: 1,
          expiryDate: DateTime.now().add(const Duration(days: 15)),
          createdAt: DateTime.now(),
        ),
      ];

  List<Opportunity> getMockOpportunities() => [
        Opportunity(
          id: 'OPP-101',
          title: 'Enterprise Server Upgrade',
          customerId: 'CUST-002',
          expectedRevenue: 1200000.0,
          probability: 50.0,
          stage: OpportunityStage.needsAnalysis,
          expectedCloseDate: DateTime(2026, 9, 30),
          leadSource: 'Referral',
          createdAt: DateTime.now(),
        ),
      ];

  List<SalesOrder> getMockOrders() => [
        SalesOrder(
          id: 'SO-1001',
          orderNumber: 'SO/2026/991',
          customerId: 'CUST-001',
          orderDate: DateTime.now().subtract(const Duration(days: 1)),
          expectedDeliveryDate: DateTime.now().add(const Duration(days: 3)),
          items: [
            const SalesOrderItem(
                id: '1',
                productId: 'P1',
                sku: 'MAC-PRO',
                name: 'MacBook Pro',
                quantity: 2,
                fulfilledQuantity: 1,
                unitPrice: 245000,
                totalAmount: 490000),
          ],
          subTotal: 490000,
          totalDiscount: 10000,
          totalTax: 86400,
          grandTotal: 566400,
          status: SalesOrderStatus.partiallyFulfilled,
        ),
      ];

  List<Lead> getMockLeads() => [
        Lead(
          id: 'L-001',
          name: 'Vikram Singh',
          companyName: 'Apex Solutions',
          email: 'vikram@apex.com',
          phone: '+91 88888 77777',
          source: 'Website',
          status: LeadStatus.contacted,
          score: 75.0,
          createdAt: DateTime.now().subtract(const Duration(days: 5)),
          updatedAt: DateTime.now(),
        ),
        Lead(
          id: 'L-002',
          name: 'Neha Gupta',
          email: 'neha.g@gmail.com',
          phone: '+91 99000 11223',
          source: 'LinkedIn',
          status: LeadStatus.new_lead,
          score: 45.0,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        ),
      ];

  List<CRMActivity> getMockActivities() => [
        CRMActivity(
          id: 'A-001',
          title: 'Follow-up Call',
          type: ActivityType.call,
          status: ActivityStatus.pending,
          priority: ActivityPriority.high,
          scheduledAt: DateTime.now().add(const Duration(hours: 2)),
          assignedToId: 'user-01',
          leadId: 'L-001',
        ),
        CRMActivity(
          id: 'A-002',
          title: 'Product Demo',
          type: ActivityType.demo,
          status: ActivityStatus.completed,
          scheduledAt: DateTime.now().subtract(const Duration(days: 1)),
          completedAt: DateTime.now().subtract(const Duration(days: 1)),
          assignedToId: 'user-01',
          opportunityId: 'OPP-101',
        ),
      ];

  List<Campaign> getMockCampaigns() => [
        Campaign(
          id: 'C-001',
          title: 'Summer Tech Expo 2026',
          type: CampaignType.email,
          status: CampaignStatus.running,
          budget: 50000,
          actualCost: 12000,
          expectedRevenue: 250000,
          audienceCount: 1500,
          conversionCount: 45,
          startDate: DateTime(2026, 6, 1),
        ),
      ];

  List<Ticket> getMockTickets() => [
        Ticket(
          id: 'T-001',
          ticketNumber: 'TKT-9901',
          subject: 'Issue with license key activation',
          customerId: 'CUST-002',
          priority: TicketPriority.high,
          status: TicketStatus.inProgress,
          category: 'Software Support',
          createdAt: DateTime.now().subtract(const Duration(hours: 4)),
          slaDeadline: DateTime.now().add(const Duration(hours: 4)),
        ),
      ];
}
