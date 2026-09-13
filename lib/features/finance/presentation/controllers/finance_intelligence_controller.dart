import 'package:flutter/material.dart';
import '../../domain/services/finance_intelligence_engine.dart';
import '../../domain/models/finance_insight.dart';

class FinanceIntelligenceController extends ChangeNotifier {
  final FinanceIntelligenceEngine _engine = FinanceIntelligenceEngine();

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  List<FinanceIntelligenceInsight> _insights = [];
  List<FinanceIntelligenceInsight> get insights => _insights;

  Future<void> runFullIntelligenceAnalysis() async {
    _isLoading = true;
    notifyListeners();

    // Simulating deep-ecosystem scan
    await Future.delayed(const Duration(seconds: 1));

    try {
      _insights = _engine.generateExecutiveInsights();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
