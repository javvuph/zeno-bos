import 'package:flutter/material.dart' hide TableCell;
import 'package:zeno/app/theme.dart';
import '../../../../domain/models/variant_matrix_item.dart';
import '../../../controllers/product_studio_controller.dart';
import '../../widgets/product_studio_widgets.dart';

class VariantMatrixRow extends StatelessWidget {
  final int index; final VariantMatrixItem variant; final ProductStudioController controller; final ZenoSemanticColors colors; final bool isActive;
  const VariantMatrixRow({super.key, required this.index, required this.variant, required this.controller, required this.colors, required this.isActive});

  @override
  Widget build(BuildContext context) {
    final deco = isActive ? BoxDecoration(color: colors.accentPrimary.withValues(alpha: 0.05), border: Border(left: BorderSide(color: colors.accentPrimary, width: 2), right: BorderSide(color: colors.borderSubtle))) : null;
    return InkWell(
      onTap: () => controller.setActiveVariant(index),
      child: Container(
        height: 40, decoration: deco,
        child: Row(children: [
          TableCell(width: 80, child: Text("${variant.color} / ${variant.size}", style: const TextStyle(fontSize: 8, fontWeight: FontWeight.bold))),
          TableCell(width: 100, child: TableCellField(value: variant.sku, onChanged: (v) => controller.updateVariantField(index, sku: v))),
          TableCell(width: 100, child: TableCellField(value: variant.barcode, onChanged: (v) => controller.updateVariantField(index, barcode: v))),
          TableCell(width: 50, child: TableCellField(value: variant.stock.toString(), textAlign: TextAlign.center, onChanged: (v) => controller.updateVariantField(index, stock: int.tryParse(v)))),
          TableCell(width: 50, child: TableCellField(value: variant.safetyStock.toString(), textAlign: TextAlign.center, onChanged: (v) => controller.updateVariantField(index, safetyStock: int.tryParse(v)))),
          TableCell(width: 50, child: TableCellField(value: variant.reorderLevel.toString(), textAlign: TextAlign.center, onChanged: (v) => controller.updateVariantField(index, reorderLevel: double.tryParse(v)))),
          TableCell(width: 170, child: TableCellDropdown<String>(value: variant.warehouseLocation.isEmpty ? null : variant.warehouseLocation, items: controller.locationsList, onChanged: (v) => controller.updateVariantField(index, warehouseLocation: v))),
          TableCell(width: 80, child: TableCellField(value: variant.purchasePrice.toString(), textAlign: TextAlign.center, onChanged: (v) => controller.updateVariantField(index, purchasePrice: double.tryParse(v)))),
          TableCell(width: 80, child: TableCellField(value: variant.price.toString(), textAlign: TextAlign.center, onChanged: (v) => controller.updateVariantField(index, price: double.tryParse(v)))),
          TableCell(width: 80, child: TableCellField(value: variant.mrp.toString(), textAlign: TextAlign.center, onChanged: (v) => controller.updateVariantField(index, mrp: double.tryParse(v)))),
          TableCell(width: 80, child: TableCellField(value: variant.wholesalePrice.toString(), textAlign: TextAlign.center, onChanged: (v) => controller.updateVariantField(index, wholesalePrice: double.tryParse(v)))),
          TableCell(width: 44, child: IconButton(visualDensity: VisualDensity.compact, icon: Icon(Icons.delete_outline, size: 14, color: colors.statusDanger), onPressed: () => controller.removeVariantItem(index))),
        ]),
      ),
    );
  }
}
