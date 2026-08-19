import '../models/opportunity.dart';
import '../models/opportunity_stage.dart';

class SalesPipelineEngine {
  /// Calculates Probability based on Stage
  double getDefaultProbability(OpportunityStage stage) {
    switch (stage) {
      case OpportunityStage.prospecting:
        return 10.0;
      case OpportunityStage.qualification:
        return 25.0;
      case OpportunityStage.needsAnalysis:
        return 50.0;
      case OpportunityStage.proposal:
        return 75.0;
      case OpportunityStage.negotiation:
        return 90.0;
      case OpportunityStage.closedWon:
        return 100.0;
      case OpportunityStage.closedLost:
        return 0.0;
    }
  }

  /// AI Win Score Prediction (Mock)
  double predictWinScore(Opportunity opp) {
    double score = opp.probability;
    if (opp.expectedCloseDate.isBefore(DateTime.now())) score -= 20;
    if (opp.leadSource == 'Referral') score += 15;
    return score.clamp(0, 100);
  }

  /// Funnel Analysis Logic
  Map<String, double> analyzeFunnel(List<Opportunity> opportunities) {
    double totalValue =
        opportunities.fold(0, (sum, o) => sum + o.expectedRevenue);
    double wonValue = opportunities
        .where((o) => o.stage == OpportunityStage.closedWon)
        .fold(0, (sum, o) => sum + o.expectedRevenue);
    return {
      'pipeline_value': totalValue,
      'conversion_rate': totalValue > 0 ? (wonValue / totalValue) * 100 : 0.0,
    };
  }
}
