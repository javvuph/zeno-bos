import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/core/widgets/zeno_header.dart';
import 'package:zeno/core/widgets/zeno_table.dart';
import 'package:zeno/core/widgets/zeno_badge.dart';

class LedgerEntry {
  final String date;
  final String type;
  final String reference;
  final double debit;
  final double credit;
  final double balance;

  LedgerEntry(
      {required this.date,
      required this.type,
      required this.reference,
      required this.debit,
      required this.credit,
      required this.balance});
}

class CustomerLedgerScreen extends StatelessWidget {
  final String customerId;
  const CustomerLedgerScreen({super.key, required this.customerId});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<ZenoSemanticColors>()!;
    final List<LedgerEntry> _entries = [
      LedgerEntry(
          date: "2024-10-20",
          type: "INVOICE",
          reference: "INV-8821",
          debit: 450.00,
          credit: 0.00,
          balance: 450.00),
      LedgerEntry(
          date: "2024-10-21",
          type: "PAYMENT",
          reference: "PY-992",
          debit: 0.00,
          credit: 400.00,
          balance: 50.00),
      LedgerEntry(
          date: "2024-10-22",
          type: "INVOICE",
          reference: "INV-8840",
          debit: 120.00,
          credit: 0.00,
          balance: 170.00),
    ];

    return Column(
      children: [
        ZenoHeader(
          title: "Financial Ledger: $customerId".toUpperCase(),
          subtitle:
              "DETAILED TRANSACTION HISTORY, OUTSTANDING BALANCES, AND PAYMENT RECONCILIATION.",
          actions: [
            _HeaderBtn(
                label: "GENERATE STATEMENT",
                icon: Icons.description_outlined,
                colors: colors),
            const SizedBox(width: 12),
            _HeaderBtn(
                label: "RECORD PAYMENT",
                icon: Icons.add_card,
                isPrimary: true,
                colors: colors),
          ],
        ),
        _buildBalanceSummary(colors),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: ZenoTable<LedgerEntry>(
              items: _entries,
              columns: [
                ZenoTableColumn(
                    label: "Date", width: 120, builder: (e) => Text(e.date)),
                ZenoTableColumn(
                    label: "Type",
                    width: 120,
                    builder: (e) => ZenoBadge(
                        label: e.type,
                        color: e.type == "INVOICE"
                            ? colors.accentPrimary
                            : colors.statusSuccess)),
                ZenoTableColumn(
                    label: "Reference",
                    builder: (e) => Text(e.reference,
                        style: const TextStyle(fontWeight: FontWeight.bold))),
                ZenoTableColumn(
                    label: "Debit",
                    width: 120,
                    isNumeric: true,
                    builder: (e) => Text(
                        e.debit > 0 ? "\$${e.debit.toStringAsFixed(2)}" : "-",
                        style: TextStyle(color: colors.statusDanger))),
                ZenoTableColumn(
                    label: "Credit",
                    width: 120,
                    isNumeric: true,
                    builder: (e) => Text(
                        e.credit > 0 ? "\$${e.credit.toStringAsFixed(2)}" : "-",
                        style: TextStyle(color: colors.statusSuccess))),
                ZenoTableColumn(
                    label: "Balance",
                    width: 140,
                    isNumeric: true,
                    builder: (e) => Text("\$${e.balance.toStringAsFixed(2)}",
                        style: const TextStyle(fontWeight: FontWeight.w900))),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBalanceSummary(ZenoSemanticColors colors) {
    return Container(
      padding: const EdgeInsets.all(24),
      margin: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: colors.bgTier2,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: colors.borderSubtle),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _SummaryItem(
              label: "TOTAL DEBIT",
              value: "\$570.00",
              color: colors.statusDanger,
              colors: colors),
          _SummaryItem(
              label: "TOTAL CREDIT",
              value: "\$400.00",
              color: colors.statusSuccess,
              colors: colors),
          _SummaryItem(
              label: "NET OUTSTANDING",
              value: "\$170.00",
              color: colors.accentPrimary,
              colors: colors),
        ],
      ),
    );
  }
}

class _SummaryItem extends StatelessWidget {
  final String label;
  final String value;
  final Color color;
  final ZenoSemanticColors colors;
  const _SummaryItem(
      {required this.label,
      required this.value,
      required this.color,
      required this.colors});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(label, style: ZenoTypography.micro(colors.textDisabled)),
        const SizedBox(height: 4),
        Text(value,
            style: ZenoTypography.headlineMD(color)
                .copyWith(fontWeight: FontWeight.w900)),
      ],
    );
  }
}

class _HeaderBtn extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool isPrimary;
  final ZenoSemanticColors colors;
  const _HeaderBtn(
      {required this.label,
      required this.icon,
      this.isPrimary = false,
      required this.colors});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {},
      icon: Icon(icon, size: 16),
      label: Text(label),
      style: ElevatedButton.styleFrom(
        backgroundColor: isPrimary ? colors.accentPrimary : colors.bgSurface,
        foregroundColor: isPrimary ? Colors.black : colors.textPrimary,
      ),
    );
  }
}
