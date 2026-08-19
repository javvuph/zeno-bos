import 'package:flutter/material.dart';
import '../../domain/repositories/i_customer_repository.dart';
import '../../domain/models/lead.dart';
import '../../domain/models/lead_status.dart';
import '../../domain/models/crm_activity.dart';
import '../../domain/models/campaign.dart';
import '../../domain/models/ticket.dart';
import '../../domain/services/crm_master_data_service.dart';
import '../../domain/services/crm_intelligence_engine.dart';

class CRMController extends ChangeNotifier {
  final ICustomerRepository _repository;
  final CRMMasterDataService _masterData = CRMMasterDataService();
  final CRMIntelligenceEngine _ai = CRMIntelligenceEngine();

  CRMController(this._repository) {
    loadCRMData();
  }

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  List<Lead> _leads = [];
  List<Lead> get leads => _leads.isEmpty ? _masterData.getMockLeads() : _leads;

  List<CRMActivity> _activities = [];
  List<CRMActivity> get activities =>
      _activities.isEmpty ? _masterData.getMockActivities() : _activities;

  List<Campaign> _campaigns = [];
  List<Campaign> get campaigns =>
      _campaigns.isEmpty ? _masterData.getMockCampaigns() : _campaigns;

  List<Ticket> _tickets = [];
  List<Ticket> get tickets =>
      _tickets.isEmpty ? _masterData.getMockTickets() : _tickets;

  Future<void> loadCRMData() async {
    _isLoading = true;
    notifyListeners();
    try {
      _leads = await _repository.getLeads();
      _activities = await _repository.getActivities();
      _campaigns = await _repository.getCampaigns();
      _tickets = await _repository.getTickets();
    } catch (e) {
      debugPrint("Error loading CRM data: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // AI Helpers
  double getLeadScore(Lead lead) => _ai.scoreLead(lead);

  // Dashboard Metrics
  int get qualifiedLeadsCount =>
      leads.where((l) => l.status == LeadStatus.qualified).length;
  int get openTicketsCount =>
      tickets.where((t) => t.status != TicketStatus.closed).length;
  int get slaBreachesCount => tickets.where((t) => t.isSlaBreached).length;

  double get totalPipelineValue => 4500000.0; // Mocked aggregate

  int get activitiesTodayCount {
    final now = DateTime.now();
    return activities
        .where((a) =>
            a.scheduledAt.year == now.year &&
            a.scheduledAt.month == now.month &&
            a.scheduledAt.day == now.day)
        .length;
  }
}
