import 'package:flutter/material.dart';
import '../../domain/repositories/i_customer_repository.dart';
import '../../domain/models/opportunity.dart';
import '../../domain/services/crm_master_data_service.dart';

class OpportunityController extends ChangeNotifier {
  final ICustomerRepository _repository;
  final CRMMasterDataService _masterData = CRMMasterDataService();

  OpportunityController(this._repository);

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  List<Opportunity> _opportunities = [];
  List<Opportunity> get opportunities => _opportunities.isEmpty
      ? _masterData.getMockOpportunities()
      : _opportunities;

  Future<void> loadOpportunities() async {
    _isLoading = true;
    notifyListeners();
    try {
      _opportunities = await _repository.getOpportunities();
    } catch (e) {
      debugPrint("Error loading opportunities: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> saveOpportunity(Opportunity opp) async {
    _isLoading = true;
    notifyListeners();
    try {
      await _repository.saveOpportunity(opp);
      await loadOpportunities();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
