import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/core/widgets/zeno_header.dart';
import 'package:zeno/core/widgets/zeno_table.dart';
import 'package:zeno/core/widgets/zeno_badge.dart';

class Invoice {
  final String id;
  final String customer;
  final double amount;
  final String method;
  final String status;
  final String date;

  Invoice(
      {required this.id,
      required this.customer,
      required this.amount,
      required this.method,
      required this.status,
      required this.date});
}

class InvoiceListScreen extends StatelessWidget {
  const InvoiceListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Invoice> _invoices = [
      Invoice(
          id: "INV-8821",
          customer: "Guest",
          amount: 45.50,
          method: "Cash",
          status: "Paid",
          date: "Oct 24, 11:20 PM"),
      Invoice(
          id: "INV-8820",
          customer: "Alex R.",
          amount: 1200.00,
          method: "Card",
          status: "Paid",
          date: "Oct 24, 10:45 PM"),
      Invoice(
          id: "INV-8819",
          customer: "Maria S.",
          amount: 85.00,
          method: "UPI",
          status: "Refunded",
          date: "Oct 24, 09:15 PM"),
      Invoice(
          id: "INV-8818",
          customer: "John Doe",
          amount: 450.20,
          method: "Wallet",
          status: "Cancelled",
          date: "Oct 24, 08:30 PM"),
    ];

    return Column(
      children: [
        ZenoHeader(
          title: "Sales Invoices",
          subtitle:
              "Track and manage all completed and historical sales transactions.",
          onSearch: (v) {},
          actions: [
            _FilterButton(),
            const SizedBox(width: 12),
            _ActionButton(label: "Export CSV", icon: Icons.download_outlined),
          ],
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: ZenoTable<Invoice>(
              items: _invoices,
              columns: [
                ZenoTableColumn(
                  label: "Invoice ID",
                  width: 150,
                  builder: (i) => Text(i.id,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: 'monospace')),
                ),
                ZenoTableColumn(
                  label: "Customer",
                  builder: (i) =>
                      Text(i.customer, style: const TextStyle(fontSize: 13)),
                ),
                ZenoTableColumn(
                  label: "Total Amount",
                  width: 120,
                  isNumeric: true,
                  builder: (i) => Text("\$${i.amount.toStringAsFixed(2)}",
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF00FF88))),
                ),
                ZenoTableColumn(
                  label: "Method",
                  width: 120,
                  builder: (i) => Row(
                    children: [
                      Icon(_getMethodIcon(i.method),
                          size: 14, color: ZenoTheme.textSecondary),
                      const SizedBox(width: 8),
                      Text(i.method, style: const TextStyle(fontSize: 12)),
                    ],
                  ),
                ),
                ZenoTableColumn(
                  label: "Status",
                  width: 150,
                  builder: (i) => ZenoBadge(
                    label: i.status,
                    color: i.status == "Paid"
                        ? Color(0xFF00FF88)
                        : (i.status == "Refunded"
                            ? Color(0xFFFFD700)
                            : Color(0xFFFF4B2B)),
                  ),
                ),
                ZenoTableColumn(
                  label: "Timestamp",
                  width: 180,
                  builder: (i) => Text(i.date,
                      style: const TextStyle(
                          fontSize: 12, color: ZenoTheme.textSecondary)),
                ),
                ZenoTableColumn(
                  label: "Actions",
                  width: 80,
                  builder: (i) => IconButton(
                      icon: const Icon(Icons.print_outlined, size: 18),
                      onPressed: () {}),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  IconData _getMethodIcon(String method) {
    if (method == "Cash") return Icons.money;
    if (method == "Card") return Icons.credit_card;
    if (method == "UPI") return Icons.qr_code;
    return Icons.account_balance_wallet;
  }
}

class _FilterButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: ZenoTheme.surface,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: ZenoTheme.border),
      ),
      child: const Row(
        children: [
          Icon(Icons.filter_list, size: 16, color: ZenoTheme.textSecondary),
          SizedBox(width: 8),
          Text("Filters",
              style: TextStyle(fontSize: 13, color: ZenoTheme.textSecondary)),
        ],
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final String label;
  final IconData icon;

  const _ActionButton({required this.label, required this.icon});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {},
      icon: Icon(icon, size: 16),
      label: Text(label),
      style: ElevatedButton.styleFrom(
        backgroundColor: ZenoTheme.surface,
        foregroundColor: Colors.white,
        side: const BorderSide(color: ZenoTheme.border),
      ),
    );
  }
}
