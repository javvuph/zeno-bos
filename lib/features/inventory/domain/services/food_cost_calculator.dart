import '../models/recipe_ingredient.dart';

class FoodCostCalculator {
  static double calculateRecipeCost(List<RecipeIngredient> bom) {
    return bom.fold(0.0, (sum, item) => sum + (item.quantity * item.cost));
  }

  static double calculateFoodCostPercentage(double recipeCost, double sellingPrice) {
    if (sellingPrice <= 0) return 0;
    return (recipeCost / sellingPrice) * 100;
  }
}
