import 'package:flutter/material.dart';
import 'package:zeno/features/inventory/presentation/controllers/product_studio_controller.dart';
import '../../../domain/models/product_studio_enums.dart';

class AuroraTabDefinition {
  final AuroraStudioTab id;
  final String label;
  final IconData icon;

  const AuroraTabDefinition({
    required this.id,
    required this.label,
    required this.icon,
  });
}

class AuroraTabComposer {
  static List<AuroraTabDefinition> compose(
    ProductStudioController controller,
  ) {
    final profile = controller.activeProfile.toLowerCase();
    final bType = controller.product.businessType.toUpperCase();
    final scale = controller.product.businessScale;
    final isClothingSmall = profile == "clothing" && bType == "FASHION" && scale == BusinessScale.small;

    if (isClothingSmall) {
      return const [
        AuroraTabDefinition(
          id: AuroraStudioTab.identity,
          label: 'BASIC INFO',
          icon: Icons.badge_outlined,
        ),
        AuroraTabDefinition(
          id: AuroraStudioTab.planogram,
          label: 'SPECS',
          icon: Icons.settings_suggest_outlined,
        ),
        AuroraTabDefinition(
          id: AuroraStudioTab.logistics,
          label: 'VARIANTS',
          icon: Icons.layers_outlined,
        ),
        AuroraTabDefinition(
          id: AuroraStudioTab.pricing,
          label: 'STOCK & PRICE',
          icon: Icons.payments_outlined,
        ),
        AuroraTabDefinition(
          id: AuroraStudioTab.media,
          label: 'MEDIA & SEO',
          icon: Icons.image_outlined,
        ),
      ];
    }

    final isGroceryKirana = profile.contains("grocery") || profile.contains("kirana");

    if (isGroceryKirana) {
      return const [
        AuroraTabDefinition(
          id: AuroraStudioTab.identity,
          label: 'BASIC INFO',
          icon: Icons.badge_outlined,
        ),
        AuroraTabDefinition(
          id: AuroraStudioTab.planogram,
          label: 'DEPARTMENT',
          icon: Icons.account_tree_outlined,
        ),
        AuroraTabDefinition(
          id: AuroraStudioTab.logistics,
          label: 'PACK & SIZE',
          icon: Icons.inventory_2_outlined,
        ),
        AuroraTabDefinition(
          id: AuroraStudioTab.pricing,
          label: 'PRICE & TAX',
          icon: Icons.payments_outlined,
        ),
        AuroraTabDefinition(
          id: AuroraStudioTab.stock,
          label: 'STOCK & SUPPLIER',
          icon: Icons.warehouse_outlined,
        ),
        AuroraTabDefinition(
          id: AuroraStudioTab.media,
          label: 'PHOTOS & ONLINE',
          icon: Icons.image_outlined,
        ),
      ];
    }

    // Default 8-tab for other profiles
    return const [
      AuroraTabDefinition(
        id: AuroraStudioTab.identity,
        label: 'IDENTITY',
        icon: Icons.badge_outlined,
      ),
      AuroraTabDefinition(
        id: AuroraStudioTab.planogram,
        label: 'SPECS',
        icon: Icons.settings_suggest_outlined,
      ),
      AuroraTabDefinition(
        id: AuroraStudioTab.logistics,
        label: 'LOGISTICS',
        icon: Icons.inventory_2_outlined,
      ),
      AuroraTabDefinition(
        id: AuroraStudioTab.pricing,
        label: 'COMMERCIAL',
        icon: Icons.payments_outlined,
      ),
      AuroraTabDefinition(
        id: AuroraStudioTab.stock,
        label: 'STOCK',
        icon: Icons.bar_chart_outlined,
      ),
      AuroraTabDefinition(
        id: AuroraStudioTab.vendors,
        label: 'SUPPLIERS',
        icon: Icons.local_shipping_outlined,
      ),
      AuroraTabDefinition(
        id: AuroraStudioTab.tax,
        label: 'COMPLIANCE',
        icon: Icons.receipt_long_outlined,
      ),
      AuroraTabDefinition(
        id: AuroraStudioTab.media,
        label: 'CHANNELS',
        icon: Icons.image_outlined,
      ),
    ];
  }
}
