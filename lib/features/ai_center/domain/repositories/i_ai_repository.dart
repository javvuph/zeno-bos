import '../models/ai_model.dart';
import '../models/ai_provider.dart';
import '../models/ai_conversation.dart';
import '../models/ai_usage.dart';
import '../models/ai_automation.dart';

abstract class IAIRepository {
  // Model & Provider Management
  Future<List<AIModel>> getModels();
  Future<List<AIProvider>> getProviders();
  Future<void> updateModelStatus(String modelId, bool isEnabled);

  // Conversations
  Future<List<AIConversation>> getConversations(String userId);
  Future<void> saveConversation(AIConversation conversation);

  // Usage & Governance
  Future<void> recordUsage(AIUsage usage);
  Future<List<AIUsage>> getUsageStats(
      String userId, DateTime start, DateTime end);

  // Automation
  Future<List<AIAutomation>> getAutomations();
  Future<void> saveAutomation(AIAutomation automation);
}
