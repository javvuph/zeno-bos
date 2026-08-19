import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/core/widgets/zeno_header.dart';
import 'package:zeno/core/widgets/zeno_card.dart';
import 'package:zeno/core/di/service_locator.dart';
import '../../domain/repositories/i_sales_repository.dart';
import '../../domain/models/sales_order_status.dart';
import '../controllers/sales_controller.dart';

class OrdersDashboardScreen extends StatefulWidget {
  const OrdersDashboardScreen({super.key});

  @override
  State<OrdersDashboardScreen> createState() => _OrdersDashboardScreenState();
}

class _OrdersDashboardScreenState extends State<OrdersDashboardScreen> {
  final controller = SalesController(sl<ISalesRepository>());

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
              "TRACK ORDER VOLUME, FULFILLMENT VELOCITY, AND GLOBAL DELIVERY PERFORMANCE.",
          actions: [
            _HeaderButton(
                label: "Export Manifest", icon: Icons.download_outlined),
            const SizedBox(width: ZenoSpacing.md),
            _HeaderButton(
                label: "Create Order",
                icon: Icons.add_shopping_cart,
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
                    // AI Logistics
                    Expanded(
                      flex: 2,
                      child: ZenoCard(
                        title: "AI LOGISTICS INTELLIGENCE",
                        trailing: const Icon(Icons.auto_awesome,
                            size: 16, color: Color(0xFF00F0FF)),
                        child: Column(
                          children: [
                            const _LogisticsMetric(
                              label: "ROUTE OPTIMIZATION EFFICIENCY",
                              value: 0.92,
                              color: Color(0xFF38ef7d),
                            ),
                            const SizedBox(height: ZenoSpacing.lg),
                            const _LogisticsMetric(
                              label: "PREDICTED DELAY RISK",
                              value: 0.15,
                              color: Color(0xFFee0979),
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
                                  const Icon(Icons.map_outlined,
                                      color: Color(0xFF00F0FF), size: 24),
                                  const SizedBox(width: ZenoSpacing.md),
                                  Expanded(
                                    child: Text(
                                      "AI ALERT: HEAVY TRAFFIC DETECTED ON SECTOR-4 ROUTE. RE-ROUTING 5 DELIVERIES TO SAVE APPROXIMATELY 45 MINUTES OF TRANSIT TIME.",
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

                    // Order Feed
                    Expanded(
                      flex: 1,
                      child: ZenoCard(
                        title: "LIVE ORDER TIMELINE",
                        child: Column(
                          children: [
                            ...controller.orders
                                .take(3)
                                .map((o) => _OrderFeedItem(
                                      id: o.id.toUpperCase(),
                                      status: o.status.name
                                          .toUpperCase()
                                          .replaceAll('_', ' '),
                                      time: "JUST NOW",
                                      color: _getStatusColor(o.status, colors),
                                    )),
                            const SizedBox(height: ZenoSpacing.md),
                            SizedBox(
                              width: double.infinity,
                              child: TextButton(
                                onPressed: () {},
                                child: Text("VIEW TRACKING MAP",
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
              label: "PENDING ORDERS",
              value: controller.activeOrderCount.toString(),
              icon: Icons.pending_actions_outlined,
              color: const Color(0xFFFF9800),
              colors: colors),
          _vDivider(colors),
          _KPIItem(
              label: "PROCESSING",
              value: "42",
              icon: Icons.inventory_2_outlined,
              color: const Color(0xFF00D2FF),
              colors: colors),
          _vDivider(colors),
          _KPIItem(
              label: "OUT FOR DELIVERY",
              value: "18",
              icon: Icons.local_shipping_outlined,
              color: const Color(0xFF00FF88),
              colors: colors),
          _vDivider(colors),
          _KPIItem(
              label: "DELIVERY SUCCESS",
              value: "98.2%",
              icon: Icons.verified_user_outlined,
              color: const Color(0xFF38ef7d),
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

  Color _getStatusColor(SalesOrderStatus status, ZenoSemanticColors colors) {
    if (status == SalesOrderStatus.delivered) return colors.statusSuccess;
    if (status == SalesOrderStatus.shipped) return colors.statusSuccess;
    if (status == SalesOrderStatus.processing) return colors.statusWarning;
    return colors.accentPrimary;
  }
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
      ),
    );
  }
}

class _LogisticsMetric extends StatelessWidget {
  final String label;
  final double value;
  final Color color;

  const _LogisticsMetric(
      {required this.label, required this.value, required this.color});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label, style: ZenoTypography.micro(color)),
            Text("${(value * 100).toInt()}%",
                style: ZenoTypography.caption(color)
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

class _OrderFeedItem extends StatelessWidget {
  final String id;
  final String status;
  final String time;
  final Color color;

  const _OrderFeedItem({
    required this.id,
    required this.status,
    required this.time,
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
            width: 8,
            height: 8,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(id,
                    style: ZenoTypography.bodyMD(colors.textPrimary).copyWith(
                        fontWeight: FontWeight.bold,
                        fontFamily: ZenoTypography.monoFamily)),
                Text(status,
                    style: ZenoTypography.micro(color)
                        .copyWith(fontWeight: FontWeight.w900)),
              ],
            ),
          ),
          Text(time, style: ZenoTypography.micro(colors.textDisabled)),
        ],
      ),
    );
  }
}
