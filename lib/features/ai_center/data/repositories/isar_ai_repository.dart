import 'dart:convert';
import 'package:isar/isar.dart';
import 'package:zeno/core/database/database_service.dart';
import 'package:zeno/core/database/collections/ai_collections.dart';
import '../../domain/repositories/i_ai_repository.dart';
import '../../domain/models/ai_model.dart';
import '../../domain/models/ai_provider.dart';
import '../../domain/models/ai_conversation.dart';
import '../../domain/models/ai_usage.dart';
import '../../domain/models/ai_automation.dart';
import '../../domain/models/ai_prompt.dart';
import '../../domain/models/ai_response.dart';

class IsarAIRepository implements IAIRepository {
  final DatabaseService db;
  IsarAIRepository(this.db);

  IsarCollection<AIModelCollection> get modelCol =>
      db.isar.collection<AIModelCollection>();
  IsarCollection<AISessionCollection> get sessionCol =>
      db.isar.collection<AISessionCollection>();
  IsarCollection<AIUsageCollection> get usageCol =>
      db.isar.collection<AIUsageCollection>();
  IsarCollection<AIAutomationCollection> get autoCol =>
      db.isar.collection<AIAutomationCollection>();

  @override
  Future<List<AIModel>> getModels() async {
    final results = await modelCol.where().findAll();
    return results
        .map((e) => AIModel(
              id: e.uuid,
              name: e.name,
              providerId: e.providerId,
              type: AIModelType.values.firstWhere((t) => t.name == e.type,
                  orElse: () => AIModelType.chat),
              isEnabled: e.isEnabled,
              capabilities: jsonDecode(e.capabilitiesJson),
            ))
        .toList();
  }

  @override
  Future<List<AIProvider>> getProviders() async => [];

  @override
  Future<void> updateModelStatus(String modelId, bool isEnabled) async {
    final model = await modelCol.filter().uuidEqualTo(modelId).findFirst();
    if (model != null) {
      model.isEnabled = isEnabled;
      await db.isar.writeTxn(() async {
        await modelCol.put(model);
      });
    }
  }

  @override
  Future<List<AIConversation>> getConversations(String userId) async {
    final results = await sessionCol.filter().userIdEqualTo(userId).findAll();
    return results.map((e) {
      final List<dynamic> historyJson = jsonDecode(e.messagesJson);
      return AIConversation(
        id: e.uuid,
        title: e.title,
        createdAt: e.startTime,
        moduleContext: e.moduleContext,
        history: historyJson
            .map((m) => AIInteraction(
                  prompt: AIPrompt(content: m['prompt']),
                  response: AIResponse(
                      content: m['response'], modelId: m['provider']),
                  timestamp: DateTime.parse(m['timestamp']),
                ))
            .toList(),
      );
    }).toList();
  }

  @override
  Future<void> saveConversation(AIConversation conversation) async {
    final existing =
        await sessionCol.filter().uuidEqualTo(conversation.id).findFirst();
    final entry = (existing ?? AISessionCollection())
      ..uuid = conversation.id
      ..userId = 'admin' // Simplified
      ..title = conversation.title
      ..startTime = conversation.createdAt
      ..moduleContext = conversation.moduleContext
      ..messagesJson = jsonEncode(conversation.history
          .map((h) => {
                'prompt': h.prompt.content,
                'response': h.response.content,
                'provider': h.response.modelId,
                'timestamp': h.timestamp.toIso8601String(),
              })
          .toList());

    await db.isar.writeTxn(() async {
      await sessionCol.put(entry);
    });
  }

  @override
  Future<void> recordUsage(AIUsage usage) async {
    final entry = AIUsageCollection()
      ..modelId = usage.modelId
      ..timestamp = usage.timestamp
      ..promptTokens = usage.promptTokens
      ..completionTokens = usage.completionTokens
      ..totalTokens = usage.totalTokens
      ..estimatedCost = usage.estimatedCost
      ..userId = usage.userId;

    await db.isar.writeTxn(() async {
      await usageCol.put(entry);
    });
  }

  @override
  Future<List<AIUsage>> getUsageStats(
      String userId, DateTime start, DateTime end) async {
    final results = await usageCol
        .filter()
        .userIdEqualTo(userId)
        .and()
        .timestampBetween(start, end)
        .findAll();

    return results
        .map((e) => AIUsage(
              id: e.id.toString(),
              modelId: e.modelId,
              userId: e.userId,
              promptTokens: e.promptTokens,
              completionTokens: e.completionTokens,
              totalTokens: e.totalTokens,
              estimatedCost: e.estimatedCost,
              timestamp: e.timestamp,
            ))
        .toList();
  }

  @override
  Future<List<AIAutomation>> getAutomations() async {
    final results = await autoCol.where().findAll();
    return results
        .map((e) => AIAutomation(
              id: e.uuid,
              name: e.name,
              description: e.description,
              trigger: AutomationTrigger.values
                  .firstWhere((t) => t.name == e.trigger),
              action: jsonDecode(e.actionJson),
              status:
                  AutomationStatus.values.firstWhere((s) => s.name == e.status),
            ))
        .toList();
  }

  @override
  Future<void> saveAutomation(AIAutomation automation) async {
    final existing =
        await autoCol.filter().uuidEqualTo(automation.id).findFirst();
    final entry = (existing ?? AIAutomationCollection())
      ..uuid = automation.id
      ..name = automation.name
      ..description = automation.description
      ..trigger = automation.trigger.name
      ..actionJson = jsonEncode(automation.action)
      ..status = automation.status.name;

    await db.isar.writeTxn(() async {
      await autoCol.put(entry);
    });
  }
}
