import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/core/widgets/zeno_card.dart';
import '../../controllers/product_studio_controller.dart';

class InventoryAdminSection extends StatelessWidget {
  final ProductStudioController controller;
  final ZenoSemanticColors colors;
  const InventoryAdminSection({super.key, required this.controller, required this.colors});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ZenoCard(
          title: "Traceability & Control",
          titleColor: Colors.blue,
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              _buildTrackingSwitch("Batch / Lot Tracking", controller.enableBatchTracking, (v) => controller.toggleTracking("batch", v)),
              _buildTrackingSwitch("Serial Number Tracking", controller.enableSerialTracking, (v) => controller.toggleTracking("serial", v)),
              _buildTrackingSwitch("IMEI Tracking (Electronics)", controller.enableIMEITracking, (v) => controller.toggleTracking("imei", v)),
              _buildTrackingSwitch("Enable Expiry Tracking", controller.product.enableExpiryTracking, (v) => controller.updateField(enableExpiryTracking: v)),
              _buildTrackingSwitch("Allow Negative Stock", controller.product.allowNegativeStock, (v) => controller.updateField(allowNegativeStock: v)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTrackingSwitch(String label, bool value, ValueChanged<bool> onChanged) {
    return Material(
      color: Colors.transparent,
      child: SwitchListTile(
        value: value,
        onChanged: onChanged,
        title: Text(label, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
        contentPadding: EdgeInsets.zero,
        dense: true,
        activeThumbColor: colors.accentPrimary,
      ),
    );
  }
}
