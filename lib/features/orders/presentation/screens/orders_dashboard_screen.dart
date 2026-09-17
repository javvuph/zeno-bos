import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/core/widgets/zeno_header.dart';
import 'package:zeno/core/widgets/zeno_card.dart';
import 'package:zeno/core/di/service_locator.dart';
import '../../domain/repositories/i_sales_repository.dart';
import '../../domain/models/sales_order_status.dart';
import '../controllers/sales_controller.dart';

part 'parts/orders_dashboard_widgets.part.dart';

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
          actions: const [
            _HeaderButton(
                label: "Export Manifest", icon: Icons.download_outlined),
            SizedBox(width: ZenoSpacing.md),
            _HeaderButton(
                label: "Create Order",
                icon: Icons.add_shopping_cart,
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
