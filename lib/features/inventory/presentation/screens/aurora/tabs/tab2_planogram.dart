import 'package:flutter/material.dart';
import 'package:zeno/core/widgets/zeno_inputs.dart';
import 'package:zeno/core/widgets/zeno_card.dart';
import 'package:zeno/features/inventory/presentation/controllers/product_studio_controller.dart';

class Tab2Planogram extends StatelessWidget {
  final ProductStudioController controller;
  const Tab2Planogram({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final p = controller.product;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              children: [
                ZenoCard(
                  title: "Storage Assignment",
                  child: Column(
                    children: [
                      ZenoDropdown<String>(
                        label: "Floor / Zone",
                        value: p.floorZone.isEmpty ? null : p.floorZone,
                        items: ["Ground Floor", "Warehouse A", "Cold Storage", "Display Area"].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
                        onChanged: (v) => controller.updateField(floorZone: v),
                        width: ZenoFieldWidth.full,
                      ),
                      const SizedBox(height: 12),
                      ZenoDropdown<String>(
                        label: "Storage Class",
                        value: p.storageClass.isEmpty ? null : p.storageClass,
                        items: ["Ambient", "Chilled", "Frozen", "Hazardous"].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
                        onChanged: (v) => controller.updateField(storageClass: v),
                        width: ZenoFieldWidth.full,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                ZenoCard(
                  title: "Planogram Details",
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: ZenoTextField(
                              key: const ValueKey('planogramAisle'),
                              label: "Aisle",
                              initialValue: p.planogramAisle,
                              onChanged: (v) => controller.updateField(planogramAisle: v),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: ZenoTextField(
                              key: const ValueKey('planogramBay'),
                              label: "Bay",
                              initialValue: p.planogramBay,
                              onChanged: (v) => controller.updateField(planogramBay: v),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(
                            child: ZenoTextField(
                              key: const ValueKey('planogramRack'),
                              label: "Rack",
                              initialValue: p.planogramRack,
                              onChanged: (v) => controller.updateField(planogramRack: v),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: ZenoTextField(
                              key: const ValueKey('planogramShelf'),
                              label: "Shelf Level",
                              initialValue: p.planogramShelf,
                              onChanged: (v) => controller.updateField(planogramShelf: v),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      ZenoTextField(
                        key: const ValueKey('planogramBin'),
                        label: "Bin Slot",
                        initialValue: p.planogramBin,
                        onChanged: (v) => controller.updateField(planogramBin: v),
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
                  title: "Display Metrics",
                  child: Column(
                    children: [
                      ZenoTextField(
                        key: const ValueKey('planogramEndcap'),
                        label: "Facing Count",
                        initialValue: p.planogramEndcap,
                        onChanged: (v) => controller.updateField(planogramEndcap: v),
                        width: ZenoFieldWidth.full,
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(
                            child: ZenoTextField(
                              key: const ValueKey('minDisplayQty'),
                              label: "Min Display Qty",
                              initialValue: p.minDisplayQty.toString(),
                              onChanged: (v) => controller.updateField(minDisplayQty: int.tryParse(v)),
                              keyboardType: TextInputType.number,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: ZenoTextField(
                              key: const ValueKey('maxDisplayQty'),
                              label: "Max Display Qty",
                              initialValue: p.maxDisplayQty.toString(),
                              onChanged: (v) => controller.updateField(maxDisplayQty: int.tryParse(v)),
                              keyboardType: TextInputType.number,
                            ),
                          ),
                        ],
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
}
