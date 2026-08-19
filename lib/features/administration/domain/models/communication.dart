class WebhookSubscription {
  final String id;
  final String targetUrl;
  final String event; // e.g., 'invoice.created'
  final bool isActive;
  final String? secret;

  const WebhookSubscription({
    required this.id,
    required this.targetUrl,
    required this.event,
    this.isActive = true,
    this.secret,
  });
}

class NotificationTemplate {
  final String id;
  final String name;
  final String channel; // 'email', 'sms', 'push'
  final String subject;
  final String body;

  const NotificationTemplate({
    required this.id,
    required this.name,
    required this.channel,
    required this.subject,
    required this.body,
  });
}
