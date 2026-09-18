import 'package:flutter/foundation.dart';
import 'package:url_launcher/url_launcher.dart';

class UPIPaymentService {
  /// Opens a UPI payment intent using the Android UPI URI scheme.
  /// Returns true when the operating system successfully launches a UPI app.
  Future<bool> initiateTransaction({
    required String receiverUpiId,
    required String receiverName,
    required double amount,
    String transactionRef = '',
    String transactionNote = 'Payment for Invoice',
  }) async {
    final ref = transactionRef.isNotEmpty
        ? transactionRef
        : DateTime.now().millisecondsSinceEpoch.toString();

    final uri = Uri(
      scheme: 'upi',
      host: 'pay',
      queryParameters: {
        'pa': receiverUpiId,
        'pn': receiverName,
        'am': amount.toStringAsFixed(2),
        'cu': 'INR',
        'tr': ref,
        'tn': transactionNote,
      },
    );

    try {
      return await launchUrl(uri, mode: LaunchMode.externalApplication);
    } catch (e) {
      debugPrint('UPI launch failed: $e');
      return false;
    }
  }

  String getResponseStatusMessage(String responseCode) {
    switch (responseCode) {
      case '00':
        return 'Transaction Successful';
      case '01':
        return 'Transaction Failed';
      case '02':
        return 'Transaction Cancelled by User';
      default:
        return 'Transaction Pending or Unknown';
    }
  }
}
