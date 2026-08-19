import 'package:flutter/material.dart' hide FilterChip;
import 'package:zeno/app/theme.dart';

class FormatOption extends StatelessWidget {
  final String label; final IconData icon; final bool isSelected; final ZenoSemanticColors colors;
  const FormatOption({super.key, required this.label, required this.icon, this.isSelected = false, required this.colors});
  @override
  Widget build(BuildContext context) {
    final bg = isSelected ? colors.accentPrimary.withValues(alpha: 0.1) : colors.bgTier2;
    final border = isSelected ? colors.accentPrimary : colors.borderSubtle;
    final text = isSelected ? colors.accentPrimary : colors.textSecondary;
    return Expanded(child: Container(
      padding: const EdgeInsets.all(16), decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(8), border: Border.all(color: border)),
      child: Column(children: [
        Icon(icon, color: text), const SizedBox(height: 8),
        Text(label, style: ZenoTypography.micro(isSelected ? colors.accentPrimary : colors.textPrimary).copyWith(fontWeight: isSelected ? FontWeight.bold : FontWeight.normal)),
      ]),
    ));
  }
}

class BulkFilterChip extends StatelessWidget {
  final String label; final bool isSelected; final ZenoSemanticColors colors;
  const BulkFilterChip({super.key, required this.label, this.isSelected = false, required this.colors});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(color: isSelected ? colors.accentPrimary : colors.bgTier3, borderRadius: BorderRadius.circular(20), border: Border.all(color: isSelected ? colors.accentPrimary : colors.borderSubtle)),
      child: Text(label, style: ZenoTypography.micro(isSelected ? colors.bgTier1 : colors.textPrimary)),
    );
  }
}

class OperationItem extends StatelessWidget {
  final String name; final String status; final String date; final String details; final bool isSuccess; final ZenoSemanticColors colors;
  const OperationItem({super.key, required this.name, required this.status, required this.date, required this.details, required this.isSuccess, required this.colors});
  @override
  Widget build(BuildContext context) {
    final statusColor = isSuccess ? colors.statusSuccess : colors.statusDanger;
    return Padding(padding: const EdgeInsets.only(bottom: 16), child: Row(children: [
      Container(padding: const EdgeInsets.all(8), decoration: BoxDecoration(color: statusColor.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(8)), child: Icon(isSuccess ? Icons.check : Icons.close, size: 16, color: statusColor)),
      const SizedBox(width: 16),
      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(name, style: ZenoTypography.bodyMD(colors.textPrimary).copyWith(fontWeight: FontWeight.bold)), Text(details, style: ZenoTypography.micro(colors.textSecondary))])),
      Column(crossAxisAlignment: CrossAxisAlignment.end, children: [Text(status, style: ZenoTypography.micro(statusColor).copyWith(fontWeight: FontWeight.bold)), Text(date, style: ZenoTypography.micro(colors.textDisabled))]),
    ]));
  }
}
