import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/core/widgets/zeno_header.dart';
import 'package:zeno/core/widgets/zeno_card.dart';
import 'package:zeno/core/di/service_locator.dart';
import '../../../purchase/domain/repositories/i_purchase_repository.dart';
import '../../../purchase/presentation/controllers/purchase_controller.dart';
import 'package:zeno/navigation/navigation_controller.dart';

part 'parts/procurement_dashboard_widgets.part.dart';

class ProcurementDashboardScreen extends StatefulWidget {
  const ProcurementDashboardScreen({super.key});

  @override
  State<ProcurementDashboardScreen> createState() =>
      _ProcurementDashboardScreenState();
}

class _ProcurementDashboardScreenState
    extends State<ProcurementDashboardScreen> {
  final controller = PurchaseController(sl<IPurchaseRepository>());

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
          title: "Procurement Command".toUpperCase(),
          subtitle:
              "ORCHESTRATE PURCHASE ORDERS, REPLENISHMENT REQUESTS, AND INCOMING LOGISTICS.",
          actions: [
            _HeaderButton(
              label: "Draft Requisition",
              icon: Icons.description_outlined,
              onPressed: () => NavigationController()
                  .openTab('suppliers/procurement/requests'),
            ),
            const SizedBox(width: ZenoSpacing.md),
            _HeaderButton(
              label: "New Purchase Order",
              icon: Icons.shopping_cart_outlined,
              isPrimary: true,
              onPressed: () => NavigationController()
                  .openTab('suppliers/procurement/orders/new'),
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
                ZenoCard(
                  title: "ACTIVE REPLENISHMENT REQUESTS",
                  trailing: Text("${controller.requisitions.length} PENDING",
                      style: ZenoTypography.micro(colors.statusWarning)),
                  child: Column(
                    children: [
                      ...controller.requisitions.map((pr) => _ReplenishItem(
                          product: pr.items.first.name,
                          qty: pr.items.first.quantity.toInt(),
                          urgency: "CRITICAL",
                          color: colors.statusDanger,
                          colors: colors)),
                      const SizedBox(height: ZenoSpacing.md),
                      SizedBox(
                        width: double.infinity,
                        child: OutlinedButton(
                          onPressed: () {},
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(color: colors.borderSubtle),
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(ZenoRadius.md)),
                          ),
                          child: Text("ACCESS PROCUREMENT WORKFLOW",
                              style:
                                  ZenoTypography.caption(colors.accentPrimary)
                                      .copyWith(
                                          fontWeight: FontWeight.w900,
                                          letterSpacing: 1)),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: ZenoSpacing.xl),
                _buildProcurementInsights(colors),
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
              label: "PENDING APPROVAL",
              value: controller.pendingApprovalCount.toString(),
              icon: Icons.pending_actions_outlined,
              color: const Color(0xFFFFD700),
              colors: colors),
          _vDivider(colors),
          _KPIItem(
              label: "TOTAL OBLIGATION",
              value: "\$${controller.totalPurchaseValue.toStringAsFixed(0)}",
              icon: Icons.attach_money_outlined,
              color: const Color(0xFF00D2FF),
              colors: colors),
          _vDivider(colors),
          _KPIItem(
              label: "ACTIVE REQUISITIONS",
              value: controller.requisitions.length.toString(),
              icon: Icons.description_outlined,
              color: const Color(0xFF9D50BB),
              colors: colors),
          _vDivider(colors),
          _KPIItem(
              label: "IN-TRANSIT VALUE",
              value: "\$42.5K",
              icon: Icons.local_shipping_outlined,
              color: const Color(0xFF38ef7d),
              colors: colors),
        ],
      ),
    );
  }

  Widget _buildProcurementInsights(ZenoSemanticColors colors) {
    return Row(
      children: [
        Expanded(
          child: ZenoCard(
            title: "SAVINGS OPPORTUNITIES",
            child: Column(
              children: [
                _InsightRow(
                    label: "Bulk Pricing: Men's Category",
                    value: "-\$1,200",
                    color: colors.statusSuccess),
                const SizedBox(height: 12),
                _InsightRow(
                    label: "Early Payment Discount",
                    value: "-\$450",
                    color: colors.statusSuccess),
              ],
            ),
          ),
        ),
        const SizedBox(width: ZenoSpacing.lg),
        Expanded(
          child: ZenoCard(
            title: "SUPPLY CHAIN RISKS",
            child: Column(
              children: [
                _InsightRow(
                    label: "Lead Time Variance: Global Ltd",
                    value: "+2 Days",
                    color: colors.statusWarning),
                const SizedBox(height: 12),
                _InsightRow(
                    label: "Stockout Projection: iPhone 15",
                    value: "72 Hours",
                    color: colors.statusDanger),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _vDivider(ZenoSemanticColors colors) => Container(
      height: 32,
      width: 1,
      color: colors.borderSubtle,
      margin: const EdgeInsets.symmetric(horizontal: ZenoSpacing.xl));
}
