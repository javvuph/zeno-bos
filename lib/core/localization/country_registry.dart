import 'country_data_asia.dart';
import 'country_data_global.dart';
import 'country_models.dart';

export 'country_models.dart';
export 'country_subdivisions.dart';

class CountryRegistry {
  static const Map<String, String> indiaStates = indiaStatesMap;

  static const List<CountryProfile> countries = [
    ...asiaCountries,
    ...globalCountries,
  ];

  static CountryProfile get defaultCountry => countries.first;

  static CountryProfile getByCode(String code) {
    return countries.firstWhere(
      (c) => c.code.toUpperCase() == code.toUpperCase(),
      orElse: () => defaultCountry,
    );
  }

  static CountryProfile? findByPhoneCode(String phoneCode) {
    try {
      return countries.firstWhere(
        (c) => c.phoneCode == phoneCode || c.phoneCode == '+$phoneCode',
      );
    } catch (_) {
      return null;
    }
  }

  static String? getStateFromGSTIN(String gstin) {
    final clean = gstin.trim();
    if (clean.length < 2) return null;
    final stateCode = clean.substring(0, 2);
    return indiaStates[stateCode];
  }
}
