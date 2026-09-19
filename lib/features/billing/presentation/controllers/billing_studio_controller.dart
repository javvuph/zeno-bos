import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/models/bill.dart';
import '../../domain/models/bill_item.dart';
import '../../domain/models/payment.dart';
import '../../domain/services/billing_math_engine.dart';
import '../../domain/repositories/i_billing_repository.dart';
import 'billing_event.dart';
import 'billing_state.dart';

part 'parts/billing_studio_controller_handlers.part.dart';

class BillingStudioController extends Bloc<BillingEvent, BillingState> {
  final IBillingRepository _repository;

  BillingStudioController(this._repository)
      : super(BillingState(
          activeBill: Bill(
            id: 'TEMP-${DateTime.now().millisecondsSinceEpoch}',
            timestamp: DateTime.now(),
          ),
          history: [
            Bill(
              id: 'TEMP-${DateTime.now().millisecondsSinceEpoch}',
              timestamp: DateTime.now(),
            )
          ],
          historyIndex: 0,
        )) {
    on<AddItemRequested>(_onAddItemRequested);
    on<RemoveItemRequested>(_onRemoveItemRequested);
    on<UpdateItemQuantityRequested>(_onUpdateItemQuantityRequested);
    on<UpdateItemDiscountRequested>(_onUpdateItemDiscountRequested);
    on<ClearCartRequested>(_onClearCartRequested);
    on<CustomerSelected>(_onCustomerSelected);
    on<SearchCustomerRequested>(_onSearchCustomerRequested);
    on<PaymentInitiated>(_onPaymentInitiated);
    on<BillHoldRequested>(_onBillHoldRequested);
    on<BillRecallRequested>(_onBillRecallRequested);
    on<BillCompleteRequested>(_onBillCompleteRequested);
    on<ToggleReturnModeRequested>(_onToggleReturnModeRequested);
    on<VariantSelectionRequested>(_onVariantSelectionRequested);
    on<VariantSelected>(_onVariantSelected);

    on<UndoRequested>(_onUndoRequested);
    on<RedoRequested>(_onRedoRequested);
    on<LockBillRequested>(_onLockBillRequested);
    on<PriceOverrideRequested>(_onPriceOverrideRequested);
    on<UpdateItemTrackingRequested>(_onUpdateItemTrackingRequested);
    on<AddLineNoteRequested>(_onAddLineNoteRequested);
  }

  void _pushToHistory(Bill bill, Emitter<BillingState> emit) {
    final currentHistory = List<Bill>.from(state.history);
    final currentIndex = state.historyIndex;

    if (currentIndex < currentHistory.length - 1) {
      currentHistory.removeRange(currentIndex + 1, currentHistory.length);
    }

    currentHistory.add(bill);
    if (currentHistory.length > 50) currentHistory.removeAt(0);

    emit(state.copyWith(
      activeBill: bill,
      history: currentHistory,
      historyIndex: currentHistory.length - 1,
    ));
  }

  Future<void> _onUndoRequested(
      UndoRequested event, Emitter<BillingState> emit) async {
    if (state.canUndo) {
      final prevIndex = state.historyIndex - 1;
      emit(state.copyWith(
        activeBill: state.history[prevIndex],
        historyIndex: prevIndex,
      ));
    }
  }

  Future<void> _onRedoRequested(
      RedoRequested event, Emitter<BillingState> emit) async {
    if (state.canRedo) {
      final nextIndex = state.historyIndex + 1;
      emit(state.copyWith(
        activeBill: state.history[nextIndex],
        historyIndex: nextIndex,
      ));
    }
  }

  Future<void> _onLockBillRequested(
      LockBillRequested event, Emitter<BillingState> emit) async {
    final updatedBill = state.activeBill.copyWith(isLocked: event.lock);
    _pushToHistory(updatedBill, emit);
  }

  bool _isBillModifiable() {
    return !state.activeBill.isLocked &&
        state.status != BillingStatus.processing;
  }

  Future<void> _onClearCartRequested(
      ClearCartRequested event, Emitter<BillingState> emit) async {
    if (!_isBillModifiable() && state.activeBill.items.isNotEmpty) return;

    final emptyBill = Bill(
      id: 'TEMP-${DateTime.now().millisecondsSinceEpoch}',
      timestamp: DateTime.now(),
    );
    _pushToHistory(emptyBill, emit);
  }

