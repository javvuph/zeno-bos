enum AllocationMethod { byValue, byQuantity, byWeight, byVolume }

class LandedCost {
  final String id;
  final String referenceId; // PO or GRN ID
  final List<LandedCostComponent> costs;
  final AllocationMethod allocationMethod;

  const LandedCost({
    required this.id,
    required this.referenceId,
    required this.costs,
    this.allocationMethod = AllocationMethod.byValue,
  });

  double get totalExtraCost => costs.fold(0, (sum, cost) => sum + cost.amount);
}

class LandedCostComponent {
  final String label; // Freight, Insurance, Custom Duty, etc.
  final double amount;
  final String currency;

  const LandedCostComponent({
    required this.label,
    required this.amount,
    required this.currency,
  });
}
