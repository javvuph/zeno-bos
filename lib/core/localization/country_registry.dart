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

class GlobalSubdivisions {
  static const Map<String, List<String>> byCountry = {
    'IN': [
      'Andhra Pradesh', 'Arunachal Pradesh', 'Assam', 'Bihar', 'Chhattisgarh',
      'Goa', 'Gujarat', 'Haryana', 'Himachal Pradesh', 'Jammu & Kashmir',
      'Jharkhand', 'Karnataka', 'Kerala', 'Madhya Pradesh', 'Maharashtra',
      'Manipur', 'Meghalaya', 'Mizoram', 'Nagaland', 'Odisha', 'Punjab',
      'Rajasthan', 'Sikkim', 'Tamil Nadu', 'Telangana', 'Tripura',
      'Uttar Pradesh', 'Uttarakhand', 'West Bengal', 'Delhi', 'Chandigarh',
      'Ladakh', 'Puducherry', 'Andaman & Nicobar', 'Dadra & Nagar Haveli', 'Lakshadweep'
    ],
    'AE': [
      'Dubai', 'Abu Dhabi', 'Sharjah', 'Ajman', 'Ras Al Khaimah', 'Fujairah', 'Umm Al Quwain'
    ],
    'SA': [
      'Riyadh', 'Makkah (Mecca)', 'Eastern Province', 'Madinah (Medina)', 'Asir',
      'Tabuk', 'Hail', 'Northern Borders', 'Jazan', 'Najran', 'Al Bahah', 'Al Jawf', 'Al Qassim'
    ],
    'US': [
      'Alabama', 'Alaska', 'Arizona', 'Arkansas', 'California', 'Colorado', 'Connecticut',
      'Delaware', 'Florida', 'Georgia', 'Hawaii', 'Idaho', 'Illinois', 'Indiana',
      'Iowa', 'Kansas', 'Kentucky', 'Louisiana', 'Maine', 'Maryland', 'Massachusetts',
      'Michigan', 'Minnesota', 'Mississippi', 'Missouri', 'Montana', 'Nebraska', 'Nevada',
      'New Hampshire', 'New Jersey', 'New Mexico', 'New York', 'North Carolina', 'North Dakota',
      'Ohio', 'Oklahoma', 'Oregon', 'Pennsylvania', 'Rhode Island', 'South Carolina',
      'South Dakota', 'Tennessee', 'Texas', 'Utah', 'Vermont', 'Virginia', 'Washington',
      'West Virginia', 'Wisconsin', 'Wyoming', 'Washington D.C.'
    ],
    'CA': [
      'Ontario', 'Quebec', 'British Columbia', 'Alberta', 'Manitoba',
      'Saskatchewan', 'Nova Scotia', 'New Brunswick', 'Newfoundland & Labrador',
      'Prince Edward Island', 'Northwest Territories', 'Nunavut', 'Yukon'
    ],
    'GB': [
      'England', 'Scotland', 'Wales', 'Northern Ireland'
    ],
    'AU': [
      'New South Wales', 'Victoria', 'Queensland', 'Western Australia',
      'South Australia', 'Tasmania', 'Australian Capital Territory', 'Northern Territory'
    ],
    'MY': [
      'Selangor', 'Kuala Lumpur', 'Johor', 'Penang', 'Perak', 'Sarawak', 'Sabah',
      'Kedah', 'Pahang', 'Negeri Sembilan', 'Kelantan', 'Melaka', 'Terengganu', 'Perlis', 'Putrajaya', 'Labuan'
    ],
    'SG': [
      'Central Region', 'East Region', 'North Region', 'North-East Region', 'West Region'
    ],
    'KW': [
      'Al Asimah (Capital)', 'Hawalli', 'Farwaniya', 'Mubarak Al-Kabeer', 'Ahmadi', 'Jahra'
    ],
    'QA': [
      'Doha', 'Al Rayyan', 'Al Wakrah', 'Al Khor', 'Umm Salal', 'Al Daayen', 'Al Shamal'
    ],
    'OM': [
      'Muscat', 'Dhofar', 'Musandam', 'Al Buraimi', 'Ad Dakhiliyah', 'Al Batinah North', 'Al Batinah South'
    ],
    'BH': [
      'Capital', 'Muharraq', 'Northern', 'Southern'
    ],
    'DE': [
      'Bavaria', 'Berlin', 'Baden-Württemberg', 'North Rhine-Westphalia', 'Hesse',
      'Saxony', 'Lower Saxony', 'Hamburg', 'Brandenburg', 'Schleswig-Holstein'
    ],
  };

