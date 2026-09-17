import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/core/widgets/zeno_header.dart';
import 'package:zeno/core/widgets/zeno_card.dart';
import 'package:zeno/core/di/service_locator.dart';
import '../../domain/repositories/i_delivery_repository.dart';
import '../controllers/delivery_controller.dart';

class LiveTrackingHubScreen extends StatefulWidget {
  const LiveTrackingHubScreen({super.key});

  @override
  State<LiveTrackingHubScreen> createState() => _LiveTrackingHubScreenState();
}

class _LiveTrackingHubScreenState extends State<LiveTrackingHubScreen> {
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
          title: "Real-Time Tracking".toUpperCase(),
          subtitle:
              "LIVE GPS MONITORING OF FLEET MOVEMENT, VEHICLE UTILIZATION, AND ROUTE COMPLIANCE.",
          actions: const [
            _HubButton(label: "Satellite View", icon: Icons.layers_outlined),
            SizedBox(width: ZenoSpacing.md),
            _HubButton(
                label: "Live Fleet Map", icon: Icons.map, isPrimary: true),
          ],
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(ZenoSpacing.lg),
            child: Row(
              children: [
                // Fleet List
                Expanded(
                  flex: 1,
                  child: ZenoCard(
                    title: "ACTIVE FLEET",
                    trailing: Text("${controller.vehicles.length} ONLINE",
                        style: ZenoTypography.caption(colors.accentPrimary)
                            .copyWith(fontWeight: FontWeight.bold)),
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: controller.vehicles.length,
                      itemBuilder: (context, index) => _VehicleStatusItem(
                          id: controller.vehicles[index].plateNumber,
                          colors: colors),
                    ),
                  ),
                ),
                const SizedBox(width: ZenoSpacing.lg),
                // Map Placeholder
                Expanded(
                  flex: 2,
                  child: ZenoCard(
                    padding: EdgeInsets.zero,
                    child: Stack(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: const Color(0xFF08080C),
                            borderRadius: BorderRadius.circular(ZenoRadius.lg),
                          ),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(32),
                                  decoration: BoxDecoration(
                                      color: const Color(0xFF00F0FF)
                                          .withValues(alpha: 0.05),
                                      shape: BoxShape.circle),
                                  child: Icon(Icons.my_location,
                                      size: 64,
                                      color: const Color(0xFF00F0FF)
                                          .withValues(alpha: 0.2)),
                                ),
                                const SizedBox(height: 24),
                                Text("INITIALIZING LIVE TELEMETRY STREAM...",
                                    style: ZenoTypography.caption(
                                            colors.textSecondary)
                                        .copyWith(
                                            letterSpacing: 2,
                                            fontWeight: FontWeight.bold)),
                              ],
                            ),
                          ),
                        ),
                        // HUD Overlay
                        Positioned(
                          top: 24,
                          right: 24,
                          child: AnimatedContainer(
                            duration: ZenoDuration.std,
                            padding: const EdgeInsets.all(ZenoSpacing.lg),
                            decoration: BoxDecoration(
                              color: Colors.black.withValues(alpha: 0.8),
                              borderRadius:
                                  BorderRadius.circular(ZenoRadius.lg),
                              border: Border.all(
                                  color: const Color(0xFF00F0FF)
                                      .withValues(alpha: 0.3)),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black.withValues(alpha: 0.4),
                                    blurRadius: 20,
                                    offset: const Offset(0, 10)),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _HudMetric(
                                    label: "AVG FLEET SPEED",
                                    value: "24 KM/H",
                                    colors: colors),
                                const SizedBox(height: 16),
                                _HudMetric(
                                    label: "GPS SIGNAL",
                                    value: "EXCELLENT",
                                    color: const Color(0xFF00FF88),
                                    colors: colors),
                                const SizedBox(height: 16),
                                _HudMetric(
                                    label: "DATA SYNC",
                                    value: "LIVE",
                                    color: const Color(0xFF00F0FF),
                                    colors: colors),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _HubButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool isPrimary;

  const _HubButton(
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
      ),
    );
  }
}

class _VehicleStatusItem extends StatelessWidget {
  final String id;
  final ZenoSemanticColors colors;
  const _VehicleStatusItem({required this.id, required this.colors});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: ZenoSpacing.md),
      padding: const EdgeInsets.all(ZenoSpacing.md),
      decoration: BoxDecoration(
        color: colors.bgTier3,
        borderRadius: BorderRadius.circular(ZenoRadius.md),
        border: Border.all(color: colors.borderSubtle),
      ),
      child: Row(
        children: [
          const Icon(Icons.directions_car_filled_outlined,
              size: 14, color: Color(0xFF00F0FF)),
          const SizedBox(width: ZenoSpacing.md),
          Text(id.toUpperCase(),
              style: ZenoTypography.bodyMD(colors.textPrimary).copyWith(
                  fontWeight: FontWeight.bold,
                  fontFamily: ZenoTypography.monoFamily)),
          const Spacer(),
          Text("MOVING",
              style: ZenoTypography.micro(const Color(0xFF00FF88))
                  .copyWith(fontWeight: FontWeight.w900)),
        ],
      ),
    );
  }
}

class _HudMetric extends StatelessWidget {
  final String label;
  final String value;
  final Color? color;
  final ZenoSemanticColors colors;

  const _HudMetric(
      {required this.label,
      required this.value,
      this.color,
      required this.colors});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: ZenoTypography.micro(colors.textDisabled)
                .copyWith(letterSpacing: 1, fontWeight: FontWeight.w900)),
        const SizedBox(height: 4),
        Text(value,
            style: ZenoTypography.bodyLG(color ?? Colors.white).copyWith(
                fontWeight: FontWeight.w900,
                fontFamily: ZenoTypography.monoFamily)),
      ],
    );
  }
}
