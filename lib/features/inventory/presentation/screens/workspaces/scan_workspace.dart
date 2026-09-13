import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/core/widgets/zeno_card.dart';
import 'package:zeno/core/widgets/zeno_button.dart';
import 'package:zeno/core/widgets/zeno_inputs.dart';
import '../../../domain/models/product_studio_models.dart';
import '../../controllers/product_studio_controller.dart';
import '../widgets/product_studio_widgets.dart';
import 'widgets/scan_widgets.dart';

class ScanWorkspace extends StatelessWidget {
  final ProductStudioController controller;
  final ZenoSemanticColors colors;
  const ScanWorkspace({super.key, required this.controller, required this.colors});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      _buildScanBar(),
      Expanded(child: Row(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        _buildRecentSessionSidebar(),
        Expanded(child: Container(color: colors.bgTier1, child: _buildScanDetailsArea())),
      ])),
    ]);
  }

  Widget _buildScanBar() {
    return Container(
      height: 40, padding: const EdgeInsets.symmetric(horizontal: 24),
      decoration: BoxDecoration(color: colors.bgTier2, border: Border(bottom: BorderSide(color: colors.borderSubtle))),
      child: Row(children: [
        Icon(Icons.qr_code_scanner_rounded, size: 14, color: colors.accentPrimary),
        const SizedBox(width: 10),
        Expanded(child: TextField(style: TextStyle(fontSize: 11, color: colors.textPrimary, fontWeight: FontWeight.bold), decoration: InputDecoration(hintText: "Scan barcode or enter manually (EAN / UPC / GTIN)...", hintStyle: TextStyle(fontSize: 10, color: colors.textDisabled), border: InputBorder.none, isDense: true), onSubmitted: (v) => controller.handleBarcodeScanned(v))),
        const SizedBox(width: 10),
        ZenoButton(label: "SCAN", icon: Icons.camera_alt_outlined, size: ZenoButtonSize.sm, onPressed: () {}),
      ]),
    );
  }

  Widget _buildRecentSessionSidebar() {
    return Container(
      width: 240, decoration: BoxDecoration(color: colors.bgTier2, border: Border(right: BorderSide(color: colors.borderSubtle))),
      padding: const EdgeInsets.all(16),
      child: Column(children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text("RECENT SESSION", style: TextStyle(fontSize: 9, fontWeight: FontWeight.w900, color: colors.textDisabled, letterSpacing: 0.5)),
          if (controller.scanSession.isNotEmpty) TextButton(style: TextButton.styleFrom(padding: EdgeInsets.zero, minimumSize: Size.zero), onPressed: controller.clearScanSession, child: const Text("Clear", style: TextStyle(fontSize: 8, color: Colors.red))),
        ]),
        const SizedBox(height: 12),
        Expanded(child: ListView.separated(itemCount: controller.scanSession.length, separatorBuilder: (_, __) => const SizedBox(height: 8), itemBuilder: (context, index) => RecentScanItem(item: controller.scanSession[index], colors: colors))),
      ]),
    );
  }

  Widget _buildScanDetailsArea() {
    if (controller.scanSession.isEmpty) return Center(child: Text("NO PRODUCT SCANNED", style: TextStyle(color: colors.textDisabled, fontWeight: FontWeight.bold)));
    final latest = controller.scanSession.first;
    if (latest.status == ScanItemStatus.notFound) return _buildNotFoundState(latest.product.barcode);
    if (latest.status == ScanItemStatus.added) return _buildSuccessState(latest.product);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        _buildDetailsHeader(latest),
        const SizedBox(height: 24),
        _buildSummaryCards(latest),
        const SizedBox(height: 24),
        StepHeader(number: 3, title: "Missing Information", colors: colors),
        const SizedBox(height: 16),
        _buildMissingFieldsForm(latest),
        const SizedBox(height: 32),
        _buildActionButtons(),
      ]),
    );
  }

  Widget _buildDetailsHeader(ScanSessionItem latest) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text("PRODUCT IDENTIFIED", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900, color: colors.statusSuccess)),
        const SizedBox(height: 4),
        Text("${latest.product.barcode} • ${latest.product.brand}", style: TextStyle(fontSize: 10, color: colors.textDisabled, fontFamily: 'monospace')),
      ]),
      ZenoButton(label: "MANUAL EDIT", variant: ZenoButtonVariant.secondary, size: ZenoButtonSize.sm, onPressed: () => controller.setCreationMode(ProductCreationMode.manual)),
    ]);
  }

  Widget _buildSummaryCards(ScanSessionItem latest) {
    return Row(children: [
      Expanded(child: SummaryGroup(title: "BASIC DATA", isComplete: true, count: 9, details: "Name, Brand, Category, Units, SKU...", colors: colors)),
      const SizedBox(width: 12),
      Expanded(child: SummaryGroup(title: "PRICING & TAX", isComplete: false, count: 3, missing: "Sale Price, Cost, Tax Rule", colors: colors)),
      const SizedBox(width: 12),
      Expanded(child: SummaryGroup(title: "VARIANTS", isComplete: true, count: 12, details: "3 Colors, 4 Sizes identified", colors: colors)),
    ]);
  }

  Widget _buildMissingFieldsForm(ScanSessionItem latest) {
    return Builder(builder: (context) => ZenoCard(padding: const EdgeInsets.all(20), child: Column(children: [
      Row(children: [
        Expanded(child: ZenoTextField(label: "Opening Stock *", hint: "Enter local stock level", textAlign: TextAlign.center, initialValue: latest.product.openingStock == 0 ? "" : latest.product.openingStock.toString(), onChanged: (v) => controller.updateField(openingStock: int.tryParse(v)))),
        const SizedBox(width: 12),
        Expanded(child: ZenoQuickAddDropdown<String>(label: "Warehouse *", value: latest.product.warehouseLocation.isEmpty ? null : latest.product.warehouseLocation, items: controller.locationsList.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(), onChanged: (v) => controller.updateField(warehouseLocation: v), onQuickAdd: () => showAddDialog(context, colors, "Warehouse", (n) => controller.addWarehouse(n)))),
      ]),
      const SizedBox(height: 16),
      Row(children: [
        Expanded(child: ZenoTextField(label: "Selling Price (₹) *", hint: "999.00", textAlign: TextAlign.center, initialValue: latest.product.sellingPrice == 0 ? "" : latest.product.sellingPrice.toString(), onChanged: (v) => controller.updatePrice(double.tryParse(v) ?? 0))),
        const SizedBox(width: 12),
        Expanded(child: ZenoTextField(label: "Purchase Cost (₹)", hint: "0.00", textAlign: TextAlign.center, initialValue: latest.product.costPrice == 0 ? "" : latest.product.costPrice.toString(), onChanged: (v) => controller.updateCost(double.tryParse(v) ?? 0))),
      ]),
    ])));
  }

  Widget _buildActionButtons() {
    return Row(mainAxisAlignment: MainAxisAlignment.end, children: [
      ZenoButton(label: "CANCEL", variant: ZenoButtonVariant.ghost, onPressed: () => controller.clearScanSession()),
      const SizedBox(width: 12),
      ZenoButton(label: "SAVE TO INVENTORY", icon: Icons.add_circle_outline_rounded, isLoading: controller.isSaving, onPressed: controller.addScannedProductToCatalog),
    ]);
  }

  Widget _buildNotFoundState(String barcode) {
    return Center(child: Column(mainAxisSize: MainAxisSize.min, children: [
      Icon(Icons.search_off_rounded, size: 48, color: colors.textDisabled),
      const SizedBox(height: 16),
      Text("PRODUCT NOT FOUND", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w900, color: colors.textPrimary)),
      const SizedBox(height: 8),
      Text("Barcode: $barcode", style: TextStyle(fontSize: 10, color: colors.textDisabled, fontFamily: 'monospace')),
      const SizedBox(height: 24),
      Row(mainAxisSize: MainAxisSize.min, children: [
        ZenoButton(label: "SCAN AGAIN", variant: ZenoButtonVariant.secondary, size: ZenoButtonSize.sm, onPressed: () {}),
        const SizedBox(width: 12),
        ZenoButton(label: "CREATE MANUALLY", icon: Icons.add_rounded, size: ZenoButtonSize.sm, onPressed: () => controller.startManualCreationFromScan(barcode)),
      ]),
    ]));
  }

  Widget _buildSuccessState(ProductStudioData product) {
    return Center(child: Column(mainAxisSize: MainAxisSize.min, children: [
      Icon(Icons.check_circle_rounded, size: 48, color: colors.statusSuccess),
      const SizedBox(height: 16),
      Text("PRODUCT ADDED TO CATALOG", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w900, color: colors.textPrimary)),
      const SizedBox(height: 8),
      Text(product.title.toUpperCase(), style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: colors.accentPrimary)),
      const SizedBox(height: 24),
      ZenoButton(label: "SCAN ANOTHER PRODUCT", icon: Icons.qr_code_scanner_rounded, onPressed: () {}),
    ]));
  }
}
