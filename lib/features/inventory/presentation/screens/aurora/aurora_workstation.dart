import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';

import 'package:zeno/features/inventory/presentation/controllers/product_studio_controller.dart';
import '../../../domain/models/product_studio_enums.dart';
import '../widgets/studio_navigation.dart';
import 'aurora_tab_composer.dart';

import 'tabs/tab1_identity.dart';
import 'tabs/tab2_specs.dart';
import 'tabs/tab2_engine.dart';
import 'tabs/tab3_price_tax.dart';
import 'tabs/tab4_stock_supply.dart';
import 'tabs/tab8_channels.dart';

class AuroraWorkstation extends StatelessWidget {
  final ProductStudioController controller;
  final ZenoSemanticColors colors;

  const AuroraWorkstation({
    super.key,
    required this.controller,
    required this.colors,
  });

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
    final tabs = AuroraTabComposer.compose(controller);

    return Container(
      height: 44,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(color: colors.borderSubtle),
        ),
      ),
      child: Row(
        children: tabs.map((tab) {
          final isActive = controller.activeTab == tab.id;

          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: _PillTab(
              label: tab.label,
              icon: tab.icon,
              isActive: isActive,
              onTap: () => controller.setTab(tab.id),
              colors: colors,
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildActiveTab() {
    switch (controller.activeTab) {
      case AuroraStudioTab.identity:
        return Tab1Identity(controller: controller);
      case AuroraStudioTab.planogram:
        return Tab2Specs(controller: controller);
      case AuroraStudioTab.logistics:
        return Tab2Engine(controller: controller);
      case AuroraStudioTab.pricing:
        return Tab3PriceTax(controller: controller);
      case AuroraStudioTab.stock:
        return Tab4StockSupply(controller: controller);
      case AuroraStudioTab.media:
        return Tab8Channels(controller: controller);
      default:
        return Tab1Identity(controller: controller);
    }
  }
}

class _PillTab extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool isActive;
  final VoidCallback onTap;
  final ZenoSemanticColors colors;

  const _PillTab({
    required this.label,
    required this.icon,
    required this.isActive,
    required this.onTap,
    required this.colors,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 10,
        ),
        decoration: BoxDecoration(
          color: isActive
              ? colors.accentPrimary
              : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
          boxShadow: isActive
              ? [
            BoxShadow(
              color: colors.accentPrimary.withValues(alpha: 0.25),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ]
              : null,
        ),
        child: Row(
          children: [
            Icon(
              icon,
              size: 18,
              color: isActive
                  ? Colors.white
                  : colors.textDisabled,
            ),
            const SizedBox(width: 10),
            Text(
              label,
              style: TextStyle(
                fontSize: 14,
                fontWeight: isActive
                    ? FontWeight.w600
                    : FontWeight.w500,
                color: isActive
                    ? Colors.white
                    : colors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}