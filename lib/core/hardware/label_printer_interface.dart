enum PrinterStatus { disconnected, printing, connected, error, outOfPaper }

abstract class ILabelPrinterDriver {
  Stream<PrinterStatus> get statusStream;
  
  Future<void> printLabel(List<int> bytes);
  Future<void> connect();
  Future<void> disconnect();
  Future<void> testPage();
}

class MockLabelPrinterDriver implements ILabelPrinterDriver {
  @override
  Future<void> connect() async {}
  @override
  Future<void> disconnect() async {}
  @override
  Future<void> printLabel(List<int> bytes) async {
    await Future.delayed(const Duration(seconds: 1));
  }
  @override
  Future<void> testPage() async {}

  @override
  Stream<PrinterStatus> get statusStream => Stream.value(PrinterStatus.connected);
}
