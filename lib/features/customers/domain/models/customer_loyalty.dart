class CustomerLoyalty {
  final double points;
  final double totalSpent;
  final DateTime? lastPurchaseDate;

  const CustomerLoyalty({
    this.points = 0.0,
    this.totalSpent = 0.0,
    this.lastPurchaseDate,
  });
}
