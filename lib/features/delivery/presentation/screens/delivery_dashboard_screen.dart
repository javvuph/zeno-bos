import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/core/widgets/zeno_header.dart';
import 'package:zeno/core/widgets/zeno_card.dart';
import 'package:zeno/core/di/service_locator.dart';
import '../../domain/repositories/i_delivery_repository.dart';
import '../controllers/delivery_controller.dart';

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
          actions: [
            _HeaderButton(
                label: "Optimize Routes", icon: Icons.auto_fix_high_outlined),
            const SizedBox(width: ZenoSpacing.md),
            _HeaderButton(
                label: "Assign Driver",
                icon: Icons.person_add_alt_1,
                isPrimary: true),
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
                    // AI Dispatch Intelligence
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

                    // Fleet Status
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

class _KPIItem extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final Color color;
  final ZenoSemanticColors colors;
  const _KPIItem(
      {required this.label,
      required this.value,
      required this.icon,
      required this.color,
      required this.colors});

  @override
  Widget build(BuildContext context) {
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

  const _HeaderButton(
      {required this.label, required this.icon, this.isPrimary = false});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<ZenoSemanticColors>()!;
    return ElevatedButton.icon(
      onPressed: () {},
      icon: Icon(icon, size: 16),
      label: Text(label.toUpperCase(),
          style: ZenoTypography.caption(
                  isPrimary ? Colors.black : colors.textPrimary)
              .copyWith(fontWeight: FontWeight.bold)),
      style: ElevatedButton.styleFrom(
        backgroundColor: isPrimary ? colors.accentPrimary : colors.bgTier3,
        foregroundColor: isPrimary ? Colors.black : colors.textPrimary,
        elevation: 0,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(ZenoRadius.md)),
        side: isPrimary ? null : BorderSide(color: colors.borderSubtle),
      ),
    );
  }
}

class _DispatchMetric extends StatelessWidget {
  final String label;
  final double value;
  final Color color;

  const _DispatchMetric(
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
            Text(label, style: ZenoTypography.micro(colors.textSecondary)),
            Text("${(value * 100).toInt()}%",
                style: ZenoTypography.micro(color)
                    .copyWith(fontWeight: FontWeight.bold)),
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

class _AgentStatusItem extends StatelessWidget {
  final String name;
  final String status;
  final IconData icon;
  final Color color;

  const _AgentStatusItem({
    required this.name,
    required this.status,
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
                    style: ZenoTypography.bodyMD(colors.textPrimary)
                        .copyWith(fontWeight: FontWeight.bold)),
                Text(status,
                    style: ZenoTypography.micro(color.withValues(alpha: 0.8))
                        .copyWith(fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          Icon(Icons.location_on_outlined,
              size: 12, color: colors.textSecondary),
        ],
      ),
    );
  }
}
