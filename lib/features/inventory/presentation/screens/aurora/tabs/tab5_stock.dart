import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/core/widgets/zeno_inputs.dart';
import 'package:zeno/core/widgets/zeno_card.dart';
import 'package:zeno/features/inventory/presentation/controllers/product_studio_controller.dart';

class Tab5Stock extends StatelessWidget {
  final ProductStudioController controller;
  const Tab5Stock({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final p = controller.product;
    final colors = Theme.of(context).extension<ZenoSemanticColors>()!;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              children: [
                ZenoCard(
                  title: "Inventory Control",
                  child: Column(
                    children: [
                      _buildSwitchRow(colors, "Track Inventory", p.trackInventory, (v) => controller.updateField(trackInventory: v)),
                      const SizedBox(height: 12),
                      ZenoDropdown<String>(
                        label: "Valuation Method",
                        value: p.valuationMethod.isEmpty ? "FIFO" : p.valuationMethod,
                        items: ["FIFO", "LIFO", "Weighted Average", "Standard Cost"].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
                        onChanged: (v) => controller.updateField(valuationMethod: v),
                        width: ZenoFieldWidth.full,
                      ),
                      const SizedBox(height: 12),
                      ZenoDropdown<String>(
                        label: "Warehouse ID / Primary Location",
                        value: p.warehouseLocation.isEmpty ? null : p.warehouseLocation,
                        items: controller.locationsList.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
                        onChanged: (v) => controller.updateField(warehouseLocation: v),
                        width: ZenoFieldWidth.full,
                        onQuickAdd: () => controller.addWarehouse("New Location"),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                ZenoCard(
                  title: "Stock Levels",
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: ZenoTextField(
                              key: const ValueKey('openingStock'),
                              label: "Opening Stock",
                              initialValue: p.openingStock == 0 ? "" : p.openingStock.toString(),
                              onChanged: (v) => controller.updateField(openingStock: double.tryParse(v) ?? 0.0),
                              keyboardType: TextInputType.number,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: ZenoTextField(
                              key: const ValueKey('safetyStock'),
                              label: "Safety Stock",
                              initialValue: p.safetyStock.toString(),
                              onChanged: (v) => controller.updateField(safetyStock: int.tryParse(v)),
                              keyboardType: TextInputType.number,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      ZenoTextField(
                        key: const ValueKey('reorderLevel'),
                        label: "Reorder Level",
                        initialValue: p.reorderLevel.toString(),
                        onChanged: (v) => controller.updateField(reorderLevel: double.tryParse(v)),
                        keyboardType: const TextInputType.numberWithOptions(decimal: true),
                        width: ZenoFieldWidth.full,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              children: [
                ZenoCard(
                  title: "Replenishment Strategy",
                  child: Column(
                    children: [
                      _buildSwitchRow(colors, "Auto Replenish", p.autoReplenish, (v) => controller.updateField(autoReplenish: v)),
                      const SizedBox(height: 12),
                      ZenoTextField(
                        key: const ValueKey('leadTimeBuffer'),
                        label: "Lead Time Buffer (Days)",
                        initialValue: p.leadTimeBuffer.toString(),
                        onChanged: (v) => controller.updateField(leadTimeBuffer: int.tryParse(v)),
                        keyboardType: TextInputType.number,
                        width: ZenoFieldWidth.full,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSwitchRow(ZenoSemanticColors colors, String label, bool value, ValueChanged<bool> onChanged) {
    return Row(
      children: [
        Text(label, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: colors.textSecondary)),
        const Spacer(),
        SizedBox(
          height: 20,
          child: Transform.scale(
            scale: 0.7,
            child: Switch(
              value: value,
              onChanged: onChanged,
              activeThumbColor: colors.accentPrimary,
            ),
          ),
        ),
      ],
    );
  }
}
