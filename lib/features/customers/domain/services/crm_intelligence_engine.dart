import '../models/customer.dart';
import '../models/lead.dart';
import '../models/opportunity.dart';
import '../models/ticket.dart';

class CRMIntelligenceEngine {
  /// AI Win Probability for Opportunities
  double predictWinProbability(Opportunity opp) {
    double score = opp.probability;
    if (opp.expectedCloseDate.isBefore(DateTime.now())) score -= 15;
    if (opp.expectedRevenue > 1000000) score += 10;
    return score.clamp(0, 100);
  }

  /// AI Lead Quality Score
  double scoreLead(Lead lead) {
    double score = 50.0;
    if (lead.email.contains('@corp.com') ||
        lead.email.contains('@business.com')) score += 20;
    if (lead.source == 'Referral') score += 15;
    if (lead.companyName != null) score += 10;
    return score.clamp(0, 100);
  }

  /// AI Churn Prediction Score (0-100, high = high risk)
  double predictChurnRisk(Customer customer) {
    double risk = 0.0;
    final lastPurchase = customer.lastPurchaseAt;
    if (lastPurchase != null) {
      final daysSince = DateTime.now().difference(lastPurchase).inDays;
      if (daysSince > 90) risk += 40;
      if (daysSince > 180) risk += 30;
    } else {
      risk += 20;
    }
    if (customer.credit.isBlocked) risk += 20;
    return risk.clamp(0, 100);
  }

  /// AI Sentiment Analysis (Mock)
  String detectSentiment(List<Ticket> tickets) {
    if (tickets.any((t) => t.isSlaBreached)) return 'Negative';
    if (tickets.length > 5) return 'Frustrated';
    return 'Neutral';
  }
}
