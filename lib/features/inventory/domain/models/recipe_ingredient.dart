class RecipeIngredient {
  final String id;
  final String ingredientName;
  final double quantity;
  final String unit;
  final double yieldPercentage;
  final double cost;

  const RecipeIngredient({
    required this.id,
    required this.ingredientName,
    this.quantity = 0.0,
    this.unit = "Piece (Pc)",
    this.yieldPercentage = 100.0,
    this.cost = 0.0,
  });

  RecipeIngredient copyWith({
    String? id,
    String? ingredientName,
    double? quantity,
    String? unit,
    double? yieldPercentage,
    double? cost,
  }) {
    return RecipeIngredient(
      id: id ?? this.id,
      ingredientName: ingredientName ?? this.ingredientName,
      quantity: quantity ?? this.quantity,
      unit: unit ?? this.unit,
      yieldPercentage: yieldPercentage ?? this.yieldPercentage,
      cost: cost ?? this.cost,
    );
  }
}
