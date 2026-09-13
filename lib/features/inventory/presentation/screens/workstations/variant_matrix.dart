// @LOCKED: VERSION_CLOTHING_V1
import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import '../../controllers/product_studio_controller.dart';
import 'widgets/variant_matrix_row.dart';

class VariantMatrix extends StatefulWidget {
  final ProductStudioController controller;
  final ZenoSemanticColors colors;
  const VariantMatrix({super.key, required this.controller, required this.colors});

  @override
  State<VariantMatrix> createState() => _VariantMatrixState();
}

class _VariantMatrixState extends State<VariantMatrix> {
  static const double _toolbarFontSize = 12;
  late final TextEditingController _bulkPriceController;
  late final TextEditingController _bulkStockController;

  ProductStudioController get controller => widget.controller;
  ZenoSemanticColors get colors => widget.colors;

  @override
  void initState() {
    super.initState();
    _bulkPriceController = TextEditingController(text: '0');
    _bulkStockController = TextEditingController(text: '0');
  }

  @override
  void dispose() {
    _bulkPriceController.dispose();
    _bulkStockController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header Actions
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "GENERATED VARIANTS (${controller.generatedVariants.length})",
                  style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w800, color: Color(0xFF1E293B)),
                ),
                InkWell(
                  onTap: controller.generatedVariants.isEmpty ? null : () => _confirmClearAll(context),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.delete_outline_rounded, size: 15, color: colors.statusDanger),
                      const SizedBox(width: 4),
                      Text("Clear All", style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: colors.statusDanger)),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            _buildActionToolbar(),
            const SizedBox(height: 12),
            _buildTableHeader(),
            if (controller.generatedVariants.isEmpty)
              _buildEmptyState()
            else
              ListView.builder(
                shrinkWrap: true,
                primary: false,
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.only(bottom: 8),
                itemCount: controller.generatedVariants.length,
                itemBuilder: (context, i) => VariantMatrixRow(
                  index: i,
                  variant: controller.generatedVariants[i],
                  controller: controller,
                  colors: colors,
                  isActive: controller.activeVariantIndex == i,
                ),
              ),
            
            const SizedBox(height: 10),
            _buildFooter(),
          ],
        ),
      ),
    );
  }

  Widget _buildActionToolbar() {
    const borderColor = Color(0xFFE2E8F0);
    return Container(
      height: 44,
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        border: Border.all(color: borderColor),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(flex: 3, child: _toolbarGridCell(borderColor: borderColor)),
          Expanded(flex: 2, child: _toolbarGridCell(borderColor: borderColor)),
          Expanded(
          flex: 4,
          child: _toolbarGridCell(
            borderColor: borderColor,
            child: _toolbarBtn("Sync 1st", Icons.sync_rounded, const Color(0xFF1E293B), controller.syncAllFromFirstRow),
          ),
          ),
          Expanded(
          flex: 4,
          child: _toolbarGridCell(
            borderColor: borderColor,
            child: _toolbarBtn("Barcodes", Icons.qr_code_rounded, const Color(0xFF1E293B), controller.generateAllVariantBarcodes),
          ),
          ),
          Expanded(
          flex: 2,
          child: _toolbarGridCell(
            borderColor: borderColor,
            child: _bulkActionPill("Stock", "0", 36, _bulkStockController, _applyBulkStock),
          ),
          ),
          Expanded(
          flex: 2,
          child: _toolbarGridCell(
            borderColor: borderColor,
            child: _bulkActionPill("Price", "0", 44, _bulkPriceController, _applyBulkPrice),
          ),
          ),
          Expanded(flex: 1, child: _toolbarGridCell(borderColor: borderColor)),
          Expanded(
          flex: 1,
          child: _toolbarGridCell(
            borderColor: borderColor,
            hasRightBorder: false,
            child: _searchBox(),
          ),
          ),
        ],
      ),
    );
  }

  Widget _bulkActionPill(String label, String hint, double width, TextEditingController textController, VoidCallback onApply) => Container(
    height: 32,
    padding: const EdgeInsets.symmetric(horizontal: 8),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(6),
      border: Border.all(color: const Color(0xFFE2E8F0)),
    ),
    child: SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.bolt_rounded, size: 14, color: Color(0xFF3B66F5)),
          const SizedBox(width: 5),
          Text(label, style: const TextStyle(fontSize: _toolbarFontSize, fontWeight: FontWeight.w600, color: Color(0xFF64748B))),
          const SizedBox(width: 3),
          SizedBox(
            width: width,
            child: TextField(
              controller: textController,
              decoration: InputDecoration(hintText: hint, border: InputBorder.none, isDense: true, contentPadding: EdgeInsets.zero),
              style: const TextStyle(fontSize: _toolbarFontSize, fontWeight: FontWeight.w700, color: Color(0xFF1E293B)),
              keyboardType: TextInputType.number,
            ),
          ),
          InkWell(onTap: onApply, child: const Text("Apply", style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: Color(0xFF3B66F5)))),
        ],
      ),
    ),
  );

  Widget _searchBox() => Container(
    height: 32,
    padding: const EdgeInsets.symmetric(horizontal: 8),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(6),
      border: Border.all(color: const Color(0xFFE2E8F0)),
    ),
    child: const Row(
      children: [
        Icon(Icons.search_rounded, size: 14, color: Color(0xFF94A3B8)),
        SizedBox(width: 6),
        Expanded(child: TextField(style: TextStyle(fontSize: _toolbarFontSize, fontWeight: FontWeight.w500, color: Color(0xFF1E293B)), decoration: InputDecoration(hintText: "Search SKU, barcode...", hintStyle: TextStyle(fontSize: _toolbarFontSize, fontWeight: FontWeight.w500, color: Color(0xFF94A3B8)), border: InputBorder.none, isDense: true))),
      ],
    ),
  );

  Widget _toolbarBtn(String l, IconData i, Color c, VoidCallback onPressed) => OutlinedButton.icon(
    onPressed: onPressed,
    icon: Icon(i, size: 13, color: c.withOpacity(0.8)),
    label: Text(l, style: TextStyle(fontSize: _toolbarFontSize, fontWeight: FontWeight.w600, color: c)),
    style: OutlinedButton.styleFrom(
      minimumSize: const Size(0, 32),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      side: const BorderSide(color: Color(0xFFCBD5E1)),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
      visualDensity: VisualDensity.compact,
      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
    ),
  );

  Widget _toolbarGridCell({
    required Color borderColor,
    Widget? child,
    bool hasRightBorder = true,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 5),
      decoration: BoxDecoration(
        border: hasRightBorder ? Border(right: BorderSide(color: borderColor)) : null,
      ),
      child: child == null ? const SizedBox.shrink() : Center(child: child),
    );
  }

  Widget _buildTableHeader() {
    final borderColor = const Color(0xFFE2E8F0);
    return Container(
      height: 38,
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        border: Border.all(color: borderColor),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            flex: 3,
            child: _headerCell(
              "COLOUR",
              borderColor,
              leading: Checkbox(
                value: controller.areAllVariantsSelected,
                onChanged: controller.generatedVariants.isEmpty ? null : (value) => controller.toggleAllVariantsSelection(value ?? false),
                visualDensity: VisualDensity.compact,
              ),
            ),
          ),
          Expanded(flex: 2, child: _headerCell("SIZE", borderColor, alignment: Alignment.center)),
          Expanded(flex: 4, child: _headerCell("VARIANT SKU", borderColor)),
          Expanded(flex: 4, child: _headerCell("BARCODE", borderColor)),
          Expanded(flex: 2, child: _headerCell("STOCK", borderColor, alignment: Alignment.center)),
          Expanded(flex: 2, child: _headerCell("PRICE (₹)", borderColor, alignment: Alignment.centerRight)),
          Expanded(flex: 1, child: _headerCell("MEDIA", borderColor, alignment: Alignment.center)),
          Expanded(flex: 1, child: _headerCell("ACTIONS", borderColor, alignment: Alignment.centerRight, hasRightBorder: false)),
        ],
      ),
    );
  }

  Widget _headerCell(
    String label,
    Color borderColor, {
    Alignment alignment = Alignment.centerLeft,
    Widget? leading,
    bool hasRightBorder = true,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      alignment: alignment,
      decoration: BoxDecoration(
        border: hasRightBorder ? Border(right: BorderSide(color: borderColor)) : null,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (leading != null) ...[
            leading,
            const SizedBox(width: 4),
          ],
          Flexible(
            child: Text(
              label,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w800, color: Color(0xFF64748B), letterSpacing: 0.5),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return SizedBox(
      height: 120,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.layers_outlined, size: 36, color: colors.textDisabled.withOpacity(0.5)),
            const SizedBox(height: 8),
            Text("NO VARIANTS GENERATED - Select sizes & colours above", style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: colors.textDisabled)),
          ],
        ),
      ),
    );
  }

  Widget _buildFooter() {
    return Padding(
      padding: const EdgeInsets.only(top: 4),
      child: Row(
        children: [
          Text(
            "Showing 1 to ${controller.generatedVariants.length} of ${controller.generatedVariants.length}",
            style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: Color(0xFF64748B)),
          ),
          const Spacer(),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              border: Border.all(color: const Color(0xFFE2E8F0)),
              borderRadius: BorderRadius.circular(6),
            ),
            child: const Row(
              children: [
                Text("View All", style: TextStyle(fontSize: 10.5, fontWeight: FontWeight.bold, color: Color(0xFF1E293B))),
                SizedBox(width: 6),
                Icon(Icons.keyboard_arrow_down_rounded, size: 14, color: Color(0xFF1E293B)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _confirmClearAll(BuildContext context) async {
    final shouldClear = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Clear all variants?'),
        content: const Text('This will remove all generated variants from the table.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Clear All'),
          ),
        ],
      ),
    );

    if (shouldClear == true) {
      controller.clearAllVariants();
    }
  }

  void _applyBulkPrice() {
    final value = double.tryParse(_bulkPriceController.text.trim());
    if (value == null) return;
    controller.applyBulkPrice(value);
  }

  void _applyBulkStock() {
    final value = int.tryParse(_bulkStockController.text.trim());
    if (value == null) return;
    controller.applyBulkStock(value);
  }
}
