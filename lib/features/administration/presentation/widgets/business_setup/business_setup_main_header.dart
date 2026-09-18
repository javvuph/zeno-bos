import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'business_setup_models.dart';
import 'business_setup_theme.dart';

class BusinessSetupMainHeader extends StatelessWidget {
  final BusinessSetupData setupData;
  final int currentStep;
  final int totalSteps;
  final String stepTitle;
  final ValueChanged<int> onTabSelected;

  const BusinessSetupMainHeader({super.key, required this.setupData, required this.currentStep, required this.totalSteps, required this.stepTitle, required this.onTabSelected});

  List<String> getVisibleTabs() {
    const all = ["1. Store & Business", "2. Regional & Tax", "3. Operations & POS", "4. Online Store & QR", "5. Team & Access", "6. Enterprise Workflows"];
    return all.take(totalSteps).toList();
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<ZenoSemanticColors>()!;
    final progressPct = setupData.getProgressPercentage().round();
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, mainAxisSize: MainAxisSize.min, children: [
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text("Business Setup", style: ZenoTypography.displayLG(colors.textPrimary).copyWith(fontSize: 24, fontWeight: FontWeight.w600, letterSpacing: -0.4)),
        Row(children: [
          Container(width: 240, height: 6, decoration: BoxDecoration(color: colors.accentPrimary.withValues(alpha: 0.10), borderRadius: BorderRadius.circular(ZenoRadius.full)), child: Align(alignment: Alignment.centerLeft, child: FractionallySizedBox(widthFactor: (progressPct / 100).clamp(0.0, 1.0), child: Container(decoration: BoxDecoration(color: colors.accentPrimary, borderRadius: BorderRadius.circular(ZenoRadius.full)))))),
          const SizedBox(width: ZenoSpacing.md),
          Text("Progress: ${progressPct}%", style: ZenoTypography.bodyMD(colors.accentPrimary).copyWith(fontWeight: FontWeight.w700)),
        ]),
      ]),
      const SizedBox(height: ZenoSpacing.md),
      SingleChildScrollView(scrollDirection: Axis.horizontal, child: Row(children: List.generate(getVisibleTabs().length, (index) {
        final isActive = currentStep == index;
        return InkWell(onTap: () => onTabSelected(index), borderRadius: BorderRadius.circular(ZenoRadius.sm), child: Container(margin: const EdgeInsets.only(right: ZenoSpacing.lg), padding: const EdgeInsets.only(bottom: ZenoSpacing.sm), decoration: BoxDecoration(border: Border(bottom: BorderSide(color: isActive ? colors.accentPrimary : Colors.transparent, width: 2))), child: Text(getVisibleTabs()[index], style: ZenoTypography.bodyMD(isActive ? colors.accentPrimary : colors.textSecondary).copyWith(fontWeight: FontWeight.w600))));
      }))),
      const SizedBox(height: ZenoSpacing.md),
      Container(padding: const EdgeInsets.symmetric(horizontal: ZenoSpacing.md, vertical: ZenoSpacing.sm), decoration: BoxDecoration(color: colors.accentPrimary.withValues(alpha: 0.06), border: Border.all(color: colors.accentPrimary.withValues(alpha: 0.16)), borderRadius: BorderRadius.circular(ZenoRadius.md)), child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text("Step ${currentStep + 1} of ${totalSteps}: ${stepTitle}", style: ZenoTypography.bodyMD(colors.accentPrimary).copyWith(fontWeight: FontWeight.w700)),
        Text("${setupData.selectedMainBusiness} • ${setupData.selectedScale.name.toUpperCase()}", style: ZenoTypography.bodyMD(colors.textSecondary).copyWith(fontWeight: FontWeight.w600)),
      ])),
    ]);
  }
}