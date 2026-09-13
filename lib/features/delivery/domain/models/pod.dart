class ProofOfDelivery {
  final String id;
  final String deliveryOrderId;
  final String? otp;
  final String? signatureUrl;
  final List<String> photoUrls;
  final DateTime timestamp;
  final String recipientName;

  const ProofOfDelivery({
    required this.id,
    required this.deliveryOrderId,
    this.otp,
    this.signatureUrl,
    this.photoUrls = const [],
    required this.timestamp,
    required this.recipientName,
  });
}
