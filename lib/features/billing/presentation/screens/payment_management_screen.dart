import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/core/widgets/zeno_header.dart';
import 'package:zeno/core/widgets/zeno_table.dart';
import 'package:zeno/core/widgets/zeno_badge.dart';

class PaymentTransaction {
  final String id;
  final String method;
  final String invoiceId;
  final double amount;
  final String status;

  PaymentTransaction(
      {required this.id,
      required this.method,
      required this.invoiceId,
      required this.amount,
      required this.status});
}

class PaymentManagementScreen extends StatelessWidget {
  const PaymentManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<PaymentTransaction> _payments = [
      PaymentTransaction(
          id: "PAY-001",
          method: "Cash",
          invoiceId: "INV-8821",
          amount: 45.50,
          status: "Success"),
      PaymentTransaction(
          id: "PAY-002",
          method: "Card",
          invoiceId: "INV-8820",
          amount: 1200.00,
          status: "Settled"),
      PaymentTransaction(
          id: "PAY-003",
          method: "UPI",
          invoiceId: "INV-8819",
          amount: 85.00,
          status: "Reversed"),
    ];

    return Column(
      children: [
        const ZenoHeader(
          title: "Payment Reconciliation",
          subtitle:
              "Audit and manage payment transactions across all channels.",
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: ZenoTable<PaymentTransaction>(
              items: _payments,
              columns: [
                ZenoTableColumn(
                  label: "Payment ID",
                  builder: (p) => Text(p.id,
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                ),
                ZenoTableColumn(
                  label: "Method",
                  width: 150,
                  builder: (p) =>
                      ZenoBadge(label: p.method, color: Color(0xFF6a11cb)),
                ),
                ZenoTableColumn(
                  label: "Invoice Ref",
                  width: 150,
                  builder: (p) => Text(p.invoiceId,
                      style: const TextStyle(color: ZenoTheme.accent)),
                ),
                ZenoTableColumn(
                  label: "Amount",
                  width: 120,
                  isNumeric: true,
                  builder: (p) => Text("\$${p.amount.toStringAsFixed(2)}",
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                ),
                ZenoTableColumn(
                  label: "Status",
                  width: 150,
                  builder: (p) => Text(p.status,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: p.status == "Reversed"
                              ? Color(0xFFFF4B2B)
                              : Color(0xFF00FF88))),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