  static List<String> getForCountry(String countryCode) {
    final list = byCountry[countryCode.toUpperCase()];
    if (list != null && list.isNotEmpty) {
      return list;
    }
    return const ['General / Main Region'];
  }

  static String getLabelForCountry(String countryCode) {
    switch (countryCode.toUpperCase()) {
      case 'AE':
        return 'Emirate';
      case 'CA':
        return 'Province / Territory';
      case 'US':
        return 'State (Tax Jurisdiction)';
      case 'IN':
        return 'State / Place of Supply';
      default:
        return 'State / Province / Region';
    }
  }
}

class CountryRegistry {
  static const Map<String, String> indiaStates = {
    '01': 'Jammu & Kashmir',
    '02': 'Himachal Pradesh',
    '03': 'Punjab',
    '04': 'Chandigarh',
    '05': 'Uttarakhand',
    '06': 'Haryana',
    '07': 'Delhi',
    '08': 'Rajasthan',
    '09': 'Uttar Pradesh',
    '10': 'Bihar',
    '11': 'Sikkim',
    '12': 'Arunachal Pradesh',
    '13': 'Nagaland',
    '14': 'Manipur',
    '15': 'Mizoram',
    '16': 'Tripura',
    '17': 'Meghalaya',
    '18': 'Assam',
    '19': 'West Bengal',
    '20': 'Jharkhand',
    '21': 'Odisha',
    '22': 'Chhattisgarh',
    '23': 'Madhya Pradesh',
    '24': 'Gujarat',
    '25': 'Daman & Diu',
    '26': 'Dadra & Nagar Haveli',
    '27': 'Maharashtra',
    '28': 'Andhra Pradesh (Old)',
    '29': 'Karnataka',
    '30': 'Goa',
    '31': 'Lakshadweep',
    '32': 'Kerala',
    '33': 'Tamil Nadu',
    '34': 'Puducherry',
    '35': 'Andaman & Nicobar Islands',
    '36': 'Telangana',
    '37': 'Andhra Pradesh',
    '38': 'Ladakh',
  };

