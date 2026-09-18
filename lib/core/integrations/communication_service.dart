import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:flutter/foundation.dart';

class CommunicationService {
  /// Launches WhatsApp with a predefined message
  Future<bool> sendWhatsApp(
      {required String phone, required String message}) async {
    // Sanitize phone number (remove +, spaces, etc.)
    final cleanPhone = phone.replaceAll(RegExp(r'[^0-9]'), '');
    final url =
        "whatsapp://send?phone=$cleanPhone&text=${Uri.encodeComponent(message)}";
    final uri = Uri.parse(url);

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
      return true;
    } else {
      debugPrint("Could not launch WhatsApp");
      return false;
    }
  }

  /// Sends a native SMS
  Future<void> sendSMS(
      {required List<String> recipients, required String message}) async {
    try {
      final uri = Uri(
        scheme: 'sms',
        path: recipients.join(','),
        queryParameters: {'body': message},
      );
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri);
      } else {
        debugPrint("Could not launch SMS");
      }
    } catch (e) {
      debugPrint("SMS Failed: $e");
    }
  }

  /// Sends a native Email
  Future<void> sendEmail({
    required String recipient,
    required String subject,
    required String body,
    List<String> attachmentPaths = const [],
  }) async {
    final Email email = Email(
      body: body,
      subject: subject,
      recipients: [recipient],
      attachmentPaths: attachmentPaths,
      isHTML: false,
    );

    try {
      await FlutterEmailSender.send(email);
    } catch (e) {
      debugPrint("Email Failed: $e");
    }
  }
}
