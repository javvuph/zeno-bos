import 'package:equatable/equatable.dart';
import 'package:zeno/features/billing/domain/models/billing_customer.dart';
import 'package:zeno/features/billing/domain/models/discount_details.dart';
import 'package:zeno/features/billing/domain/models/payment.dart';

abstract class BillingEvent extends Equatable {
  const BillingEvent();

  @override
  List<Object?> get props => [];
}

class AddItemRequested extends BillingEvent {
  final String barcode;
  const AddItemRequested(this.barcode);
  @override
  List<Object?> get props => [barcode];
}

class RemoveItemRequested extends BillingEvent {
  final String productId;
  const RemoveItemRequested(this.productId);
  @override
  List<Object?> get props => [productId];
}

class UpdateItemQuantityRequested extends BillingEvent {
  final String productId;
  final int newQuantity;
  const UpdateItemQuantityRequested(this.productId, this.newQuantity);
  @override
  List<Object?> get props => [productId, newQuantity];
}

class UpdateItemDiscountRequested extends BillingEvent {
  final String productId;
  final List<DiscountDetails> discounts;
  const UpdateItemDiscountRequested(this.productId, this.discounts);
  @override
  List<Object?> get props => [productId, discounts];
}

class ClearCartRequested extends BillingEvent {}

class CustomerSelected extends BillingEvent {
  final BillingCustomer customer;
  const CustomerSelected(this.customer);
  @override
  List<Object?> get props => [customer];
}

class SearchCustomerRequested extends BillingEvent {
  final String query;
  const SearchCustomerRequested(this.query);
  @override
  List<Object?> get props => [query];
}

class PaymentInitiated extends BillingEvent {
  final Payment payment;
  const PaymentInitiated(this.payment);
  @override
  List<Object?> get props => [payment];
}

class BillHoldRequested extends BillingEvent {}

class BillRecallRequested extends BillingEvent {
  final String billId;
  const BillRecallRequested(this.billId);
  @override
  List<Object?> get props => [billId];
}

class BillCompleteRequested extends BillingEvent {}

// Phase 6: Production Readiness
class UndoRequested extends BillingEvent {}

class RedoRequested extends BillingEvent {}

class LockBillRequested extends BillingEvent {
  final bool lock;
  const LockBillRequested(this.lock);
  @override
  List<Object?> get props => [lock];
}

class PriceOverrideRequested extends BillingEvent {
  final String productId;
  final double newPrice;
  const PriceOverrideRequested(this.productId, this.newPrice);
  @override
  List<Object?> get props => [productId, newPrice];
}

class UpdateItemTrackingRequested extends BillingEvent {
  final String productId;
  final String? serialNumber;
  final String? batchNumber;
  final DateTime? expiryDate;
  const UpdateItemTrackingRequested(this.productId,
      {this.serialNumber, this.batchNumber, this.expiryDate});
  @override
  List<Object?> get props => [productId, serialNumber, batchNumber, expiryDate];
}

class AddLineNoteRequested extends BillingEvent {
  final String productId;
  final String note;
  const AddLineNoteRequested(this.productId, this.note);
  @override
  List<Object?> get props => [productId, note];
}

class ToggleReturnModeRequested extends BillingEvent {}

class VariantSelectionRequested extends BillingEvent {
  final String productId;
  final List<String> availableVariants;
  const VariantSelectionRequested(this.productId, this.availableVariants);
  @override
  List<Object?> get props => [productId, availableVariants];
}

class VariantSelected extends BillingEvent {
  final String productId;
  final String variant;
  const VariantSelected(this.productId, this.variant);
  @override
  List<Object?> get props => [productId, variant];
}
