part of '../billing_studio_controller.dart';

extension BillingStudioControllerHandlers on BillingStudioController {
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
}
