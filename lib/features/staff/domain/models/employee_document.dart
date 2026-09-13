class EmployeeDocument {
  final String id;
  final String employeeId;
  final String title;
  final String type; // e.g., Contract, ID Card, Certification
  final String fileUrl;
  final DateTime expiryDate;

  const EmployeeDocument({
    required this.id,
    required this.employeeId,
    required this.title,
    required this.type,
    required this.fileUrl,
    required this.expiryDate,
  });
}
