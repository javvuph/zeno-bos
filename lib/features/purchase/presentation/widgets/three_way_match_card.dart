import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import '../../domain/models/vendor_bill.dart';

class ThreeWayMatchCard extends StatelessWidget {
  final VendorBill bill;

  const ThreeWayMatchCard({super.key, required this.bill});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<ZenoSemanticColors>()!;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: colors.bgTier2,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
            color: bill.is3WayMatched
                ? Colors.green.withValues(alpha: 0.3)
                : Colors.red.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                bill.is3WayMatched
                    ? Icons.verified_user_rounded
                    : Icons.warning_amber_rounded,
                color: bill.is3WayMatched ? Colors.green : Colors.red,
                size: 20,
              ),
              const SizedBox(width: 12),
              Text(
                bill.is3WayMatched
                    ? "3-WAY MATCH VERIFIED"
                    : "MATCH DISCREPANCIES DETECTED",
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 13,
                  color: bill.is3WayMatched ? Colors.green : Colors.red,
                  letterSpacing: 0.5,
                ),
              ),
              const Spacer(),
              _MatchScore(score: bill.aiMatchScore),
            ],
          ),
          const SizedBox(height: 20),
          _buildMatchRow(
              "PURCHASE ORDER", bill.poId ?? "MISSING", bill.poId != null),
          const SizedBox(height: 8),
          _buildMatchRow("GOODS RECEIPT (GRN)", bill.grnId ?? "MISSING",
              bill.grnId != null),
          const SizedBox(height: 8),
          _buildMatchRow("VENDOR INVOICE", bill.invoiceNumber, true),
          if (bill.matchDiscrepancies.isNotEmpty) ...[
            const SizedBox(height: 20),
            const Divider(),
            const SizedBox(height: 12),
            ...bill.matchDiscrepancies.map((d) => Padding(
                  padding: const EdgeInsets.only(bottom: 6),
                  child: Row(
                    children: [
                      const Icon(Icons.error_outline,
                          size: 12, color: Colors.red),
                      const SizedBox(width: 8),
                      Expanded(
                          child: Text(d,
                              style: const TextStyle(
                                  fontSize: 11,
                                  color: Colors.red,
                                  fontWeight: FontWeight.w600))),
                    ],
                  ),
                )),
          ],
        ],
      ),
    );
  }

  Widget _buildMatchRow(String label, String value, bool isMatched) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label,
            style: const TextStyle(
                fontSize: 10, fontWeight: FontWeight.w700, color: Colors.grey)),
        Row(
          children: [
            Text(value,
                style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w900,
                    color: isMatched ? null : Colors.red)),
            const SizedBox(width: 8),
            Icon(isMatched ? Icons.check_circle : Icons.cancel,
                size: 14, color: isMatched ? Colors.green : Colors.red),
          ],
        ),
      ],
    );
  }
}

class _MatchScore extends StatelessWidget {
  final double score;
  const _MatchScore({required this.score});

  @override
  Widget build(BuildContext context) {
    Color color = score > 90
        ? const Color(0xFF00F0FF)
        : (score > 70 ? Colors.orange : Colors.red);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text("${score.toInt()}%",
            style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.w900, color: color)),
        const Text("AI CONFIDENCE",
            style: TextStyle(
                fontSize: 8, fontWeight: FontWeight.bold, color: Colors.grey)),
      ],
    );
  }
}
