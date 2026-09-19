import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/features/billing/domain/models/bill.dart';
import 'package:zeno/features/billing/domain/models/payment.dart';

class PaymentDialog extends StatefulWidget {
  final Bill bill;
  final Function(Payment) onPaymentConfirmed;
  final PaymentMethod initialMethod;

  const PaymentDialog({
    super.key,
    required this.bill,
    required this.onPaymentConfirmed,
    this.initialMethod = PaymentMethod.cash,
  });

  @override
  State<PaymentDialog> createState() => _PaymentDialogState();
}

class _PaymentDialogState extends State<PaymentDialog> {
  late PaymentMethod _selectedMethod;
  final TextEditingController _amountController = TextEditingController();
  late double _balance;

  @override
  void initState() {
    super.initState();
    _selectedMethod = widget.initialMethod;
    final totalPaid = widget.bill.payments.fold(0.0, (sum, p) => sum + p.amount);
    _balance = widget.bill.grandTotal - totalPaid;
    _amountController.text = _balance > 0 ? _balance.toStringAsFixed(2) : '0.00';
  }

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  void _confirmPayment() {
    final amount = double.tryParse(_amountController.text);
    if (amount == null || amount <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Enter a valid payment amount.')));
      return;
    }
    if (amount > _balance && _selectedMethod != PaymentMethod.cash) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Payment cannot exceed the remaining balance for this method.')));
      return;
    }
    widget.onPaymentConfirmed(Payment(
      transactionId: 'TXN-${DateTime.now().millisecondsSinceEpoch}',
      method: _selectedMethod,
      amount: amount,
      timestamp: DateTime.now(),
      status: 'Completed',
    ));
    Navigator.pop(context);
  }

  void _cyclePaymentMethod(bool forward) {
    setState(() {
      const methods = [
        PaymentMethod.cash, PaymentMethod.card, PaymentMethod.upi,
        PaymentMethod.wallet, PaymentMethod.creditNote, PaymentMethod.bankTransfer,
      ];
      final i = methods.indexOf(_selectedMethod);
      _selectedMethod = methods[(i + (forward ? 1 : -1) + methods.length) % methods.length];
    });
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<ZenoSemanticColors>()!;
    return CallbackShortcuts(
      bindings: {
        const SingleActivator(LogicalKeyboardKey.escape): () => Navigator.pop(context),
        const SingleActivator(LogicalKeyboardKey.enter): _confirmPayment,
        const SingleActivator(LogicalKeyboardKey.arrowRight): () => _cyclePaymentMethod(true),
        const SingleActivator(LogicalKeyboardKey.arrowLeft): () => _cyclePaymentMethod(false),
      },
      child: FocusScope(
        autofocus: true,
        child: Dialog(
          backgroundColor: Colors.transparent,
          child: Container(
            width: 520,
            decoration: BoxDecoration(color: colors.bgTier2, borderRadius: BorderRadius.circular(ZenoRadius.lg), border: Border.all(color: colors.borderSubtle)),
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              _header(colors),
              Padding(
                padding: const EdgeInsets.all(ZenoSpacing.lg),
                child: Column(children: [
                  _amount(colors),
                  const SizedBox(height: ZenoSpacing.lg),
                  _methods(colors),
                  const SizedBox(height: ZenoSpacing.xl),
                  SizedBox(width: double.infinity, height: 50, child: ElevatedButton(
                    onPressed: _confirmPayment,
                    style: ElevatedButton.styleFrom(backgroundColor: colors.accentPrimary, foregroundColor: Colors.black),
                    child: const Text('CONFIRM PAYMENT [Enter]', style: TextStyle(fontWeight: FontWeight.w900, letterSpacing: 1)),
                  )),
                ]),
              ),
            ]),
          ),
        ),
      ),
    );
  }

  Widget _header(ZenoSemanticColors c) => Container(
    padding: const EdgeInsets.all(ZenoSpacing.md),
    decoration: BoxDecoration(color: c.bgTier3, borderRadius: const BorderRadius.vertical(top: Radius.circular(ZenoRadius.lg))),
    child: Row(children: [
      const Icon(Icons.payments_outlined, size: 20), const SizedBox(width: ZenoSpacing.md),
      Text('PROCESS PAYMENT', style: ZenoTypography.headlineMD(c.textPrimary)),
      const Spacer(), IconButton(onPressed: () => Navigator.pop(context), icon: const Icon(Icons.close, size: 18)),
    ]),
  );

  Widget _amount(ZenoSemanticColors c) => Container(
    padding: const EdgeInsets.all(ZenoSpacing.lg),
    decoration: BoxDecoration(color: c.bgTier1, borderRadius: BorderRadius.circular(ZenoRadius.md), border: Border.all(color: c.borderSubtle)),
    child: Column(children: [
      Text('REMAINING BALANCE', style: ZenoTypography.caption(c.textDisabled)),
      Text('₹${_balance.toStringAsFixed(2)}', style: TextStyle(fontSize: 32, fontWeight: FontWeight.w900, color: c.accentPrimary)),
      const SizedBox(height: 16),
      Container(
        width: 220, padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(color: c.bgTier2, borderRadius: BorderRadius.circular(ZenoRadius.md), border: Border.all(color: c.accentPrimary.withValues(alpha: .5))),
        child: TextField(controller: _amountController, autofocus: true, textAlign: TextAlign.center, keyboardType: const TextInputType.numberWithOptions(decimal: true), style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: c.textPrimary), decoration: const InputDecoration(border: InputBorder.none, prefixText: '₹ ')),
      ),
    ]),
  );

  Widget _methods(ZenoSemanticColors c) => Wrap(spacing: 10, runSpacing: 10, children: [
    _tile('CASH', Icons.money, PaymentMethod.cash, c),
    _tile('CARD', Icons.credit_card, PaymentMethod.card, c),
    _tile('UPI', Icons.qr_code, PaymentMethod.upi, c),
    _tile('WALLET', Icons.account_balance_wallet, PaymentMethod.wallet, c),
    _tile('CREDIT', Icons.credit_score, PaymentMethod.creditNote, c),
    _tile('BANK', Icons.account_balance, PaymentMethod.bankTransfer, c),
  ]);

  Widget _tile(String label, IconData icon, PaymentMethod method, ZenoSemanticColors c) => InkWell(
    onTap: () => setState(() => _selectedMethod = method),
    borderRadius: BorderRadius.circular(ZenoRadius.md),
    child: Container(
      width: 145, padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(color: _selectedMethod == method ? c.accentPrimary.withValues(alpha: .1) : c.bgTier3, borderRadius: BorderRadius.circular(ZenoRadius.md), border: Border.all(color: _selectedMethod == method ? c.accentPrimary : c.borderSubtle, width: _selectedMethod == method ? 2 : 1)),
      child: Column(children: [
        Icon(icon, color: _selectedMethod == method ? c.accentPrimary : c.textSecondary),
        const SizedBox(height: 5),
        Text(label, style: TextStyle(color: _selectedMethod == method ? c.textPrimary : c.textSecondary, fontWeight: FontWeight.bold, fontSize: 11)),
      ]),
    ),
  );
}
