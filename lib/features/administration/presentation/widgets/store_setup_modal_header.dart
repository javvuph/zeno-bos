import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';

class StoreSetupModalHeader extends StatelessWidget {
  final int activeTab; final int totalSteps; final String stepTitle; final String industry; final String subType; final ValueChanged<int> onTabSelected;
  const StoreSetupModalHeader({super.key, required this.activeTab, required this.totalSteps, required this.stepTitle, required this.industry, required this.subType, required this.onTabSelected});
  @override Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<ZenoSemanticColors>()!;
    final progressPct = totalSteps == 0 ? 0 : ((activeTab + 1) / totalSteps * 100).round();
    const allTabs = ["1. Store & Business", "2. Regional & Tax", "3. Operations & POS", "4. Online Store & QR", "5. Team & Access", "6. Enterprise Workflows"];
    final visibleTabs = allTabs.take(totalSteps).toList();
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text("Business Setup", style: ZenoTypography.displayLG(colors.textPrimary).copyWith(fontSize: 24, fontWeight: FontWeight.w600, letterSpacing: -0.4)),
        Row(children: [Container(width: 260, height: 6, decoration: BoxDecoration(color: colors.accentPrimary.withValues(alpha: 0.10), borderRadius: BorderRadius.circular(ZenoRadius.full)), child: Align(alignment: Alignment.centerLeft, child: FractionallySizedBox(widthFactor: totalSteps == 0 ? 0 : ((activeTab + 1) / totalSteps).clamp(0.0, 1.0), child: Container(decoration: BoxDecoration(color: colors.accentPrimary, borderRadius: BorderRadius.circular(ZenoRadius.full))))), const SizedBox(width: ZenoSpacing.md), Text("Step $" + "{activeTab + 1} of $" + "{totalSteps} ($" + "{progressPct}%)", style: ZenoTypography.bodyMD(colors.accentPrimary).copyWith(fontWeight: FontWeight.w700))]),
      ]),
      const SizedBox(height: ZenoSpacing.lg),
      SingleChildScrollView(scrollDirection: Axis.horizontal, child: Row(children: List.generate(visibleTabs.length, (index) { final isActive = activeTab == index; return InkWell(onTap: () => onTabSelected(index), borderRadius: BorderRadius.circular(ZenoRadius.sm), child: Container(margin: const EdgeInsets.only(right: ZenoSpacing.lg), padding: const EdgeInsets.only(bottom: ZenoSpacing.sm), decoration: BoxDecoration(border: Border(bottom: BorderSide(color: isActive ? colors.accentPrimary : Colors.transparent, width: 2))), child: Text(visibleTabs[index], style: ZenoTypography.bodyMD(isActive ? colors.accentPrimary : colors.textSecondary).copyWith(fontWeight: FontWeight.w600)))); }))),
      const SizedBox(height: ZenoSpacing.lg),
      Container(padding: const EdgeInsets.symmetric(horizontal: ZenoSpacing.md, vertical: ZenoSpacing.sm), decoration: BoxDecoration(color: colors.accentPrimary.withValues(alpha: 0.06), border: Border.all(color: colors.accentPrimary.withValues(alpha: 0.16)), borderRadius: BorderRadius.circular(ZenoRadius.md)), child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text("Step $" + "{activeTab + 1} of $" + "{totalSteps}: $" + "{stepTitle} ($" + "{progressPct}%)", style: ZenoTypography.bodyMD(colors.accentPrimary).copyWith(fontWeight: FontWeight.w700)), Text("$" + "{industry} • $" + "{subType}", style: ZenoTypography.bodyMD(colors.textSecondary).copyWith(fontWeight: FontWeight.w600))])),
    ]);
  }
}