import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';

class SummaryItem extends StatelessWidget {
  final String label; final String value; final ZenoSemanticColors colors; final Color? color;
  const SummaryItem({super.key, required this.label, required this.value, required this.colors, this.color});
  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(label, style: ZenoTypography.micro(colors.textDisabled)),
      const SizedBox(height: 4),
      Text(value, style: ZenoTypography.headlineMD(color ?? colors.textPrimary).copyWith(fontWeight: FontWeight.w900)),
    ]);
  }
}

class POFilterChip extends StatelessWidget {
  final String label; final int count; final bool isSelected; final ZenoSemanticColors colors; final bool isWarning;
  const POFilterChip({super.key, required this.label, required this.count, this.isSelected = false, required this.colors, this.isWarning = false});
  @override
  Widget build(BuildContext context) {
    final bg = isSelected ? colors.accentPrimary.withValues(alpha: 0.1) : (isWarning ? colors.statusWarning.withValues(alpha: 0.1) : colors.bgTier3);
    final border = isSelected ? colors.accentPrimary.withValues(alpha: 0.3) : (isWarning ? colors.statusWarning.withValues(alpha: 0.3) : colors.borderSubtle);
    final text = isSelected ? colors.accentPrimary : (isWarning ? colors.statusWarning : colors.textSecondary);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: ZenoSpacing.md, vertical: 6),
      decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(ZenoRadius.md), border: Border.all(color: border)),
      child: Row(children: [
        Text(label, style: ZenoTypography.micro(text)), const SizedBox(width: 8),
        Text(count.toString(), style: ZenoTypography.micro(text).copyWith(fontWeight: FontWeight.bold)),
      ]),
    );
  }
}

class POActionBtn extends StatelessWidget {
  final String label; final IconData icon; final bool isPrimary; final ZenoSemanticColors colors; final VoidCallback onPressed;
  const POActionBtn({super.key, required this.label, required this.icon, this.isPrimary = false, required this.colors, required this.onPressed});
  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed, icon: Icon(icon, size: 16), label: Text(label, style: ZenoTypography.caption(isPrimary ? Colors.black : colors.textPrimary).copyWith(fontWeight: FontWeight.w900)),
      style: ElevatedButton.styleFrom(backgroundColor: isPrimary ? colors.accentPrimary : colors.bgTier3, foregroundColor: isPrimary ? Colors.black : colors.textPrimary, elevation: 0, padding: const EdgeInsets.symmetric(horizontal: ZenoSpacing.lg, vertical: 14), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(ZenoRadius.md))),
    );
  }
}

class IconBtn extends StatelessWidget {
  final IconData icon; final Color color;
  const IconBtn({super.key, required this.icon, required this.color});
  @override
  Widget build(BuildContext context) {
    return Container(padding: const EdgeInsets.all(6), decoration: BoxDecoration(color: color.withValues(alpha: 0.05), borderRadius: BorderRadius.circular(6)), child: Icon(icon, size: 16, color: color));
  }
}
