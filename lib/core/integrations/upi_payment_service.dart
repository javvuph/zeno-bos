import 'package:upi_india/upi_india.dart';
import 'package:flutter/foundation.dart';

class UPIPaymentService {
  final UpiIndia _upiIndia = UpiIndia();

  Future<List<UpiApp>> getAvailableApps() async {
    try {
      return await _upiIndia.getAllUpiApps();
    } catch (e) {
      debugPrint("UPI Apps Discovery Failed: $e");
      return [];
    }
  }

  Future<UpiResponse> initiateTransaction({
    required UpiApp app,
    required String receiverUpiId,
    required String receiverName,
    required double amount,
    String transactionRef = '',
    String transactionNote = 'Payment for Invoice',
  }) async {
    return _upiIndia.startTransaction(
      app: app,
      receiverUpiId: receiverUpiId,
      receiverName: receiverName,
      transactionRefId: transactionRef.isNotEmpty
          ? transactionRef
          : DateTime.now().millisecondsSinceEpoch.toString(),
      transactionNote: transactionNote,
      amount: amount,
    );
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
