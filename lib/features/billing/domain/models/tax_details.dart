import 'package:equatable/equatable.dart';

/// Represents the breakdown of taxes for a bill or bill item.
class TaxDetails extends Equatable {
  final String label;
  final double percentage;
  final double amount;

  const TaxDetails({
    required this.label,
    required this.percentage,
    required this.amount,
  });

  @override
  List<Object?> get props => [label, percentage, amount];
}
