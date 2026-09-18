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

  static const Color kPurplePrimary = Color(0xFF667EEA);
  static const Color kPurpleSecondary = Color(0xFF764BA2);

  const AuroraWorkstation({
    super.key,
    required this.controller,
    required this.colors,
  });

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: controller,
      builder: (context, _) {
        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                colors.bgTier1,
                colors.bgTier2.withValues(alpha: 0.55),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Column(
            children: [
              _buildModernNavigation(),
              Expanded(
                child: _buildActiveTab(),
              ),
              buildStickyFooter(controller, colors),
            ],
          ),
        );
      },
    );
  }

  Widget _buildModernNavigation() {
    final tabs = AuroraTabComposer.compose(controller);

    return Container(
      height: 40,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      decoration: BoxDecoration(
        color: colors.bgSurface.withValues(alpha: 0.78),
        border: Border(bottom: BorderSide(color: colors.borderSubtle)),
      ),
      child: Row(
        children: tabs.asMap().entries.map((entry) {
          final index = entry.key;
          final tab = entry.value;
          final isActive = controller.activeTab == tab.id;

          return Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _ModernTab(
                label: tab.label,
                icon: tab.icon,
                isActive: isActive,
                onTap: () => controller.setTab(tab.id),
              ),
              if (index < tabs.length - 1)
                Container(
                  width: 1,
                  height: 20,
                  color: colors.borderSubtle,
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                ),
            ],
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

class _ModernTab extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool isActive;
  final VoidCallback onTap;

  const _ModernTab({
    required this.label,
    required this.icon,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final semantic = Theme.of(context).extension<ZenoSemanticColors>();
    final activeColor = semantic?.accentPrimary ?? const Color(0xFF6366F1);
    final inactiveColor = semantic?.textSecondary ?? const Color(0xFF64748B);

    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 6),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                size: 14,
                color: isActive ? activeColor : inactiveColor,
              ),
              const SizedBox(width: 6),
              Text(
                label,
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: isActive ? activeColor : inactiveColor,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            height: 3,
            width: label.length * 7.0 + 20, 
            decoration: BoxDecoration(
              gradient: isActive
                  ? LinearGradient(
                      colors: [
                        activeColor,
                        semantic?.accentPurple ?? const Color(0xFF7C3AED),
                      ],
                    )
                  : null,
              color: isActive ? null : Colors.transparent,
              borderRadius: const BorderRadius.vertical(top: Radius.circular(2)),
            ),
          ),
        ],
      ),
    );
  }
}
