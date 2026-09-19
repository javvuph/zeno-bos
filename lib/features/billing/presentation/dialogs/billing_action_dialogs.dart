import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:zeno/features/billing/domain/models/billing_customer.dart';
import 'package:zeno/features/billing/domain/models/discount_details.dart';
import 'package:zeno/features/billing/domain/models/payment.dart';
import 'package:zeno/features/billing/presentation/controllers/billing_event.dart';
import 'package:zeno/features/billing/presentation/controllers/billing_studio_controller.dart';
import 'package:zeno/features/billing/presentation/dialogs/payment_dialog.dart';

class BillingActionDialogs {
  static void addCustomer(BuildContext context) {
    final name = TextEditingController();
    final phone = TextEditingController();
    showDialog(
      context: context,
      builder: (d) => AlertDialog(
        title: const Text('ADD CUSTOMER'),
        content: SizedBox(
          width: 420,
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            TextField(controller: name, autofocus: true, decoration: const InputDecoration(labelText: 'Customer name')),
            const SizedBox(height: 12),
            TextField(controller: phone, keyboardType: TextInputType.phone, decoration: const InputDecoration(labelText: 'Phone number')),
          ]),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(d), child: const Text('CANCEL')),
          FilledButton(
            onPressed: () {
              final n = name.text.trim();
              final p = phone.text.trim();
              if (n.isEmpty || p.isEmpty) return;
              context.read<BillingStudioController>().add(
                CustomerSelected(BillingCustomer(id: 'LOCAL-$p', name: n, phone: p, loyaltyTier: 'Retail')),
              );
              Navigator.pop(d);
            },
            child: const Text('USE CUSTOMER'),
          ),
        ],
      ),
    );
  }

  static void loyalty(BuildContext context) => _info(context, 'LOYALTY PROGRAM', 'Select a customer first to work with loyalty information. The current billing model can carry the customer context and loyalty tier.');

  static void wallet(BuildContext context) => _info(context, 'CUSTOMER WALLET', 'Select a customer first. Wallet payment can be processed through the payment flow once a wallet balance is available.');

  static void scanner(BuildContext context) {
    showDialog(
      context: context,
      builder: (d) => Dialog(
        child: SizedBox(
          width: 520,
          height: 520,
          child: Column(children: [
            AppBar(title: const Text('SCAN BARCODE'), automaticallyImplyLeading: false,
              actions: [IconButton(onPressed: () => Navigator.pop(d), icon: const Icon(Icons.close))]),
            Expanded(child: MobileScanner(onDetect: (capture) {
              if (capture.barcodes.isEmpty) return;
              final value = capture.barcodes.first.rawValue;
              if (value == null || value.trim().isEmpty) return;
              context.read<BillingStudioController>().add(AddItemRequested(value.trim()));
              Navigator.pop(d);
            })),
          ]),
        ),
      ),
    );
  }

  static void calculator(BuildContext context) {
    final controller = TextEditingController();
    showDialog(
      context: context,
      builder: (d) => AlertDialog(
        title: const Text('CALCULATOR'),
        content: TextField(controller: controller, autofocus: true, keyboardType: const TextInputType.numberWithOptions(decimal: true), decoration: const InputDecoration(hintText: 'Enter amount')),
        actions: [
          TextButton(onPressed: () => controller.clear(), child: const Text('CLEAR')),
          FilledButton(onPressed: () => Navigator.pop(d), child: const Text('DONE')),
        ],
      ),
    );
  }

  static void discount(BuildContext context) {
    final value = TextEditingController();
    showDialog(
      context: context,
      builder: (d) => AlertDialog(
        title: const Text('APPLY DISCOUNT'),
        content: TextField(controller: value, autofocus: true, keyboardType: const TextInputType.numberWithOptions(decimal: true), decoration: const InputDecoration(labelText: 'Discount %', suffixText: '%')),
        actions: [
          TextButton(onPressed: () => Navigator.pop(d), child: const Text('CANCEL')),
          FilledButton(
            onPressed: () {
              final pct = double.tryParse(value.text);
              final state = context.read<BillingStudioController>().state;
              if (pct == null || pct < 0 || pct > 100 || state.activeBill.items.isEmpty) return;
              for (final item in state.activeBill.items) {
                context.read<BillingStudioController>().add(UpdateItemDiscountRequested(item.productId, [
                  DiscountDetails(label: 'Bill discount', value: pct, isPercentage: true, calculatedAmount: 0),
                ]));
              }
              Navigator.pop(d);
            },
            child: const Text('APPLY'),
          ),
        ],
      ),
    );
  }

  static void printReceipt(BuildContext context) {
    final bill = context.read<BillingStudioController>().state.activeBill;
    showDialog(
      context: context,
      builder: (d) => AlertDialog(
        title: const Text('RECEIPT PREVIEW'),
        content: SizedBox(width: 420, child: SingleChildScrollView(child: Text(_receiptText(bill), style: const TextStyle(fontFamily: 'monospace', fontSize: 12)))),
        actions: [
          TextButton(onPressed: () => Navigator.pop(d), child: const Text('CLOSE')),
          FilledButton(onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Receipt prepared. Connect a configured thermal printer to send it to hardware.')));
            Navigator.pop(d);
          }, child: const Text('PRINT')),
        ],
      ),
    );
  }

  static void drawer(BuildContext context) => _info(context, 'CASH DRAWER', 'The command control is ready. A compatible printer/cash drawer must be configured before a hardware pulse can be sent.');

  static void payment(BuildContext context, PaymentMethod method) {
    final bill = context.read<BillingStudioController>().state.activeBill;
    if (bill.items.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Add at least one item before payment.')));
      return;
    }
    showDialog(
      context: context,
      builder: (_) => PaymentDialog(
        bill: bill,
        initialMethod: method,
        onPaymentConfirmed: (payment) => context.read<BillingStudioController>().add(PaymentInitiated(payment)),
      ),
    );
  }

  static void _info(BuildContext context, String title, String message) {
    showDialog(context: context, builder: (d) => AlertDialog(title: Text(title), content: Text(message), actions: [TextButton(onPressed: () => Navigator.pop(d), child: const Text('CLOSE'))]));
  }

  static String _receiptText(dynamic b) {
    final lines = <String>[
      'ZENO BOS', '--------------------------------', 'BILL: ${b.id}', 'DATE: ${b.timestamp}',
      if (b.customer != null) 'CUSTOMER: ${b.customer.name}',
      '--------------------------------',
      ...b.items.map<String>((i) => '${i.productName} x${i.quantity}  ${i.totalAmount.toStringAsFixed(2)}'),
      '--------------------------------',
      'SUBTOTAL: ${b.subtotal.toStringAsFixed(2)}',
      'DISCOUNT: ${b.totalDiscount.toStringAsFixed(2)}',
      'TAX: ${b.totalTax.toStringAsFixed(2)}',
      'TOTAL: ${b.grandTotal.toStringAsFixed(2)}',
    ];
    return lines.join('\n');
  }
}
