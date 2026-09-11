// @LOCKED: VERSION_CLOTHING_V1
import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
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
                style: TextStyle(fontSize: 10, fontWeight: FontWeight.w900, color: colors.textPrimary),
              ),
              InkWell(
                onTap: () => controller.product.variants.clear(),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
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
          
          // Data Rows (Removed Expanded to prevent layout crashes in scroll views)
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
          
          _buildFooter(),
        ],
      ),
    ),
  );
}

  Widget _buildActionToolbar() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          _bulkActionPill("Bulk Price: ₹", "1299", 50, (v) {}),
          const SizedBox(width: 8),
          _bulkActionPill("Bulk Stock:", "50", 40, (v) {}),
          const SizedBox(width: 8),
          _toolbarBtn("Sync 1st", Icons.sync_rounded, colors.textPrimary, controller.syncAllFromFirstRow),
          const SizedBox(width: 6),
          _toolbarBtn("Barcodes", Icons.qr_code_rounded, colors.textPrimary, controller.generateAllVariantBarcodes),
          const SizedBox(width: 12),
          Container(width: 1, height: 16, color: const Color(0xFFE2E8F0)),
          const SizedBox(width: 12),
          _searchBox(),
        ],
      ),
    );
  }

  Widget _bulkActionPill(String label, String hint, double width, Function(String) onApply) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(6),
      border: Border.all(color: const Color(0xFFE2E8F0)),
      boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 2)],
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Icon(Icons.bolt_rounded, size: 12, color: Color(0xFF6366F1)),
        const SizedBox(width: 6),
        Text(label, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: Color(0xFF64748B))),
        const SizedBox(width: 4),
        SizedBox(
          width: width,
          child: TextField(
            decoration: InputDecoration(hintText: hint, border: InputBorder.none, isDense: true, contentPadding: EdgeInsets.zero),
            style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w800, color: Color(0xFF1E293B)),
            keyboardType: TextInputType.number,
          ),
        ),
        InkWell(onTap: () {}, child: const Text("Apply", style: TextStyle(fontSize: 10, fontWeight: FontWeight.w900, color: Color(0xFF4F46E5)))),
      ],
    ),
  );

  Widget _searchBox() => Container(
    width: 140,
    height: 28,
    padding: const EdgeInsets.symmetric(horizontal: 10),
    decoration: BoxDecoration(
      color: const Color(0xFFF1F5F9),
      borderRadius: BorderRadius.circular(6),
    ),
    child: const Row(
      children: [
        Icon(Icons.search_rounded, size: 14, color: Color(0xFF94A3B8)),
        SizedBox(width: 8),
        Expanded(child: TextField(decoration: InputDecoration(hintText: "Search SKU", hintStyle: TextStyle(fontSize: 10, color: Color(0xFF94A3B8)), border: InputBorder.none, isDense: true))),
      ],
    ),
  );

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
      color: const Color(0xFFF8FAFC),
      child: Row(
        children: [
          const SizedBox(width: 8),
          const SizedBox(width: 20, child: Icon(Icons.check_box_outline_blank_rounded, size: 14, color: Color(0xFFCBD5E1))),
          const SizedBox(width: 8),
          _headerCell("COLOUR", width: 100),
          _headerCell("SIZE", width: 50),
          Expanded(flex: 2, child: _headerCell("VARIANT SKU")),
          const SizedBox(width: 6),
          Expanded(flex: 2, child: _headerCell("BARCODE")),
          const SizedBox(width: 6),
          _headerCell("STOCK", width: 60),
          const SizedBox(width: 6),
          _headerCell("PRICE (₹)", width: 80),
          const SizedBox(width: 6),
          _headerCell("MEDIA", width: 60, alignment: Alignment.center),
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
    return SizedBox(
      height: 160,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.layers_outlined, size: 40, color: colors.textDisabled.withOpacity(0.5)),
            const SizedBox(height: 8),
            Text("NO VARIANTS GENERATED - Select sizes & colours above", style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: colors.textDisabled)),
            const SizedBox(height: 8),
          ],
        ),
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
