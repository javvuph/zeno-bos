import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import '../../controllers/product_studio_controller.dart';
import 'widgets/retail_cards.dart';
import 'widgets/retail_grids.dart';

Widget buildAdvancedRetailLayout({
  required ProductStudioController controller,
  required ZenoSemanticColors colors,
  required Widget Function(ZenoSemanticColors) buildStickyFooter,
}) {
  const sapphireAccent = Color(0xFF2563EB);

  return Container(
    color: colors.bgTier1,
    child: Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                GridView.count(
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  childAspectRatio: 1.2,
                  children: [
                    RetailVisualCard(
                      index: 1, title: "Product Identity", icon: Icons.fingerprint_rounded, accentColor: sapphireAccent, colors: colors,
                      child: buildRetailIdentityGrid(controller, colors),
                    ),
                    RetailVisualCard(
                      index: 2, title: "Packaging & UOM Matrix", icon: Icons.inventory_2_rounded, accentColor: sapphireAccent, colors: colors,
                      child: buildRetailPackagingGrid(controller, colors),
                    ),
                    RetailVisualCard(
                      index: 3, title: "Taxation & Compliance", icon: Icons.gavel_rounded, accentColor: sapphireAccent, colors: colors,
                      child: buildRetailTaxGrid(controller, colors),
                    ),
                    RetailVisualCard(
                      index: 4, title: "Pricing & Omnichannel", icon: Icons.payments_rounded, accentColor: sapphireAccent, colors: colors,
                      child: buildRetailPricingGrid(controller, colors),
                    ),
                    RetailVisualCard(
                      index: 5, title: "Batch & Lifecycle Control", icon: Icons.hourglass_bottom_rounded, accentColor: sapphireAccent, colors: colors,
                      child: buildRetailLifecycleGrid(controller, colors),
                    ),
                    RetailVisualCard(
                      index: 6, title: "Marketing & SEO Visibility", icon: Icons.campaign_rounded, accentColor: sapphireAccent, colors: colors,
                      child: buildRetailMarketingGrid(controller, colors),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                SupplierMatrixRetailCard(controller: controller, colors: colors),
              ],
            ),
          ),
        ),
        buildStickyFooter(colors),
      ],
    ),
  );
}
