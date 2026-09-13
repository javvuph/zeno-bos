import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/core/widgets/zeno_inputs.dart';
import '../../../controllers/product_studio_controller.dart';
import '../../../controllers/registries/retail_schemas.dart';
import '../../widgets/product_studio_redesign_widgets.dart';

class RetailBasicTab extends StatelessWidget {
  final ProductStudioController controller;
  final ZenoSemanticColors colors;
  const RetailBasicTab({super.key, required this.controller, required this.colors});

  @override
  Widget build(BuildContext context) {
    final p = controller.product;
    return Column(children: [
      StudioSectionCard(
        title: "Product Identity",
        subtitle: "Primary identification and multilingual naming",
        icon: Icons.inventory_2_outlined,
        child: Column(children: [
          Wrap(spacing: 20, runSpacing: 20, children: [
            if (controller.isFieldVisible('title'))
            ZenoTextField(key: const ValueKey('title'), label: "Product Name", initialValue: p.title, onChanged: (v) => controller.updateFieldById(p, 'title', v), width: ZenoFieldWidth.standard, isRequired: true),
            if (controller.isFieldVisible('arabicTitle'))
            ZenoTextField(key: const ValueKey('arabicTitle'), label: "Arabic Name [AR]", textAlign: TextAlign.right, initialValue: p.arabicTitle, onChanged: (v) => controller.updateFieldById(p, 'arabicTitle', v), width: ZenoFieldWidth.standard),
          ]),
          if (controller.isFieldVisible('description')) ...[
            const SizedBox(height: 20),
            ZenoTextField(key: const ValueKey('description'), label: "Description", initialValue: p.description, onChanged: (v) => controller.updateFieldById(p, 'description', v), maxLines: 3, width: ZenoFieldWidth.full),
          ],
        ]),
      ),
      StudioSectionCard(
        title: "Scanning & POS",
        subtitle: "Universal identifiers and thermal naming",
        icon: Icons.qr_code_scanner_rounded,
        accentColor: colors.statusInfo,
        child: Wrap(spacing: 20, runSpacing: 20, children: [
          if (controller.isFieldVisible('barcode'))
          ZenoTextField(key: const ValueKey('barcode'), label: "Primary Barcode", initialValue: p.barcode, onChanged: (v) => controller.updateFieldById(p, 'barcode', v), suffix: const Icon(Icons.qr_code_scanner_rounded), width: ZenoFieldWidth.medium),
          if (controller.isFieldVisible('sku'))
          ZenoTextField(key: const ValueKey('sku'), label: "Master SKU", initialValue: p.sku, onChanged: (v) => controller.updateFieldById(p, 'sku', v), width: ZenoFieldWidth.medium),
          if (controller.isFieldVisible('posShortThermalName'))
          ZenoTextField(key: const ValueKey('posShortThermalName'), label: "POS Short Name", initialValue: p.posShortThermalName, onChanged: (v) => controller.updateFieldById(p, 'posShortThermalName', v), width: ZenoFieldWidth.medium, hint: "Max 22 chars"),
          if (controller.isFieldVisible('barcodeType'))
          ZenoDropdown<String>(key: const ValueKey('barcodeType'), label: "Barcode Type", value: p.barcodeType, items: barcodeTypes.map((e)=>DropdownMenuItem(value: e, child: Text(e))).toList(), onChanged: (v) => controller.updateFieldById(p, 'barcodeType', v), width: ZenoFieldWidth.medium),
        ]),
      ),
      StudioSectionCard(
        title: "Taxonomy",
        subtitle: "Merchandising hierarchy and brand mapping",
        icon: Icons.category_outlined,
        accentColor: colors.accentPurple,
        child: Wrap(spacing: 20, runSpacing: 20, children: [
          if (controller.isFieldVisible('brand'))
          ZenoTextField(key: const ValueKey('brand'), label: "Principal Brand", initialValue: p.brand, onChanged: (v) => controller.updateFieldById(p, 'brand', v), width: ZenoFieldWidth.medium),
          if (controller.isFieldVisible('category'))
          ZenoDropdown<String>(key: const ValueKey('category'), label: "Department", value: p.category, items: retailDepartments.map((e)=>DropdownMenuItem(value: e, child: Text(e))).toList(), onChanged: (v) => controller.updateFieldById(p, 'category', v), width: ZenoFieldWidth.medium),
          if (controller.isFieldVisible('subDepartment'))
          ZenoTextField(key: const ValueKey('subDepartment'), label: "Sub-Department", initialValue: p.subDepartment, onChanged: (v) => controller.updateFieldById(p, 'subDepartment', v), width: ZenoFieldWidth.medium),
          if (controller.isFieldVisible('returnPolicy'))
          ZenoDropdown<String>(key: const ValueKey('returnPolicy'), label: "Return Policy", value: p.returnPolicy, items: returnPolicies.map((e)=>DropdownMenuItem(value: e, child: Text(e))).toList(), onChanged: (v) => controller.updateFieldById(p, 'returnPolicy', v), width: ZenoFieldWidth.medium),
        ]),
      ),
    ]);
  }
}
