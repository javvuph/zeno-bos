import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zeno/features/billing/presentation/controllers/billing_studio_controller.dart';
import 'package:zeno/features/billing/presentation/controllers/billing_state.dart';

class BillSummarySidebar extends StatelessWidget {
  const BillSummarySidebar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BillingStudioController, BillingState>(
      builder: (context, state) {
        final bill = state.activeBill;

        return Container(
          width: 260,
          decoration: const BoxDecoration(
            color: Colors.white,
            border: Border(left: BorderSide(color: Color(0xFFF1F5F9))),
          ),
          child: Column(
            children: [
              // --- 0. SECTION HEADER (BILL SUMMARY) ---
              const Padding(
                padding: EdgeInsets.fromLTRB(14, 10, 14, 4), // Compressed top
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text("BILL SUMMARY",
                      style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w900,
                          color: Color(0xFF1E293B),
                          letterSpacing: 1.0)),
                ),
              ),

              // --- 1. SUBTOTAL DETAILS ---
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 14, vertical: 4), // Compressed
                child: Column(
                  children: [
                    _RowItem(
                        label: "Sub Total",
                        value: "₹${bill.subtotal.toStringAsFixed(0)}"),
                    const SizedBox(height: 4),
                    _RowItem(
                        label: "Discount",
                        value: "-₹${bill.totalDiscount.toStringAsFixed(0)}",
                        valueColor: const Color(0xFF10B981)),
                    const SizedBox(height: 4),
                    _RowItem(
                        label: "Tax (5%)",
                        value: "₹${bill.totalTax.toStringAsFixed(0)}"),
                  ],
                ),
              ),

              // --- 2. TOTAL ROW (LOCKED & ALIGNED) ---
              Container(
                margin: const EdgeInsets.symmetric(vertical: 2),
                padding: const EdgeInsets.symmetric(
                    horizontal: 14, vertical: 10), // Compressed
                decoration: const BoxDecoration(
                  border: Border.symmetric(
                    horizontal:
                        BorderSide(color: Color(0xFF1E293B), width: 1.5),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Total",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF1E293B))),
                    Text(
                      "₹${bill.grandTotal.toStringAsFixed(0)}",
                      style: const TextStyle(
                          fontSize: 38,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF6366F1),
                          letterSpacing: -1.0),
                    ),
                  ],
                ),
              ),

              // --- 3. CHECKOUT ACTION (NOW DIRECTLY BELOW TOTAL) ---
              Padding(
                padding: const EdgeInsets.fromLTRB(12, 6, 12, 8), // Tightened
                child: _CheckoutAction(),
              ),

              // --- 4. PAYMENTS GRID (MOVED TO BOTTOM) ---
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 14, vertical: 4),
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text("PAYMENT OPTIONS",
                        style: TextStyle(
                            fontSize: 8,
                            fontWeight: FontWeight.w900,
                            color: Colors.grey,
                            letterSpacing: 1.0))),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: GridView.count(
                  shrinkWrap: true,
                  crossAxisCount: 3,
                  mainAxisSpacing: 6,
                  crossAxisSpacing: 6,
                  childAspectRatio: 0.95,
                  physics: const NeverScrollableScrollPhysics(),
                  children: const [
                    _PaymentBtn(
                        icon: Icons.payments,
                        label: "Cash",
                        hint: "F1",
                        color: Color(0xFF10B981)),
                    _PaymentBtn(
                        icon: Icons.credit_card,
                        label: "Card",
                        hint: "F2",
                        color: Color(0xFF3B82F6)),
                    _PaymentBtn(
                        icon: Icons.qr_code,
                        label: "UPI",
                        hint: "F3",
                        color: Color(0xFFF59E0B)),
                    _PaymentBtn(
                        icon: Icons.account_balance_wallet,
                        label: "Wallet",
                        hint: "F4",
                        color: Color(0xFFF97316)),
                    _PaymentBtn(
                        icon: Icons.card_giftcard,
                        label: "Gift",
                        hint: "F5",
                        color: Color(0xFFEF4444)),
                    _PaymentBtn(
                        icon: Icons.store,
                        label: "Credit",
                        hint: "F6",
                        color: Color(0xFF06B6D4)),
                  ],
                ),
              ),

              const Spacer(), // REMOVES BOTTOM DEAD SPACE BY FILLING
            ],
          ),
        );
      },
    );
  }
}

class _RowItem extends StatelessWidget {
  final String label;
  final String value;
  final Color? valueColor;

  const _RowItem({required this.label, required this.value, this.valueColor});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: const TextStyle(
                  fontSize: 16,
                  color: Color(0xFF64748B),
                  fontWeight: FontWeight.w400)),
          Text(value,
              style: TextStyle(
                  fontSize: 18,
                  color: valueColor ?? const Color(0xFF1E293B),
                  fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }
}

class _PaymentBtn extends StatelessWidget {
  final IconData icon;
  final String label;
  final String hint;
  final Color color;

  const _PaymentBtn(
      {required this.icon,
      required this.label,
      required this.hint,
      required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 20, color: color),
          const SizedBox(height: 4),
          Text(label,
              style: const TextStyle(
                  fontSize: 9,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF1E293B))),
          Text(hint,
              style: const TextStyle(fontSize: 8, color: Color(0xFF94A3B8))),
        ],
      ),
    );
  }
}

class _CheckoutAction extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 48,
      decoration: BoxDecoration(
        color: const Color(0xFF6366F1),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
              color: const Color(0xFF6366F1).withValues(alpha: 0.2),
              blurRadius: 10,
              offset: const Offset(0, 4)),
        ],
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("CHECKOUT",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 1.0,
                  fontSize: 13)),
          SizedBox(width: 12),
          _HintBadge(label: "F12"),
        ],
      ),
    );
  }
}

class _HintBadge extends StatelessWidget {
  final String label;
  const _HintBadge({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.15),
          borderRadius: BorderRadius.circular(4)),
      child: Text(label,
          style: const TextStyle(
              color: Colors.white, fontSize: 9, fontWeight: FontWeight.bold)),
    );
  }
}
