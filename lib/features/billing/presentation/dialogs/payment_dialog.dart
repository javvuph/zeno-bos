import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/features/billing/domain/models/bill.dart';
import 'package:zeno/features/billing/domain/models/payment.dart';

class PaymentDialog extends StatefulWidget {
  final Bill bill;
  final Function(Payment) onPaymentConfirmed;

  const PaymentDialog({
    super.key,
    required this.bill,
    required this.onPaymentConfirmed,
  });

  @override
  State<PaymentDialog> createState() => _PaymentDialogState();
}

class _PaymentDialogState extends State<PaymentDialog> {
  PaymentMethod _selectedMethod = PaymentMethod.cash;
  final TextEditingController _amountController = TextEditingController();

  late double _balance;

  @override
  void initState() {
    super.initState();
    final totalPaid =
        widget.bill.payments.fold(0.0, (sum, p) => sum + p.amount);
    _balance = widget.bill.grandTotal - totalPaid;
    _amountController.text = _balance.toStringAsFixed(2);
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<ZenoSemanticColors>()!;

    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        width: 500,
        decoration: BoxDecoration(
          color: colors.bgTier2,
          borderRadius: BorderRadius.circular(ZenoRadius.lg),
          border: Border.all(color: colors.borderSubtle),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildHeader(colors),
            Padding(
              padding: const EdgeInsets.all(ZenoSpacing.lg),
              child: Column(
                children: [
                  _buildAmountDisplay(colors),
                  const SizedBox(height: ZenoSpacing.lg),
                  _buildPaymentMethods(colors),
                  const SizedBox(height: ZenoSpacing.xl),
                  _buildActionButtons(colors),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(ZenoSemanticColors colors) {
    return Container(
      padding: const EdgeInsets.all(ZenoSpacing.md),
      decoration: BoxDecoration(
        color: colors.bgTier3,
        borderRadius:
            const BorderRadius.vertical(top: Radius.circular(ZenoRadius.lg)),
      ),
      child: Row(
        children: [
          const Icon(Icons.payments_outlined, size: 20),
          const SizedBox(width: ZenoSpacing.md),
          Text(
            'PROCESS PAYMENT',
            style: ZenoTypography.headlineMD(colors.textPrimary),
          ),
          const Spacer(),
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.close, size: 18),
          ),
        ],
      ),
    );
  }

  Widget _buildAmountDisplay(ZenoSemanticColors colors) {
    return Container(
      padding: const EdgeInsets.all(ZenoSpacing.lg),
      decoration: BoxDecoration(
        color: colors.bgTier1,
        borderRadius: BorderRadius.circular(ZenoRadius.md),
        border: Border.all(color: colors.borderSubtle),
      ),
      child: Column(
        children: [
          Text(
            'REMAINING BALANCE',
            style: ZenoTypography.caption(colors.textDisabled),
          ),
          Text(
            '\$${_balance.toStringAsFixed(2)}',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.w900,
              color: colors.accentPrimary,
            ),
          ),
          const SizedBox(height: 16),
          _buildAmountInput(colors),
        ],
      ),
    );
  }

  Widget _buildAmountInput(ZenoSemanticColors colors) {
    return Container(
      width: 200,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: colors.bgTier2,
        borderRadius: BorderRadius.circular(ZenoRadius.md),
        border: Border.all(color: colors.accentPrimary.withValues(alpha: 0.5)),
      ),
      child: TextField(
        controller: _amountController,
        textAlign: TextAlign.center,
        style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: colors.textPrimary),
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        decoration: const InputDecoration(
          border: InputBorder.none,
          prefixText: '\$',
        ),
      ),
    );
  }

  Widget _buildPaymentMethods(ZenoSemanticColors colors) {
    return Wrap(
      spacing: ZenoSpacing.md,
      runSpacing: ZenoSpacing.md,
      children: [
        _MethodTile(
          label: 'CASH',
          icon: Icons.money,
          isSelected: _selectedMethod == PaymentMethod.cash,
          onTap: () => setState(() => _selectedMethod = PaymentMethod.cash),
          colors: colors,
        ),
        _MethodTile(
          label: 'CARD',
          icon: Icons.credit_card,
          isSelected: _selectedMethod == PaymentMethod.card,
          onTap: () => setState(() => _selectedMethod = PaymentMethod.card),
          colors: colors,
        ),
        _MethodTile(
          label: 'UPI',
          icon: Icons.qr_code,
          isSelected: _selectedMethod == PaymentMethod.upi,
          onTap: () => setState(() => _selectedMethod = PaymentMethod.upi),
          colors: colors,
        ),
      ],
    );
  }

  Widget _buildActionButtons(ZenoSemanticColors colors) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: () {
          final payment = Payment(
            transactionId: 'TXN-${DateTime.now().millisecondsSinceEpoch}',
            method: _selectedMethod,
            amount: double.tryParse(_amountController.text) ??
                widget.bill.grandTotal,
            timestamp: DateTime.now(),
            status: 'Completed',
          );
          widget.onPaymentConfirmed(payment);
          Navigator.pop(context);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: colors.accentPrimary,
          foregroundColor: Colors.black,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(ZenoRadius.md)),
        ),
        child: const Text(
          'CONFIRM PAYMENT',
          style: TextStyle(fontWeight: FontWeight.w900, letterSpacing: 1.0),
        ),
      ),
    );
  }
}

class _MethodTile extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;
  final ZenoSemanticColors colors;

  const _MethodTile({
    required this.label,
    required this.icon,
    required this.isSelected,
    required this.onTap,
    required this.colors,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(ZenoRadius.md),
      child: Container(
        width: 130,
        padding: const EdgeInsets.symmetric(vertical: ZenoSpacing.md),
        decoration: BoxDecoration(
          color: isSelected
              ? colors.accentPrimary.withValues(alpha: 0.1)
              : colors.bgTier3,
          borderRadius: BorderRadius.circular(ZenoRadius.md),
          border: Border.all(
            color: isSelected ? colors.accentPrimary : colors.borderSubtle,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Column(
          children: [
            Icon(icon,
                color:
                    isSelected ? colors.accentPrimary : colors.textSecondary),
            const SizedBox(height: ZenoSpacing.sm),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? colors.textPrimary : colors.textSecondary,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
