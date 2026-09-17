import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/core/di/service_locator.dart';
import 'package:zeno/features/reports/domain/repositories/i_reports_repository.dart';
import 'package:zeno/features/reports/presentation/controllers/reports_controller.dart';
import 'package:zeno/navigation/navigation_controller.dart' as nav;

part 'parts/executive_kpi_painters.part.dart';

class ExecutiveKPIRow extends StatefulWidget {
  const ExecutiveKPIRow({super.key});

  @override
  State<ExecutiveKPIRow> createState() => _ExecutiveKPIRowState();
}

class _ExecutiveKPIRowState extends State<ExecutiveKPIRow> {
  final controller = ReportsController(sl<IReportsRepository>());

  @override
  void initState() {
    super.initState();
    controller.addListener(_onUpdate);
    controller.refreshDashboard();
  }

  void _onUpdate() {
    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    controller.removeListener(_onUpdate);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (controller.dashboardKPIs.isEmpty) {
      return const SizedBox(
        height: 96,
        child: Center(child: CircularProgressIndicator()),
      );
    }

    final kpis = controller.dashboardKPIs;

    return SizedBox(
      height: 96,
      child: Row(
        children: kpis.map((kpi) {
          return Expanded(
            child: Padding(
              padding: EdgeInsets.only(right: kpis.last == kpi ? 0 : 12),
              child: InkWell(
                onTap: () =>
                    nav.NavigationController().openTab('reports/dashboard'),
                borderRadius: BorderRadius.circular(8),
                child: _KPICard(
                  title: kpi.label.toUpperCase(),
                  value: kpi.value,
                  trend:
                      "${kpi.change > 0 ? '▲' : '▼'} ${kpi.change.abs().toStringAsFixed(1)}%",
                  subtext: kpi.change >= 0 ? "Growth Observed" : "Below Target",
                  color: kpi.color,
                  graphic: _getGraphicForId(kpi.id),
                  isWarning: kpi.change < 0,
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _getGraphicForId(String id) {
    switch (id) {
      case 'revenue':
        return const _SparklineGraphic();
      case 'profit':
        return const _DonutGraphic(percent: 0.231);
      case 'purchase':
        return const _ExpenseStackedGraphic();
      default:
        return const _CashBarsGraphic();
    }
  }
}

class _KPICard extends StatelessWidget {
  final String title;
  final String value;
  final String trend;
  final String subtext;
  final Color color;
  final Widget graphic;
  final bool isWarning;

  const _KPICard({
    required this.title,
    required this.value,
    required this.trend,
    required this.subtext,
    required this.color,
    required this.graphic,
    this.isWarning = false,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<ZenoSemanticColors>()!;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: colors.bgTier2,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: colors.borderSubtle),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: colors.textSecondary,
                    letterSpacing: 0.2,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              graphic,
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 2),
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                value,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: colors.textPrimary,
                  letterSpacing: -0.5,
                ),
              ),
            ),
          ),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(color: color.withValues(alpha: 0.3)),
                ),
                child: Text(
                  trend,
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    color: color,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Flexible(
                child: Text(
                  subtext,
                  style: TextStyle(
                    fontSize: 11,
                    color:
                        isWarning ? colors.statusDanger : colors.textSecondary,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
