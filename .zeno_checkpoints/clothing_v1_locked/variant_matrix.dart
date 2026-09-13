import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/core/widgets/zeno_card.dart';
import '../../controllers/product_studio_controller.dart';
import 'widgets/variant_matrix_row.dart';

class VariantMatrix extends StatelessWidget {
  final ProductStudioController controller;
  final ZenoSemanticColors colors;
  const VariantMatrix({super.key, required this.controller, required this.colors});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: colors.borderSubtle.withOpacity(0.5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "GENERATED VARIANTS (${controller.generatedVariants.length})",
                style: TextStyle(fontSize: 10, fontWeight: FontWeight.w900, color: colors.textPrimary),
              ),
              InkWell(
                onTap: () => controller.product.variants.clear(),
                child: Row(
                  children: [
                    Icon(Icons.delete_outline_rounded, size: 14, color: colors.statusDanger),
                    const SizedBox(width: 4),
                    Text("Clear All", style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: colors.statusDanger)),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          _buildActionToolbar(),
          const SizedBox(height: 10),
          _buildTableHeader(),
          const Divider(height: 1),
          Expanded(
            child: controller.generatedVariants.isEmpty
              ? _buildEmptyState()
              : ListView.builder(
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
          ),
          _buildFooter(),
        ],
      ),
    );
  }

  Widget _buildActionToolbar() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          _toolbarBtn("Sync First Row", Icons.sync_rounded, colors.textPrimary, controller.syncAllFromFirstRow),
          const SizedBox(width: 4),
          _toolbarBtn("Barcodes", Icons.qr_code_rounded, colors.textPrimary, controller.generateAllVariantBarcodes),
          const SizedBox(width: 4),
          _toolbarBtn("Bulk Price", Icons.payments_outlined, colors.textPrimary, controller.syncBasePriceToAllVariants),
          const SizedBox(width: 4),
          _toolbarBtn("Bulk Stock", Icons.inventory_2_outlined, colors.textPrimary, controller.syncBaseStockToAllVariants),
        ],
      ),
    );
  }

  Widget _toolbarBtn(String l, IconData i, Color c, VoidCallback onPressed) => OutlinedButton.icon(
    onPressed: onPressed,
    icon: Icon(i, size: 12, color: c.withOpacity(0.7)),
    label: Text(l, style: TextStyle(fontSize: 9, fontWeight: FontWeight.bold, color: c)),
    style: OutlinedButton.styleFrom(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      side: BorderSide(color: colors.borderSubtle),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      minimumSize: Size.zero,
      visualDensity: VisualDensity.compact,
    ),
  );

  Widget _buildTableHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      color: Colors.grey.shade50.withOpacity(0.5),
      child: Row(
        children: [
          _headerCell("#", width: 24),
          _headerCell("COLOUR", width: 90),
          _headerCell("SIZE", width: 50),
          Expanded(flex: 2, child: _headerCell("VARIANT SKU")),
          const SizedBox(width: 6),
          Expanded(flex: 2, child: _headerCell("BARCODE")),
          const SizedBox(width: 6),
          _headerCell("STOCK", width: 60),
          const SizedBox(width: 6),
          _headerCell("PRICE (₹)", width: 80),
          const SizedBox(width: 6),
          _headerCell("ACTIONS", width: 50, alignment: Alignment.centerRight),
        ],
      ),
    );
  }

  Widget _headerCell(String label, {double? width, Alignment alignment = Alignment.centerLeft}) {
    return Container(
      width: width,
      alignment: alignment,
      child: Text(
        label,
        style: TextStyle(fontSize: 8, fontWeight: FontWeight.w900, color: colors.textSecondary.withOpacity(0.8), letterSpacing: 0.5),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.layers_outlined, size: 40, color: colors.textDisabled.withOpacity(0.5)),
          const SizedBox(height: 8),
          Text("NO VARIANTS GENERATED", style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: colors.textDisabled)),
        ],
      ),
    );
  }

  Widget _buildFooter() {
    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: Row(
        children: [
          Text(
            "Showing 1 to ${controller.generatedVariants.length} of ${controller.generatedVariants.length}",
            style: TextStyle(fontSize: 9, fontWeight: FontWeight.w600, color: colors.textSecondary),
          ),
          const Spacer(),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              border: Border.all(color: colors.borderSubtle),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Row(
              children: [
                Text("View All", style: TextStyle(fontSize: 9, fontWeight: FontWeight.bold, color: colors.textPrimary)),
                const SizedBox(width: 6),
                Icon(Icons.keyboard_arrow_down_rounded, size: 14, color: colors.textPrimary),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
