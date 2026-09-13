import 'package:flutter/material.dart' hide TableCell;
import 'dart:io';
import 'package:zeno/app/theme.dart';
import '../../../../domain/models/variant_matrix_item.dart';
import '../../../../domain/models/media_asset.dart';
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
    const borderColor = Color(0xFFE2E8F0);
    return InkWell(
      onTap: () => controller.setActiveMediaColor(variant.color),
      child: Container(
        height: 42,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            left: BorderSide(color: borderColor),
            right: BorderSide(color: borderColor),
            bottom: BorderSide(color: borderColor),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
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
                    Container(width: 12, height: 12, decoration: BoxDecoration(color: colorValue, shape: BoxShape.circle, border: Border.all(color: Colors.black12, width: 0.5))),
                    const SizedBox(width: 8),
                    Expanded(child: Text(variant.color, style: const TextStyle(fontSize: 11.5, fontWeight: FontWeight.w600, color: Color(0xFF1E293B)), overflow: TextOverflow.ellipsis)),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: _buildCell(
                borderColor: borderColor,
                child: Center(
                  child: Container(
                    constraints: const BoxConstraints(minWidth: 54),
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                    decoration: BoxDecoration(color: const Color(0xFFF8FAFC), borderRadius: BorderRadius.circular(4), border: Border.all(color: const Color(0xFFE2E8F0))),
                    child: Text(variant.size, textAlign: TextAlign.center, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w800, color: Color(0xFF475569))),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 4,
              child: _buildCell(
                borderColor: borderColor,
                child: _tableInput(variant.sku, (v) => controller.updateVariantField(index, sku: v)),
              ),
            ),
            Expanded(
              flex: 4,
              child: _buildCell(
                borderColor: borderColor,
                child: _tableInput(variant.barcode, (v) => controller.updateVariantField(index, barcode: v)),
              ),
            ),
            Expanded(
              flex: 2,
              child: _buildCell(
                borderColor: borderColor,
                child: _tableInput(variant.stock.toString(), (v) => controller.updateVariantField(index, stock: int.tryParse(v)), textAlign: TextAlign.center),
              ),
            ),
            Expanded(
              flex: 2,
              child: _buildCell(
                borderColor: borderColor,
                child: _tableInput(variant.price.toString(), (v) => controller.updateVariantField(index, price: double.tryParse(v)), isBold: true, textAlign: TextAlign.right),
              ),
            ),
            Expanded(
              flex: 1,
              child: _buildCell(
                borderColor: borderColor,
                child: Center(
                  child: InkWell(
                    onTap: () => _showVariantMediaDialog(context),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.image_outlined, size: 14, color: Color(0xFF3B66F5)),
                        const SizedBox(width: 4),
                        Text(
                          '${controller.getVariantMediaCount(index)}',
                          style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w800, color: Color(0xFF3B66F5)),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Center(
                child: InkWell(
                  onTap: () => controller.removeVariantItem(index),
                  child: const Icon(Icons.delete_outline_rounded, size: 15, color: Color(0xFF94A3B8)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _tableInput(String value, Function(String) onChanged, {bool isBold = false, TextAlign textAlign = TextAlign.left}) {
    return TextField(
      controller: TextEditingController(text: value)..selection = TextSelection.collapsed(offset: value.length),
      onChanged: onChanged,
      textAlign: textAlign,
      style: TextStyle(fontSize: 11, fontWeight: isBold ? FontWeight.w800 : FontWeight.w600, color: const Color(0xFF1E293B)),
      decoration: const InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 12),
        border: InputBorder.none,
        isDense: true,
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

  Future<void> _showVariantMediaDialog(BuildContext context) async {
    await showDialog<void>(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) {
          final media = controller.getVariantMedia(index);
          return AlertDialog(
            title: Text('Variant Media • ${variant.sku}', style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700)),
            content: SizedBox(
              width: 420,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      ...media.map(_mediaThumb),
                      InkWell(
                        onTap: () async {
                          await controller.uploadVariantMedia(index);
                          setState(() {});
                        },
                        child: Container(
                          width: 84,
                          height: 84,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: const Color(0xFFE2E8F0)),
                          ),
                          child: const Icon(Icons.add_a_photo_outlined, color: Color(0xFF64748B), size: 20),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Close'),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _mediaThumb(MediaAsset asset) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Image.file(
        File(asset.url),
        width: 84,
        height: 84,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => Container(
          width: 84,
          height: 84,
          color: const Color(0xFFF8FAFC),
          alignment: Alignment.center,
          child: const Icon(Icons.image_outlined, color: Color(0xFF94A3B8)),
        ),
      ),
    );
  }
}
