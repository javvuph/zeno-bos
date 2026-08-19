import 'package:equatable/equatable.dart';
import 'package:zeno/features/billing/domain/models/bill.dart';

enum BillingStatus { initial, loading, active, processing, success, failure }

class BillingState extends Equatable {
  final BillingStatus status;
  final Bill activeBill;
  final List<Bill> heldBills;
  final List<Bill> history; // For Undo
  final int historyIndex;
  final String? errorMessage;

  final String? pendingVariantProductId;
  final List<String>? availableVariants;

  const BillingState({
    this.status = BillingStatus.initial,
    required this.activeBill,
    this.heldBills = const [],
    this.history = const [],
    this.historyIndex = -1,
    this.errorMessage,
    this.pendingVariantProductId,
    this.availableVariants,
  });

  bool get needsVariantSelection => pendingVariantProductId != null;
  bool get canUndo => historyIndex > 0;
  bool get canRedo => historyIndex < history.length - 1;

  @override
  List<Object?> get props => [
        status,
        activeBill,
        heldBills,
        history,
        historyIndex,
        errorMessage,
        pendingVariantProductId,
        availableVariants,
      ];

  BillingState copyWith({
    BillingStatus? status,
    Bill? activeBill,
    List<Bill>? heldBills,
    List<Bill>? history,
    int? historyIndex,
    String? errorMessage,
    String? pendingVariantProductId,
    List<String>? availableVariants,
  }) {
    return BillingState(
      status: status ?? this.status,
      activeBill: activeBill ?? this.activeBill,
      heldBills: heldBills ?? this.heldBills,
      history: history ?? this.history,
      historyIndex: historyIndex ?? this.historyIndex,
      errorMessage: errorMessage ?? this.errorMessage,
      pendingVariantProductId:
          pendingVariantProductId ?? this.pendingVariantProductId,
      availableVariants: availableVariants ?? this.availableVariants,
    );
  }
}
