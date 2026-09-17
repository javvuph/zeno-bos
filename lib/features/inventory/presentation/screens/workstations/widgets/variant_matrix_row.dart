import 'package:flutter/material.dart' hide TableCell;
import 'package:flutter/services.dart';
import 'package:zeno/app/theme.dart';
import '../../../../domain/models/variant_matrix_item.dart';
import '../../../controllers/product_studio_controller.dart';

class VariantMatrixRow extends StatelessWidget {
  final int index;
  final VariantMatrixItem variant;
  final ProductStudioController controller;
  final ZenoSemanticColors colors;
  final bool isActive;
  final FocusNode quantityFocusNode;
  final Function(LogicalKeyboardKey key, bool isShift) onQuantityKey;

  const VariantMatrixRow({
    super.key,
    required this.index,
    required this.variant,
    required this.controller,
    required this.colors,
    required this.isActive,
    required this.quantityFocusNode,
    required this.onQuantityKey,
  });

  @override
  Widget build(BuildContext context) {
    final colorValue = controller.getColorValue(variant.color);
    const borderColor = Color(0xFFE2E8F0);
    final skuText = variant.sku.isNotEmpty ? variant.sku : 'AUTO';
    final barcodeText = variant.barcode.isNotEmpty ? variant.barcode : 'AUTO';

    return InkWell(
      onTap: () => controller.setActiveMediaColor(variant.color),
      child: Container(
        height: 42,
        decoration: BoxDecoration(
          color: isActive ? colors.accentPrimary.withValues(alpha: 0.05) : Colors.white,
          border: const Border(
            left: BorderSide(color: Color(0xFFE2E8F0)),
            right: BorderSide(color: Color(0xFFE2E8F0)),
            bottom: BorderSide(color: Color(0xFFE2E8F0)),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // COLOUR
            Expanded(
              flex: 3,
              child: _buildCell(
                borderColor: borderColor,
                child: Row(
                  children: [
                    Checkbox(
                      value: variant.isSelected,
                      onChanged: (value) => controller.toggleVariantSelection(index, value ?? false),
                      visualDensity: VisualDensity.compact,
                    ),
                    Container(
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                        color: colorValue,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.black12, width: 0.5),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        variant.color,
                        style: const TextStyle(fontSize: 11.5, fontWeight: FontWeight.w600, color: Color(0xFF1E293B)),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // SIZE
            Expanded(
              flex: 2,
              child: _buildCell(
                borderColor: borderColor,
                child: Center(
                  child: Container(
                    constraints: const BoxConstraints(minWidth: 54),
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF8FAFC),
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(color: const Color(0xFFE2E8F0)),
                    ),
                    child: Text(
                      variant.size,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w800, color: Color(0xFF475569)),
                    ),
                  ),
                ),
              ),
            ),
            // VARIANT SKU (AUTOMATIC / LOCKED)
            Expanded(
              flex: 4,
              child: _buildCell(
                borderColor: borderColor,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Row(
                    children: [
                      const Icon(Icons.lock_outline_rounded, size: 12, color: Color(0xFF94A3B8)),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          skuText,
                          style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: Color(0xFF64748B)),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // BARCODE (AUTOMATIC / LOCKED)
            Expanded(
              flex: 4,
              child: _buildCell(
                borderColor: borderColor,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Row(
                    children: [
                      const Icon(Icons.qr_code_2_rounded, size: 13, color: Color(0xFF94A3B8)),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          barcodeText,
                          style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: Color(0xFF64748B)),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // QUANTITY (EDITABLE CELL)
            Expanded(
              flex: 2,
              child: _buildCell(
                borderColor: borderColor,
                hasRightBorder: false,
                child: _buildQuantityInput(context),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuantityInput(BuildContext context) {
    final textController = TextEditingController(text: variant.stock.toString())
      ..selection = TextSelection.collapsed(offset: variant.stock.toString().length);

    return Focus(
      focusNode: quantityFocusNode,
      onKeyEvent: (node, event) {
        if (event is! KeyDownEvent) return KeyEventResult.ignored;

        final key = event.logicalKey;
        final isShift = HardwareKeyboard.instance.isShiftPressed;

        if (key == LogicalKeyboardKey.arrowUp ||
            key == LogicalKeyboardKey.arrowDown ||
            key == LogicalKeyboardKey.enter ||
            key == LogicalKeyboardKey.tab) {
          onQuantityKey(key, isShift);
          return KeyEventResult.handled;
        }

        return KeyEventResult.ignored;
      },
      child: TextField(
        controller: textController,
        keyboardType: TextInputType.number,
        onChanged: (v) {
          final qty = int.tryParse(v) ?? 0;
          controller.updateVariantField(index, stock: qty);
        },
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w800, color: Color(0xFF1E293B)),
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 12),
          border: InputBorder.none,
          isDense: true,
        ),
      ),
    );
  }

  Widget _buildCell({
    required Widget child,
    required Color borderColor,
    bool hasRightBorder = true,
  }) {
    return Container(
      decoration: BoxDecoration(
        border: hasRightBorder ? Border(right: BorderSide(color: borderColor)) : null,
      ),
      child: child,
    );
  }
}
