import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zeno/features/billing/presentation/controllers/billing_studio_controller.dart';
import 'package:zeno/features/billing/presentation/controllers/billing_event.dart';
import 'package:zeno/features/billing/presentation/dialogs/payment_dialog.dart';

class BillingShortcuts extends StatelessWidget {
  final Widget child;
  final VoidCallback? onSearchFocus;
  final VoidCallback? onCustomerFocus;
  final VoidCallback? onDiscountFocus;

  const BillingShortcuts({
    super.key,
    required this.child,
    this.onSearchFocus,
    this.onCustomerFocus,
    this.onDiscountFocus,
  });

  @override
  Widget build(BuildContext context) {
    // CallbackShortcuts must be an ANCESTOR of the focused node: key events
    // travel from the primary focus node up through its ancestors only.
    return CallbackShortcuts(
      bindings: {
        const SingleActivator(LogicalKeyboardKey.f2): () {
          onSearchFocus?.call();
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Focus Quantity Edit (F2)'),
              duration: Duration(seconds: 1),
            ),
          );
        },
        const SingleActivator(LogicalKeyboardKey.f3): () =>
            onSearchFocus?.call(),
        const SingleActivator(LogicalKeyboardKey.keyF, control: true): () =>
            onSearchFocus?.call(),
        const SingleActivator(LogicalKeyboardKey.f4): () =>
            onCustomerFocus?.call(),
        const SingleActivator(LogicalKeyboardKey.f8): () {
          context.read<BillingStudioController>().add(BillHoldRequested());
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Cart Parked Successfully (F8)'),
              duration: Duration(seconds: 2),
            ),
          );
        },
        const SingleActivator(LogicalKeyboardKey.f9): () =>
            onDiscountFocus?.call(),
        const SingleActivator(LogicalKeyboardKey.f12): () =>
            _handlePayment(context),
        const SingleActivator(LogicalKeyboardKey.enter, control: true): () =>
            _handlePayment(context),
        const SingleActivator(LogicalKeyboardKey.keyP, control: true): () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Printing POS receipt...'),
              duration: Duration(seconds: 2),
            ),
          );
        },
        const SingleActivator(LogicalKeyboardKey.escape): () =>
            onSearchFocus?.call(),
      },
      child: Focus(
        autofocus: true,
        skipTraversal: true,
        child: child,
      ),
    );
  }

  void _handlePayment(BuildContext context) {
    final controller = context.read<BillingStudioController>();
    final bill = controller.state.activeBill;

    if (bill.items.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Cannot checkout with an empty cart'),
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }

    showDialog(
      context: context,
      builder: (dialogCtx) => PaymentDialog(
        bill: bill,
        onPaymentConfirmed: (payment) {
          controller.add(PaymentInitiated(payment));
        },
      ),
    );
  }
}
