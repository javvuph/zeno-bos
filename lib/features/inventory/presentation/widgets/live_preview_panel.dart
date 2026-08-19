import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/features/inventory/domain/models/product_studio_models.dart';
import 'package:zeno/features/inventory/presentation/controllers/product_studio_controller.dart';
import 'preview/widgets/preview_identity.dart';
import 'preview/widgets/preview_variants.dart';
import 'preview/widgets/preview_stats.dart';

class LivePreviewPanel extends StatelessWidget {
  final ProductStudioController controller;
  final ZenoSemanticColors colors;
  const LivePreviewPanel({super.key, required this.controller, required this.colors});

  @override
  Widget build(BuildContext context) {
    final product = controller.product;
    double displayPrice = product.sellingPrice; double displayCost = product.costPrice;
    int displayStock = product.openingStock.toInt(); String displaySku = product.sku.isEmpty ? "NO SKU" : product.sku;
    String displayBarcode = product.barcode.isEmpty ? "0000000000" : product.barcode;

    if (controller.activeVariantIndex != null && controller.activeVariantIndex! < controller.generatedVariants.length) {
      final variant = controller.generatedVariants[controller.activeVariantIndex!];
      displayPrice = variant.price; displayCost = variant.purchasePrice > 0 ? variant.purchasePrice : displayCost;
      displayStock = variant.stock; displaySku = variant.sku.isEmpty ? displaySku : variant.sku;
      displayBarcode = variant.barcode.isEmpty ? displayBarcode : variant.barcode;
    }

    double marginPct = displayPrice > 0 ? ((displayPrice - displayCost) / displayPrice) * 100 : 0;
    String? displayImageUrl = _getDisplayImage(product);

    return Container(
      decoration: BoxDecoration(color: colors.bgTier2, borderRadius: BorderRadius.circular(14), border: Border.all(color: colors.borderSubtle)),
      child: Column(children: [
        Expanded(child: Padding(padding: const EdgeInsets.all(10), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          buildImagePreview(displayImageUrl, colors),
          const SizedBox(height: 8),
          buildProductHeader(product.title.isEmpty ? 'New Product' : product.title, displaySku, product.description, colors),
          if (controller.selectedColors.isNotEmpty || controller.selectedSizes.isNotEmpty) buildVariantSelectors(controller, colors),
          buildStatsArea(displayPrice, displayStock, marginPct, product.taxCode, product.unit, colors),
          const Spacer(),
          buildBarcodeArea(displayBarcode, colors),
        ]))),
        _buildFooter(colors),
      ]),
    );
  }

  String? _getDisplayImage(ProductStudioData product) {
    if (controller.activeVariantIndex != null) {
      final v = controller.generatedVariants[controller.activeVariantIndex!];
      if (v.mediaMode == MediaMode.overridden && v.customMedia != null && v.customMedia!.isNotEmpty) return v.customMedia!.first.url;
      final colorMedia = product.colorMediaLibrary[v.color];
      if (colorMedia != null && colorMedia.isNotEmpty) return colorMedia.first.url;
    } else if (controller.activeMediaColor != null) {
      final colorMedia = product.colorMediaLibrary[controller.activeMediaColor!];
      if (colorMedia != null && colorMedia.isNotEmpty) return colorMedia.first.url;
    }
    return product.primaryImageUrl;
  }

  Widget _buildFooter(ZenoSemanticColors colors) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(color: colors.bgTier4, borderRadius: const BorderRadius.vertical(bottom: Radius.circular(14))),
      child: Row(children: [
        Icon(Icons.auto_awesome, size: 12, color: colors.accentPrimary),
        const SizedBox(width: 8),
        Expanded(child: Row(children: [
          _insightChip("HIGH DEMAND", Colors.purple, colors), const SizedBox(width: 6),
          _insightChip("GOOD MARGIN", Colors.green, colors),
        ])),
      ]),
    );
  }

  Widget _insightChip(String label, Color color, ZenoSemanticColors colors) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
      decoration: BoxDecoration(color: color.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(4), border: Border.all(color: color.withValues(alpha: 0.2))),
      child: Text(label, style: TextStyle(fontSize: 7, fontWeight: FontWeight.w900, color: color)),
    );
  }
}
