class CustomerContact {
  final String id;
  final String name;
  final String email;
  final String phone;
  final String? role;
  final bool isPrimary;

  const CustomerContact({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    this.role,
    this.isPrimary = false,
  });
}
