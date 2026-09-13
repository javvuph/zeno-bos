import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import '../../../../domain/models/product_studio_models.dart';

class StepHeader extends StatelessWidget {
  final int number; final String title; final ZenoSemanticColors colors;
  const StepHeader({super.key, required this.number, required this.title, required this.colors});
  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Container(width: 18, height: 18, alignment: Alignment.center, decoration: BoxDecoration(color: colors.accentPrimary, shape: BoxShape.circle), child: Text(number.toString(), style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold))),
      const SizedBox(width: 10),
      Text(title.toUpperCase(), style: TextStyle(fontSize: 11, fontWeight: FontWeight.w900, color: colors.textPrimary, letterSpacing: 0.5)),
    ]);
  }
}

class RecentScanItem extends StatelessWidget {
  final ScanSessionItem item; final ZenoSemanticColors colors;
  const RecentScanItem({super.key, required this.item, required this.colors});
  @override
  Widget build(BuildContext context) {
    Color statusColor = Colors.green; String statusText = "Added";
    if (item.status == ScanItemStatus.exists) { statusColor = Colors.blue; statusText = "In DB"; }
    if (item.status == ScanItemStatus.foundExternal) { statusColor = Colors.orange; statusText = "Found"; }
    if (item.status == ScanItemStatus.notFound) { statusColor = Colors.red; statusText = "Miss"; }
    return Container(
      padding: const EdgeInsets.all(8), decoration: BoxDecoration(color: colors.bgTier3, borderRadius: BorderRadius.circular(6), border: Border.all(color: colors.borderSubtle)),
      child: Row(mainAxisSize: MainAxisSize.min, children: [
        Container(width: 28, height: 28, decoration: BoxDecoration(color: colors.bgTier1, borderRadius: BorderRadius.circular(4)), child: Icon(Icons.image_outlined, size: 14, color: colors.textDisabled)),
        const SizedBox(width: 8),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(item.product.title.isEmpty ? "New Item" : item.product.title, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 9.5, fontWeight: FontWeight.bold)),
          Text(item.product.barcode, style: TextStyle(fontSize: 7.5, color: colors.textDisabled, fontFamily: 'monospace')),
        ])),
        const SizedBox(width: 4),
        Container(padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2), decoration: BoxDecoration(color: statusColor.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(3)), child: Text(statusText.toUpperCase(), style: TextStyle(fontSize: 7, fontWeight: FontWeight.w900, color: statusColor))),
      ]),
    );
  }
}

class SummaryGroup extends StatelessWidget {
  final String title; final bool isComplete; final int count; final String? details; final String? missing; final ZenoSemanticColors colors;
  const SummaryGroup({super.key, required this.title, required this.isComplete, required this.count, this.details, this.missing, required this.colors});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12), decoration: BoxDecoration(color: colors.bgTier2, borderRadius: BorderRadius.circular(8), border: Border.all(color: isComplete ? colors.statusSuccess.withValues(alpha: 0.3) : colors.statusWarning.withValues(alpha: 0.3))),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          Icon(isComplete ? Icons.check_circle_rounded : Icons.warning_rounded, size: 12, color: isComplete ? colors.statusSuccess : colors.statusWarning),
          const SizedBox(width: 6),
          Text(title, style: TextStyle(fontSize: 8, fontWeight: FontWeight.w900, color: colors.textPrimary)),
        ]),
        const SizedBox(height: 8),
        Text("$count FIELDS", style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: isComplete ? colors.statusSuccess : colors.statusWarning)),
        const SizedBox(height: 4),
        Text(isComplete ? (details ?? "") : "Needs: ${missing ?? ""}", style: TextStyle(fontSize: 8, color: colors.textDisabled)),
      ]),
    );
  }
}
