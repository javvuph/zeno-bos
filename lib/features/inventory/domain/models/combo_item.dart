class ComboItem {
  final String sku;
  final int quantity;

  ComboItem({
    required this.sku,
    this.quantity = 1,
  });

  ComboItem copyWith({
    String? sku,
    int? quantity,
  }) {
    return ComboItem(
      sku: sku ?? this.sku,
      quantity: quantity ?? this.quantity,
    );
  }
}
