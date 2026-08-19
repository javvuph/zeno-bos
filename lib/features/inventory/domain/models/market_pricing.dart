class MarketPricing {
  final String market;
  final String currency;
  double costPrice;
  double sellingPrice;
  double taxPct;
  String status;
  String trend;

  MarketPricing({
    required this.market,
    required this.currency,
    required this.costPrice,
    required this.sellingPrice,
    required this.taxPct,
    this.status = "ACTIVE",
    this.trend = "STABLE",
  });

  double get marginPct {
    if (sellingPrice == 0) return 0;
    final taxAmount = sellingPrice * (taxPct / (100 + taxPct));
    return ((sellingPrice - taxAmount - costPrice) /
            (sellingPrice - taxAmount)) *
        100;
  }
}
