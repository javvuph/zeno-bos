class SupplierContact {
  final String id;
  final String name;
  final String email;
  final String phone;
  final String? designation;
  final bool isPrimary;

  const SupplierContact({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    this.designation,
    this.isPrimary = false,
  });
}
