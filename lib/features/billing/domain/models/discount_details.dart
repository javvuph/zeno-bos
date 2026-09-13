import 'package:equatable/equatable.dart';

/// Represents a discount applied to a bill or bill item.
class DiscountDetails extends Equatable {
  final String label;
  final double value; // Can be percentage or absolute
  final bool isPercentage;
  final double calculatedAmount;

  const DiscountDetails({
    required this.label,
    required this.value,
    this.isPercentage = true,
    required this.calculatedAmount,
  });

  @override
  List<Object?> get props => [label, value, isPercentage, calculatedAmount];
}
