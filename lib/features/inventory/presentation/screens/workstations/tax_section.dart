import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/core/widgets/zeno_inputs.dart';
import '../../controllers/product_studio_controller.dart';
import '../widgets/product_studio_redesign_widgets.dart';

class TaxSection extends StatelessWidget {
  final ProductStudioController controller;
  final ZenoSemanticColors colors;
  const TaxSection({super.key, required this.controller, required this.colors});

  @override
  Widget build(BuildContext context) {
    final config = controller.currentTaxConfig;
    final String country = controller.businessCountry;

    return Column(
      children: [
        StudioSectionCard(
          title: "Tax Classification",
          subtitle: "Statutory mapping and jurisdictional rates",
          icon: Icons.receipt_long_outlined,
          accentColor: colors.statusInfo,
          trailing: Text("REGION: ${country.toUpperCase()}", style: TextStyle(fontSize: 10, fontWeight: FontWeight.w800, color: colors.accentPrimary, letterSpacing: 0.5)),
          child: Column(
            children: [
              Wrap(
                spacing: 20, runSpacing: 20,
                children: [
                  ZenoDropdown<String>(
                    key: const ValueKey('taxStatus'),
                    label: "Tax Status",
                    value: controller.product.taxStatus,
                    items: (config['statuses'] as List<String>).map((s) => DropdownMenuItem(value: s, child: Text(s))).toList(),
                    onChanged: (v) => controller.updateField(taxStatus: v),
                    width: ZenoFieldWidth.medium,
                  ),
                  ZenoDropdown<String>(
                    key: const ValueKey('taxCategory'),
                    label: "${config['taxName']} Category",
                    value: controller.product.taxCategory,
                    items: (config['categories'] as List<String>).map((c) => DropdownMenuItem(value: c, child: Text(c))).toList(),
                    onChanged: (v) => controller.updateField(taxCategory: v),
                    width: ZenoFieldWidth.medium,
                  ),
                  ZenoTextField(
                    key: const ValueKey('taxRate'),
                    label: "${config['taxName']} Rate (%)",
                    hint: "0",
                    initialValue: controller.product.taxRate == 0 ? "" : controller.product.taxRate.toString(),
                    onChanged: (v) => controller.updateField(taxRate: double.tryParse(v)),
                    width: ZenoFieldWidth.micro,
                  ),
                  ZenoTextField(
                    key: const ValueKey('taxCode'),
                    label: config['codeLabel'],
                    initialValue: controller.product.taxCode,
                    onChanged: (v) => controller.updateField(taxCode: v),
                    width: ZenoFieldWidth.medium,
                  ),
                ],
              ),
              if (config['showGSTMode'] == true) ...[
                const SizedBox(height: 20),
                Wrap(
                  spacing: 20, runSpacing: 20,
                  children: [
                    ZenoDropdown<String>(
                      key: const ValueKey('gstTaxMode'),
                      label: "GST Tax Mode",
                      value: controller.product.gstTaxMode,
                      items: (config['gstModes'] as List<String>).map((m) => DropdownMenuItem(value: m, child: Text(m))).toList(),
                      onChanged: (v) => controller.updateField(gstTaxMode: v),
                      width: ZenoFieldWidth.medium,
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}
