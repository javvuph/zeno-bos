import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/core/widgets/zeno_header.dart';
import 'package:zeno/core/widgets/zeno_card.dart';
import 'package:zeno/core/di/service_locator.dart';
import '../../domain/repositories/i_staff_repository.dart';
import '../controllers/staff_controller.dart';

part 'parts/payroll_dashboard_widgets.part.dart';

class PayrollDashboardScreen extends StatefulWidget {
  const PayrollDashboardScreen({super.key});

  @override
  State<PayrollDashboardScreen> createState() => _PayrollDashboardScreenState();
}

class _PayrollDashboardScreenState extends State<PayrollDashboardScreen> {
  final controller = StaffController(sl<IStaffRepository>());

  @override
  void initState() {
    super.initState();
    controller.addListener(_onUpdate);
  }

  void _onUpdate() => setState(() {});

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
          title: "Payroll Control Hub".toUpperCase(),
          subtitle:
              "MANAGE GLOBAL SALARY DISBURSEMENTS, PERFORMANCE BONUSES, AND TAX DEDUCTIONS.",
          actions: [
            _PayrollButton(
              label: "PROCESS PAYROLL",
              icon: Icons.sync,
              isPrimary: true,
              colors: colors,
              onPressed: () async {
                await controller.runPayroll('2026-08');
                if (mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("Payroll Processed & Journals Posted")));
                }
              },
            ),
          ],
        ),
        _buildStickyKPI(colors),
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(ZenoSpacing.lg),
            child: Column(
              children: [
                ZenoCard(
                  title: "RECENT PAYROLL CYCLES",
                  trailing: Text("2 HISTORICAL",
                      style: ZenoTypography.caption(colors.accentPrimary)
                          .copyWith(fontWeight: FontWeight.bold)),
                  child: Column(
                    children: [
                      _HistoryItem(
                          month: "JUNE 2026",
                          amount: "\$342,000",
                          status: "COMPLETED",
                          colors: colors),
                      _HistoryItem(
                          month: "MAY 2026",
                          amount: "\$338,500",
                          status: "COMPLETED",
                          colors: colors),
                      const SizedBox(height: ZenoSpacing.lg),
                      _ActionBtn(
                          label: "VIEW DETAILED DISBURSEMENT LOG",
                          colors: colors),
                    ],
                  ),
                ),
                const SizedBox(height: ZenoSpacing.xl),
                _buildTaxGrid(colors),
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
          border: Border(bottom: BorderSide(color: colors.borderSubtle))),
      child: Row(
        children: [
          _SummaryItem(
              label: "TOTAL SALARY (MTD)",
              value: "\$342K",
              icon: Icons.payments_outlined,
              color: const Color(0xFFFFD700),
              colors: colors),
          _vDivider(colors),
          _SummaryItem(
              label: "TAX ACCRUED",
              value: "\$52K",
              icon: Icons.gavel_outlined,
              color: const Color(0xFFee0979),
              colors: colors),
          _vDivider(colors),
          _SummaryItem(
              label: "DISBURSED RATE",
              value: "95%",
              icon: Icons.check_circle_outline,
              color: const Color(0xFF38ef7d),
              colors: colors),
          const Spacer(),
          _FilterChip(
              label: "ACTIVE CYCLE",
              count: 1,
              isSelected: true,
              colors: colors),
        ],
      ),
    );
  }

  Widget _buildTaxGrid(ZenoSemanticColors colors) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 3,
      crossAxisSpacing: ZenoSpacing.lg,
      mainAxisSpacing: ZenoSpacing.lg,
      childAspectRatio: 2.5,
      children: [
        _AIActionCard(
            title: "Tax Optimization",
            icon: Icons.savings_outlined,
            colors: colors),
        _AIActionCard(
            title: "Bonus Allocation",
            icon: Icons.stars_outlined,
            colors: colors),
        _AIActionCard(
            title: "Compliance Audit",
            icon: Icons.verified_user_outlined,
            colors: colors),
      ],
    );
  }

  Widget _vDivider(ZenoSemanticColors colors) => Container(
      height: 24,
      width: 1,
      color: colors.borderSubtle,
      margin: const EdgeInsets.symmetric(horizontal: ZenoSpacing.lg));
}
