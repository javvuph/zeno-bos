import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/navigation/quick_access_controller.dart';
import 'package:zeno/navigation/navigation_controller.dart';
import 'package:zeno/navigation/widgets/quick_access_item_widget.dart';
import 'package:zeno/navigation/widgets/quick_access_manage_palette.dart';

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
          height: 32, // Spec: Fixed 32px
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: colors.bgTier3, // Tier 3: Elevated Slate (#1B1E2B)
            border: Border(bottom: BorderSide(color: colors.borderSubtle)),
          ),
          child: Row(
            children: [
              // LABEL: ⚡ ACTIONS
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

              // SCROLLABLE AREA FOR ALL ACTIONS (FIXED + DYNAMIC)
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Row(
                    children: [
                      // TACTILE FIXED ACTION PILLS
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

                      // DYNAMIC ITEMS FROM CONTROLLER
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

              // MANAGE BUTTON
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

class _TactileActionPill extends StatefulWidget {
  final String label;
  final String? hotkey;
  final IconData icon;
  final Color iconColor;
  final bool isAI;
  final VoidCallback onTap;

  const _TactileActionPill({
    required this.label,
    this.hotkey,
    required this.icon,
    required this.iconColor,
    this.isAI = false,
    required this.onTap,
  });

  @override
  State<_TactileActionPill> createState() => _TactileActionPillState();
}

class _TactileActionPillState extends State<_TactileActionPill> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<ZenoSemanticColors>()!;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          margin: const EdgeInsets.only(right: 8),
          decoration: BoxDecoration(
            // Spec: Tinted pills based on icon color
            color: _isHovered
                ? widget.iconColor.withValues(alpha: 0.2)
                : widget.iconColor.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(6),
            border: Border.all(
              color: widget.iconColor.withValues(alpha: _isHovered ? 0.6 : 0.3),
              width: _isHovered ? 1.2 : 1.0,
            ),
            boxShadow: _isHovered
                ? [
                    BoxShadow(
                        color: widget.iconColor.withValues(alpha: 0.2),
                        blurRadius: 4,
                        spreadRadius: 0),
                  ]
                : null,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (widget.isAI)
                ShaderMask(
                  shaderCallback: (bounds) =>
                      ZenoTheme.aiVioletGradient.createShader(bounds),
                  child: Icon(widget.icon, size: 14, color: Colors.white),
                )
              else
                Icon(widget.icon, size: 14, color: widget.iconColor),
              const SizedBox(width: 8),
              Text(
                widget.label,
                style: TextStyle(
                  fontSize: 11,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w700,
                  color: colors.textPrimary, // Theme-aware color
                ),
              ),
              if (widget.hotkey != null) ...[
                const SizedBox(width: 8),
                // Spec: High-contrast keycaps
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 1.5),
                  decoration: BoxDecoration(
                    color: colors.bgTier1.withValues(alpha: 0.8),
                    borderRadius: BorderRadius.circular(3),
                    border: Border.all(
                        color: colors.borderSubtle.withValues(alpha: 0.5)),
                  ),
                  child: Text(
                    widget.hotkey!,
                    style: TextStyle(
                      fontSize: 9,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w900,
                      color: colors.accentPrimary,
                    ),
                  ),
                ),
              ],
              if (widget.isAI) ...[
                const SizedBox(width: 6),
                ShaderMask(
                  shaderCallback: (bounds) =>
                      ZenoTheme.aiVioletGradient.createShader(bounds),
                  child: const Text(
                    "AI",
                    style: TextStyle(
                        fontSize: 8,
                        fontWeight: FontWeight.w900,
                        color: Colors.white),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _VerticalDivider extends StatelessWidget {
  final ZenoSemanticColors colors;
  const _VerticalDivider({required this.colors});

  @override
  Widget build(BuildContext context) {
    return Container(width: 1, height: 16, color: colors.borderSubtle);
  }
}

class _ManageButton extends StatefulWidget {
  final VoidCallback onTap;
  const _ManageButton({required this.onTap});

  @override
  State<_ManageButton> createState() => _ManageButtonState();
}

class _ManageButtonState extends State<_ManageButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<ZenoSemanticColors>()!;
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: InkWell(
        onTap: widget.onTap,
        borderRadius: BorderRadius.circular(4),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: _isHovered ? colors.bgHover : colors.bgTier2,
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: colors.borderSubtle),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "MANAGE",
                style: TextStyle(
                  fontSize: 10,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w700,
                  color: _isHovered
                      ? colors.textPrimary
                      : Colors.white.withValues(alpha: 0.9),
                ),
              ),
              const SizedBox(width: 6),
              Icon(Icons.settings_outlined,
                  size: 14,
                  color:
                      _isHovered ? colors.accentPrimary : colors.textSecondary),
            ],
          ),
        ),
      ),
    );
  }
}
