import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/core/widgets/zeno_header.dart';
import 'package:zeno/core/widgets/zeno_card.dart';
import 'package:zeno/core/di/service_locator.dart';
import 'journal_entry_form_screen.dart';
import '../controllers/finance_controller.dart';
import 'package:zeno/navigation/navigation_controller.dart';

part 'parts/finance_dashboard_widgets.part.dart';

class FinanceDashboardScreen extends StatefulWidget {
  const FinanceDashboardScreen({super.key});

  @override
  State<FinanceDashboardScreen> createState() => _FinanceDashboardScreenState();
}

class _FinanceDashboardScreenState extends State<FinanceDashboardScreen> {
  late final FinanceController controller;

  @override
  void initState() {
    super.initState();
    controller = sl<FinanceController>();
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
          title: "Financial Command Hub".toUpperCase(),
          subtitle:
              "REAL-TIME TRACKING OF GLOBAL CASH FLOW, PROFITABILITY, AND FISCAL HEALTH.",
          actions: [
            const _FinanceHeaderButton(
                label: "Fiscal Year End", icon: Icons.event_busy_outlined),
            const SizedBox(width: ZenoSpacing.md),
            _FinanceHeaderButton(
              label: "New Journal",
              icon: Icons.edit_note,
              isPrimary: true,
              onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const JournalEntryFormScreen())),
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
                        title: "AI FINANCIAL INTELLIGENCE",
                        trailing: Icon(Icons.auto_awesome,
                            size: 16, color: colors.accentPrimary),
                        child: Column(
                          children: [
                            _FinanceMetric(
                              label: "LIQUIDITY RATIO",
                              value: 0.94,
                              color: colors.statusSuccess,
                            ),
                            const SizedBox(height: ZenoSpacing.lg),
                            _FinanceMetric(
                              label: "PROFIT MARGIN TARGET",
                              value: 0.82,
                              color: colors.statusInfo,
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
                                      "AI FORECAST: PROJECTED CASH FLOW FOR Q3 SUGGESTS A 15% SURPLUS. RECOMMENDATION: INCREASE ASSET ALLOCATION TOWARDS 'WAREHOUSE EXPANSION' TO OPTIMIZE LONG-TERM DEPRECIATION BENEFITS.",
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
                      child: Column(
                        children: [
                          ZenoCard(
                            title: "FINANCIAL REPORTS",
                            child: Column(
                              children: [
                                _ReportRow(
                                    label: "Trial Balance",
                                    route: 'reports/fin/trial-balance',
                                    colors: colors),
                                _ReportRow(
                                    label: "Profit & Loss",
                                    route: 'reports/fin/pl',
                                    colors: colors),
                                _ReportRow(
                                    label: "Balance Sheet",
                                    route: 'reports/fin/balance-sheet',
                                    colors: colors),
                              ],
                            ),
                          ),
                          const SizedBox(height: ZenoSpacing.lg),
                          ZenoCard(
                            title: "RECENT TRANSACTIONS",
                            child: Column(
                              children: [
                                ...controller.entries
                                    .take(3)
                                    .map((e) => _LedgerItem(
                                          title: e.description.toUpperCase(),
                                          subtitle: e.referenceNumber,
                                          amount: "${e.lines.first.debit > 0
                                                  ? "+"
                                                  : "-"}\$${e.lines.fold(0.0, (s, l) => s + l.debit).toStringAsFixed(0)}",
                                          color: e.lines.first.debit > 0
                                              ? colors.statusSuccess
                                              : colors.statusWarning,
                                        )),
                                const SizedBox(height: ZenoSpacing.md),
                                SizedBox(
                                  width: double.infinity,
                                  child: TextButton(
                                    onPressed: () {},
                                    child: Text("VIEW GENERAL LEDGER",
                                        style: ZenoTypography.caption(
                                            colors.accentPrimary)),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
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
              label: "OPERATING CASH",
              value: "\$${controller.operatingCash.toStringAsFixed(0)}",
              icon: Icons.account_balance_wallet_outlined,
              color: colors.statusInfo),
          _vDivider(colors),
          _KPIItem(
              label: "NET PROFIT (MTD)",
              value:
                  "\$${controller.kpis['net_profit']?.toStringAsFixed(0) ?? '0'}",
              icon: Icons.analytics_outlined,
              color: colors.statusSuccess),
          _vDivider(colors),
          _KPIItem(
              label: "RECEIVABLES",
              value: "\$${controller.totalReceivables.toStringAsFixed(0)}",
              icon: Icons.payments_outlined,
              color: colors.statusWarning),
          _vDivider(colors),
          _KPIItem(
              label: "TAX LIABILITY",
              value: "\$15.2K",
              icon: Icons.gavel_outlined,
              color: colors.statusDanger),
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
