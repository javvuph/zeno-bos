import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/core/widgets/zeno_header.dart';
import 'package:zeno/core/widgets/zeno_card.dart';
import 'package:zeno/core/di/service_locator.dart';
import '../../domain/repositories/i_inventory_repository.dart';
import '../controllers/inventory_controller.dart';
import 'widgets/dashboard/dashboard_widgets.dart';

class ProductDashboardScreen extends StatefulWidget {
  const ProductDashboardScreen({super.key});
  @override
  State<ProductDashboardScreen> createState() => _ProductDashboardScreenState();
}

class _ProductDashboardScreenState extends State<ProductDashboardScreen> {
  final controller = InventoryController(sl<IInventoryRepository>());
  @override
  void initState() { super.initState(); controller.addListener(_onUpdate); }
  void _onUpdate() => setState(() {});
  @override
  void dispose() { controller.removeListener(_onUpdate); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      ZenoHeader(title: "Inventory Dashboard".toUpperCase(), subtitle: "REAL-TIME OVERVIEW OF GLOBAL PRODUCT CATALOG AND PERFORMANCE.", actions: const [HeaderButton(label: "Export Report", icon: Icons.download_outlined, isPrimary: false)]),
      Expanded(child: SingleChildScrollView(padding: const EdgeInsets.all(ZenoSpacing.lg), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        _buildStatsGrid(), const SizedBox(height: ZenoSpacing.xl),
        Row(crossAxisAlignment: CrossAxisAlignment.start, children: [_buildAIHealthCard(), const SizedBox(width: ZenoSpacing.lg), _buildActivityCard()]),
        const SizedBox(height: ZenoSpacing.xl),
        _buildTopCategoriesCard(),
      ]))),
    ]);
  }

  Widget _buildStatsGrid() {
    return Row(children: [
      const Expanded(child: ZenoStatCard(label: "TOTAL PRODUCTS", value: "12,450", change: "+12.5%", icon: Icons.inventory_2_outlined)),
      const SizedBox(width: ZenoSpacing.lg),
      const Expanded(child: ZenoStatCard(label: "ACTIVE VARIANTS", value: "45,200", change: "+8.2%", icon: Icons.account_tree_outlined, iconColor: ZenoTheme.cyan500)),
      const SizedBox(width: ZenoSpacing.lg),
      Expanded(child: ZenoStatCard(label: "OUT OF STOCK", value: controller.outOfStockCount.toString(), change: "-2.4%", isPositive: false, icon: Icons.error_outline, iconColor: ZenoTheme.ruby500)),
      const SizedBox(width: ZenoSpacing.lg),
      const Expanded(child: ZenoStatCard(label: "CATALOG VALUE", value: "\$1.2M", change: "+15.3%", icon: Icons.attach_money_outlined, iconColor: ZenoTheme.green500)),
    ]);
  }

  Widget _buildAIHealthCard() {
    return Expanded(flex: 2, child: ZenoCard(title: "AI INVENTORY HEALTH", trailing: const Icon(Icons.auto_awesome, size: 16, color: ZenoTheme.violet500), child: Column(children: [
      const HealthMetric(label: "DATA COMPLETENESS", value: 0.92, color: ZenoTheme.green500), const SizedBox(height: ZenoSpacing.md),
      const HealthMetric(label: "CATEGORIZATION ACCURACY", value: 0.85, color: ZenoTheme.cyan500), const SizedBox(height: ZenoSpacing.md),
      const HealthMetric(label: "IMAGE QUALITY SCORE", value: 0.78, color: ZenoTheme.amber500), const SizedBox(height: ZenoSpacing.xl),
      _buildAITip(),
    ])));
  }

  Widget _buildAITip() {
    return AnimatedContainer(duration: ZenoDuration.std, padding: const EdgeInsets.all(ZenoSpacing.md), decoration: BoxDecoration(gradient: ZenoTheme.aiVioletGradient.withValues(alpha: 0.05), borderRadius: BorderRadius.circular(ZenoRadius.lg), border: Border.all(color: ZenoTheme.violet500.withValues(alpha: 0.2))), child: Row(children: [
      const Icon(Icons.lightbulb_outline, color: ZenoTheme.violet500, size: 24), const SizedBox(width: ZenoSpacing.md),
      Expanded(child: Text("AI SUGGESTS ADDING DESCRIPTIONS TO 45 PRODUCTS IN THE 'ELECTRONICS' CATEGORY TO IMPROVE SEO AND SEARCHABILITY.", style: ZenoTypography.caption(ZenoTheme.textPrimary).copyWith(height: 1.5, letterSpacing: 0.2))),
    ]));
  }

  Widget _buildActivityCard() {
    return Expanded(flex: 1, child: ZenoCard(title: "RECENT ACTIVITY", child: Column(children: [
      ...controller.recentTransactions.map((trx) => ActivityItem(title: trx.stockItemId.toUpperCase(), subtitle: (trx.notes ?? "").toUpperCase(), time: "JUST NOW", icon: trx.quantityDelta > 0 ? Icons.add_circle_outline : Icons.remove_circle_outline, color: trx.quantityDelta > 0 ? ZenoTheme.green500 : ZenoTheme.ruby500)),
      const SizedBox(height: ZenoSpacing.md),
      SizedBox(width: double.infinity, child: TextButton(onPressed: () {}, style: TextButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: ZenoSpacing.sm)), child: Text("VIEW ALL ACTIVITY", style: ZenoTypography.caption(ZenoTheme.cyan500)))),
    ])));
  }

  Widget _buildTopCategoriesCard() {
    return const ZenoCard(title: "TOP CATEGORIES BY VALUE", child: SizedBox(height: 240, child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, crossAxisAlignment: CrossAxisAlignment.end, children: [
      BarChartItem(label: "MOBILE", value: 0.8, color: ZenoTheme.cyan500), BarChartItem(label: "LAPTOPS", value: 0.6, color: ZenoTheme.violet500),
      BarChartItem(label: "AUDIO", value: 0.4, color: ZenoTheme.green500), BarChartItem(label: "CAMERAS", value: 0.3, color: ZenoTheme.amber500),
      BarChartItem(label: "GAMING", value: 0.5, color: ZenoTheme.ruby500), BarChartItem(label: "WEARABLES", value: 0.2, color: ZenoTheme.violet500),
    ])));
  }
}
