import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'country_registry.dart';

class CurrencyService extends ChangeNotifier {
  CountryProfile _country = CountryRegistry.defaultCountry;

  CurrencyService([CountryProfile? initialCountry]) {
    if (initialCountry != null) {
      _country = initialCountry;
    }
  }

  CountryProfile get currentCountry => _country;
  CurrencyProfile get currentCurrency => _country.currency;
  String get symbol => _country.currency.symbol;
  String get currencyCode => _country.currency.code;
  int get decimalDigits => _country.currency.decimalDigits;

  void setCountry(String countryCode) {
    final newCountry = CountryRegistry.getByCode(countryCode);
    if (_country.code != newCountry.code) {
      _country = newCountry;
      notifyListeners();
    }
  }

  void setCountryProfile(CountryProfile countryProfile) {
    if (_country.code != countryProfile.code) {
      _country = countryProfile;
      notifyListeners();
    }
  }

  String format(
    num amount, {
    String? overrideSymbol,
    int? overrideDecimals,
    bool showSymbol = true,
  }) {
    final digits = overrideDecimals ?? decimalDigits;
    final sym = showSymbol ? (overrideSymbol ?? symbol) : '';
    
    final formatter = NumberFormat.currency(
      locale: currentCurrency.locale,
      symbol: sym.isNotEmpty ? '$sym ' : '',
      decimalDigits: digits,
    );

    return formatter.format(amount).trim();
  }

  String compact(num amount, {bool showSymbol = true}) {
    final sym = showSymbol ? symbol : '';
    final formatter = NumberFormat.compact(
      locale: currentCurrency.locale,
    );
    final formattedNum = formatter.format(amount);
    return sym.isNotEmpty ? '$sym $formattedNum' : formattedNum;
  }

  num round(num amount, {int? overrideDecimals}) {
    final digits = overrideDecimals ?? decimalDigits;
    if (digits == 0) {
      return amount.round();
    }
    final mod = num.parse(10.toStringAsFixed(0)) * (digits > 1 ? (digits == 2 ? 10 : 100) : 1);
    // multiplier = 10^digits
    num multiplier = 1;
    for (int i = 0; i < digits; i++) {
      multiplier *= 10;
    }
    return (amount * multiplier).round() / multiplier;
  }
}
