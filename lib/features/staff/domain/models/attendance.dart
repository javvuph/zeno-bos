enum AttendanceSource { manual, biometric, geofence, web }

class Attendance {
  final String id;
  final String employeeId;
  final DateTime clockIn;
  final DateTime? clockOut;
  final AttendanceSource source;
  final double? latitude;
  final double? longitude;
  final String? deviceId;

  const Attendance({
    required this.id,
    required this.employeeId,
    required this.clockIn,
    this.clockOut,
    this.source = AttendanceSource.web,
    this.latitude,
    this.longitude,
    this.deviceId,
  });
}
