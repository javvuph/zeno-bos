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
