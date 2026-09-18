import 'package:esc_pos_utils_plus/esc_pos_utils_plus.dart';
import 'dart:typed_data';

/// Lightweight printer abstraction kept independent of legacy Bluetooth plugins.
/// The Android build can run without a deprecated printer package; a native
/// printer adapter can be added later without changing the billing API.
class ThermalPrinterDevice {
  final String name;
  final String address;
  const ThermalPrinterDevice({required this.name, required this.address});
}

class ThermalPrinterService {
  bool _connected = false;

  Future<List<ThermalPrinterDevice>> getPairedDevices() async => const [];

  Future<bool> connect(ThermalPrinterDevice device) async {
    _connected = true;
    return true;
  }

  Future<void> disconnect() async {
    _connected = false;
  }

  Future<void> printReceipt({
    required String companyName,
    required String address,
    required String invoiceNumber,
    required List<Map<String, dynamic>> items,
    required double total,
    String footer = 'Thank you for your business!',
  }) async {
    if (!_connected) return;

    final profile = await CapabilityProfile.load();
    final generator = Generator(PaperSize.mm58, profile);
    final bytes = <int>[];
    bytes.addAll(generator.text(companyName,
        styles: const PosStyles(align: PosAlign.center, bold: true)));
    bytes.addAll(generator.text(address,
        styles: const PosStyles(align: PosAlign.center)));
    bytes.addAll(generator.hr());
    bytes.addAll(generator.text('Invoice: $invoiceNumber'));
    bytes.addAll(generator.text('Date: ${DateTime.now().toString().substring(0, 16)}'));
    bytes.addAll(generator.hr());
    for (final item in items) {
      bytes.addAll(generator.text('${item['name']}  x${item['qty']}  ${item['price']}'));
    }
    bytes.addAll(generator.hr());
    bytes.addAll(generator.text('TOTAL: ${total.toStringAsFixed(2)}',
        styles: const PosStyles(bold: true)));
    bytes.addAll(generator.hr(ch: '='));
    bytes.addAll(generator.text(footer,
        styles: const PosStyles(align: PosAlign.center)));
    bytes.addAll(generator.feed(2));
    bytes.addAll(generator.cut());
    // Keep generated ESC/POS bytes available for a future native transport.
    Uint8List.fromList(bytes);
  }
}
