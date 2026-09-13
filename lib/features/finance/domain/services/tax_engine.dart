import '../models/tax_rule.dart';

class TaxEngine {
  /// Calculates Tax Amount for a given taxable value and tax rule
  double calculateTax(double taxableValue, TaxRule rule) {
    return (taxableValue * rule.rate) / 100;
  }

  /// Resolves the correct GST components based on Origin vs Destination state
  List<TaxRule> resolveGstRules(String originState, String destinationState,
      List<TaxRule> availableRules) {
    if (originState == destinationState) {
      // Intra-state: CGST + SGST
      return availableRules
          .where((r) =>
              r.category == TaxCategory.cgst || r.category == TaxCategory.sgst)
          .toList();
    } else {
      // Inter-state: IGST
      return availableRules
          .where((r) => r.category == TaxCategory.igst)
          .toList();
    }
  }

  /// AI-Driven Tax Validation: Detects if wrong tax type is applied
  bool validateTaxApplication(
      TaxRule rule, String customerCountry, String businessCountry) {
    if (customerCountry != businessCountry && rule.type == TaxType.vat) {
      return false; // Should likely be export/customs logic
    }
    return true;
  }

  /// Estimates Tax Liability for a period
  double estimateLiability(double outputTax, double inputCredit) {
    return (outputTax - inputCredit).clamp(0, double.infinity);
  }
}
