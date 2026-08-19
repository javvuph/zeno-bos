enum PmsPostStatus { pending, posted, failed, reversed }

class PmsPostResult {
  final PmsPostStatus status;
  final String? externalReference;
  final String? errorMessage;

  const PmsPostResult({required this.status, this.externalReference, this.errorMessage});
}

abstract class IPmsAdapter {
  Future<bool> validateRoom(String roomNumber, String guestName);
  Future<PmsPostResult> postCharge({
    required String roomNumber,
    required String guestName,
    required double amount,
    required String billId,
    required String remarks,
  });
}

class MockPmsAdapter implements IPmsAdapter {
  @override
  Future<bool> validateRoom(String roomNumber, String guestName) async => true;

  @override
  Future<PmsPostResult> postCharge({
    required String roomNumber,
    required String guestName,
    required double amount,
    required String billId,
    required String remarks,
  }) async {
    return const PmsPostResult(status: PmsPostStatus.posted, externalReference: "PMS-9988");
  }
}
