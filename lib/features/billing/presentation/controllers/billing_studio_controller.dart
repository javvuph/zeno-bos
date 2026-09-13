import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/models/bill.dart';
import '../../domain/models/bill_item.dart';
import '../../domain/models/payment.dart';
import '../../domain/services/billing_math_engine.dart';
import '../../domain/repositories/i_billing_repository.dart';
import 'billing_event.dart';
import 'billing_state.dart';

/// Orchestrator for the Billing Studio.
/// Implements the enterprise business logic for high-speed POS operations.
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

    // Phase 6: Production Readiness
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

  Future<void> _onAddItemRequested(
      AddItemRequested event, Emitter<BillingState> emit) async {
    if (!_isBillModifiable()) return;

    emit(state.copyWith(status: BillingStatus.loading));

    final product = await _repository.findProduct(event.barcode);

    if (product == null) {
      emit(state.copyWith(
          status: BillingStatus.active,
          errorMessage: 'Product not found: ${event.barcode}'));
      return;
    }

    final int qtyMultiplier = state.activeBill.status == 'Return' ? -1 : 1;
    final String productId = product.productId;
    final existingIndex =
        state.activeBill.items.indexWhere((i) => i.productId == productId);

    List<BillItem> updatedItems;
    if (existingIndex != -1) {
      updatedItems = List<BillItem>.from(state.activeBill.items);
      final existingItem = updatedItems[existingIndex];
      updatedItems[existingIndex] = existingItem.copyWith(
          quantity: existingItem.quantity + qtyMultiplier);
    } else {
      updatedItems = List<BillItem>.from(state.activeBill.items)
        ..add(product.copyWith(quantity: qtyMultiplier));
    }

    final updatedBill = state.activeBill.copyWith(items: updatedItems);
    final recalculatedBill = BillingMathEngine.calculateBillTotals(updatedBill);

    _pushToHistory(recalculatedBill, emit);
    
    // Fashion Logic: If product name contains 'Shirt' (mock), request variant
    if (product.productName.contains('Shirt') && product.variant.contains('/')) {
      add(VariantSelectionRequested(product.productId, ['Red / S', 'Blue / M', 'Black / L']));
    }
    
    emit(state.copyWith(status: BillingStatus.active));
  }

  Future<void> _onRemoveItemRequested(
      RemoveItemRequested event, Emitter<BillingState> emit) async {
    if (!_isBillModifiable()) return;

    final updatedItems = state.activeBill.items
        .where((i) => i.productId != event.productId)
        .toList();
    final updatedBill = state.activeBill.copyWith(items: updatedItems);
    final recalculatedBill = BillingMathEngine.calculateBillTotals(updatedBill);

    _pushToHistory(recalculatedBill, emit);
  }

  Future<void> _onUpdateItemQuantityRequested(
      UpdateItemQuantityRequested event, Emitter<BillingState> emit) async {
    if (!_isBillModifiable()) return;

    if (event.newQuantity <= 0) {
      add(RemoveItemRequested(event.productId));
      return;
    }

    final updatedItems = state.activeBill.items.map((item) {
      if (item.productId == event.productId) {
        return item.copyWith(quantity: event.newQuantity);
      }
      return item;
    }).toList();

    final updatedBill = state.activeBill.copyWith(items: updatedItems);
    final recalculatedBill = BillingMathEngine.calculateBillTotals(updatedBill);

    _pushToHistory(recalculatedBill, emit);
  }

  Future<void> _onPriceOverrideRequested(
      PriceOverrideRequested event, Emitter<BillingState> emit) async {
    if (!_isBillModifiable()) return;

    final updatedItems = state.activeBill.items.map((item) {
      if (item.productId == event.productId) {
        return item.copyWith(
          unitPrice: event.newPrice,
          originalPrice: item.originalPrice ?? item.unitPrice,
        );
      }
      return item;
    }).toList();

    final auditTrail = List<String>.from(state.activeBill.auditTrail)
      ..add(
          'PRICE OVERRIDE: ${event.productId} set to ${event.newPrice} by Manager');

    final updatedBill =
        state.activeBill.copyWith(items: updatedItems, auditTrail: auditTrail);
    final recalculatedBill = BillingMathEngine.calculateBillTotals(updatedBill);

    _pushToHistory(recalculatedBill, emit);
  }

  Future<void> _onUpdateItemTrackingRequested(
      UpdateItemTrackingRequested event, Emitter<BillingState> emit) async {
    if (!_isBillModifiable()) return;

    final updatedItems = state.activeBill.items.map((item) {
      if (item.productId == event.productId) {
        return item.copyWith(
          serialNumber: event.serialNumber ?? item.serialNumber,
          batchNumber: event.batchNumber ?? item.batchNumber,
          expiryDate: event.expiryDate ?? item.expiryDate,
        );
      }
      return item;
    }).toList();

    final updatedBill = state.activeBill.copyWith(items: updatedItems);
    _pushToHistory(updatedBill, emit);
  }

  Future<void> _onAddLineNoteRequested(
      AddLineNoteRequested event, Emitter<BillingState> emit) async {
    if (!_isBillModifiable()) return;

    final updatedItems = state.activeBill.items.map((item) {
      if (item.productId == event.productId) {
        return item.copyWith(notes: event.note);
      }
      return item;
    }).toList();

    final updatedBill = state.activeBill.copyWith(items: updatedItems);
    _pushToHistory(updatedBill, emit);
  }

  Future<void> _onUpdateItemDiscountRequested(
      UpdateItemDiscountRequested event, Emitter<BillingState> emit) async {
    if (!_isBillModifiable()) return;

    final updatedItems = state.activeBill.items.map((item) {
      if (item.productId == event.productId) {
        return item.copyWith(discounts: event.discounts);
      }
      return item;
    }).toList();

    final updatedBill = state.activeBill.copyWith(items: updatedItems);
    final recalculatedBill = BillingMathEngine.calculateBillTotals(updatedBill);

    _pushToHistory(recalculatedBill, emit);
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
    if (state.activeBill.isLocked) return;

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
