import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/core/widgets/zeno_header.dart';
import 'package:zeno/core/widgets/zeno_card.dart';
import 'package:zeno/core/di/service_locator.dart';
import '../../domain/repositories/i_supplier_repository.dart';
import '../controllers/supplier_controller.dart';
import 'supplier_form_screen.dart';

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
            _HeaderButton(
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
        // STICKY KPI SUMMARY
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
                    // AI Procurement Insights
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

                    // Critical Vendors
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

class _KPIItem extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final Color color;
  const _KPIItem(
      {required this.label,
      required this.value,
      required this.icon,
      required this.color});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<ZenoSemanticColors>()!;
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8)),
          child: Icon(icon, size: 18, color: color),
        ),
        const SizedBox(width: ZenoSpacing.md),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: ZenoTypography.micro(colors.textDisabled)),
            const SizedBox(height: 2),
            Text(value,
                style: ZenoTypography.headlineMD(colors.textPrimary)
                    .copyWith(fontWeight: FontWeight.w900)),
          ],
        ),
      ],
    );
  }
}

class _HeaderButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool isPrimary;
  final VoidCallback? onPressed;

  const _HeaderButton(
      {required this.label,
      required this.icon,
      this.isPrimary = false,
      this.onPressed});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<ZenoSemanticColors>()!;
    return ElevatedButton.icon(
      onPressed: onPressed ?? () {},
      icon: Icon(icon, size: 16),
      label: Text(label),
      style: ElevatedButton.styleFrom(
        backgroundColor: isPrimary ? colors.accentPrimary : colors.bgSurface,
        foregroundColor: Colors.white,
        side: isPrimary ? null : BorderSide(color: colors.borderSubtle),
      ),
    );
  }
}

class _ProcurementMetric extends StatelessWidget {
  final String label;
  final double value;
  final Color color;

  const _ProcurementMetric(
      {required this.label, required this.value, required this.color});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<ZenoSemanticColors>()!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label, style: ZenoTypography.bodyMD(colors.textSecondary)),
            Text("${(value * 100).toInt()}%",
                style: TextStyle(
                    fontSize: 12, fontWeight: FontWeight.bold, color: color)),
          ],
        ),
        const SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(2),
          child: LinearProgressIndicator(
            value: value,
            backgroundColor: color.withValues(alpha: 0.1),
            valueColor: AlwaysStoppedAnimation<Color>(color),
            minHeight: 4,
          ),
        ),
      ],
    );
  }
}

class _VendorItem extends StatelessWidget {
  final String name;
  final String rating;
  final IconData icon;
  final Color color;

  const _VendorItem({
    required this.name,
    required this.rating,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<ZenoSemanticColors>()!;
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: 14, color: color),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name,
                    style: ZenoTypography.bodyLG(colors.textPrimary)
                        .copyWith(fontSize: 13, fontWeight: FontWeight.bold)),
                Text(rating,
                    style: ZenoTypography.bodyMD(colors.textSecondary)),
              ],
            ),
          ),
          Icon(Icons.verified, size: 12, color: colors.statusSuccess),
        ],
      ),
    );
  }
}
