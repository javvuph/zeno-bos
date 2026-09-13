class Driver {
  final String id;
  final String name;
  final String phone;
  final String licenseNumber;
  final String status; // 'on_duty', 'off_duty', 'on_break'
  final String? currentVehicleId;

  const Driver({
    required this.id,
    required this.name,
    required this.phone,
    required this.licenseNumber,
    this.status = 'off_duty',
    this.currentVehicleId,
  });
}
