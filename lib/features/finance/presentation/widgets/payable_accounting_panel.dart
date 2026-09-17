import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import '../../domain/models/accounts_payable.dart';

class PayableAccountingPanel extends StatelessWidget {
  final AccountsPayable payable;
  const PayableAccountingPanel({super.key, required this.payable});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<ZenoSemanticColors>()!;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: colors.bgTier2,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: colors.borderSubtle),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.account_balance_rounded,
                  size: 20, color: Colors.blue),
              SizedBox(width: 12),
              Text("GL POSTING PREVIEW",
                  style: TextStyle(fontWeight: FontWeight.w900, fontSize: 13)),
            ],
          ),
          const SizedBox(height: 20),
          _entryRow("2100 - Accounts Payable", 0, payable.amount, isBold: true),
          _entryRow("1000 - Operating Cash", payable.amount, 0),
          const SizedBox(height: 20),
          const Divider(),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("TOTAL",
                  style: TextStyle(fontSize: 10, fontWeight: FontWeight.w900)),
              Text("₹${payable.amount.toStringAsFixed(2)}",
                  style: const TextStyle(
                      fontSize: 11, fontWeight: FontWeight.w900)),
              Text("₹${payable.amount.toStringAsFixed(2)}",
                  style: const TextStyle(
                      fontSize: 11, fontWeight: FontWeight.w900)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _entryRow(String account, double debit, double credit,
      {bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Expanded(
              child: Text(account,
                  style: TextStyle(
                      fontSize: 10,
                      fontWeight: isBold ? FontWeight.bold : FontWeight.w500))),
          SizedBox(
              width: 60,
              child: Text(debit > 0 ? "₹${debit.toInt()}" : "-",
                  textAlign: TextAlign.right,
                  style: const TextStyle(fontSize: 10))),
          SizedBox(
              width: 60,
              child: Text(credit > 0 ? "₹${credit.toInt()}" : "-",
                  textAlign: TextAlign.right,
                  style: const TextStyle(fontSize: 10))),
        ],
      ),
    );
  }
}
