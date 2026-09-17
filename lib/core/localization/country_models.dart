enum TaxType {
  gstSplit,
  vat,
  salesTax,
  none,
}

class TaxProfile {
  final TaxType taxType;
  final double defaultRate;
  final String label;
  final String taxIdName;
  final Map<String, String> states;

  const TaxProfile({
    required this.taxType,
    required this.defaultRate,
    required this.label,
    required this.taxIdName,
    this.states = const {},
  });
}

class CurrencyProfile {
  final String code;
  final String symbol;
  final int decimalDigits;
  final String name;
  final String locale;

  const CurrencyProfile({
    required this.code,
    required this.symbol,
    required this.decimalDigits,
    required this.name,
    required this.locale,
  });
}

class CountryProfile {
  final String code;
  final String name;
  final String flagEmoji;
  final String phoneCode;
  final CurrencyProfile currency;
  final TaxProfile tax;
  final String defaultTimezone;
  final List<String> timezones;

  const CountryProfile({
    required this.code,
    required this.name,
    required this.flagEmoji,
    required this.phoneCode,
    required this.currency,
    required this.tax,
    this.defaultTimezone = 'UTC',
    this.timezones = const [],
  });

  bool get hasMultipleTimezones => timezones.length > 1;
}
