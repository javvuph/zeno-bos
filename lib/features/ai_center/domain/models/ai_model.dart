enum AIModelType { chat, vision, ocr, voice, analysis }

class AIModel {
  final String id;
  final String name;
  final String providerId;
  final AIModelType type;
  final bool isEnabled;
  final Map<String, dynamic> capabilities;

  const AIModel({
    required this.id,
    required this.name,
    required this.providerId,
    required this.type,
    this.isEnabled = true,
    this.capabilities = const {},
  });
}
