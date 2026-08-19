import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zeno/features/billing/presentation/controllers/billing_studio_controller.dart';
import 'package:zeno/features/billing/presentation/controllers/billing_event.dart';

class BillingShortcuts extends StatelessWidget {
  final Widget child;
  final VoidCallback? onSearchFocus;
  final VoidCallback? onPaymentInitiated;
  final VoidCallback? onCustomerSearch;

  const BillingShortcuts({
    super.key,
    required this.child,
    this.onSearchFocus,
    this.onPaymentInitiated,
    this.onCustomerSearch,
  });

  @override
  Widget build(BuildContext context) {
    return Shortcuts(
      shortcuts: <LogicalKeySet, Intent>{
        LogicalKeySet(LogicalKeyboardKey.f2): const CustomerSearchIntent(),
        LogicalKeySet(LogicalKeyboardKey.f4): const HoldBillIntent(),
        LogicalKeySet(LogicalKeyboardKey.f6): const RecallBillIntent(),
        LogicalKeySet(LogicalKeyboardKey.f10): const CashPaymentIntent(),
        LogicalKeySet(LogicalKeyboardKey.f11): const CardPaymentIntent(),
        LogicalKeySet(LogicalKeyboardKey.escape): const ExitIntent(),
        LogicalKeySet(LogicalKeyboardKey.control, LogicalKeyboardKey.keyF):
            const GlobalSearchIntent(),
        LogicalKeySet(LogicalKeyboardKey.control, LogicalKeyboardKey.keyS):
            const SaveIntent(),
      },
      child: Actions(
        actions: <Type, Action<Intent>>{
          CustomerSearchIntent: CallbackAction<CustomerSearchIntent>(
            onInvoke: (intent) => onCustomerSearch?.call(),
          ),
          HoldBillIntent: CallbackAction<HoldBillIntent>(
            onInvoke: (intent) => context
                .read<BillingStudioController>()
                .add(BillHoldRequested()),
          ),
          RecallBillIntent: CallbackAction<RecallBillIntent>(
            onInvoke: (intent) => _handleRecallBill(context),
          ),
          CashPaymentIntent: CallbackAction<CashPaymentIntent>(
            onInvoke: (intent) => onPaymentInitiated?.call(),
          ),
          CardPaymentIntent: CallbackAction<CardPaymentIntent>(
            onInvoke: (intent) => onPaymentInitiated?.call(),
          ),
          ExitIntent: CallbackAction<ExitIntent>(
            onInvoke: (intent) => context
                .read<BillingStudioController>()
                .add(ClearCartRequested()),
          ),
          GlobalSearchIntent: CallbackAction<GlobalSearchIntent>(
            onInvoke: (intent) => onSearchFocus?.call(),
          ),
          SaveIntent: CallbackAction<SaveIntent>(
            onInvoke: (intent) => context
                .read<BillingStudioController>()
                .add(BillCompleteRequested()),
          ),
        },
        child: Focus(
          autofocus: true,
          child: child,
        ),
      ),
    );
  }

  void _handleRecallBill(BuildContext context) {
    final state = context.read<BillingStudioController>().state;
    if (state.heldBills.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No held bills available')),
      );
      return;
    }
    // This could also be a callback to show the dialog
  }
}

class CustomerSearchIntent extends Intent {
  const CustomerSearchIntent();
}

class HoldBillIntent extends Intent {
  const HoldBillIntent();
}

class RecallBillIntent extends Intent {
  const RecallBillIntent();
}

class CashPaymentIntent extends Intent {
  const CashPaymentIntent();
}

class CardPaymentIntent extends Intent {
  const CardPaymentIntent();
}

class ExitIntent extends Intent {
  const ExitIntent();
}

class GlobalSearchIntent extends Intent {
  const GlobalSearchIntent();
}

class SaveIntent extends Intent {
  const SaveIntent();
}
