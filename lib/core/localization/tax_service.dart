import 'country_registry.dart';

class TaxCalculationResult {
  final double taxableAmount;
  final double totalTax;
  final double finalAmount;
  final double cgst;
  final double sgst;
  final double igst;
  final double vat;
  final double salesTax;
  final bool isInterState;
  final TaxType taxType;
  final String taxLabel;
  final double effectiveRate;

  const TaxCalculationResult({
    required this.taxableAmount,
    required this.totalTax,
    required this.finalAmount,
    this.cgst = 0.0,
    this.sgst = 0.0,
    this.igst = 0.0,
    this.vat = 0.0,
    this.salesTax = 0.0,
    this.isInterState = false,
    required this.taxType,
    required this.taxLabel,
    required this.effectiveRate,
  });
}

class TaxService {
  CountryProfile _country = CountryRegistry.defaultCountry;

  TaxService([CountryProfile? initialCountry]) {
    if (initialCountry != null) {
      _country = initialCountry;
    }
  }

  CountryProfile get currentCountry => _country;
  TaxProfile get currentTaxProfile => _country.tax;

  void setCountry(String countryCode) {
    _country = CountryRegistry.getByCode(countryCode);
  }

  void setCountryProfile(CountryProfile countryProfile) {
    _country = countryProfile;
  }

  TaxCalculationResult calculate({
    required num amount,
    String? countryCode,
    String? storeState,
    String? customerState,
    double? taxRateOverride,
    bool isInclusive = false,
  }) {
    final country = countryCode != null
        ? CountryRegistry.getByCode(countryCode)
        : _country;
    final taxProfile = country.tax;
    final rate = taxRateOverride ?? taxProfile.defaultRate;
    final numVal = amount.toDouble();

    if (taxProfile.taxType == TaxType.none || rate <= 0) {
      return TaxCalculationResult(
        taxableAmount: numVal,
        totalTax: 0.0,
        finalAmount: numVal,
        taxType: TaxType.none,
        taxLabel: taxProfile.label,
        effectiveRate: 0.0,
      );
    }

    double taxableAmount;
    double totalTax;

    if (isInclusive) {
      totalTax = numVal - (numVal / (1 + rate / 100));
      taxableAmount = numVal - totalTax;
    } else {
      taxableAmount = numVal;
      totalTax = taxableAmount * (rate / 100);
    }

    final finalAmount = isInclusive ? numVal : (taxableAmount + totalTax);

    switch (taxProfile.taxType) {
      case TaxType.gstSplit:
        final storeSt = (storeState ?? '').trim().toLowerCase();
        final custSt = (customerState ?? '').trim().toLowerCase();

        final bool isInter = custSt.isNotEmpty && storeSt.isNotEmpty && custSt != storeSt;

        if (isInter) {
          return TaxCalculationResult(
            taxableAmount: taxableAmount,
            totalTax: totalTax,
            finalAmount: finalAmount,
            igst: totalTax,
            isInterState: true,
            taxType: TaxType.gstSplit,
            taxLabel: 'IGST (${rate.toStringAsFixed(1)}%)',
            effectiveRate: rate,
          );
        } else {
          final halfTax = totalTax / 2;
          final halfRate = rate / 2;
          return TaxCalculationResult(
            taxableAmount: taxableAmount,
            totalTax: totalTax,
            finalAmount: finalAmount,
            cgst: halfTax,
            sgst: halfTax,
            isInterState: false,
            taxType: TaxType.gstSplit,
            taxLabel: 'CGST (${halfRate.toStringAsFixed(1)}%) + SGST (${halfRate.toStringAsFixed(1)}%)',
            effectiveRate: rate,
          );
        }

      case TaxType.vat:
        return TaxCalculationResult(
          taxableAmount: taxableAmount,
          totalTax: totalTax,
          finalAmount: finalAmount,
          vat: totalTax,
          taxType: TaxType.vat,
          taxLabel: '${taxProfile.label} (${rate.toStringAsFixed(1)}%)',
          effectiveRate: rate,
        );

      case TaxType.salesTax:
        return TaxCalculationResult(
          taxableAmount: taxableAmount,
          totalTax: totalTax,
          finalAmount: finalAmount,
          salesTax: totalTax,
          taxType: TaxType.salesTax,
          taxLabel: '${taxProfile.label} (${rate.toStringAsFixed(1)}%)',
          effectiveRate: rate,
        );

      case TaxType.none:
        return TaxCalculationResult(
          taxableAmount: taxableAmount,
          totalTax: 0.0,
          finalAmount: taxableAmount,
          taxType: TaxType.none,
          taxLabel: taxProfile.label,
          effectiveRate: 0.0,
        );
    }
  }
}
