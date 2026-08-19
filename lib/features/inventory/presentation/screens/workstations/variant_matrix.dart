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
    return ZenoCard(
      title: "Variant Matrix",
      trailing: Text("${controller.generatedVariants.length} VARIANTS", style: TextStyle(fontSize: 9, fontWeight: FontWeight.w900, color: colors.accentPrimary)),
      titleColor: Colors.blue, padding: const EdgeInsets.all(8),
      child: Column(children: [
        _buildActionToolbar(),
        const SizedBox(height: 12),
        _buildMatrixTable(context),
      ]),
    );
  }

  Widget _buildActionToolbar() {
    return Row(children: [
      _toolbarBtn("SYNC ALL FROM FIRST ROW", Icons.sync_rounded, colors.accentPrimary, controller.syncAllFromFirstRow),
      const SizedBox(width: 8),
      _toolbarBtn("GENERATE BARCODES", Icons.qr_code_rounded, colors.accentPrimary, controller.generateAllVariantBarcodes),
      const SizedBox(width: 8),
      _toolbarBtn("APPLY BASE PRICE TO ALL", Icons.payments_outlined, Colors.green, controller.syncBasePriceToAllVariants),
      const SizedBox(width: 8),
      _toolbarBtn("APPLY BASE STOCK TO ALL", Icons.inventory_2_outlined, Colors.blue, controller.syncBaseStockToAllVariants),
    ]);
  }

  Widget _buildMatrixTable(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal, physics: const BouncingScrollPhysics(),
      child: SizedBox(
        width: 1200,
        child: Column(children: [
          _buildHeader(),
          ListView.separated(
            shrinkWrap: true, physics: const NeverScrollableScrollPhysics(),
            itemCount: controller.generatedVariants.length,
            separatorBuilder: (_, __) => Divider(height: 1, color: colors.borderSubtle),
            itemBuilder: (context, i) => VariantMatrixRow(index: i, variant: controller.generatedVariants[i], controller: controller, colors: colors, isActive: controller.activeVariantIndex == i),
          ),
        ]),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      height: 32, padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(color: colors.bgTier3, border: Border.all(color: colors.borderSubtle)),
      child: const Row(children: [
        _H(80, "VARIANT"), _H(100, "SKU"), _H(100, "BARCODE"),
        _HG(320, Colors.blue, ["STOCK", "SAFETY", "REORDER", "WH LOCATION"], [50, 50, 50, 170]),
        _HG(320, Colors.green, ["PURCHASE", "SELLING", "MRP", "WHOLESALE"], [80, 80, 80, 80]),
        _H(44, "DEL"),
      ]),
    );
  }

  Widget _toolbarBtn(String l, IconData i, Color c, VoidCallback onPressed) => InkWell(onTap: onPressed, child: Container(padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6), decoration: BoxDecoration(color: c.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(4), border: Border.all(color: c.withValues(alpha: 0.3))), child: Row(children: [Icon(i, size: 10, color: c), const SizedBox(width: 6), Text(l, style: TextStyle(fontSize: 8, fontWeight: FontWeight.w900, color: c))])));
}

class _H extends StatelessWidget {
  final double w; final String l;
  const _H(this.w, this.l);
  @override Widget build(BuildContext context) => SizedBox(width: w, child: Text(l, textAlign: TextAlign.center, style: const TextStyle(fontSize: 8, fontWeight: FontWeight.w900)));
}

class _HG extends StatelessWidget {
  final double w; final Color c; final List<String> ls; final List<double> ws;
  const _HG(this.w, this.c, this.ls, this.ws);
  @override Widget build(BuildContext context) => SizedBox(width: w, child: Row(children: List.generate(ls.length, (i) => SizedBox(width: ws[i], child: Text(ls[i], textAlign: TextAlign.center, style: TextStyle(fontSize: 8, fontWeight: FontWeight.w900, color: c))))));
}
