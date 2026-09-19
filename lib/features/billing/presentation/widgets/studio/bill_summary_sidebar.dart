import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zeno/features/billing/domain/models/payment.dart';
import 'package:zeno/features/billing/presentation/controllers/billing_event.dart';
import 'package:zeno/features/billing/presentation/controllers/billing_studio_controller.dart';
import 'package:zeno/features/billing/presentation/controllers/billing_state.dart';
import 'package:zeno/features/billing/presentation/dialogs/billing_action_dialogs.dart';

class BillSummarySidebar extends StatelessWidget {
  const BillSummarySidebar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BillingStudioController, BillingState>(
      builder: (context, state) {
        final bill = state.activeBill;
        return Container(
          width: 260,
          decoration: const BoxDecoration(color: Colors.white, border: Border(left: BorderSide(color: Color(0xFFF1F5F9)))),
          child: Column(children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(14, 10, 14, 4),
              child: Align(alignment: Alignment.centerLeft, child: Text('BILL SUMMARY', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w900, color: Color(0xFF1E293B), letterSpacing: 1))),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
              child: Column(children: [
                _RowItem(label: 'Sub Total', value: '₹${bill.subtotal.toStringAsFixed(2)}'),
                const SizedBox(height: 4),
                _RowItem(label: 'Discount', value: '-₹${bill.totalDiscount.toStringAsFixed(2)}', valueColor: const Color(0xFF10B981)),
                const SizedBox(height: 4),
                _RowItem(label: 'Tax', value: '₹${bill.totalTax.toStringAsFixed(2)}'),
              ]),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 2),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              decoration: const BoxDecoration(border: Border.symmetric(horizontal: BorderSide(color: Color(0xFF1E293B), width: 1.5))),
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                const Text('Total', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400, color: Color(0xFF1E293B))),
                Text('₹${bill.grandTotal.toStringAsFixed(2)}', style: const TextStyle(fontSize: 30, fontWeight: FontWeight.w600, color: Color(0xFF6366F1), letterSpacing: -1)),
              ]),
            ),
            Padding(padding: const EdgeInsets.fromLTRB(12, 6, 12, 8), child: SizedBox(
              width: double.infinity, height: 48,
              child: ElevatedButton.icon(
                onPressed: () => BillingActionDialogs.payment(context, PaymentMethod.cash),
                icon: const Icon(Icons.point_of_sale, size: 18),
                label: const Text('CHECKOUT  [F12]', style: TextStyle(fontWeight: FontWeight.w900, letterSpacing: 1)),
                style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF6366F1), foregroundColor: Colors.white),
              ),
            )),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 14, vertical: 4),
              child: Align(alignment: Alignment.centerLeft, child: Text('PAYMENT OPTIONS', style: TextStyle(fontSize: 8, fontWeight: FontWeight.w900, color: Colors.grey, letterSpacing: 1))),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: GridView.count(
                shrinkWrap: true, crossAxisCount: 3, mainAxisSpacing: 6, crossAxisSpacing: 6, childAspectRatio: .95, physics: const NeverScrollableScrollPhysics(),
                children: [
                  _PaymentBtn(icon: Icons.payments, label: 'Cash', hint: 'F1', color: const Color(0xFF10B981), onTap: () => BillingActionDialogs.payment(context, PaymentMethod.cash)),
                  _PaymentBtn(icon: Icons.credit_card, label: 'Card', hint: 'F2', color: const Color(0xFF3B82F6), onTap: () => BillingActionDialogs.payment(context, PaymentMethod.card)),
                  _PaymentBtn(icon: Icons.qr_code, label: 'UPI', hint: 'F3', color: const Color(0xFFF59E0B), onTap: () => BillingActionDialogs.payment(context, PaymentMethod.upi)),
                  _PaymentBtn(icon: Icons.account_balance_wallet, label: 'Wallet', hint: 'F4', color: const Color(0xFFF97316), onTap: () => BillingActionDialogs.payment(context, PaymentMethod.wallet)),
                  _PaymentBtn(icon: Icons.credit_score, label: 'Credit', hint: 'F5', color: const Color(0xFF06B6D4), onTap: () => BillingActionDialogs.payment(context, PaymentMethod.creditNote)),
                  _PaymentBtn(icon: Icons.account_balance, label: 'Bank', hint: 'F6', color: const Color(0xFF8B5CF6), onTap: () => BillingActionDialogs.payment(context, PaymentMethod.bankTransfer)),
                ],
              ),
            ),
            const Spacer(),
          ]),
        );
      },
    );
  }
}

class _RowItem extends StatelessWidget {
  final String label; final String value; final Color? valueColor;
  const _RowItem({required this.label, required this.value, this.valueColor});
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Text(label, style: const TextStyle(fontSize: 14, color: Color(0xFF64748B))),
      Text(value, style: TextStyle(fontSize: 15, color: valueColor ?? const Color(0xFF1E293B), fontWeight: FontWeight.w600)),
    ]),
  );
}

class _PaymentBtn extends StatelessWidget {
  final IconData icon; final String label; final String hint; final Color color; final VoidCallback onTap;
  const _PaymentBtn({required this.icon, required this.label, required this.hint, required this.color, required this.onTap});
  @override
  Widget build(BuildContext context) => InkWell(
    onTap: onTap,
    borderRadius: BorderRadius.circular(10),
    child: Container(
      decoration: BoxDecoration(color: const Color(0xFFF8FAFC), borderRadius: BorderRadius.circular(10), border: Border.all(color: const Color(0xFFE2E8F0))),
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Icon(icon, size: 20, color: color), const SizedBox(height: 4),
        Text(label, style: const TextStyle(fontSize: 9, fontWeight: FontWeight.w600, color: Color(0xFF1E293B))),
        Text(hint, style: const TextStyle(fontSize: 8, color: Color(0xFF94A3B8))),
      ]),
    ),
  );
}
