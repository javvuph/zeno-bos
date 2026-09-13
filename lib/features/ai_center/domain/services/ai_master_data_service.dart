import '../models/ai_model.dart';
import '../models/ai_usage.dart';
import '../models/ai_provider.dart';

import '../models/ai_automation.dart';

class AIMasterDataService {
  List<AIModel> getMockModels() => [
        const AIModel(
            id: 'gpt-4o',
            name: 'Zeno GPT-4o',
            providerId: 'openai',
            type: AIModelType.chat),
        const AIModel(
            id: 'gemini-1.5-pro',
            name: 'Gemini Pro v1.5',
            providerId: 'google',
            type: AIModelType.analysis),
        const AIModel(
            id: 'claude-3-opus',
            name: 'Claude 3 Opus',
            providerId: 'anthropic',
            type: AIModelType.vision),
      ];

  List<AIUsage> getMockUsage() => [
        AIUsage(
            id: 'u1',
            modelId: 'gpt-4o',
            userId: 'usr_1',
            promptTokens: 1200,
            completionTokens: 450,
            totalTokens: 1650,
            estimatedCost: 0.16,
            timestamp: DateTime.now().subtract(const Duration(hours: 1))),
        AIUsage(
            id: 'u2',
            modelId: 'gemini-1.5-pro',
            userId: 'usr_1',
            promptTokens: 800,
            completionTokens: 200,
            totalTokens: 1000,
            estimatedCost: 0.05,
            timestamp: DateTime.now().subtract(const Duration(minutes: 15))),
      ];

  List<AIProvider> getMockProviders() => [
        const AIProvider(
            id: 'openai', name: 'OpenAI', type: AIProviderType.openai),
        const AIProvider(
            id: 'google', name: 'Google Gemini', type: AIProviderType.gemini),
      ];

  List<AIAutomation> getMockAutomations() => [
        AIAutomation(
            id: 'a1',
            name: 'Low Stock Auto-PO',
            description:
                'Automatically generate purchase orders when inventory drops below safety stock levels.',
            trigger: AutomationTrigger.threshold,
            action: {'type': 'create_po', 'module': 'purchase'},
            status: AutomationStatus.active),
        AIAutomation(
            id: 'a2',
            name: 'Anomalous Transaction Alert',
            description:
                'Identify and flag finance transactions that deviate significantly from historical patterns.',
            trigger: AutomationTrigger.anomaly,
            action: {'type': 'notify_admin', 'priority': 'high'},
            status: AutomationStatus.active),
        AIAutomation(
            id: 'a3',
            name: 'Weekly Performance Digest',
            description:
                'Compile and email a summary of multi-module KPIs every Monday morning.',
            trigger: AutomationTrigger.schedule,
            action: {'type': 'send_email', 'template': 'weekly_briefing'},
            status: AutomationStatus.paused),
      ];
}
