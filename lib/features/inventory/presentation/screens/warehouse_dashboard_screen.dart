import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/core/widgets/zeno_header.dart';
import 'package:zeno/core/widgets/zeno_card.dart';
import 'package:zeno/core/di/service_locator.dart';
import '../../domain/repositories/i_inventory_repository.dart';
import '../controllers/inventory_controller.dart';

class WarehouseDashboardScreen extends StatefulWidget {
  const WarehouseDashboardScreen({super.key});

  @override
  State<WarehouseDashboardScreen> createState() =>
      _WarehouseDashboardScreenState();
}

class _WarehouseDashboardScreenState extends State<WarehouseDashboardScreen> {
  final controller = InventoryController(sl<IInventoryRepository>());

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
          title: "Warehouse Intelligence".toUpperCase(),
          subtitle:
              "MULTI-LOCATION OPTIMIZATION AND GLOBAL CAPACITY MANAGEMENT.",
          actions: const [
            _HeaderButton(
                label: "New Warehouse",
                icon: Icons.add_business,
                isPrimary: true),
          ],
        ),
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(ZenoSpacing.lg),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                        child: ZenoStatCard(
                            label: "TOTAL WAREHOUSES",
                            value: controller.warehouses.length.toString(),
                            icon: Icons.warehouse_outlined)),
                    const SizedBox(width: ZenoSpacing.lg),
                    const Expanded(
                        child: ZenoStatCard(
                            label: "TOTAL CAPACITY",
                            value: "85%",
                            change: "+5%",
                            icon: Icons.compress,
                            iconColor: ZenoTheme.amber500)),
                    const SizedBox(width: ZenoSpacing.lg),
                    const Expanded(
                        child: ZenoStatCard(
                            label: "PENDING TRANSFERS",
                            value: "12",
                            change: "4 URGENT",
                            isPositive: false,
                            icon: Icons.swap_horiz,
                            iconColor: ZenoTheme.cyan500)),
                  ],
                ),
                const SizedBox(height: ZenoSpacing.xl),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 2,
                      child: ZenoCard(
                        title: "CAPACITY BY LOCATION",
                        child: Column(
                          children: controller.warehouses
                              .map((w) => _CapacityItem(
                                  label: w.name.toUpperCase(), value: 0.85))
                              .toList(),
                        ),
                      ),
                    ),
                    const SizedBox(width: ZenoSpacing.lg),
                    Expanded(
                      flex: 1,
                      child: ZenoCard(
                        title: "RECENT TRANSFERS",
                        child: Column(
                          children: [
                            const _TransferItem(
                                from: "MAIN HQ",
                                to: "STORE A",
                                status: "IN TRANSIT"),
                            const _TransferItem(
                                from: "SINGAPORE",
                                to: "MAIN HQ",
                                status: "COMPLETED"),
                            const _TransferItem(
                                from: "MAIN HQ",
                                to: "STORE B",
                                status: "PENDING"),
                            const SizedBox(height: ZenoSpacing.md),
                            SizedBox(
                              width: double.infinity,
                              child: OutlinedButton(
                                onPressed: () {},
                                style: OutlinedButton.styleFrom(
                                  side: BorderSide(color: colors.borderSubtle),
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 12),
                                ),
                                child: Text("INITIATE NEW TRANSFER",
                                    style: ZenoTypography.caption(
                                        colors.textPrimary)),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
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
    return ElevatedButton.icon(
      onPressed: () {},
      icon: Icon(icon, size: 16),
      label: Text(label),
      style: ElevatedButton.styleFrom(
          backgroundColor: isPrimary ? ZenoTheme.accent : ZenoTheme.surface,
          foregroundColor: Colors.white),
    );
  }
}

class _CapacityItem extends StatelessWidget {
  final String label;
  final double value;

  const _CapacityItem({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(label, style: const TextStyle(fontSize: 12)),
              Text("${(value * 100).toInt()}%",
                  style: const TextStyle(
                      fontSize: 12, fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 8),
          LinearProgressIndicator(
              value: value,
              backgroundColor: ZenoTheme.border,
              valueColor: AlwaysStoppedAnimation<Color>(value > 0.9
                  ? ZenoTheme.danger
                  : (value > 0.7 ? ZenoTheme.warning : ZenoTheme.success))),
        ],
      ),
    );
  }
}

class _TransferItem extends StatelessWidget {
  final String from;
  final String to;
  final String status;

  const _TransferItem(
      {required this.from, required this.to, required this.status});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          const Icon(Icons.swap_horiz, size: 16, color: ZenoTheme.accent),
          const SizedBox(width: 12),
          Expanded(
              child: Text("$from → $to", style: const TextStyle(fontSize: 12))),
          Text(status,
              style: TextStyle(
                  fontSize: 10,
                  color: status == "Completed"
                      ? ZenoTheme.success
                      : ZenoTheme.warning,
                  fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
