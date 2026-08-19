import 'dart:io';
import 'fnb_printer_interface.dart';

class NetworkPrinterDriver implements IFnbPrinter {
  Socket? _socket;
  bool _connected = false;

  @override
  Future<void> connect(String address, ConnectionType connection) async {
    if (connection != ConnectionType.network) throw Exception("Unsupported connection type");
    final parts = address.split(':');
    final host = parts[0];
    final port = parts.length > 1 ? int.parse(parts[1]) : 9100;
    
    _socket = await Socket.connect(host, port, timeout: const Duration(seconds: 5));
    _connected = true;
  }

  @override
  Future<void> disconnect() async {
    await _socket?.close();
    _connected = false;
  }

  @override
  Future<void> printKOT(Map<String, dynamic> data) async {
    if (!_connected) throw Exception("Printer not connected");
    // Generate ESC/POS bytes from data and send to socket
    // _socket!.add(bytes);
    // await _socket!.flush();
  }

  @override
  Future<void> printReceipt(Map<String, dynamic> data) async {
    if (!_connected) throw Exception("Printer not connected");
  }

  @override
  Stream<bool> get isConnected => Stream.periodic(const Duration(seconds: 2), (_) => _connected);
}
