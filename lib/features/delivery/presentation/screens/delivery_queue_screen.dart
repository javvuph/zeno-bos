import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/core/widgets/zeno_header.dart';
import 'package:zeno/core/widgets/zeno_table.dart';
import 'package:zeno/core/widgets/zeno_badge.dart';
import '../../domain/models/delivery_order.dart' as domain;
import '../controllers/delivery_controller.dart';
import 'package:zeno/core/di/service_locator.dart';
import '../dialogs/pod_dialog.dart';
import 'package:zeno/navigation/navigation_controller.dart';

part 'parts/delivery_queue_widgets.part.dart';

class DeliveryQueueScreen extends StatefulWidget {
  const DeliveryQueueScreen({super.key});

  @override
  State<DeliveryQueueScreen> createState() => _DeliveryQueueScreenState();
}

class _DeliveryQueueScreenState extends State<DeliveryQueueScreen> {
  late final DeliveryController controller;

  @override
  void initState() {
    super.initState();
    controller = sl<DeliveryController>();
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
    final items = controller.deliveries;

    return Column(
      children: [
        ZenoHeader(
          title: "Operations Ledger".toUpperCase(),
          subtitle:
              "CONSOLIDATED VIEW OF ALL ACTIVE AND PENDING DELIVERY ASSIGNMENTS ACROSS GLOBAL ZONES.",
          onSearch: (v) {},
          actions: [
            _ActionBtn(
                label: "Export CSV",
                icon: Icons.download_outlined,
                colors: colors,
                onPressed: () {}),
            const SizedBox(width: ZenoSpacing.sm),
            _ActionBtn(
              label: "New Assignment",
              icon: Icons.add_location_alt_outlined,
              isPrimary: true,
              colors: colors,
              onPressed: () =>
                  NavigationController().openTab('delivery/shipments/new'),
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
              child: ZenoTable<domain.DeliveryOrder>(
                items: items,
                columns: [
                  ZenoTableColumn(
                    label: "Task Identity",
                    width: 140,
                    builder: (t) => Text(t.id.toUpperCase(),
                        style: ZenoTypography.bodyMD(colors.textPrimary)
                            .copyWith(
                                fontWeight: FontWeight.w900,
                                fontFamily: ZenoTypography.monoFamily,
                                letterSpacing: 0.5)),
                  ),
                  ZenoTableColumn(
                    label: "Order Reference",
                    width: 140,
                    builder: (t) => Text(t.salesOrderId.toUpperCase(),
                        style: ZenoTypography.caption(colors.accentPrimary)
                            .copyWith(fontWeight: FontWeight.bold)),
                  ),
                  ZenoTableColumn(
                    label: "Geospatial Destination",
                    builder: (t) => Text(t.address.toUpperCase(),
                        style: ZenoTypography.micro(colors.textSecondary),
                        overflow: TextOverflow.ellipsis),
                  ),
                  ZenoTableColumn(
                    label: "Fulfillment Agent",
                    width: 160,
                    builder: (t) => Row(
                      children: [
                        CircleAvatar(
                            radius: 10,
                            backgroundColor: colors.bgTier3,
                            child: Icon(Icons.person_outline,
                                size: 10, color: colors.textPrimary)),
                        const SizedBox(width: 8),
                        Text("MARCUS J.",
                            style: ZenoTypography.caption(colors.textPrimary)),
                      ],
                    ),
                  ),
                  ZenoTableColumn(
                    label: "Logistics State",
                    width: 180,
                    builder: (t) => ZenoBadge(
                      label: t.status.name.toUpperCase().replaceAll('_', ' '),
                      color: _getStatusColor(t.status.name),
                    ),
                  ),
                  ZenoTableColumn(
                    label: "Est. Arrival",
                    width: 120,
                    builder: (t) => Text(
                        t.expectedDeliveryTime.toString().substring(11, 16),
                        style: ZenoTypography.caption(colors.textPrimary)
                            .copyWith(fontWeight: FontWeight.w900)),
                  ),
                  ZenoTableColumn(
                    label: "Actions",
                    width: 200,
                    builder: (t) => Row(
                      children: [
                        if (t.status == domain.DeliveryStatus.pending)
                          IconButton(
                            icon: const Icon(Icons.person_add_alt,
                                color: Colors.blue),
                            onPressed: () => controller.updateStatus(
                                t, domain.DeliveryStatus.assigned),
                            tooltip: "Assign Agent",
                          ),
                        if (t.status == domain.DeliveryStatus.assigned)
                          IconButton(
                            icon: const Icon(Icons.inventory_2_outlined,
                                color: Colors.orange),
                            onPressed: () => controller.updateStatus(
                                t, domain.DeliveryStatus.picked_up),
                            tooltip: "Mark Picked Up",
                          ),
                        if (t.status == domain.DeliveryStatus.picked_up)
                          IconButton(
                            icon: const Icon(Icons.local_shipping_outlined,
                                color: Colors.green),
                            onPressed: () => controller.updateStatus(
                                t, domain.DeliveryStatus.out_for_delivery),
                            tooltip: "In Transit",
                          ),
                        if (t.status == domain.DeliveryStatus.out_for_delivery)
                          IconButton(
                            icon: const Icon(Icons.verified_outlined,
                                color: Colors.blue),
                            onPressed: () => _showPODDialog(t),
                            tooltip: "Confirm Delivery",
                          ),
                        IconButton(
                          icon: Icon(Icons.my_location,
                              color: colors.accentPrimary),
                          onPressed: () => NavigationController()
                              .openTab('delivery/tracking/orders'),
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
              label: "ALL TASKS",
              count: controller.deliveries.length,
              isSelected: true,
              colors: colors),
          const SizedBox(width: ZenoSpacing.lg),
          _FilterTab(
              label: "IN TRANSIT",
              count: controller.activeDeliveryCount,
              colors: colors,
              isWarning: false),
          const SizedBox(width: ZenoSpacing.lg),
          _FilterTab(
              label: "PENDING",
              count: controller.pendingAssignmentCount,
              colors: colors,
              isWarning: true),
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

  Color _getStatusColor(String status) {
    if (status == "out_for_delivery" || status == "In Transit") {
      return const Color(0xFF00FF88);
    }
    if (status == "assigned" || status == "Assigned") {
      return const Color(0xFF00D2FF);
    }
    if (status == "pending" || status == "Pending") {
      return const Color(0xFFFF9800);
    }
    return const Color(0xFFFF4B2B);
  }

  void _showPODDialog(domain.DeliveryOrder order) {
    showDialog(
      context: context,
      builder: (context) => PODDialog(
        order: order,
        onConfirm: (pod) => controller.submitPOD(pod),
      ),
    );
  }
}