  static const List<CountryProfile> countries = [
    CountryProfile(
      code: 'IN',
      name: 'India',
      flagEmoji: '🇮🇳',
      phoneCode: '+91',
      defaultTimezone: 'Asia/Kolkata',
      timezones: ['Asia/Kolkata'],
      currency: CurrencyProfile(
        code: 'INR',
        symbol: '₹',
        decimalDigits: 2,
        name: 'Indian Rupee',
        locale: 'en_IN',
      ),
      tax: TaxProfile(
        taxType: TaxType.gstSplit,
        defaultRate: 18.0,
        label: 'GST (CGST / SGST / IGST)',
        taxIdName: 'GSTIN',
        states: indiaStates,
      ),
    ),
    CountryProfile(
      code: 'AE',
      name: 'United Arab Emirates',
      flagEmoji: '🇦🇪',
      phoneCode: '+971',
      defaultTimezone: 'Asia/Dubai',
      timezones: ['Asia/Dubai'],
      currency: CurrencyProfile(
        code: 'AED',
        symbol: 'AED',
        decimalDigits: 2,
        name: 'UAE Dirham',
        locale: 'ar_AE',
      ),
      tax: TaxProfile(
        taxType: TaxType.vat,
        defaultRate: 5.0,
        label: 'VAT',
        taxIdName: 'TRN',
      ),
    ),
    CountryProfile(
      code: 'SA',
      name: 'Saudi Arabia',
      flagEmoji: '🇸🇦',
      phoneCode: '+966',
      defaultTimezone: 'Asia/Riyadh',
      timezones: ['Asia/Riyadh'],
      currency: CurrencyProfile(
        code: 'SAR',
        symbol: 'SAR',
        decimalDigits: 2,
        name: 'Saudi Riyal',
        locale: 'ar_SA',
      ),
      tax: TaxProfile(
        taxType: TaxType.vat,
        defaultRate: 15.0,
        label: 'VAT',
        taxIdName: 'VAT Reg No',
      ),
    ),
    CountryProfile(
      code: 'KW',
      name: 'Kuwait',
      flagEmoji: '🇰🇼',
      phoneCode: '+965',
      defaultTimezone: 'Asia/Kuwait',
      timezones: ['Asia/Kuwait'],
      currency: CurrencyProfile(
        code: 'KWD',
        symbol: 'KWD',
        decimalDigits: 3,
        name: 'Kuwaiti Dinar',
        locale: 'en_KW',
      ),
      tax: TaxProfile(
        taxType: TaxType.none,
        defaultRate: 0.0,
        label: 'No Tax',
        taxIdName: 'Tax ID',
      ),
    ),
    CountryProfile(
      code: 'OM',
      name: 'Oman',
      flagEmoji: '🇴🇲',
      phoneCode: '+968',
      defaultTimezone: 'Asia/Muscat',
      timezones: ['Asia/Muscat'],
      currency: CurrencyProfile(
        code: 'OMR',
        symbol: 'OMR',
        decimalDigits: 3,
        name: 'Omani Rial',
        locale: 'ar_OM',
      ),
      tax: TaxProfile(
        taxType: TaxType.vat,
        defaultRate: 5.0,
        label: 'VAT',
        taxIdName: 'VAT ID',
      ),
    ),
    CountryProfile(
      code: 'BH',
      name: 'Bahrain',
      flagEmoji: '🇧🇭',
      phoneCode: '+973',
      defaultTimezone: 'Asia/Bahrain',
      timezones: ['Asia/Bahrain'],
      currency: CurrencyProfile(
        code: 'BHD',
        symbol: 'BHD',
        decimalDigits: 3,
        name: 'Bahraini Dinar',
        locale: 'ar_BH',
      ),
      tax: TaxProfile(
        taxType: TaxType.vat,
        defaultRate: 10.0,
        label: 'VAT',
        taxIdName: 'VAT ID',
      ),
    ),
    CountryProfile(
      code: 'QA',
      name: 'Qatar',
      flagEmoji: '🇶🇦',
      phoneCode: '+974',
      defaultTimezone: 'Asia/Qatar',
      timezones: ['Asia/Qatar'],
      currency: CurrencyProfile(
        code: 'QAR',
        symbol: 'QAR',
        decimalDigits: 2,
        name: 'Qatari Riyal',
        locale: 'ar_QA',
      ),
      tax: TaxProfile(
        taxType: TaxType.none,
        defaultRate: 0.0,
        label: 'No Tax',
        taxIdName: 'Tax Card No',
      ),
    ),
    CountryProfile(
      code: 'US',
      name: 'United States',
      flagEmoji: '🇺🇸',
      phoneCode: '+1',
      defaultTimezone: 'America/New_York',
      timezones: [
        'America/New_York',
        'America/Chicago',
        'America/Denver',
        'America/Los_Angeles',
        'America/Anchorage',
        'Pacific/Honolulu'
      ],
      currency: CurrencyProfile(
        code: 'USD',
        symbol: '\$',
        decimalDigits: 2,
        name: 'US Dollar',
        locale: 'en_US',
      ),
      tax: TaxProfile(
        taxType: TaxType.salesTax,
        defaultRate: 7.5,
        label: 'Sales Tax',
        taxIdName: 'EIN / Tax ID',
      ),
    ),
    CountryProfile(
      code: 'GB',
      name: 'United Kingdom',
      flagEmoji: '🇬🇧',
      phoneCode: '+44',
      defaultTimezone: 'Europe/London',
      timezones: ['Europe/London'],
      currency: CurrencyProfile(
        code: 'GBP',
        symbol: '£',
        decimalDigits: 2,
        name: 'British Pound',
        locale: 'en_GB',
      ),
      tax: TaxProfile(
        taxType: TaxType.vat,
        defaultRate: 20.0,
        label: 'VAT',
        taxIdName: 'VAT Registration No',
      ),
    ),
    CountryProfile(
      code: 'SG',
      name: 'Singapore',
      flagEmoji: '🇸🇬',
      phoneCode: '+65',
      defaultTimezone: 'Asia/Singapore',
      timezones: ['Asia/Singapore'],
      currency: CurrencyProfile(
        code: 'SGD',
        symbol: 'S\$',
        decimalDigits: 2,
        name: 'Singapore Dollar',
        locale: 'en_SG',
      ),
      tax: TaxProfile(
        taxType: TaxType.vat,
        defaultRate: 9.0,
        label: 'GST',
        taxIdName: 'GST Reg No',
      ),
    ),
    CountryProfile(
      code: 'CA',
      name: 'Canada',
      flagEmoji: '🇨🇦',
      phoneCode: '+1',
      defaultTimezone: 'America/Toronto',
      timezones: [
        'America/Toronto',
        'America/Vancouver',
        'America/Edmonton',
        'America/Winnipeg',
        'America/Halifax'
      ],
      currency: CurrencyProfile(
        code: 'CAD',
        symbol: '\$',
        decimalDigits: 2,
        name: 'Canadian Dollar',
        locale: 'en_CA',
      ),
      tax: TaxProfile(
        taxType: TaxType.salesTax,
        defaultRate: 5.0,
        label: 'GST / HST',
        taxIdName: 'BN / GST No',
      ),
    ),
    CountryProfile(
      code: 'AU',
      name: 'Australia',
      flagEmoji: '🇦🇺',
      phoneCode: '+61',
      defaultTimezone: 'Australia/Sydney',
      timezones: [
        'Australia/Sydney',
        'Australia/Melbourne',
        'Australia/Brisbane',
        'Australia/Perth',
        'Australia/Adelaide'
      ],
      currency: CurrencyProfile(
        code: 'AUD',
        symbol: 'A\$',
        decimalDigits: 2,
        name: 'Australian Dollar',
        locale: 'en_AU',
      ),
      tax: TaxProfile(
        taxType: TaxType.vat,
        defaultRate: 10.0,
        label: 'GST',
        taxIdName: 'ABN',
      ),
    ),
    CountryProfile(
      code: 'DE',
      name: 'Germany',
      flagEmoji: '🇩🇪',
      phoneCode: '+49',
      defaultTimezone: 'Europe/Berlin',
      timezones: ['Europe/Berlin'],
      currency: CurrencyProfile(
        code: 'EUR',
        symbol: '€',
        decimalDigits: 2,
        name: 'Euro',
        locale: 'de_DE',
      ),
      tax: TaxProfile(
        taxType: TaxType.vat,
        defaultRate: 19.0,
        label: 'MwSt / VAT',
        taxIdName: 'USt-IdNr',
      ),
    ),
    CountryProfile(
      code: 'FR',
      name: 'France',
      flagEmoji: '🇫🇷',
      phoneCode: '+33',
      defaultTimezone: 'Europe/Paris',
      timezones: ['Europe/Paris'],
      currency: CurrencyProfile(
        code: 'EUR',
        symbol: '€',
        decimalDigits: 2,
        name: 'Euro',
        locale: 'fr_FR',
      ),
      tax: TaxProfile(
        taxType: TaxType.vat,
        defaultRate: 20.0,
        label: 'TVA / VAT',
        taxIdName: 'TVA Intracommunautaire',
      ),
    ),
    CountryProfile(
      code: 'JP',
      name: 'Japan',
      flagEmoji: '🇯🇵',
      phoneCode: '+81',
      defaultTimezone: 'Asia/Tokyo',
      timezones: ['Asia/Tokyo'],
      currency: CurrencyProfile(
        code: 'JPY',
        symbol: '¥',
        decimalDigits: 0,
        name: 'Japanese Yen',
        locale: 'ja_JP',
      ),
      tax: TaxProfile(
        taxType: TaxType.salesTax,
        defaultRate: 10.0,
        label: 'Consumption Tax',
        taxIdName: 'Corporate Number',
      ),
    ),
    CountryProfile(
      code: 'VN',
      name: 'Vietnam',
      flagEmoji: '🇻🇳',
      phoneCode: '+84',
      defaultTimezone: 'Asia/Ho_Chi_Minh',
      timezones: ['Asia/Ho_Chi_Minh'],
      currency: CurrencyProfile(
        code: 'VND',
        symbol: '₫',
        decimalDigits: 0,
        name: 'Vietnamese Dong',
        locale: 'vi_VN',
      ),
      tax: TaxProfile(
        taxType: TaxType.vat,
        defaultRate: 10.0,
        label: 'VAT',
        taxIdName: 'Mã số thuế',
      ),
    ),
    CountryProfile(
      code: 'ID',
      name: 'Indonesia',
      flagEmoji: '🇮🇩',
      phoneCode: '+62',
      defaultTimezone: 'Asia/Jakarta',
      timezones: ['Asia/Jakarta', 'Asia/Makassar', 'Asia/Jayapura'],
      currency: CurrencyProfile(
        code: 'IDR',
        symbol: 'Rp',
        decimalDigits: 0,
        name: 'Indonesian Rupiah',
        locale: 'id_ID',
      ),
      tax: TaxProfile(
        taxType: TaxType.vat,
        defaultRate: 11.0,
        label: 'PPN / VAT',
        taxIdName: 'NPWP',
      ),
    ),
    CountryProfile(
      code: 'MY',
      name: 'Malaysia',
      flagEmoji: '🇲🇾',
      phoneCode: '+60',
      defaultTimezone: 'Asia/Kuala_Lumpur',
      timezones: ['Asia/Kuala_Lumpur'],
      currency: CurrencyProfile(
        code: 'MYR',
        symbol: 'RM',
        decimalDigits: 2,
        name: 'Malaysian Ringgit',
        locale: 'ms_MY',
      ),
      tax: TaxProfile(
        taxType: TaxType.salesTax,
        defaultRate: 8.0,
        label: 'SST',
        taxIdName: 'SST No',
      ),
    ),
    CountryProfile(
      code: 'TH',
      name: 'Thailand',
      flagEmoji: '🇹🇭',
      phoneCode: '+66',
      defaultTimezone: 'Asia/Bangkok',
      timezones: ['Asia/Bangkok'],
      currency: CurrencyProfile(
        code: 'THB',
        symbol: '฿',
        decimalDigits: 2,
        name: 'Thai Baht',
        locale: 'th_TH',
      ),
      tax: TaxProfile(
        taxType: TaxType.vat,
        defaultRate: 7.0,
        label: 'VAT',
        taxIdName: 'Tax ID',
      ),
    ),
    CountryProfile(
      code: 'PH',
      name: 'Philippines',
      flagEmoji: '🇵🇭',
      phoneCode: '+63',
      defaultTimezone: 'Asia/Manila',
      timezones: ['Asia/Manila'],
      currency: CurrencyProfile(
        code: 'PHP',
        symbol: '₱',
        decimalDigits: 2,
        name: 'Philippine Peso',
        locale: 'en_PH',
      ),
      tax: TaxProfile(
        taxType: TaxType.vat,
        defaultRate: 12.0,
        label: 'VAT',
        taxIdName: 'TIN',
      ),
    ),
    CountryProfile(
      code: 'ZA',
      name: 'South Africa',
      flagEmoji: '🇿🇦',
      phoneCode: '+27',
      defaultTimezone: 'Africa/Johannesburg',
      timezones: ['Africa/Johannesburg'],
      currency: CurrencyProfile(
        code: 'ZAR',
        symbol: 'R',
        decimalDigits: 2,
        name: 'South African Rand',
        locale: 'en_ZA',
      ),
      tax: TaxProfile(
        taxType: TaxType.vat,
        defaultRate: 15.0,
        label: 'VAT',
        taxIdName: 'VAT Number',
      ),
    ),
    CountryProfile(
      code: 'NG',
      name: 'Nigeria',
      flagEmoji: '🇳🇬',
      phoneCode: '+234',
      defaultTimezone: 'Africa/Lagos',
      timezones: ['Africa/Lagos'],
      currency: CurrencyProfile(
        code: 'NGN',
        symbol: '₦',
        decimalDigits: 2,
        name: 'Nigerian Naira',
        locale: 'en_NG',
      ),
      tax: TaxProfile(
        taxType: TaxType.vat,
        defaultRate: 7.5,
        label: 'VAT',
        taxIdName: 'TIN',
      ),
    ),
    CountryProfile(
      code: 'KE',
      name: 'Kenya',
      flagEmoji: '🇰🇪',
      phoneCode: '+254',
      defaultTimezone: 'Africa/Nairobi',
      timezones: ['Africa/Nairobi'],
      currency: CurrencyProfile(
        code: 'KES',
        symbol: 'KSh',
        decimalDigits: 2,
        name: 'Kenyan Shilling',
        locale: 'en_KE',
      ),
      tax: TaxProfile(
        taxType: TaxType.vat,
        defaultRate: 16.0,
        label: 'VAT',
        taxIdName: 'KRA PIN',
      ),
    ),
    CountryProfile(
      code: 'EG',
      name: 'Egypt',
      flagEmoji: '🇪🇬',
      phoneCode: '+20',
      defaultTimezone: 'Africa/Cairo',
      timezones: ['Africa/Cairo'],
      currency: CurrencyProfile(
        code: 'EGP',
        symbol: 'E£',
        decimalDigits: 2,
        name: 'Egyptian Pound',
        locale: 'ar_EG',
      ),
      tax: TaxProfile(
        taxType: TaxType.vat,
        defaultRate: 14.0,
        label: 'VAT',
        taxIdName: 'Tax Reg No',
      ),
    ),
    CountryProfile(
      code: 'BR',
      name: 'Brazil',
      flagEmoji: '🇧🇷',
      phoneCode: '+55',
      defaultTimezone: 'America/Sao_Paulo',
      timezones: ['America/Sao_Paulo', 'America/Manaus', 'America/Recife'],
      currency: CurrencyProfile(
        code: 'BRL',
        symbol: 'R\$',
        decimalDigits: 2,
        name: 'Brazilian Real',
        locale: 'pt_BR',
      ),
      tax: TaxProfile(
        taxType: TaxType.vat,
        defaultRate: 17.0,
        label: 'ICMS / VAT',
        taxIdName: 'CNPJ',
      ),
    ),
    CountryProfile(
      code: 'MX',
      name: 'Mexico',
      flagEmoji: '🇲🇽',
      phoneCode: '+52',
      defaultTimezone: 'America/Mexico_City',
      timezones: ['America/Mexico_City', 'America/Cancun', 'America/Tijuana'],
      currency: CurrencyProfile(
        code: 'MXN',
        symbol: '\$',
        decimalDigits: 2,
        name: 'Mexican Peso',
        locale: 'es_MX',
      ),
      tax: TaxProfile(
        taxType: TaxType.vat,
        defaultRate: 16.0,
        label: 'IVA / VAT',
        taxIdName: 'RFC',
      ),
    ),
    CountryProfile(
      code: 'LK',
      name: 'Sri Lanka',
      flagEmoji: '🇱🇰',
      phoneCode: '+94',
      defaultTimezone: 'Asia/Colombo',
      timezones: ['Asia/Colombo'],
      currency: CurrencyProfile(
        code: 'LKR',
        symbol: 'Rs',
        decimalDigits: 2,
        name: 'Sri Lankan Rupee',
        locale: 'si_LK',
      ),
      tax: TaxProfile(
        taxType: TaxType.vat,
        defaultRate: 18.0,
        label: 'VAT',
        taxIdName: 'TIN',
      ),
    ),
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
