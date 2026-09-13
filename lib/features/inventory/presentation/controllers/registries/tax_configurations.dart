Map<String, dynamic> getTaxConfigForCountry(String businessCountry) {
  switch (businessCountry) {
    case 'India':
      return {
        'taxName': 'GST',
        'statuses': ['Taxable', 'Exempt', 'Zero Rated', 'Non-GST'],
        'categories': ['GST 0%', 'GST 5%', 'GST 12%', 'GST 18%', 'GST 28%', 'Nil Rated'],
        'rates': [0.0, 5.0, 12.0, 18.0, 28.0],
        'codeLabel': 'HSN / SAC',
        'showGSTMode': true,
        'gstModes': ['Intra-State', 'Inter-State'],
      };
    case 'UAE':
    case 'United Arab Emirates':
      return {
        'taxName': 'VAT',
        'statuses': ['Taxable', 'Zero Rated', 'Exempt', 'Out of Scope'],
        'categories': ['Standard (5%)', 'Zero-rated (0%)', 'Exempt'],
        'rates': [5.0, 0.0],
        'codeLabel': 'Tax Code',
        'showVATTreatment': true,
        'treatments': ['Standard', 'Zero-rated', 'Exempt', 'Out of Scope'],
      };
    case 'Saudi Arabia':
      return {
        'taxName': 'VAT',
        'statuses': ['Taxable', 'Zero Rated', 'Exempt', 'Out of Scope'],
        'categories': ['Standard (15%)', 'Zero-rated (0%)', 'Exempt'],
        'rates': [15.0, 0.0],
        'codeLabel': 'Tax Code',
        'showVATTreatment': true,
        'treatments': ['Standard', 'Zero-rated', 'Exempt', 'Out of Scope'],
      };
    case 'Bahrain':
      return {
        'taxName': 'VAT',
        'statuses': ['Taxable', 'Zero Rated', 'Exempt', 'Out of Scope'],
        'categories': ['Standard (10%)', 'Zero-rated (0%)', 'Exempt'],
        'rates': [10.0, 0.0],
        'codeLabel': 'Tax Code',
        'showVATTreatment': true,
        'treatments': ['Standard', 'Zero-rated', 'Exempt', 'Out of Scope'],
      };
    case 'Oman':
      return {
        'taxName': 'VAT',
        'statuses': ['Taxable', 'Zero Rated', 'Exempt', 'Out of Scope'],
        'categories': ['Standard (5%)', 'Zero-rated (0%)', 'Exempt'],
        'rates': [5.0, 0.0],
        'codeLabel': 'Tax Code',
        'showVATTreatment': true,
        'treatments': ['Standard', 'Zero-rated', 'Exempt', 'Out of Scope'],
      };
    case 'Qatar':
    case 'Kuwait':
      return {
        'taxName': 'TAX',
        'statuses': ['Taxable', 'Non-Taxable'],
        'categories': ['General'],
        'rates': [0.0],
        'codeLabel': 'Tax Code',
      };
    default:
      return {
        'taxName': 'Tax',
        'statuses': ['Taxable', 'Exempt', 'Zero Rated'],
        'categories': ['General'],
        'rates': [0.0],
        'codeLabel': 'Tax Code',
      };
  }
}
