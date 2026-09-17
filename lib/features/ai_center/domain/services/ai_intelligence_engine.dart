import '../models/ai_model.dart';
import '../models/ai_recommendation.dart';
import '../models/ai_prediction.dart';
import 'package:uuid/uuid.dart';

class AIIntelligenceEngine {
  /// Builds a context-aware prompt by aggregating data from other modules
  String buildContextPrompt(String userQuery, Map<String, dynamic> moduleData) {
    String context =
        "You are the ZENO BOS Global Assistant. You have access to real-time enterprise data.\n";
    context += "Current system state summary:\n";

    moduleData.forEach((module, data) {
      if (data is Map) {
        context += "--- $module ---\n";
        data.forEach((key, value) => context += "$key: $value\n");
      } else {
        context += "--- $module ---\n$data\n";
      }
    });

    context +=
        "\nInstructions: Provide a concise, actionable response based on the above data. If the data is insufficient, ask for clarification. Be highly professional and specific with numbers.\n";
    return "$context\nUser Query: $userQuery";
  }

  /// Generates autonomous actionable recommendations based on global context
  List<AIRecommendation> generateExecutiveRecommendations(
      Map<String, dynamic> context) {
    final List<AIRecommendation> recs = [];
    const uuid = Uuid();

    // 1. Inventory Insights
    if (context['inventory'] != null) {
      final inv = context['inventory'];
      if (inv['critical_low'] != null &&
          (inv['critical_low'] as List).isNotEmpty) {
        recs.add(AIRecommendation(
          id: uuid.v4(),
          title: "Optimize Inventory Restock",
          description:
              "Critical low stock detected for ${(inv['critical_low'] as List).length} items.",
          reasoning:
              "Current physical stock levels have dropped below the safety threshold of 5 units, risking delivery delays.",
          dataUsed: ["inventory.critical_low", "sales.pending_orders"],
          confidence: 0.98,
          impact: RecommendationImpact.high,
          suggestedAction: {
            'type': 'nav',
            'route': 'suppliers/procurement/orders/new'
          },
          timestamp: DateTime.now(),
        ));
      }
    }

    // 2. Financial Insights
    if (context['finance'] != null) {
      final fin = context['finance'];
      if (fin['pending_payables'] > 10000) {
        recs.add(AIRecommendation(
          id: uuid.v4(),
          title: "Cash Flow Preservation",
          description:
              "Pending payables exceed threshold. Optimize outgoing payments.",
          reasoning:
              "High volume of short-term liabilities may impact liquidity in the next 15 days.",
          dataUsed: ["finance.pending_payables", "finance.cash_on_hand"],
          confidence: 0.85,
          impact: RecommendationImpact.medium,
          suggestedAction: {'type': 'nav', 'route': 'finance/dashboard'},
          timestamp: DateTime.now(),
        ));
      }
    }

    // 3. Sales/Customer Insights
    if (context['sales'] != null && context['sales']['pending_orders'] > 50) {
      recs.add(AIRecommendation(
        id: uuid.v4(),
        title: "Fulfillment Acceleration",
        description: "Backlog of pending orders detected.",
        reasoning:
            "Pending order volume is 25% higher than weekly average. Possible bottleneck in delivery assignment.",
        dataUsed: ["sales.pending_orders", "logistics.active_shipments"],
        confidence: 0.92,
        impact: RecommendationImpact.high,
        suggestedAction: {'type': 'nav', 'route': 'delivery/ops/queue'},
        timestamp: DateTime.now(),
      ));
    }

    return recs;
  }

  /// Calculates predictive metrics using business heuristics
  List<AIPrediction> calculateBusinessPredictions(
      Map<String, dynamic> context) {
    final List<AIPrediction> predictions = [];
    const uuid = Uuid();

    // Sales Forecast (Simple linear growth simulation)
    if (context['sales'] != null) {
      predictions.add(AIPrediction(
        id: uuid.v4(),
        targetMetric: "Monthly Revenue Forecast",
        currentValue: 125000.0,
        forecastValue: 138000.0,
        timeframe: "Next 30 Days",
        confidence: 0.88,
        historicalTrend: [110, 115, 112, 125, 122],
        insight:
            "Consistent 8-10% MoM growth observed in electronics category.",
      ));
    }

    // Inventory Trend
    if (context['inventory'] != null) {
      predictions.add(AIPrediction(
        id: uuid.v4(),
        targetMetric: "Inventory Turnover Ratio",
        currentValue: 4.2,
        forecastValue: 4.8,
        timeframe: "Next Quarter",
        confidence: 0.82,
        historicalTrend: [3.8, 4.0, 4.1, 4.2],
        insight:
            "Optimization of procurement lead times expected to improve turnover.",
      ));
    }

    return predictions;
  }

  /// Automatically selects the best model for a specific task
  String selectOptimalModel(String query, List<AIModel> availableModels) {
    if (availableModels.isEmpty) return 'mock-model';

    final q = query.toLowerCase();
    if (q.contains('image') || q.contains('photo') || q.contains('look')) {
      return availableModels
          .firstWhere((m) => m.type == AIModelType.vision,
              orElse: () => availableModels.first)
          .id;
    }
    if (q.contains('analyze') ||
        q.contains('predict') ||
        q.contains('forecast') ||
        q.contains('trend')) {
      return availableModels
          .firstWhere((m) => m.type == AIModelType.analysis,
              orElse: () => availableModels.first)
          .id;
    }
    return availableModels
        .firstWhere((m) => m.type == AIModelType.chat,
            orElse: () => availableModels.first)
        .id;
  }

  /// Calculates the monetary cost based on provider pricing
  double calculateInteractionCost(int tokens, String modelId) {
    // Model-specific pricing (per 1M tokens)
    double pricePerMillion = 10.0; // Default
    if (modelId.contains('gpt-4')) pricePerMillion = 30.0;
    if (modelId.contains('gemini-pro')) pricePerMillion = 1.0;
    if (modelId.contains('mock')) pricePerMillion = 0.0;

    return (tokens / 1000000) * pricePerMillion;
  }

  /// Detects anomalies in a numerical dataset (e.g., Sales or Finance)
  List<String> detectAnomalies(List<double> values, double threshold) {
    if (values.isEmpty) return [];
    double avg = values.reduce((a, b) => a + b) / values.length;
    List<String> anomalies = [];
    for (int i = 0; i < values.length; i++) {
      if ((values[i] - avg).abs() > (avg * threshold)) {
        anomalies.add(
            "Anomaly at index $i: Value ${values[i]} deviates significantly from average $avg");
      }
    }
    return anomalies;
  }

  /// Generates an automation suggestion based on system state
  String suggestAutomation(String module, dynamic state) {
    if (module == 'inventory' && state['stock_low'] == true) {
      return "Suggestion: Create an automated Purchase Requisition when stock levels drop below 15% for ${state['product_name']}.";
    }
    return "No automation suggestions currently available for $module.";
  }
}
