enum ScaleStatus { disconnected, connecting, connected, error, weighing, stable }

abstract class IScaleDriver {
  Stream<double> get weightStream;
  Stream<ScaleStatus> get statusStream;
  
  Future<void> connect();
  Future<void> disconnect();
  Future<void> zero();
  Future<void> tare();
}

class MockScaleDriver implements IScaleDriver {
  @override
  Future<void> connect() async {}
  @override
  Future<void> disconnect() async {}
  @override
  Future<void> tare() async {}
  @override
  Future<void> zero() async {}

  @override
  Stream<ScaleStatus> get statusStream => Stream.value(ScaleStatus.connected);
  @override
  Stream<double> get weightStream => Stream.periodic(const Duration(seconds: 1), (i) => 1.250 + (i % 5) * 0.1);
}
