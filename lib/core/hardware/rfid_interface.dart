enum RfidStatus { disconnected, scanning, connected, error }

abstract class IRfidDriver {
  Stream<String> get tagStream;
  Stream<RfidStatus> get statusStream;
  
  Future<void> startScan();
  Future<void> stopScan();
  Future<void> connect();
  Future<void> disconnect();
}

class MockRfidDriver implements IRfidDriver {
  @override
  Future<void> connect() async {}
  @override
  Future<void> disconnect() async {}
  @override
  Future<void> startScan() async {}
  @override
  Future<void> stopScan() async {}

  @override
  Stream<RfidStatus> get statusStream => Stream.value(RfidStatus.connected);
  @override
  Stream<String> get tagStream => Stream.periodic(const Duration(seconds: 2), (i) => "EPC-E280-1191-${1000 + i}");
}
