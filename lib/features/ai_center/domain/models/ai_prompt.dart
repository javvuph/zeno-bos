class AIPrompt {
  final String content;
  final Map<String, dynamic> context;
  final List<String> attachments; // URLs or paths

  const AIPrompt({
    required this.content,
    this.context = const {},
    this.attachments = const [],
  });
}
