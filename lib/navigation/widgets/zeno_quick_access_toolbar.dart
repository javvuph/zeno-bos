import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:zeno/navigation/navigation_controller.dart';
import 'package:zeno/navigation/toolbar_controller.dart';
import 'package:zeno/navigation/widgets/quick_access_manage_palette.dart';
import 'package:zeno/features/inventory/presentation/controllers/product_studio_controller.dart';
import 'package:zeno/features/inventory/domain/models/product_studio_enums.dart';

part 'parts/zeno_quick_access_buttons.part.dart';

class ZenoQuickAccessToolbar extends StatelessWidget {
  const ZenoQuickAccessToolbar({super.key});

  @override
  Widget build(BuildContext context) {
    final nav = NavigationController();
    final isPosActive = nav.currentRoute.contains('sales/pos') ||
        nav.currentRoute.contains('billing') ||
        nav.currentRoute.contains('sales/new');

    final bindings = <ShortcutActivator, VoidCallback>{
      const SingleActivator(LogicalKeyboardKey.space, control: true): () => nav.toggleSidePanel(),
    };

    if (!isPosActive) {
      bindings[const SingleActivator(LogicalKeyboardKey.f1)] = () => nav.navigateTo('sales/pos');
      bindings[const SingleActivator(LogicalKeyboardKey.f2)] = () => nav.navigateTo('procurement/orders');
      bindings[const SingleActivator(LogicalKeyboardKey.f3)] = () => nav.navigateTo('crm/customers');
      bindings[const SingleActivator(LogicalKeyboardKey.f4)] = () => nav.navigateTo('inventory/studio');
    }

    return CallbackShortcuts(
      bindings: bindings,
      child: Focus(
        autofocus: true,
        child: ListenableBuilder(
          listenable: ZenoToolbarController(),
          builder: (context, _) {
            final controller = ZenoToolbarController();
            final isCompact = controller.state == ToolbarState.compact;

            return Container(
              height: 34,
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.white,
                border: Border(bottom: BorderSide(color: Color(0xFFE2E8F0))),
              ),
              child: Row(
                children: [
                  const SizedBox(width: 14),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.bolt_rounded, size: 15, color: Color(0xFF6366F1)),
                      const SizedBox(width: 7),
                      const Text(
                        "Quick Actions",
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF1E293B),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Container(width: 1, height: 14, color: const Color(0xFFE2E8F0)),
                    ],
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: ListenableBuilder(
                        listenable: nav,
                        builder: (context, _) => _buildContextualButtons(context, isCompact),
                      ),
                    ),
                  ),
                  _AIAssistantButton(onTap: nav.toggleSidePanel),
                  const SizedBox(width: 8),
                  _ToolbarIconBtn(
                    icon: Icons.more_horiz_rounded,
                    onTap: () => _showManagePalette(context),
                  ),
                  const SizedBox(width: 12),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  void _showManagePalette(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => const QuickAccessManagePalette(),
    );
  }

  Widget _buildContextualButtons(BuildContext context, bool isCompact) {
    final nav = NavigationController();
    final route = nav.currentRoute;

    List<_ToolbarButton> buttons = [];

    if (route.contains('inventory/studio')) {
      buttons = [
        _ToolbarButton(label: "Save Draft", icon: Icons.save_outlined, iconColor: Colors.blue, onTap: () => ProductStudioController().saveProduct()),
        _ToolbarButton(label: "Variant Actions", icon: Icons.layers_outlined, iconColor: Colors.orange, onTap: () {}),
        _ToolbarButton(label: "Import CSV", icon: Icons.upload_file_outlined, iconColor: Colors.green, onTap: () => ProductStudioController().setCreationMode(ProductCreationMode.import)),
        _ToolbarButton(label: "Bulk Price", icon: Icons.sell_outlined, iconColor: Colors.purple, onTap: () {}),
      ];
    } else if (route.contains('sales/pos') || route.contains('billing/sales/pos')) {
      buttons = [
        _ToolbarButton(label: "New Sale", hotkey: "F1", icon: Icons.add_shopping_cart_rounded, iconColor: const Color(0xFF34D399), onTap: () => nav.navigateTo('sales/pos')),
        _ToolbarButton(label: "Add Customer", icon: Icons.person_add_outlined, iconColor: const Color(0xFF38BDF8), onTap: () => nav.navigateTo('crm/customers')),
        _ToolbarButton(label: "Hold Bill", icon: Icons.pause_circle_outline_rounded, iconColor: const Color(0xFFFBBF24), onTap: () {}),
        _ToolbarButton(label: "Quick Pay", icon: Icons.payments_outlined, iconColor: const Color(0xFF34D399), onTap: () {}),
      ];
    } else if (route.contains('inventory')) {
      buttons = [
        _ToolbarButton(label: "Stock In", icon: Icons.login_rounded, iconColor: const Color(0xFF2DD4BF), onTap: () => nav.navigateTo('inventory/transfers')),
        _ToolbarButton(label: "Stock Out", icon: Icons.logout_rounded, iconColor: const Color(0xFFFB7185), onTap: () => nav.navigateTo('inventory/transfers')),
        _ToolbarButton(label: "Add Product", hotkey: "F4", icon: Icons.add_box_outlined, iconColor: const Color(0xFF818CF8), onTap: () => nav.navigateTo('inventory/studio')),
        _ToolbarButton(label: "Stock Count", icon: Icons.inventory_rounded, iconColor: const Color(0xFF6366F1), onTap: () => nav.navigateTo('inventory/stock-count')),
      ];
    } else {
      buttons = [
        _ToolbarButton(label: "New Sale", hotkey: "F1", icon: Icons.shopping_cart_outlined, iconColor: const Color(0xFF34D399), onTap: () => nav.navigateTo('sales/pos')),
        _ToolbarButton(label: "New Purchase", hotkey: "F2", icon: Icons.shopping_bag_outlined, iconColor: const Color(0xFFFBBF24), onTap: () => nav.navigateTo('procurement/orders')),
        _ToolbarButton(label: "Add Customer", hotkey: "F3", icon: Icons.person_add_outlined, iconColor: const Color(0xFF38BDF8), onTap: () => nav.navigateTo('crm/customers')),
        _ToolbarButton(label: "Add Product", hotkey: "F4", icon: Icons.inventory_2_outlined, iconColor: const Color(0xFF818CF8), onTap: () => nav.navigateTo('inventory/studio')),
      ];
    }

    return Row(
      children: [
        ...buttons.map((btn) {
          if (isCompact) {
            return Padding(
              padding: const EdgeInsets.only(right: 4),
              child: _CompactBadge(label: btn.label, icon: btn.icon, color: btn.iconColor, onTap: btn.onTap),
            );
          }
          return btn;
        }),
        if (!isCompact && (route == 'dashboard' || route == 'home')) ...[
          const SizedBox(width: 8),
          Container(width: 1, height: 16, color: const Color(0xFFE2E8F0)),
          const SizedBox(width: 8),
          _SimpleTextBtn(label: "Stock In", onTap: () => nav.navigateTo('inventory/transfers')),
          _SimpleTextBtn(label: "Stock Out", onTap: () => nav.navigateTo('inventory/transfers')),
        ],
      ],
    );
  }
}
