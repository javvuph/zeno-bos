import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import '../../controllers/product_studio_controller.dart';
import '../../../domain/models/product_studio_enums.dart';

class ProductStudioTabs extends StatelessWidget {
  final ProductStudioController controller;
  final String? profileTitle;

  const ProductStudioTabs({super.key, required this.controller, this.profileTitle});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<ZenoSemanticColors>()!;
    
    final sections = !controller.isAdvancedMode
        ? [
            {'id': ProductStudioSection.fashionBasic, 'label': 'Basic Info', 'icon': Icons.info_outline_rounded},
            {'id': ProductStudioSection.variants, 'label': 'Variants', 'icon': Icons.style_outlined},
          ]
        : [
            {'id': ProductStudioSection.basic, 'label': 'Basic Info', 'icon': Icons.info_outline_rounded},
            {'id': ProductStudioSection.retailPackaging, 'label': profileTitle ?? 'Specs', 'icon': Icons.layers_outlined},
            {'id': ProductStudioSection.fashionBasic, 'label': 'Basic Info', 'icon': Icons.info_outline_rounded},
            {'id': ProductStudioSection.fashionSpecs, 'label': profileTitle ?? 'Specs', 'icon': Icons.layers_outlined},
            {'id': ProductStudioSection.fnbDish, 'label': 'Dish Identity', 'icon': Icons.restaurant_menu_outlined},
            {'id': ProductStudioSection.fnbKitchen, 'label': 'Kitchen & Recipe', 'icon': Icons.outdoor_grill_outlined},
            {'id': ProductStudioSection.healthcareBasic, 'label': 'Basic Info', 'icon': Icons.medical_services_outlined},
            {'id': ProductStudioSection.healthcareClinical, 'label': 'Clinical', 'icon': Icons.vaccines_outlined},
            {'id': ProductStudioSection.wholesaleBasic, 'label': 'Basic Info', 'icon': Icons.business_outlined},
            {'id': ProductStudioSection.wholesaleB2B, 'label': 'B2B', 'icon': Icons.warehouse_outlined},
            {'id': ProductStudioSection.serviceBasic, 'label': 'Service Info', 'icon': Icons.handyman_outlined},
            {'id': ProductStudioSection.serviceExecution, 'label': 'Execution', 'icon': Icons.settings_suggest_outlined},
            {'id': ProductStudioSection.variants, 'label': 'Variants', 'icon': Icons.style_outlined},
            {'id': ProductStudioSection.inventoryPrice, 'label': 'Stock & Price', 'icon': Icons.payments_outlined},
            {'id': ProductStudioSection.retailWms, 'label': 'WMS', 'icon': Icons.precision_manufacturing_outlined},
            {'id': ProductStudioSection.retailPromotions, 'label': 'Promos', 'icon': Icons.campaign_outlined},
            {'id': ProductStudioSection.retailProcurement, 'label': 'Supply', 'icon': Icons.local_shipping_outlined},
            {'id': ProductStudioSection.retailReplenishment, 'label': 'Stock Plan', 'icon': Icons.autorenew_outlined},
            {'id': ProductStudioSection.retailOmnichannel, 'label': 'Web/App', 'icon': Icons.devices_outlined},
            {'id': ProductStudioSection.retailMerchandising, 'label': 'Shelf', 'icon': Icons.grid_view_rounded},
            {'id': ProductStudioSection.retailPricingEnterprise, 'label': 'Schedules', 'icon': Icons.schedule_send_outlined},
            {'id': ProductStudioSection.retailStoreOverrides, 'label': 'Overrides', 'icon': Icons.edit_location_alt_outlined},
            {'id': ProductStudioSection.retailColdChain, 'label': 'Cold Chain', 'icon': Icons.ac_unit_rounded},
            {'id': ProductStudioSection.retailTraceability, 'label': 'History', 'icon': Icons.history_edu_outlined},
            {'id': ProductStudioSection.packaging, 'label': 'UOM', 'icon': Icons.inventory_2_outlined},
            {'id': ProductStudioSection.suppliers, 'label': 'Vendors', 'icon': Icons.group_outlined},
            {'id': ProductStudioSection.tax, 'label': 'Tax', 'icon': Icons.receipt_long_outlined},
            {'id': ProductStudioSection.media, 'label': 'Media & SEO', 'icon': Icons.image_outlined},
            {'id': ProductStudioSection.batch, 'label': 'Batch', 'icon': Icons.view_comfortable_outlined},
            {'id': ProductStudioSection.expiry, 'label': 'Expiry', 'icon': Icons.timer_off_outlined},
            {'id': ProductStudioSection.marketing, 'label': 'SEO', 'icon': Icons.auto_graph_outlined},
            {'id': ProductStudioSection.advanced, 'label': 'Advanced', 'icon': Icons.tune_rounded},
          ];

    final visibleSections = sections.where((s) => controller.isSectionVisible(s['id'] as ProductStudioSection)).toList();

    return Container(
      height: 38,
      padding: const EdgeInsets.only(left: 12, right: 12),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: Color(0xFFE2E8F0), width: 1)),
      ),
      alignment: Alignment.centerLeft,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: visibleSections.map((s) {
            final id = s['id'] as ProductStudioSection;
            final isActive = controller.activeSection == id;
            return Padding(
              padding: const EdgeInsets.only(right: 8),
              child: _TabPill(
                label: s['label'] as String,
                icon: s['icon'] as IconData,
                isActive: isActive,
                onTap: () => controller.setSection(id),
                colors: colors,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}

class _TabPill extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool isActive;
  final VoidCallback onTap;
  final ZenoSemanticColors colors;

  const _TabPill({required this.label, required this.icon, required this.isActive, required this.onTap, required this.colors});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        height: 30,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(
          color: isActive ? const Color(0xFFEEF2FF) : Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isActive ? const Color(0xFF6366F1) : const Color(0xFFE2E8F0),
            width: isActive ? 1.5 : 1,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 13,
              color: isActive ? const Color(0xFF6366F1) : const Color(0xFF64748B),
            ),
            const SizedBox(width: 6),
            Text(
              label,
              style: TextStyle(
                fontSize: 11,
                fontWeight: isActive ? FontWeight.w800 : FontWeight.w600,
                color: isActive ? const Color(0xFF4338CA) : const Color(0xFF334155),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
