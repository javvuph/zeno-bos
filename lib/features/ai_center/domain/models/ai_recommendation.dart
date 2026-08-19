import 'package:flutter/material.dart';

enum RecommendationImpact { low, medium, high, critical }

class AIRecommendation {
  final String id;
  final String title;
  final String description;
  final String reasoning;
  final List<String> dataUsed;
  final double confidence;
  final RecommendationImpact impact;
  final Map<String, dynamic> suggestedAction;
  final DateTime timestamp;

  const AIRecommendation({
    required this.id,
    required this.title,
    required this.description,
    required this.reasoning,
    required this.dataUsed,
    required this.confidence,
    required this.impact,
    required this.suggestedAction,
    required this.timestamp,
  });

  Color get impactColor {
    switch (impact) {
      case RecommendationImpact.critical:
        return Colors.red;
      case RecommendationImpact.high:
        return Colors.orange;
      case RecommendationImpact.medium:
        return Colors.blue;
      case RecommendationImpact.low:
        return Colors.grey;
    }
  }
}
