enum PrinterType { receipt, kot, label }
enum ConnectionType { network, usb, bluetooth }

abstract class IFnbPrinter {
  Future<void> connect(String address, ConnectionType connection);
  Future<void> disconnect();
  Future<void> printKOT(Map<String, dynamic> data);
  Future<void> printReceipt(Map<String, dynamic> data);
  
  Stream<bool> get isConnected;
}

class MockFnbPrinter implements IFnbPrinter {
  @override
  Future<void> connect(String address, ConnectionType connection) async {}
  @override
  Future<void> disconnect() async {}
  @override
  Future<void> printKOT(Map<String, dynamic> data) async => await Future.delayed(const Duration(seconds: 1));
  @override
  Future<void> printReceipt(Map<String, dynamic> data) async => await Future.delayed(const Duration(seconds: 1));

  @override
  Stream<bool> get isConnected => Stream.value(true);
}
