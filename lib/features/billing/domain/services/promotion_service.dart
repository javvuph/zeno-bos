import '../models/discount_details.dart';

class PromotionService {
  DiscountDetails resolveConflict(List<DiscountDetails> activePromotions) {
    if (activePromotions.isEmpty) {
      return const DiscountDetails(label: 'None', value: 0, isPercentage: true, calculatedAmount: 0);
    }

    // 1. Sort by Priority (Assuming 'priority' exists or using type hierarchy)
    // 2. Exclusive promotions take absolute priority
    // 3. Percentage vs Fixed logic
    
    // For this implementation, we take the highest value benefit to the customer
    activePromotions.sort((a, b) => b.value.compareTo(a.value));
    
    return activePromotions.first;
  }

  bool canStack(DiscountDetails a, DiscountDetails b) {
    // Logic to check stacking rules from registry
    return false;
  }
}
