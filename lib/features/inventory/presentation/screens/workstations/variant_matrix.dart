import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:zeno/app/theme.dart';
import '../../controllers/product_studio_controller.dart';
import 'widgets/variant_matrix_row.dart';

part 'parts/variant_matrix_toolbar.part.dart';

class VariantMatrix extends StatefulWidget {
  final ProductStudioController controller;
  final ZenoSemanticColors colors;
  const VariantMatrix({super.key, required this.controller, required this.colors});

  @override
  State<VariantMatrix> createState() => _VariantMatrixState();
}

class _VariantMatrixState extends State<VariantMatrix> {
  ProductStudioController get controller => widget.controller;
  ZenoSemanticColors get colors => widget.colors;

  final Map<int, FocusNode> _quantityFocusNodes = {};

  FocusNode _getQuantityFocusNode(int rowIndex) {
    return _quantityFocusNodes.putIfAbsent(
      rowIndex,
      () => FocusNode(debugLabel: 'Quantity_$rowIndex'),
    );
  }

  @override
  void dispose() {
    for (var node in _quantityFocusNodes.values) {
      node.dispose();
    }
    _quantityFocusNodes.clear();
    super.dispose();
  }

  void _handleQuantityKey(int rowIndex, LogicalKeyboardKey key, bool isShift) {
    final totalRows = controller.generatedVariants.length;
    if (totalRows == 0) return;

    int nextRow = rowIndex;

    if (key == LogicalKeyboardKey.arrowDown || key == LogicalKeyboardKey.enter) {
      nextRow = (rowIndex + 1) < totalRows ? rowIndex + 1 : rowIndex;
    } else if (key == LogicalKeyboardKey.arrowUp) {
      nextRow = (rowIndex - 1) >= 0 ? rowIndex - 1 : rowIndex;
    } else if (key == LogicalKeyboardKey.tab) {
      if (isShift) {
        nextRow = (rowIndex - 1) >= 0 ? rowIndex - 1 : rowIndex;
      } else {
        nextRow = (rowIndex + 1) < totalRows ? rowIndex + 1 : rowIndex;
      }
    }

    _getQuantityFocusNode(nextRow).requestFocus();
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
                  quantityFocusNode: _getQuantityFocusNode(i),
                  onQuantityKey: (key, isShift) => _handleQuantityKey(i, key, isShift),
                ),
              ),
            const SizedBox(height: 10),
            _buildFooter(),
          ],
        ),
      ),
    );
  }

  Widget _buildTableHeader() {
    const borderColor = Color(0xFFE2E8F0);
    return Container(
      height: 38,
      decoration: const BoxDecoration(
        color: Color(0xFFF8FAFC),
        border: Border.fromBorderSide(BorderSide(color: borderColor)),
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
          Expanded(flex: 4, child: _headerCell("VARIANT SKU (AUTO)", borderColor)),
          Expanded(flex: 4, child: _headerCell("BARCODE (AUTO)", borderColor)),
          Expanded(flex: 2, child: _headerCell("QUANTITY (EDIT)", borderColor, alignment: Alignment.center, hasRightBorder: false)),
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
            Icon(Icons.layers_outlined, size: 36, color: colors.textDisabled.withValues(alpha: 0.5)),
            const SizedBox(height: 8),
            Text("NO VARIANTS GENERATED - Select sizes & colours above", style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: colors.textDisabled)),
          ],
        ),
      ),
    );
  }

  Widget _buildFooter() {
    final totalStock = controller.generatedVariants.fold(0, (sum, v) => sum + v.stock);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 6),
      child: Row(
        children: [
          Text(
            "Showing 1 to ${controller.generatedVariants.length} of ${controller.generatedVariants.length}",
            style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: Color(0xFF64748B)),
          ),
          const Spacer(),
          Text(
            "Total Initial Stock: $totalStock",
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w800, color: Color(0xFF1E293B)),
          ),
        ],
      ),
    );
  }

  Future<void> _confirmClearAll(BuildContext context) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Clear All Variants', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700)),
        content: const Text('Are you sure you want to clear all generated variants?'),
        actions: [
          TextButton(onPressed: () => Navigator.of(context).pop(false), child: const Text('Cancel')),
          TextButton(onPressed: () => Navigator.of(context).pop(true), child: Text('Clear', style: TextStyle(color: colors.statusDanger))),
        ],
      ),
    );
    if (confirmed == true) {
      controller.clearAllVariants();
      setState(() {});
    }
  }
}
