enum SupplierAddressType { billing, shipping, warehouse, office }

class SupplierAddress {
  final String id;
  final String label;
  final String street;
  final String city;
  final String state;
  final String country;
  final String postalCode;
  final SupplierAddressType type;
  final bool isDefault;

  const SupplierAddress({
    required this.id,
    required this.label,
    required this.street,
    required this.city,
    required this.state,
    required this.country,
    required this.postalCode,
    required this.type,
    this.isDefault = false,
  });
}
