import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import '../../controllers/product_studio_controller.dart';
import '../../../domain/models/product_studio_enums.dart';
import '../widgets/studio_navigation.dart';
import 'tabs/tab1_identity.dart';
import 'tabs/tab2_planogram.dart';
import 'tabs/tab3_logistics.dart';
import 'tabs/tab4_pricing.dart';
import 'tabs/tab5_stock.dart';
import 'tabs/tab6_vendors.dart';
import 'tabs/tab7_tax.dart';
import 'tabs/tab8_media.dart';

class AuroraWorkstation extends StatelessWidget {
  final ProductStudioController controller;
  final ZenoSemanticColors colors;
  const AuroraWorkstation({super.key, required this.controller, required this.colors});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: colors.bgTier1,
      child: Column(
        children: [
          _buildPillNavigation(),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(24, 20, 24, 0),
              child: _buildActiveTab(),
            ),
          ),
          buildStickyFooter(controller, colors),
        ],
      ),
    );
  }

  Widget _buildPillNavigation() {
    final tabs = [
      {'id': AuroraStudioTab.identity, 'label': 'Identity', 'icon': Icons.badge_outlined},
      {'id': AuroraStudioTab.planogram, 'label': 'Planogram', 'icon': Icons.location_on_outlined},
      {'id': AuroraStudioTab.logistics, 'label': 'Logistics', 'icon': Icons.inventory_2_outlined},
      {'id': AuroraStudioTab.pricing, 'label': 'Pricing', 'icon': Icons.payments_outlined},
      {'id': AuroraStudioTab.stock, 'label': 'Stock', 'icon': Icons.bar_chart_outlined},
      {'id': AuroraStudioTab.vendors, 'label': 'Vendors', 'icon': Icons.local_shipping_outlined},
      {'id': AuroraStudioTab.tax, 'label': 'Tax', 'icon': Icons.receipt_long_outlined},
      {'id': AuroraStudioTab.media, 'label': 'Media', 'icon': Icons.image_outlined},
    ];

    return Container(
      height: 44, // Optimized for 44px top bar context
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: colors.borderSubtle)),
      ),
      child: Row(
        children: tabs.map((tab) {
          final id = tab['id'] as AuroraStudioTab;
          final isActive = controller.activeTab == id;
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: _PillTab(
              label: tab['label'] as String,
              icon: tab['icon'] as IconData,
              isActive: isActive,
              onTap: () => controller.setTab(id),
              colors: colors,
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildActiveTab() {
    switch (controller.activeTab) {
      case AuroraStudioTab.identity: return Tab1Identity(controller: controller);
      case AuroraStudioTab.planogram: return Tab2Planogram(controller: controller);
      case AuroraStudioTab.logistics: return Tab3Logistics(controller: controller);
      case AuroraStudioTab.pricing: return Tab4Pricing(controller: controller);
      case AuroraStudioTab.stock: return Tab5Stock(controller: controller);
      case AuroraStudioTab.vendors: return Tab6Vendors(controller: controller);
      case AuroraStudioTab.tax: return Tab7Tax(controller: controller);
      case AuroraStudioTab.media: return Tab8Media(controller: controller);
    }
  }
}

class _PillTab extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool isActive;
  final VoidCallback onTap;
  final ZenoSemanticColors colors;

  const _PillTab({required this.label, required this.icon, required this.isActive, required this.onTap, required this.colors});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: isActive ? colors.accentPrimary : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
          boxShadow: isActive ? [BoxShadow(color: colors.accentPrimary.withValues(alpha: 0.25), blurRadius: 10, offset: const Offset(0, 4))] : null,
        ),
        child: Row(
          children: [
            Icon(icon, size: 18, color: isActive ? Colors.white : colors.textDisabled),
            const SizedBox(width: 10),
            Text(
              label,
              style: TextStyle(
                fontSize: 14,
                fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
                color: isActive ? Colors.white : colors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
