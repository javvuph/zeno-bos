import 'package:isar/isar.dart';

part 'ai_collections.g.dart';

@collection
class AIModelCollection {
  Id id = Isar.autoIncrement;

  @Index(unique: true, replace: true)
  late String uuid;

  @Index(caseSensitive: false)
  late String name;

  late String providerId;
  late String type; // chat, vision, etc.
  bool isEnabled = true;

  late String capabilitiesJson; // Store as JSON string
}

@collection
class AISessionCollection {
  Id id = Isar.autoIncrement;

  @Index(unique: true, replace: true)
  late String uuid;

  @Index()
  late String userId;

  late String title;
  late DateTime startTime;
  DateTime? lastMessageTime;

  late String messagesJson; // List of messages as JSON

  @Index()
  String? moduleContext; // 'sales', 'finance', etc.
}

@collection
class AIUsageCollection {
  Id id = Isar.autoIncrement;

  @Index()
  late String modelId;

  @Index()
  late DateTime timestamp;

  late int promptTokens;
  late int completionTokens;
  late int totalTokens;

  late double estimatedCost;
  late String userId;
}

@collection
class AIAutomationCollection {
  Id id = Isar.autoIncrement;

  @Index(unique: true, replace: true)
  late String uuid;

  @Index(caseSensitive: false)
  late String name;

  late String description;
  late String trigger; // schedule, event, manual
  late String actionJson;
  late String status; // active, paused, etc.
}