  Future<void> _onSearchCustomerRequested(
      SearchCustomerRequested event, Emitter<BillingState> emit) async {
    if (!_isBillModifiable()) return;

    emit(state.copyWith(status: BillingStatus.loading));
    try {
      final customer = await _repository.findCustomer(event.query);
      if (customer != null) {
        add(CustomerSelected(customer));
      }
    } catch (e) {
      emit(state.copyWith(
          status: BillingStatus.active,
          errorMessage: 'Customer search failed'));
    }
  }

  Future<void> _onCustomerSelected(
      CustomerSelected event, Emitter<BillingState> emit) async {
    if (!_isBillModifiable()) return;

    final updatedBill = state.activeBill.copyWith(customer: event.customer);
    final recalculatedBill = BillingMathEngine.calculateBillTotals(updatedBill);
    _pushToHistory(recalculatedBill, emit);
    emit(state.copyWith(status: BillingStatus.active));
  }

  Future<void> _onBillHoldRequested(
      BillHoldRequested event, Emitter<BillingState> emit) async {
    if (state.activeBill.items.isEmpty || state.activeBill.isLocked) return;

    await _repository.saveBill(state.activeBill.copyWith(status: 'Held'));
    final heldBills = await _repository.getHeldBills();

    final newBill = Bill(
      id: 'TEMP-${DateTime.now().millisecondsSinceEpoch}',
      timestamp: DateTime.now(),
    );

    emit(state.copyWith(
      heldBills: heldBills,
    ));
    _pushToHistory(newBill, emit);
  }

  Future<void> _onBillRecallRequested(
      BillRecallRequested event, Emitter<BillingState> emit) async {
    final bill = await _repository.getBill(event.billId);
    if (bill != null) {
      _pushToHistory(bill, emit);
    }
  }

  Future<void> _onPaymentInitiated(
      PaymentInitiated event, Emitter<BillingState> emit) async {
    if (state.activeBill.isLocked) return;

    final updatedPayments = List<Payment>.from(state.activeBill.payments)
      ..add(event.payment);
    final totalPaid = updatedPayments.fold(0.0, (sum, p) => sum + p.amount);

    final updatedBill = state.activeBill.copyWith(payments: updatedPayments);

    _pushToHistory(updatedBill, emit);

    if (totalPaid >= state.activeBill.grandTotal) {
      add(BillCompleteRequested());
    }
  }

  Future<void> _onToggleReturnModeRequested(
      ToggleReturnModeRequested event, Emitter<BillingState> emit) async {
    if (state.activeBill.items.isNotEmpty) {
      emit(state.copyWith(
          errorMessage: 'Cannot switch mode with items in cart'));
      return;
    }
    final newStatus = state.activeBill.status == 'Return' ? 'Draft' : 'Return';
    final updatedBill = state.activeBill.copyWith(status: newStatus);
    _pushToHistory(updatedBill, emit);
  }

  Future<void> _onBillCompleteRequested(
      BillCompleteRequested event, Emitter<BillingState> emit) async {
    // Prevent double-submit/double inventory deduction if checkout is triggered
    // more than once before the first completion finishes.
    if (state.activeBill.isLocked ||
        state.status == BillingStatus.processing ||
        state.status == BillingStatus.success) {
      return;
    }

    emit(state.copyWith(status: BillingStatus.processing));
    final bill = state.activeBill.copyWith(status: 'Completed');

    try {
      await _repository.saveBill(bill);
      emit(state.copyWith(status: BillingStatus.success));
    } catch (e) {
      emit(state.copyWith(
          status: BillingStatus.failure,
          errorMessage: 'Persistence Error: $e'));
    }
  }

  void _onVariantSelectionRequested(
      VariantSelectionRequested event, Emitter<BillingState> emit) {
    emit(state.copyWith(
      pendingVariantProductId: event.productId,
      availableVariants: event.availableVariants,
    ));
  }

  void _onVariantSelected(VariantSelected event, Emitter<BillingState> emit) {
    final itemIndex = state.activeBill.items
        .indexWhere((i) => i.productId == event.productId);
    if (itemIndex != -1) {
      final updatedItems = List<BillItem>.from(state.activeBill.items);
      updatedItems[itemIndex] =
          updatedItems[itemIndex].copyWith(variant: event.variant);
      final updatedBill = state.activeBill.copyWith(items: updatedItems);
      _pushToHistory(updatedBill, emit);
    }
    emit(state.copyWith(
        pendingVariantProductId: null, availableVariants: null));
  }
}
