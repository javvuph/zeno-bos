import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/core/widgets/zeno_header.dart';
import 'package:zeno/core/widgets/zeno_table.dart';
import 'package:zeno/core/widgets/zeno_badge.dart';
import '../../domain/models/sales_order.dart' as domain;
import '../../domain/models/sales_order_status.dart';
import '../controllers/sales_controller.dart';
import 'package:zeno/core/di/service_locator.dart';
import 'sales_order_form_screen.dart';

part 'parts/order_list_widgets.part.dart';

class OrderListScreen extends StatefulWidget {
  const OrderListScreen({super.key});

  @override
  State<OrderListScreen> createState() => _OrderListScreenState();
}

class _OrderListScreenState extends State<OrderListScreen> {
  late final SalesController controller;

  @override
  void initState() {
    super.initState();
    controller = sl<SalesController>();
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
    final items = controller.orders;

    return Column(
      children: [
        ZenoHeader(
          title: "Order Control Ledger".toUpperCase(),
          subtitle:
              "CONSOLIDATED VIEW OF ALL SALES ORDERS ACROSS MULTIPLE CHANNELS AND GLOBAL LOCATIONS.",
          onSearch: (v) {},
          actions: [
            _ActionBtn(
                label: "EXPORT CSV",
                icon: Icons.download_outlined,
                colors: colors),
            const SizedBox(width: ZenoSpacing.sm),
            _ActionBtn(
              label: "NEW ORDER",
              icon: Icons.add,
              isPrimary: true,
              colors: colors,
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const SalesOrderFormScreen())),
            ),
          ],
        ),
        _buildStickyFilters(colors),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(
                ZenoSpacing.lg, 0, ZenoSpacing.lg, ZenoSpacing.lg),
            child: Container(
              decoration: BoxDecoration(
                color: colors.bgTier2,
                borderRadius: BorderRadius.circular(ZenoRadius.lg),
                border: Border.all(color: colors.borderSubtle),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withValues(alpha: 0.02),
                      blurRadius: 20,
                      offset: const Offset(0, 10)),
                ],
              ),
              clipBehavior: Clip.antiAlias,
              child: ZenoTable<domain.SalesOrder>(
                items: items,
                columns: [
                  ZenoTableColumn(
                    label: "Order Identity",
                    width: 160,
                    builder: (o) => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(o.id.toUpperCase(),
                            style: ZenoTypography.bodyMD(colors.textPrimary)
                                .copyWith(
                                    fontWeight: FontWeight.w900,
                                    letterSpacing: 0.5)),
                        Text(o.currency,
                            style: ZenoTypography.micro(colors.textSecondary)
                                .copyWith(
                                    fontFamily: ZenoTypography.monoFamily)),
                      ],
                    ),
                  ),
                  ZenoTableColumn(
                    label: "Customer Identity",
                    builder: (o) => Row(
                      children: [
                        CircleAvatar(
                            radius: 12,
                            backgroundColor: colors.bgTier3,
                            child: Icon(Icons.person_outline,
                                size: 14, color: colors.textPrimary)),
                        const SizedBox(width: ZenoSpacing.md),
                        Text(o.customerId.toUpperCase(),
                            style: ZenoTypography.caption(colors.textPrimary)
                                .copyWith(fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                  ZenoTableColumn(
                    label: "Origin Node",
                    width: 140,
                    builder: (o) => Row(
                      children: [
                        Icon(_getChannelIcon("POS"),
                            size: 12, color: colors.textDisabled),
                        const SizedBox(width: ZenoSpacing.sm),
                        Text("POS TERMINAL",
                            style: ZenoTypography.micro(colors.textSecondary)),
                      ],
                    ),
                  ),
                  ZenoTableColumn(
                    label: "Financial Value",
                    width: 120,
                    isNumeric: true,
                    builder: (o) => Text(
                        "\$${o.totalAmount.toStringAsFixed(2)}",
                        style: ZenoTypography.bodyMD(colors.textPrimary)
                            .copyWith(fontWeight: FontWeight.w900)),
                  ),
                  ZenoTableColumn(
                    label: "Lifecycle State",
                    width: 180,
                    builder: (o) => ZenoBadge(
                      label: o.status.name.toUpperCase().replaceAll('_', ' '),
                      color: _getStatusColor(o.status),
                    ),
                  ),
                  ZenoTableColumn(
                    label: "Operations",
                    width: 160,
                    builder: (o) => Row(
                      children: [
                        if (o.status == SalesOrderStatus.confirmed ||
                            o.status == SalesOrderStatus.processing)
                          IconButton(
                            icon: const Icon(Icons.local_shipping_outlined,
                                color: Colors.green, size: 18),
                            onPressed: () => controller.dispatchOrder(o),
                            tooltip: "Dispatch Order",
                          ),
                        IconButton(
                          icon: Icon(Icons.edit_outlined,
                              color: colors.textSecondary, size: 18),
                          onPressed: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      SalesOrderFormScreen(existingOrder: o))),
                          tooltip: "Edit Order",
                        ),
                        IconButton(
                          icon: Icon(Icons.delete_outline_rounded,
                              color: colors.statusDanger, size: 18),
                          onPressed: () => _confirmDelete(o),
                          tooltip: "Delete Order",
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStickyFilters(ZenoSemanticColors colors) {
    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: ZenoSpacing.lg, vertical: ZenoSpacing.md),
      margin: const EdgeInsets.only(bottom: ZenoSpacing.md),
      decoration: BoxDecoration(
          color: colors.bgTier1,
          border: Border(bottom: BorderSide(color: colors.borderSubtle))),
      child: Row(
        children: [
          _FilterTab(
              label: "ALL ORDERS",
              count: controller.orders.length,
              isSelected: true,
              colors: colors),
          const SizedBox(width: ZenoSpacing.lg),
          _FilterTab(
              label: "PENDING",
              count: controller.activeOrderCount,
              colors: colors,
              isWarning: true),
          const SizedBox(width: ZenoSpacing.lg),
          _FilterTab(label: "DISPATCHED", count: 8, colors: colors),
          const Spacer(),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
                color: colors.bgTier3, borderRadius: BorderRadius.circular(6)),
            child: Row(
              children: [
                Icon(Icons.filter_list_rounded,
                    size: 14, color: colors.textSecondary),
                const SizedBox(width: 8),
                Text("ADVANCED FILTERS",
                    style: ZenoTypography.micro(colors.textSecondary)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  IconData _getChannelIcon(String channel) {
    if (channel == "Web") return Icons.language;
    if (channel == "App") return Icons.smartphone;
    if (channel == "WhatsApp") return Icons.message;
    return Icons.point_of_sale;
  }

  Color _getStatusColor(SalesOrderStatus status) {
    final colors = Theme.of(context).extension<ZenoSemanticColors>()!;
    if (status == SalesOrderStatus.delivered) return colors.statusSuccess;
    if (status == SalesOrderStatus.shipped) return colors.statusSuccess;
    if (status == SalesOrderStatus.processing) return colors.statusWarning;
    return colors.accentPrimary;
  }

  void _confirmDelete(domain.SalesOrder o) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Delete Order"),
        content: Text("Are you sure you want to delete order '${o.id}'?"),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("CANCEL")),
          TextButton(
            onPressed: () async {
              await controller.deleteOrder(o.id);
              if (mounted) Navigator.pop(context);
            },
            child: const Text("DELETE", style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
