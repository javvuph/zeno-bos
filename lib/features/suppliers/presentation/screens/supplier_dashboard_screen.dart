import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/core/widgets/zeno_header.dart';
import 'package:zeno/core/widgets/zeno_card.dart';
import 'package:zeno/core/di/service_locator.dart';
import '../../domain/repositories/i_supplier_repository.dart';
import '../controllers/supplier_controller.dart';
import 'supplier_form_screen.dart';

part 'parts/supplier_dashboard_widgets.part.dart';

class SupplierDashboardScreen extends StatefulWidget {
  const SupplierDashboardScreen({super.key});

  @override
  State<SupplierDashboardScreen> createState() =>
      _SupplierDashboardScreenState();
}

class _SupplierDashboardScreenState extends State<SupplierDashboardScreen> {
  final controller = SupplierController(sl<ISupplierRepository>());

  @override
  void initState() {
    super.initState();
    controller.addListener(_onUpdate);
  }

  void _onUpdate() {
    if (mounted) setState(() {});
  }

  void _onboardVendor() {
    showDialog(
      context: context,
      builder: (context) => const SupplierFormScreen(),
    );
  }

  @override
  void dispose() {
    controller.removeListener(_onUpdate);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<ZenoSemanticColors>()!;
    return Column(
      children: [
        ZenoHeader(
          title: "Supplier Intelligence".toUpperCase(),
          subtitle:
              "ANALYZE VENDOR PERFORMANCE, PROCUREMENT EFFICIENCY, AND STRATEGIC SPEND DISTRIBUTION.",
          actions: [
            const _HeaderButton(
                label: "Export Ledger", icon: Icons.download_outlined),
            const SizedBox(width: ZenoSpacing.md),
            _HeaderButton(
              label: "Onboard Vendor",
              icon: Icons.add_business,
              isPrimary: true,
              onPressed: _onboardVendor,
            ),
          ],
        ),
        _buildStickyKPI(colors),
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: ZenoSpacing.lg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 2,
                      child: ZenoCard(
                        title: "AI PROCUREMENT INSIGHTS",
                        trailing: Icon(Icons.auto_awesome,
                            size: 16, color: colors.accentPrimary),
                        child: Column(
                          children: [
                            _ProcurementMetric(
                              label: "VENDOR RELIABILITY INDEX",
                              value: 0.94,
                              color: colors.statusSuccess,
                            ),
                            const SizedBox(height: ZenoSpacing.lg),
                            _ProcurementMetric(
                              label: "PRICE AGREEMENT COMPLIANCE",
                              value: 0.82,
                              color: colors.amberGold,
                            ),
                            const SizedBox(height: ZenoSpacing.xl),
                            AnimatedContainer(
                              duration: ZenoDuration.std,
                              padding: const EdgeInsets.all(ZenoSpacing.md),
                              decoration: BoxDecoration(
                                color: colors.accentPrimary
                                    .withValues(alpha: 0.05),
                                borderRadius:
                                    BorderRadius.circular(ZenoRadius.lg),
                                border: Border.all(
                                    color: colors.accentPrimary
                                        .withValues(alpha: 0.2)),
                              ),
                              child: Row(
                                children: [
                                  Icon(Icons.psychology_outlined,
                                      color: colors.accentPrimary, size: 24),
                                  const SizedBox(width: ZenoSpacing.md),
                                  Expanded(
                                    child: Text(
                                      "AI ANALYSIS: SWITCHING TO 'GLOBAL ELECTRONICS' FOR THE NEXT IPHONE 15 BATCH COULD SAVE 4% IN PROCUREMENT COSTS DUE TO NEW BULK PRICING TIERS.",
                                      style: ZenoTypography.caption(
                                              colors.textPrimary)
                                          .copyWith(
                                              height: 1.5, letterSpacing: 0.2),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: ZenoSpacing.lg),

                    Expanded(
                      flex: 1,
                      child: ZenoCard(
                        title: "TOP VENDOR SCORECARD",
                        child: Column(
                          children: [
                            ...controller.suppliers
                                .take(3)
                                .map((s) => _VendorItem(
                                      name: s.name.toUpperCase(),
                                      rating:
                                          "${(s.rating.overallScore * 100).toInt()}% RELIABILITY",
                                      icon: s.isPreferred
                                          ? Icons.stars
                                          : Icons.factory_outlined,
                                      color: s.isPreferred
                                          ? colors.amberGold
                                          : colors.statusInfo,
                                    )),
                            const SizedBox(height: ZenoSpacing.md),
                            SizedBox(
                              width: double.infinity,
                              child: TextButton(
                                onPressed: () {},
                                child: Text("VIEW ALL SCORES",
                                    style: ZenoTypography.caption(
                                        colors.accentPrimary)),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: ZenoSpacing.xl),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStickyKPI(ZenoSemanticColors colors) {
    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: ZenoSpacing.lg, vertical: ZenoSpacing.md),
      margin: const EdgeInsets.only(bottom: ZenoSpacing.md),
      decoration: BoxDecoration(
        color: colors.bgTier1,
        border: Border(bottom: BorderSide(color: colors.borderSubtle)),
      ),
      child: Row(
        children: [
          _KPIItem(
              label: "TOTAL SUPPLIERS",
              value: controller.suppliers.length.toString(),
              icon: Icons.factory_outlined,
              color: colors.statusInfo),
          _vDivider(colors),
          _KPIItem(
              label: "RELIABILITY INDEX",
              value: "${(controller.avgReliability * 100).toInt()}%",
              icon: Icons.verified_outlined,
              color: colors.statusSuccess),
          _vDivider(colors),
          _KPIItem(
              label: "PREFERRED NODES",
              value: controller.preferredCount.toString(),
              icon: Icons.star_outline,
              color: colors.amberGold),
          _vDivider(colors),
          _KPIItem(
              label: "MTD SPEND",
              value: "\$182.4K",
              icon: Icons.payments_outlined,
              color: colors.accentPurple),
        ],
      ),
    );
  }

  Widget _vDivider(ZenoSemanticColors colors) => Container(
      height: 32,
      width: 1,
      color: colors.borderSubtle,
      margin: const EdgeInsets.symmetric(horizontal: ZenoSpacing.xl));
}
