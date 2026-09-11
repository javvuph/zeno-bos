import 'package:flutter/material.dart' hide TableCell;
import 'package:zeno/app/theme.dart';
import '../../../../domain/models/variant_matrix_item.dart';
import '../../../controllers/product_studio_controller.dart';

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
    return InkWell(
      onTap: () => controller.setActiveMediaColor(variant.color),
      child: Container(
        decoration: BoxDecoration(
          color: isActive ? const Color(0xFFF5F3FF) : Colors.white,
          border: Border(bottom: BorderSide(color: const Color(0xFFF1F5F9))),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        child: Row(
          children: [
          const SizedBox(width: 8),
          // Checkbox
          SizedBox(width: 20, child: Icon(Icons.check_box_outline_blank_rounded, size: 14, color: isActive ? const Color(0xFF6366F1) : const Color(0xFFCBD5E1))),
          const SizedBox(width: 8),
          
          // Colour
          SizedBox(
            width: 100,
            child: Row(
              children: [
                Container(width: 10, height: 10, decoration: BoxDecoration(color: colorValue, shape: BoxShape.circle, border: Border.all(color: Colors.black12, width: 0.5))),
                const SizedBox(width: 8),
                Expanded(child: Text(variant.color, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: Color(0xFF1E293B)), overflow: TextOverflow.ellipsis)),
              ],
            ),
          ),

          // Size
          SizedBox(
            width: 50, 
            child: Center(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(color: const Color(0xFFF8FAFC), borderRadius: BorderRadius.circular(4), border: Border.all(color: const Color(0xFFE2E8F0))),
                child: Text(variant.size, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w800, color: Color(0xFF475569))),
              ),
            ),
          ),

          // SKU
          Expanded(flex: 2, child: _tableInput(variant.sku, (v) => controller.updateVariantField(index, sku: v))),
          const SizedBox(width: 6),
          
          // Barcode
          Expanded(flex: 2, child: Text(variant.barcode, style: const TextStyle(fontSize: 10, fontFamily: 'monospace', color: Color(0xFF64748B)))),
          const SizedBox(width: 6),
          
          // Stock
          SizedBox(width: 60, child: _tableInput(variant.stock.toString(), (v) => controller.updateVariantField(index, stock: int.tryParse(v)))),
          const SizedBox(width: 6),
          
          // Price
          SizedBox(width: 80, child: _tableInput(variant.price.toString(), (v) => controller.updateVariantField(index, price: double.tryParse(v)), isBold: true)),
          const SizedBox(width: 6),

          // Media
          SizedBox(
            width: 60,
            child: Center(
              child: InkWell(
                onTap: () {},
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.image_outlined, size: 12, color: Color(0xFF6366F1)),
                    const SizedBox(width: 4),
                    Text("3", style: TextStyle(fontSize: 10, fontWeight: FontWeight.w800, color: Color(0xFF4F46E5))),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(width: 6),

          // Actions
          SizedBox(
            width: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  onTap: () => controller.removeVariantItem(index),
                  child: const Icon(Icons.delete_outline_rounded, size: 14, color: Color(0xFF94A3B8)),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

  Widget _tableInput(String value, Function(String) onChanged, {bool isBold = false}) {
    return Container(
      height: 28,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: TextField(
        controller: TextEditingController(text: value)..selection = TextSelection.collapsed(offset: value.length),
        onChanged: onChanged,
        style: TextStyle(fontSize: 10, fontWeight: isBold ? FontWeight.w800 : FontWeight.w600, color: const Color(0xFF1E293B)),
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 6, vertical: 0),
          border: InputBorder.none,
          isDense: true,
        ),
      ),
    );
  }
}
