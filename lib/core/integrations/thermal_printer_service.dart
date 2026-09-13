import 'package:blue_thermal_printer/blue_thermal_printer.dart';
import 'package:esc_pos_utils_plus/esc_pos_utils_plus.dart';
import 'package:flutter/services.dart';
import 'dart:typed_data';

class ThermalPrinterService {
  final BlueThermalPrinter _bluetooth = BlueThermalPrinter.instance;

  Future<List<BluetoothDevice>> getPairedDevices() async {
    return await _bluetooth.getBondedDevices();
  }

  Future<bool> connect(BluetoothDevice device) async {
    try {
      final isConnected = await _bluetooth.isConnected;
      if (isConnected == true) return true;
      await _bluetooth.connect(device);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<void> disconnect() async {
    await _bluetooth.disconnect();
  }

  Future<void> printReceipt({
    required String companyName,
    required String address,
    required String invoiceNumber,
    required List<Map<String, dynamic>> items,
    required double total,
    String footer = "Thank you for your business!",
  }) async {
    bool? isConnected = await _bluetooth.isConnected;
    if (isConnected != true) return;

    final profile = await CapabilityProfile.load();
    final generator = Generator(PaperSize.mm58, profile);
    List<int> bytes = [];

    // Header
    bytes += generator.text(companyName,
        styles: const PosStyles(
            align: PosAlign.center,
            bold: true,
            height: PosTextSize.size2,
            width: PosTextSize.size2));
    bytes += generator.text(address,
        styles: const PosStyles(align: PosAlign.center));
    bytes += generator.hr();

    // Body
    bytes += generator.text("Invoice: $invoiceNumber",
        styles: const PosStyles(bold: true));
    bytes +=
        generator.text("Date: ${DateTime.now().toString().substring(0, 16)}");
    bytes += generator.hr();

    bytes += generator.row([
      PosColumn(text: 'Item', width: 6),
      PosColumn(
          text: 'Qty',
          width: 2,
          styles: const PosStyles(align: PosAlign.right)),
      PosColumn(
          text: 'Price',
          width: 4,
          styles: const PosStyles(align: PosAlign.right)),
    ]);

    for (var item in items) {
      bytes += generator.row([
        PosColumn(text: item['name'].toString(), width: 6),
        PosColumn(
            text: item['qty'].toString(),
            width: 2,
            styles: const PosStyles(align: PosAlign.right)),
        PosColumn(
            text: item['price'].toString(),
            width: 4,
            styles: const PosStyles(align: PosAlign.right)),
      ]);
    }

    bytes += generator.hr();

    // Total
    bytes += generator.row([
      PosColumn(text: 'TOTAL', width: 8, styles: const PosStyles(bold: true)),
      PosColumn(
          text: total.toStringAsFixed(2),
          width: 4,
          styles: const PosStyles(align: PosAlign.right, bold: true)),
    ]);

    bytes += generator.hr(ch: '=');
    bytes +=
        generator.text(footer, styles: const PosStyles(align: PosAlign.center));
    bytes += generator.feed(2);
    bytes += generator.cut();

    await _bluetooth.writeBytes(Uint8List.fromList(bytes));
  }
}
