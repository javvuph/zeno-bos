import '../../../administration/domain/models/business_vertical.dart';

class SalesAdaptiveEngine {
  final BusinessVertical vertical;

  const SalesAdaptiveEngine(this.vertical);

  /// Dynamically determines visible fields for a Customer based on business vertical
  List<String> getRequiredCustomerFields() {
    switch (vertical) {
      case BusinessVertical.pharmacy:
        return ['name', 'phone', 'drug_license_no'];
      case BusinessVertical.fashion:
        return ['name', 'phone', 'size_preferences', 'style_profile'];
      case BusinessVertical.restaurant:
        return ['name', 'phone', 'table_preference', 'allergies'];
      default:
        return ['name', 'phone'];
    }
  }

  /// Adaptive Billing Flow
  bool shouldShowTableSelection() => vertical == BusinessVertical.restaurant;
  bool shouldShowPrescriptionUpload() => vertical == BusinessVertical.pharmacy;
  bool shouldShowMeasurementMatrix() => vertical == BusinessVertical.fashion;

  /// Dynamic Pricing Strategy
  String getPricingModel() {
    if (vertical == BusinessVertical.wholesale) return 'Volume-based';
    if (vertical == BusinessVertical.service) return 'Hourly/Milestone';
    return 'Retail-standard';
  }
}
