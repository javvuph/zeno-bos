import 'package:flutter/material.dart';
import '../../controllers/product_studio_controller.dart';
import '../../../domain/models/product_studio_enums.dart';
import 'aurora_profile_visibility.dart';

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
    final business = controller.activeBusiness.toLowerCase();

    final tabs = <AuroraTabDefinition>[
      const AuroraTabDefinition(
        id: AuroraStudioTab.identity,
        label: 'Identity',
        icon: Icons.badge_outlined,
      ),
    ];

    if (_isFashion(business, profile)) {
      tabs.add(
        const AuroraTabDefinition(
          id: AuroraStudioTab.planogram,
          label: 'Specifications',
          icon: Icons.checkroom_outlined,
        ),
      );
    } else if (_isFood(business, profile)) {
      tabs.add(
        const AuroraTabDefinition(
          id: AuroraStudioTab.planogram,
          label: 'Kitchen & Recipe',
          icon: Icons.restaurant_menu_outlined,
        ),
      );
    } else {
      tabs.add(
        const AuroraTabDefinition(
          id: AuroraStudioTab.planogram,
          label: 'Operations',
          icon: Icons.account_tree_outlined,
        ),
      );
    }

    // Only add tabs that have visible content for the active profile.
    final candidateTabs = <AuroraTabDefinition>[
      const AuroraTabDefinition(
        id: AuroraStudioTab.logistics,
        label: 'Logistics',
        icon: Icons.inventory_2_outlined,
      ),
      const AuroraTabDefinition(
        id: AuroraStudioTab.pricing,
        label: 'Pricing',
        icon: Icons.payments_outlined,
      ),
      const AuroraTabDefinition(
        id: AuroraStudioTab.stock,
        label: 'Stock',
        icon: Icons.bar_chart_outlined,
      ),
      const AuroraTabDefinition(
        id: AuroraStudioTab.vendors,
        label: 'Suppliers',
        icon: Icons.local_shipping_outlined,
      ),
      const AuroraTabDefinition(
        id: AuroraStudioTab.tax,
        label: 'Tax',
        icon: Icons.receipt_long_outlined,
      ),
      const AuroraTabDefinition(
        id: AuroraStudioTab.media,
        label: 'Media',
        icon: Icons.image_outlined,
      ),
    ];

    for (var t in candidateTabs) {
      if (hasAuroraContentForTab(controller, t.id)) {
        tabs.add(t);
      }
    }

    return tabs;
  }

  static bool _isFashion(String business, String profile) {
    return business.contains('fashion') ||
        business.contains('apparel') ||
        [
          'clothing',
          'shoes',
          'footwear',
          'jewelry',
          'watch store',
          'eyewear / opticals',
          'cosmetics',
          'perfume',
          'boutique',
          'bridal wear',
          'bags & luggage',
          'accessories',
          'innerwear',
          'kids fashion',
          'sportswear',
        ].contains(profile);
  }

  static bool _isFood(String business, String profile) {
    return business.contains('food') ||
        business.contains('beverage') ||
        [
          'restaurant',
          'fine dining',
          'cafe',
          'coffee shop',
          'bakery',
          'juice shop',
          'fast food',
          'cloud kitchen',
          'ice cream parlor',
          'catering service',
          'bar / pub',
          'bistro',
          'food court',
        ].contains(profile);
  }
}