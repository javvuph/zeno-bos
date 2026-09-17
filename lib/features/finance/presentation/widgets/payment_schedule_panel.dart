import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import '../../domain/models/accounts_payable.dart';

class PaymentSchedulePanel extends StatelessWidget {
  final AccountsPayable payable;
  const PaymentSchedulePanel({super.key, required this.payable});

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
              Icon(Icons.event_note_rounded,
                  size: 20, color: Colors.indigo),
              SizedBox(width: 12),
              Text("DISBURSEMENT SCHEDULE",
                  style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 13,
                      letterSpacing: 0.5)),
            ],
          ),
          const SizedBox(height: 24),
          _buildStep(
              "SCHEDULED DATE",
              payable.scheduledDate?.toString().substring(0, 10) ??
                  "NOT SCHEDULED",
              true),
          _buildStep(
              "DUE DATE", payable.dueDate.toString().substring(0, 10), false),
          const SizedBox(height: 24),
          const Text("OPTIMIZATION PROPOSAL",
              style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey)),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.green.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.green.withValues(alpha: 0.3)),
            ),
            child: const Row(
              children: [
                Icon(Icons.auto_awesome, size: 16, color: Colors.green),
                SizedBox(width: 12),
                Expanded(
                  child: Text(
                    "Pay before Aug 15 to secure ₹236.00 early payment discount.",
                    style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: Colors.green),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStep(String label, String value, bool isPrimary) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: const TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                  color: Colors.grey)),
          Text(value,
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w900,
                  color: isPrimary ? const Color(0xFF00F0FF) : null)),
        ],
      ),
    );
  }
}
