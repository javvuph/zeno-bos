import 'package:flutter/material.dart';
import '../../domain/repositories/i_ai_repository.dart';
import '../../domain/models/ai_model.dart';
import '../../domain/models/ai_usage.dart';
import '../../domain/services/ai_intelligence_engine.dart';
import '../../domain/services/ai_master_data_service.dart';
import '../../domain/models/ai_conversation.dart';
import '../../domain/models/ai_prompt.dart';
import '../../domain/models/ai_response.dart' as domain_resp;
import '../../domain/models/ai_automation.dart';
import '../../domain/models/ai_recommendation.dart';
import '../../domain/models/ai_prediction.dart';
import '../../domain/services/ai_context_service.dart';
import 'package:zeno/core/ai/ai_gateway.dart';
import 'package:zeno/core/di/service_locator.dart';
import 'package:uuid/uuid.dart';

class AIController extends ChangeNotifier {
  final IAIRepository _repository;
  final AIGateway _gateway = sl<AIGateway>();
  final AIIntelligenceEngine _engine = AIIntelligenceEngine();
  final AIMasterDataService _masterData = AIMasterDataService();

  AIController(this._repository);

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  List<AIModel> _models = [];
  List<AIModel> get models =>
      _models.isEmpty ? _masterData.getMockModels() : _models;

  List<AIUsage> _usageLogs = [];
  List<AIUsage> get usageLogs => _usageLogs;

  List<AIAutomation> _automations = [];
  List<AIAutomation> get automations => _automations;

  AIConversation? _activeConversation;
  AIConversation? get activeConversation => _activeConversation;

  List<AIConversation> _history = [];
  List<AIConversation> get history => _history;

  List<AIRecommendation> _recommendations = [];
  List<AIRecommendation> get recommendations => _recommendations;

  List<AIPrediction> _predictions = [];
  List<AIPrediction> get predictions => _predictions;

  Map<String, dynamic> _lastGlobalContext = {};
  Map<String, dynamic> get lastGlobalContext => _lastGlobalContext;

  // Executive KPIs
  double get healthScore => 0.0;
  double get avgResponseTime => 0.0;
  double get confidenceScore => 0.0;
  double get accuracyRate => 0.0;

  // KPI Bridges
  double get totalMonthlyCost =>
      _usageLogs.fold(0.0, (sum, u) => sum + u.estimatedCost);

  Future<void> loadModels() async {
    _isLoading = true;
    notifyListeners();
    try {
      _models = await _repository.getModels();
      if (_models.isEmpty) _models = _masterData.getMockModels();
    } catch (e) {
      debugPrint("Error loading AI models: $e");
      _models = _masterData.getMockModels();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> loadHistory() async {
    _isLoading = true;
    notifyListeners();
    try {
      _history = await _repository.getConversations('admin');
    } catch (e) {
      debugPrint("Error loading history: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> loadUsage() async {
    _isLoading = true;
    notifyListeners();
    try {
      final now = DateTime.now();
      final startOfMonth = DateTime(now.year, now.month, 1);
      _usageLogs = await _repository.getUsageStats('admin', startOfMonth, now);
      if (_usageLogs.isEmpty) _usageLogs = _masterData.getMockUsage();
    } catch (e) {
      debugPrint("Error loading usage: $e");
      _usageLogs = _masterData.getMockUsage();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> loadAutomations() async {
    _isLoading = true;
    notifyListeners();
    try {
      _automations = await _repository.getAutomations();
      if (_automations.isEmpty) _automations = _masterData.getMockAutomations();
    } catch (e) {
      debugPrint("Error loading automations: $e");
      _automations = _masterData.getMockAutomations();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> refreshIntelligence() async {
    _isLoading = true;
    notifyListeners();
    try {
      final contextService = sl<AIContextService>();
      _lastGlobalContext = await contextService.gatherGlobalContext();

      _recommendations =
          _engine.generateExecutiveRecommendations(_lastGlobalContext);
      _predictions = _engine.calculateBusinessPredictions(_lastGlobalContext);

      await loadUsage();
      await loadAutomations();
      await loadModels();
      await loadHistory();
    } catch (e) {
      debugPrint("Intelligence Refresh Failed: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void selectConversation(AIConversation conversation) {
    _activeConversation = conversation;
    notifyListeners();
  }

  Future<void> startNewSession() async {
    _activeConversation = AIConversation(
      id: const Uuid().v4(),
      title: "New Intelligence Session",
      createdAt: DateTime.now(),
      history: [],
    );
    notifyListeners();
  }

  Future<void> processNLQuery(
      String query, Map<String, dynamic> context) async {
    if (_activeConversation == null) await startNewSession();

    _isLoading = true;
    notifyListeners();

    try {
      // 1. Audit Log Entry
      debugPrint(
          "AI_AUDIT: Query from 'admin' - ${DateTime.now()} - Context Modules: ${context.keys}");

      // 2. Optimal Model Selection
      final modelId = _engine.selectOptimalModel(
          query, _models.isEmpty ? _masterData.getMockModels() : _models);

      // 3. Build contextual prompt
      final fullPrompt = _engine.buildContextPrompt(query, context);

      // 4. Execution via Gateway
      final response =
          await _gateway.prompt(fullPrompt, context: {'model': modelId});

      // 5. Record Interaction
      final interaction = AIInteraction(
        prompt: AIPrompt(content: query),
        response: domain_resp.AIResponse(
          content: response.text,
          modelId: response.provider,
          metadata: {
            'tokens': (query.length + response.text.length) ~/ 4,
            'modules_analyzed': context.keys.toList(),
          },
        ),
        timestamp: DateTime.now(),
      );

      final updatedHistory =
          List<AIInteraction>.from(_activeConversation!.history)
            ..add(interaction);
      _activeConversation = AIConversation(
        id: _activeConversation!.id,
        title: query.length > 30 ? "${query.substring(0, 27)}..." : query,
        createdAt: _activeConversation!.createdAt,
        history: updatedHistory,
      );

      // 6. Persistence
      await _repository.saveConversation(_activeConversation!);
      await loadHistory();

      // 7. Log Usage & Governance
      final usage = AIUsage(
        id: const Uuid().v4(),
        modelId: response.provider,
        userId: 'admin',
        promptTokens: query.length ~/ 4,
        completionTokens: response.text.length ~/ 4,
        totalTokens: (query.length + response.text.length) ~/ 4,
        estimatedCost: _engine.calculateInteractionCost(
            (query.length + response.text.length) ~/ 4, response.provider),
        timestamp: DateTime.now(),
      );
      await _repository.recordUsage(usage);
      await loadUsage();
    } catch (e) {
      debugPrint("AI Query Failed: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Triggers an anomaly check for a specific dataset
  List<String> checkForAnomalies(List<double> values) =>
      _engine.detectAnomalies(values, 0.2);
}
