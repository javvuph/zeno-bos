import 'package:flutter/material.dart' hide TableCell;
import 'package:zeno/app/theme.dart';
import '../../../../domain/models/variant_matrix_item.dart';
import '../../../controllers/product_studio_controller.dart';
import '../../widgets/product_studio_widgets.dart';

class VariantMatrixRow extends StatelessWidget {
  final int index;
  final VariantMatrixItem variant;
  final ProductStudioController controller;
  final ZenoSemanticColors colors;
  final bool isActive;

  const VariantMatrixRow({
    super.key,
    required this.index,
    required this.variant,
    required this.controller,
    required this.colors,
    required this.isActive,
  });

  @override
  Widget build(BuildContext context) {
    final colorValue = controller.getColorValue(variant.color);
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: colors.borderSubtle.withOpacity(0.2))),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      child: Row(
        children: [
          // Index
          SizedBox(width: 24, child: Text("${index + 1}", style: TextStyle(fontSize: 9, fontWeight: FontWeight.w600, color: colors.textSecondary))),
          
          // Colour
          SizedBox(
            width: 90,
            child: Row(
              children: [
                Container(width: 8, height: 8, decoration: BoxDecoration(color: colorValue, shape: BoxShape.circle, border: Border.all(color: Colors.grey.shade300, width: 0.5))),
                const SizedBox(width: 6),
                Expanded(child: Text(variant.color, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.black87), overflow: TextOverflow.ellipsis)),
              ],
            ),
          ),

          // Size
          SizedBox(width: 50, child: Text(variant.size, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w800, color: Colors.black87))),

          // SKU
          Expanded(flex: 2, child: _tableInput(variant.sku, (v) => controller.updateVariantField(index, sku: v))),
          const SizedBox(width: 6),
          
          // Barcode
          Expanded(flex: 2, child: _tableInput(variant.barcode, (v) => controller.updateVariantField(index, barcode: v))),
          const SizedBox(width: 6),
          
          // Stock
          SizedBox(width: 60, child: _tableInput(variant.stock.toString(), (v) => controller.updateVariantField(index, stock: int.tryParse(v)))),
          const SizedBox(width: 6),
          
          // Price
          SizedBox(width: 80, child: _tableInput(variant.price.toString(), (v) => controller.updateVariantField(index, price: double.tryParse(v)))),
          const SizedBox(width: 6),

          // Actions
          SizedBox(
            width: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Icon(Icons.qr_code_2_rounded, size: 14, color: colors.textSecondary.withOpacity(0.5)),
                const SizedBox(width: 8),
                InkWell(
                  onTap: () => controller.removeVariantItem(index),
                  child: Icon(Icons.delete_outline_rounded, size: 14, color: colors.textSecondary.withOpacity(0.5)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _tableInput(String value, Function(String) onChanged) {
    return Container(
      height: 28,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: TextField(
        controller: TextEditingController(text: value)..selection = TextSelection.collapsed(offset: value.length),
        onChanged: onChanged,
        style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: Colors.black87),
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 6, vertical: 0),
          border: InputBorder.none,
          isDense: true,
        ),
      ),
    );
  }
}
