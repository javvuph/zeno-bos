enum AddressType { billing, shipping, office, residential }

class CustomerAddress {
  final String id;
  final String label;
  final String addressLine1;
  final String? addressLine2;
  final String city;
  final String state;
  final String zipCode;
  final String country;
  final AddressType type;
  final bool isDefault;

  const CustomerAddress({
    required this.id,
    required this.label,
    required this.addressLine1,
    this.addressLine2,
    required this.city,
    required this.state,
    required this.zipCode,
    required this.country,
    this.type = AddressType.billing,
    this.isDefault = false,
  });
}
