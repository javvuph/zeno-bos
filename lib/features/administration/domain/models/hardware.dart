enum HardwareStatus { connected, disconnected, error }

class Printer {
  final String id;
  final String name;
  final String ipAddress;
  final String type; // 'thermal', 'laser'
  final HardwareStatus status;

  const Printer({
    required this.id,
    required this.name,
    required this.ipAddress,
    this.type = 'thermal',
    this.status = HardwareStatus.disconnected,
  });
}

class BarcodeScanner {
  final String id;
  final String name;
  final String connectionType; // 'usb', 'bluetooth'

  const BarcodeScanner({
    required this.id,
    required this.name,
    required this.connectionType,
  });
}

class POSTerminal {
  final String id;
  final String branchId;
  final String terminalName;
  final String assignedUserId;

  const POSTerminal({
    required this.id,
    required this.branchId,
    required this.terminalName,
    required this.assignedUserId,
  });
}
