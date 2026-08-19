import 'package:flutter/material.dart';
import '../../../controllers/product_studio_controller.dart';
import '../aurora_field_renderer.dart';
import '../widgets/aurora_card.dart';

class Tab4StockSupply extends StatelessWidget {
  final ProductStudioController controller;
  const Tab4StockSupply({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final allFields = controller.getTab4Fields();
    final stockFields = allFields.where((f) => f.contains('Stock') || f.contains('reorder') || f.contains('warehouse') || f.contains('planogram') || f.contains('Zone') || f.contains('Aisle') || f.contains('Bay') || f.contains('Rack') || f.contains('Shelf') || f.contains('Bin') || f == 'storageClass' || f.contains('Display')).toList();
    final supplyFields = allFields.where((f) => !stockFields.contains(f)).toList();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          AuroraCard(
            title: "Inventory & WMS",
            subtitle: "Stock levels and warehouse placement",
            icon: Icons.warehouse_outlined,
            accentColor: Colors.blue,
            child: AuroraFieldRenderer(controller: controller, fieldIds: stockFields),
          ),
          AuroraCard(
            title: "Supply Chain",
            subtitle: "Procurement, vendors and replenishment",
            icon: Icons.local_shipping_outlined,
            accentColor: Colors.orange,
            child: AuroraFieldRenderer(controller: controller, fieldIds: supplyFields),
          ),
        ],
      ),
    );
  }
}
