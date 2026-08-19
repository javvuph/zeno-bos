import 'package:flutter/material.dart' hide TableCell;
import 'package:zeno/app/theme.dart';
import 'package:zeno/core/widgets/zeno_button.dart';
import 'package:zeno/core/widgets/zeno_inputs.dart';
import '../../controllers/product_studio_controller.dart';
import '../../../domain/models/product_studio_models.dart';
import '../../../domain/models/product_studio_enums.dart';
import 'widgets/session_table_widgets.dart';

class BulkScanWorkspace extends StatefulWidget {
  final ProductStudioController controller;
  final ZenoSemanticColors colors;
  const BulkScanWorkspace({super.key, required this.controller, required this.colors});

  @override
  State<BulkScanWorkspace> createState() => _BulkScanWorkspaceState();
}

class _BulkScanWorkspaceState extends State<BulkScanWorkspace> {
  final ScrollController _horizontalController = ScrollController();

  @override
  void dispose() {
    _horizontalController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final readyCount = widget.controller.bulkScanItems.where((i) => i.status == BulkScanStatus.ready).length;
    final reviewCount = widget.controller.bulkScanItems.where((i) => i.status == BulkScanStatus.review || i.status == BulkScanStatus.notFound).length;
    final duplicateCount = widget.controller.bulkScanItems.where((i) => i.status == BulkScanStatus.duplicate).length;

    final fields = widget.controller.getOrderedFields();
    // 100 base width for checkbox, #, and padding
    double totalWidth = 100 + 56 + 48; // Static cols
    for (var f in fields) {
       if (f == 'title') totalWidth += 200;
       else if (f == 'description') totalWidth += 150;
       else if (f.contains('Price') || f == 'mrp' || f == 'costPrice') totalWidth += 90;
       else if (f.contains('Stock') || f == 'openingStock') totalWidth += 80;
       else totalWidth += 120;
    }

    return Column(
      children: [
        Container(
          height: 60, padding: const EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(color: widget.colors.bgTier2, border: Border(bottom: BorderSide(color: widget.colors.borderSubtle))),
          child: Row(
            children: [
              ZenoButton(label: "START SCANNING", icon: Icons.camera_alt_outlined, onPressed: () {}),
              const SizedBox(width: 12),
              SizedBox(width: 200, child: ZenoTextField(label: null, hint: "Enter Barcode...", onSubmitted: (v) => widget.controller.handleBulkBarcodeScanned(v))),
              const SizedBox(width: 12),
              ZenoButton(label: "MANUAL ROW", variant: ZenoButtonVariant.secondary, icon: Icons.add_rounded, onPressed: () => widget.controller.handleBulkBarcodeScanned("MANUAL-${DateTime.now().millisecond}")),
              const Spacer(),
              _StatToken(label: "SCANNED", value: "${widget.controller.bulkScanItems.length}", color: widget.colors.textPrimary),
              const SizedBox(width: 16),
              _StatToken(label: "READY", value: "$readyCount", color: widget.colors.statusSuccess),
              const SizedBox(width: 16),
              _StatToken(label: "REVIEW", value: "${reviewCount + duplicateCount}", color: widget.colors.statusWarning),
              const SizedBox(width: 24),
              ZenoButton(label: "FINISH SCAN", onPressed: widget.controller.addBulkReadyToCatalog, isLoading: widget.controller.isSaving),
            ],
          ),
        ),
        Expanded(
          child: Scrollbar(
            controller: _horizontalController,
            thumbVisibility: true,
            child: SingleChildScrollView(
              controller: _horizontalController,
              scrollDirection: Axis.horizontal,
              child: SizedBox(
                width: totalWidth,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _buildTableHeader(),
                    Expanded(child: ListView.builder(itemCount: widget.controller.bulkScanItems.length, itemBuilder: (context, index) {
                      return SessionRow(index: index, item: widget.controller.bulkScanItems[index], controller: widget.controller, colors: widget.colors, updateField: widget.controller.updateBulkItemField);
                    })),
                  ],
                ),
              ),
            ),
          ),
        ),
        if (widget.controller.bulkScanItems.any((i) => i.isSelected))
          _buildBottomActionBar(),
      ],
    );
  }

  Widget _buildTableHeader() {
    final fields = widget.controller.getOrderedFields();
    double totalWidth = 100 + 56 + 48; // Must match calculation in build
    for (var f in fields) {
       if (f == 'title') totalWidth += 200;
       else if (f == 'description') totalWidth += 150;
       else if (f.contains('Price') || f == 'mrp' || f == 'costPrice') totalWidth += 90;
       else if (f.contains('Stock') || f == 'openingStock') totalWidth += 80;
       else totalWidth += 120;
    }

    return Container(
      width: totalWidth, height: 32, decoration: BoxDecoration(color: widget.colors.bgTier3, border: Border.all(color: widget.colors.borderSubtle)),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        children: [
          Checkbox(value: widget.controller.bulkScanItems.isNotEmpty && widget.controller.bulkScanItems.every((i) => i.isSelected), onChanged: (v) => widget.controller.toggleBulkSelectAll(v ?? false), visualDensity: VisualDensity.compact),
          const ColHeader(width: 36, label: "#"),
          const ColHeader(width: 56, label: "IMG"),
          
          // Dynamic Headers
          ...fields.map((f) {
            double width = 120;
            if (f == 'title') width = 200;
            if (f == 'description') width = 150;
            if (f.contains('Price') || f == 'mrp' || f == 'costPrice') width = 90;
            if (f.contains('Stock') || f == 'openingStock') width = 80;
            return ColHeader(width: width, label: widget.controller.getFieldLabel(f));
          }),
        ],
      ),
    );
  }

  Widget _buildBottomActionBar() {
    return Container(
      height: 48, color: widget.colors.accentPrimary.withValues(alpha: 0.1),
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        children: [
          Text("${widget.controller.bulkScanItems.where((i) => i.isSelected).length} SELECTED", style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: widget.colors.accentPrimary)),
          const Spacer(),
          ZenoButton(label: "BULK EDIT", variant: ZenoButtonVariant.secondary, size: ZenoButtonSize.sm, onPressed: () {}),
          const SizedBox(width: 12),
          ZenoButton(label: "DELETE SELECTED", variant: ZenoButtonVariant.ghost, size: ZenoButtonSize.sm, onPressed: widget.controller.deleteSelectedBulkItems),
        ],
      ),
    );
  }
}

class _StatToken extends StatelessWidget {
  final String label; final String value; final Color color;
  const _StatToken({required this.label, required this.value, required this.color});
  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Text(label, style: const TextStyle(fontSize: 7, fontWeight: FontWeight.bold)),
      Text(value, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w900, color: color)),
    ]);
  }
}

class ColHeader extends StatelessWidget {
  final double width; final String label;
  const ColHeader({super.key, required this.width, required this.label});
  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<ZenoSemanticColors>()!;
    return Container(
      width: width, decoration: BoxDecoration(border: Border(right: BorderSide(color: colors.borderSubtle))),
      padding: const EdgeInsets.only(left: 8), alignment: Alignment.centerLeft,
      child: Text(label, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 8, fontWeight: FontWeight.w900, letterSpacing: 0.5)),
    );
  }
}
