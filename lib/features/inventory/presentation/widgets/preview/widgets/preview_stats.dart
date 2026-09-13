import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';

Widget buildStatsArea(double displayPrice, int displayStock, double marginPct, String taxCode, String unit, ZenoSemanticColors colors) {
  return Column(children: [
    const Divider(height: 12),
    _buildStatRow("SALE PRICE", "₹${displayPrice.toStringAsFixed(2)}", colors, valueColor: colors.accentPrimary, isPrimary: true),
    const SizedBox(height: 6),
    Row(children: [
      Expanded(child: _buildStatItem("STOCK", "$displayStock PCS", colors)),
      Expanded(child: _buildStatItem("MARGIN", "${marginPct.toStringAsFixed(1)}%", colors, valueColor: colors.statusSuccess)),
    ]),
    const SizedBox(height: 8),
    Row(children: [
      Expanded(child: _buildStatItem("TAX", taxCode.isEmpty ? "0%" : taxCode, colors)),
      Expanded(child: _buildStatItem("UNIT", unit.isEmpty ? "PCS" : unit, colors)),
    ]),
  ]);
}

Widget _buildStatRow(String label, String value, ZenoSemanticColors colors, {Color? valueColor, bool isPrimary = false}) {
  return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
    Text(label, style: TextStyle(fontSize: 8, fontWeight: FontWeight.w800, color: colors.textDisabled)),
    Text(value, style: TextStyle(fontSize: isPrimary ? 16 : 11, fontWeight: FontWeight.w900, color: valueColor ?? colors.textPrimary, fontFamily: 'monospace')),
  ]);
}

Widget _buildStatItem(String label, String value, ZenoSemanticColors colors, {Color? valueColor}) {
  return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    Text(label, style: TextStyle(fontSize: 7, fontWeight: FontWeight.w800, color: colors.textDisabled)),
    const SizedBox(height: 2),
    Text(value, style: TextStyle(fontSize: 11, fontWeight: FontWeight.w900, color: valueColor ?? colors.textPrimary, fontFamily: 'monospace')),
  ]);
}

Widget buildBarcodeArea(String displayBarcode, ZenoSemanticColors colors) {
  return Center(child: Column(children: [
    Container(height: 20, width: double.infinity, decoration: BoxDecoration(color: colors.textPrimary.withValues(alpha: 0.03), borderRadius: BorderRadius.circular(4)), child: Icon(Icons.reorder, size: 16, color: colors.textPrimary.withValues(alpha: 0.5))),
    const SizedBox(height: 2),
    Text(displayBarcode, style: TextStyle(fontSize: 7, fontFamily: 'monospace', color: colors.textDisabled)),
  ]));
}
