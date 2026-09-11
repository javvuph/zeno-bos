import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:zeno/navigation/navigation_controller.dart';
import 'package:zeno/navigation/toolbar_controller.dart';
import 'package:zeno/navigation/widgets/quick_access_manage_palette.dart';
import 'package:zeno/features/inventory/presentation/controllers/product_studio_controller.dart';
import 'package:zeno/features/inventory/domain/models/product_studio_enums.dart';

class ZenoQuickAccessToolbar extends StatelessWidget {
  const ZenoQuickAccessToolbar({super.key});

  @override
  Widget build(BuildContext context) {
    final nav = NavigationController();

    return CallbackShortcuts(
      bindings: {
        const SingleActivator(LogicalKeyboardKey.f1): () => nav.navigateTo('sales/pos'),
        const SingleActivator(LogicalKeyboardKey.f2): () => nav.navigateTo('procurement/orders'),
        const SingleActivator(LogicalKeyboardKey.f3): () => nav.navigateTo('crm/customers'),
        const SingleActivator(LogicalKeyboardKey.f4): () => nav.navigateTo('inventory/studio'),
        const SingleActivator(LogicalKeyboardKey.space, control: true): () => nav.toggleSidePanel(),
      },
      child: Focus(
        autofocus: true,
        child: ListenableBuilder(
          listenable: ZenoToolbarController(),
          builder: (context, _) {
            final controller = ZenoToolbarController();
            final isCompact = controller.state == ToolbarState.compact;

            return Container(
              height: 56, // h-14 equivalent
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.white,
                border: Border(bottom: BorderSide(color: Color(0xFFE2E8F0))),
              ),
              child: Row(
                children: [
                  const SizedBox(width: 16),
                  // BRAND / LABEL
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.bolt_rounded, size: 16, color: Color(0xFF6366F1)), 
                      const SizedBox(width: 8),
                      const Text(
                        "Quick Actions",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF1E293B),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Container(width: 1, height: 16, color: const Color(0xFFE2E8F0)),
                    ],
                  ),
                  const SizedBox(width: 8),
                  
                  // CONTEXTUAL BUTTONS (SCROLLABLE)
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: ListenableBuilder(
                        listenable: nav,
                        builder: (context, _) => _buildContextualButtons(context, isCompact),
                      ),
                    ),
                  ),
                  
                  // RIGHT ACTIONS: AI & OVERFLOW
                  _AIAssistantButton(onTap: nav.toggleSidePanel),
                  const SizedBox(width: 12),
                  _ToolbarIconBtn(
                    icon: Icons.more_horiz_rounded,
                    onTap: () => _showManagePalette(context),
                  ),
                  const SizedBox(width: 16),
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
      // Global / Default
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

class _ToolbarButton extends StatelessWidget {
  final String label;
  final String? hotkey;
  final IconData icon;
  final Color iconColor;
  final VoidCallback onTap;

  const _ToolbarButton({
    required this.label,
    this.hotkey,
    required this.icon,
    required this.iconColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 4),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(6),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 14, color: iconColor),
              const SizedBox(width: 8),
              Text(
                label,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF1E293B),
                ),
              ),
              if (hotkey != null) ...[
                const SizedBox(width: 8),
                _KbdBadge(text: hotkey!),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _SimpleTextBtn extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  const _SimpleTextBtn({required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onTap,
      style: TextButton.styleFrom(
        foregroundColor: const Color(0xFF64748B),
        padding: const EdgeInsets.symmetric(horizontal: 10),
      ),
      child: Text(label, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w400)),
    );
  }
}

class _AIAssistantButton extends StatelessWidget {
  final VoidCallback onTap;
  const _AIAssistantButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF1F5F9),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFF6366F1).withOpacity(0.1)),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.auto_awesome, size: 14, color: Color(0xFF6366F1)),
              const SizedBox(width: 8),
              const Text(
                "AI Assistant",
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: Color(0xFF475569)),
              ),
              const SizedBox(width: 8),
              const _KbdBadge(text: "Ctrl+Space"),
            ],
          ),
        ),
      ),
    );
  }
}

class _KbdBadge extends StatelessWidget {
  final String text;
  const _KbdBadge({required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: const Color(0xFFF1F5F9),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w500,
          color: Color(0xFF64748B),
        ),
      ),
    );
  }
}

class _ToolbarIconBtn extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onTap;
  const _ToolbarIconBtn({required this.icon, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(6),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Icon(icon, size: 16, color: const Color(0xFF94A3B8)),
      ),
    );
  }
}

class _CompactBadge extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const _CompactBadge({required this.label, required this.icon, required this.color, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: label,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(4),
        child: Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: const Color(0xFFE2E8F0)),
          ),
          child: Icon(icon, size: 14, color: color),
        ),
      ),
    );
  }
}
