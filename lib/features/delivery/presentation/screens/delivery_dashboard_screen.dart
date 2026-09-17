import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/core/widgets/zeno_header.dart';
import 'package:zeno/core/widgets/zeno_card.dart';
import 'package:zeno/core/di/service_locator.dart';
import '../../domain/repositories/i_delivery_repository.dart';
import '../controllers/delivery_controller.dart';

part 'parts/delivery_dashboard_widgets.part.dart';

class DeliveryDashboardScreen extends StatefulWidget {
  const DeliveryDashboardScreen({super.key});

  @override
  State<DeliveryDashboardScreen> createState() =>
      _DeliveryDashboardScreenState();
}

class _DeliveryDashboardScreenState extends State<DeliveryDashboardScreen> {
  final controller = DeliveryController(sl<IDeliveryRepository>());

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
          title: "Logistics Command".toUpperCase(),
          subtitle:
              "ORCHESTRATE LAST-MILE OPERATIONS, MONITOR FLEET TELEMETRY, AND OPTIMIZE DISPATCH VELOCITY.",
          actions: const [
            _HeaderButton(
                label: "Optimize Routes", icon: Icons.auto_fix_high_outlined),
            SizedBox(width: ZenoSpacing.md),
            _HeaderButton(
                label: "Assign Driver",
                icon: Icons.person_add_alt_1,
                isPrimary: true),
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
                        title: "AI DISPATCH INTELLIGENCE",
                        trailing: const Icon(Icons.auto_awesome,
                            size: 16, color: Color(0xFF00F0FF)),
                        child: Column(
                          children: [
                            const _DispatchMetric(
                              label: "ROUTE LOAD BALANCE",
                              value: 0.88,
                              color: Color(0xFF00FF88),
                            ),
                            const SizedBox(height: ZenoSpacing.lg),
                            const _DispatchMetric(
                              label: "PREDICTED ARRIVAL ACCURACY",
                              value: 0.96,
                              color: Color(0xFF00F0FF),
                            ),
                            const SizedBox(height: ZenoSpacing.xl),
                            AnimatedContainer(
                              duration: ZenoDuration.std,
                              padding: const EdgeInsets.all(ZenoSpacing.md),
                              decoration: BoxDecoration(
                                color: const Color(0xFF00F0FF)
                                    .withValues(alpha: 0.05),
                                borderRadius:
                                    BorderRadius.circular(ZenoRadius.lg),
                                border: Border.all(
                                    color: const Color(0xFF00F0FF)
                                        .withValues(alpha: 0.2)),
                              ),
                              child: Row(
                                children: [
                                  const Icon(Icons.psychology_outlined,
                                      color: Color(0xFF00F0FF), size: 24),
                                  const SizedBox(width: ZenoSpacing.md),
                                  Expanded(
                                    child: Text(
                                      "AI DISPATCH SUGGESTS RE-ALLOCATING 3 ORDERS FROM 'ROUTE A' TO 'ROUTE B' TO REDUCE AVERAGE ETA BY 12 MINUTES BASED ON REAL-TIME TRAFFIC DATA.",
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
                        title: "AGENT FLEET STATUS",
                        child: Column(
                          children: [
                            ...controller.drivers
                                .take(3)
                                .map((d) => _AgentStatusItem(
                                      name: d.name.toUpperCase(),
                                      status: d.status
                                          .toUpperCase()
                                          .replaceAll('_', ' '),
                                      icon: Icons.directions_bike,
                                      color: const Color(0xFF00FF88),
                                    )),
                            const SizedBox(height: ZenoSpacing.md),
                            SizedBox(
                              width: double.infinity,
                              child: TextButton(
                                onPressed: () {},
                                child: Text("VIEW FULL FLEET MAP",
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
              label: "ACTIVE DELIVERIES",
              value: controller.activeDeliveryCount.toString(),
              icon: Icons.local_shipping_outlined,
              color: const Color(0xFF00FF88),
              colors: colors),
          _vDivider(colors),
          _KPIItem(
              label: "ON-DUTY AGENTS",
              value: controller.drivers.length.toString(),
              icon: Icons.badge_outlined,
              color: const Color(0xFF9D50BB),
              colors: colors),
          _vDivider(colors),
          _KPIItem(
              label: "ON-TIME RATE",
              value:
                  "${(controller.fleetOnTimeRate * 100).toStringAsFixed(1)}%",
              icon: Icons.timer_outlined,
              color: const Color(0xFFFFD700),
              colors: colors),
          _vDivider(colors),
          _KPIItem(
              label: "FUEL EFFICIENCY",
              value: "14.2 KM/L",
              icon: Icons.speed,
              color: const Color(0xFF00D2FF),
              colors: colors),
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
