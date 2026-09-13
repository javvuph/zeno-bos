import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/core/widgets/zeno_header.dart';
import 'package:zeno/core/widgets/zeno_table.dart';
import 'package:zeno/core/widgets/zeno_badge.dart';
import 'package:zeno/core/di/service_locator.dart';
import '../controllers/product_controller.dart';
import '../../domain/repositories/i_product_repository.dart';

class ProductVariantsScreen extends StatefulWidget {
  final String? productId;
  const ProductVariantsScreen({super.key, this.productId});

  @override
  State<ProductVariantsScreen> createState() => _ProductVariantsScreenState();
}

class _ProductVariantsScreenState extends State<ProductVariantsScreen> {
  final controller = ProductController(sl<IProductRepository>());

  @override
  void initState() {
    super.initState();
    if (widget.productId != null) {
      controller.loadProduct(widget.productId!);
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<ZenoSemanticColors>()!;
    final product = controller.currentProduct;

    return Column(
      children: [
        ZenoHeader(
          title: "Product Variants",
          subtitle:
              "Manage SKU-level variations for '${product?.name ?? 'Loading...'}'.",
          actions: [
            _HeaderBtn(
                label: "Generate Variants",
                icon: Icons.auto_awesome_outlined,
                colors: colors),
            const SizedBox(width: 12),
            _HeaderBtn(
                label: "Add Variant",
                icon: Icons.add,
                isPrimary: true,
                colors: colors),
          ],
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: product == null
                ? const Center(child: CircularProgressIndicator())
                : ZenoTable<dynamic>(
                    items: product.variants,
                    columns: [
                      ZenoTableColumn(
                        label: "Variant SKU",
                        width: 200,
                        builder: (v) => Text(v.sku.value,
                            style: const TextStyle(
                                fontSize: 13, fontFamily: 'monospace')),
                      ),
                      ZenoTableColumn(
                        label: "Attributes",
                        builder: (v) => Text(v.attributes.values.join(', '),
                            style: TextStyle(
                                fontSize: 13, color: colors.textSecondary)),
                      ),
                      ZenoTableColumn(
                        label: "Price",
                        width: 120,
                        isNumeric: true,
                        builder: (v) => Text(
                            "\$${v.priceOverride?.toStringAsFixed(2) ?? product.basePrice.toStringAsFixed(2)}",
                            style: const TextStyle(
                                fontSize: 13, fontWeight: FontWeight.bold)),
                      ),
                      ZenoTableColumn(
                        label: "Status",
                        width: 120,
                        builder: (v) => ZenoBadge(
                          label: "ACTIVE",
                          color: colors.statusSuccess,
                        ),
                      ),
                    ],
                  ),
          ),
        ),
      ],
    );
  }
}

class _HeaderBtn extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool isPrimary;
  final ZenoSemanticColors colors;

  const _HeaderBtn(
      {required this.label,
      required this.icon,
      this.isPrimary = false,
      required this.colors});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {},
      icon: Icon(icon, size: 16),
      label: Text(label),
      style: ElevatedButton.styleFrom(
        backgroundColor: isPrimary ? colors.accentPrimary : colors.bgSurface,
        foregroundColor: isPrimary ? Colors.black : colors.textPrimary,
        side: isPrimary ? null : BorderSide(color: colors.borderSubtle),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
    );
  }
}
