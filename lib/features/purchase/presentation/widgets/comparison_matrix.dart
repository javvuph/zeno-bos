import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import '../../domain/models/rfq.dart';
import '../../domain/models/supplier_quotation.dart';

class SupplierComparisonMatrix extends StatelessWidget {
  final RFQ rfq;
  final List<SupplierQuotation> quotations;

  const SupplierComparisonMatrix({
    super.key,
    required this.rfq,
    required this.quotations,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<ZenoSemanticColors>()!;

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Row Headers
          _buildLabelsColumn(colors),

          // Supplier Columns
          ...quotations.map((q) => _buildSupplierColumn(q, colors)),
        ],
      ),
    );
  }

  Widget _buildLabelsColumn(ZenoSemanticColors colors) {
    return Container(
      width: 200,
      decoration: BoxDecoration(
        color: colors.bgTier2,
        border: Border(right: BorderSide(color: colors.borderSubtle)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _cell("SUPPLIER", isHeader: true),
          _cell("UNIT PRICE (AVG)"),
          _cell("DISCOUNT"),
          _cell("TOTAL AMOUNT"),
          _cell("LEAD TIME"),
          _cell("PAYMENT TERMS"),
          _cell("WARRANTY"),
          _cell("QUALITY RATING"),
          _cell("PAST PERFORMANCE"),
          _cell("DELIVERY SCORE"),
          _cell("AI SCORE", isSpecial: true),
          _cell("SELECTION", isHeader: true),
        ],
      ),
    );
  }

  Widget _buildSupplierColumn(SupplierQuotation q, ZenoSemanticColors colors) {
    return Container(
      width: 250,
      decoration: BoxDecoration(
        border: Border(right: BorderSide(color: colors.borderSubtle)),
      ),
      child: Column(
        children: [
          _cell(q.supplierId.toUpperCase(),
              isHeader: true, textAlign: TextAlign.center),
          _cell(
              "\$${(q.subtotal / (q.items.isNotEmpty ? q.items.length : 1)).toStringAsFixed(2)}"),
          _cell("\$${q.discountAmount.toStringAsFixed(2)}",
              color: Colors.green),
          _cell("\$${q.totalAmount.toStringAsFixed(2)}", isBold: true),
          _cell("${q.leadTimeDays} DAYS"),
          _cell(q.paymentTerms),
          _cell(q.warrantyTerms),
          _scoreCell(q.qualityRating),
          _scoreCell(q.pastPerformanceScore),
          _scoreCell(q.deliveryReliabilityScore),
          _cell("${q.aiScore.toStringAsFixed(1)} / 100",
              isSpecial: true, textAlign: TextAlign.center),
          _actionCell(q, colors),
        ],
      ),
    );
  }

  Widget _cell(
    String text, {
    bool isHeader = false,
    bool isBold = false,
    bool isSpecial = false,
    Color? color,
    TextAlign textAlign = TextAlign.start,
  }) {
    return Container(
      height: 48,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      alignment: textAlign == TextAlign.center
          ? Alignment.center
          : Alignment.centerLeft,
      decoration: BoxDecoration(
        color: isSpecial ? const Color(0x0D00F0FF) : null,
        border: const Border(bottom: BorderSide(color: Color(0x1A64748B))),
      ),
      child: Text(
        text,
        textAlign: textAlign,
        style: TextStyle(
          fontSize: isHeader ? 10 : 12,
          fontWeight: (isHeader || isBold || isSpecial)
              ? FontWeight.w900
              : FontWeight.w500,
          color: color ??
              (isHeader
                  ? Colors.grey
                  : (isSpecial ? const Color(0xFF00F0FF) : null)),
          letterSpacing: isHeader ? 1.0 : 0,
        ),
      ),
    );
  }

  Widget _scoreCell(double score) {
    Color color = Colors.red;
    if (score > 85)
      color = Colors.green;
    else if (score > 70) color = Colors.orange;

    return Container(
      height: 48,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      alignment: Alignment.centerLeft,
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Color(0x1A64748B))),
      ),
      child: Row(
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(2),
              child: LinearProgressIndicator(
                value: score / 100,
                backgroundColor: color.withValues(alpha: 0.1),
                valueColor: AlwaysStoppedAnimation<Color>(color),
                minHeight: 4,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Text("${score.toInt()}%",
              style: TextStyle(
                  fontSize: 10, fontWeight: FontWeight.bold, color: color)),
        ],
      ),
    );
  }

  Widget _actionCell(SupplierQuotation q, ZenoSemanticColors colors) {
    return Container(
      height: 48,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Color(0x1A64748B))),
      ),
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: q.isSelected ? colors.statusSuccess : colors.bgTier3,
          foregroundColor: q.isSelected ? Colors.white : colors.textPrimary,
          elevation: 0,
          minimumSize: const Size(double.infinity, 32),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        ),
        child: Text(q.isSelected ? "SELECTED" : "SELECT WINNER",
            style: const TextStyle(fontSize: 9, fontWeight: FontWeight.w900)),
      ),
    );
  }
}
