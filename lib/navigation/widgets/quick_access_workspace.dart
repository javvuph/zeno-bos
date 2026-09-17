import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/navigation/quick_access_controller.dart';
import 'package:zeno/navigation/navigation_controller.dart';
import 'package:zeno/navigation/widgets/quick_access_item_widget.dart';
import 'package:zeno/navigation/widgets/quick_access_manage_palette.dart';

part 'parts/quick_access_pills.part.dart';

class QuickAccessWorkspace extends StatelessWidget {
  const QuickAccessWorkspace({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<ZenoSemanticColors>()!;
    final nav = NavigationController();

    return CallbackShortcuts(
      bindings: {
        const SingleActivator(LogicalKeyboardKey.f1): () =>
            nav.navigateTo('billing/sales/pos'),
        const SingleActivator(LogicalKeyboardKey.f2): () =>
            nav.navigateTo('suppliers/procurement/orders'),
        const SingleActivator(LogicalKeyboardKey.f3): () =>
            nav.navigateTo('customers/mgmt/add'),
        const SingleActivator(LogicalKeyboardKey.f4): () =>
            nav.navigateTo('inventory/studio'),
      },
      child: Focus(
        autofocus: true,
        child: Container(
          height: 32,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: colors.bgTier3,
            border: Border(bottom: BorderSide(color: colors.borderSubtle)),
          ),
          child: Row(
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: colors.amberGold.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                      color: colors.amberGold.withValues(alpha: 0.4)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.bolt_rounded, size: 14, color: colors.amberGold),
                    const SizedBox(width: 4),
                    Text(
                      "ACTIONS",
                      style: TextStyle(
                        fontSize: 10,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w900,
                        color: colors.amberGold,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              _VerticalDivider(colors: colors),
              const SizedBox(width: 4),

              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Row(
                    children: [
                      _TactileActionPill(
                        label: "New Sale",
                        hotkey: "F1",
                        icon: Icons.description_outlined,
                        iconColor: const Color(0xFF3B82F6),
                        onTap: () => nav.navigateTo('billing/sales/pos'),
                      ),
                      _TactileActionPill(
                        label: "New Purchase",
                        hotkey: "F2",
                        icon: Icons.inventory_2_outlined,
                        iconColor: colors.amberGold,
                        onTap: () =>
                            nav.navigateTo('suppliers/procurement/orders'),
                      ),
                      _TactileActionPill(
                        label: "Add Customer",
                        hotkey: "F3",
                        icon: Icons.person_add_outlined,
                        iconColor: colors.statusSuccess,
                        onTap: () => nav.navigateTo('customers/mgmt/add'),
                      ),
                      _TactileActionPill(
                        label: "Add Product",
                        hotkey: "F4",
                        icon: Icons.add_box_outlined,
                        iconColor: colors.accentPrimary,
                        onTap: () => nav.navigateTo('inventory/studio'),
                      ),
                      _TactileActionPill(
                        label: "Stock In",
                        icon: Icons.login_outlined,
                        iconColor: const Color(0xFF2DD4BF),
                        onTap: () => nav.navigateTo('inventory/stock/in'),
                      ),
                      _TactileActionPill(
                        label: "Stock Out",
                        icon: Icons.logout_outlined,
                        iconColor: const Color(0xFFFB7185),
                        onTap: () => nav.navigateTo('inventory/stock/out'),
                      ),
                      _TactileActionPill(
                        label: "AI Assistant",
                        hotkey: "Ctrl+Space",
                        icon: Icons.auto_awesome,
                        iconColor: colors.accentPurple,
                        isAI: true,
                        onTap: () => nav.toggleSidePanel(),
                      ),

                      ListenableBuilder(
                        listenable: QuickAccessController(),
                        builder: (context, _) {
                          final controller = QuickAccessController();
                          if (controller.items.isEmpty) {
                            return const SizedBox.shrink();
                          }
                          return Row(
                            children: [
                              _VerticalDivider(colors: colors),
                              const SizedBox(width: 8),
                              ...controller.items.map((item) =>
                                  QuickAccessItemWidget(
                                    item: item,
                                    onTap: () => nav.navigateTo(item.route),
                                  )),
                            ],
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(width: 8),
              _VerticalDivider(colors: colors),
              const SizedBox(width: 12),

              _ManageButton(onTap: () => _showManagePalette(context)),
            ],
          ),
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
}
