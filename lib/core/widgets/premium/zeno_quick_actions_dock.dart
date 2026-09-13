import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:zeno/navigation/navigation_controller.dart';

class ZenoQuickActionsDock extends StatefulWidget {
  const ZenoQuickActionsDock({super.key});

  @override
  State<ZenoQuickActionsDock> createState() => _ZenoQuickActionsDockState();
}

class _ZenoQuickActionsDockState extends State<ZenoQuickActionsDock> {
  Offset _position = const Offset(-1, -1);
  bool _isHorizontal = true;
  bool _isDragging = false;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<ZenoSemanticColors>()!;
    final screenSize = MediaQuery.of(context).size;

    // DEFAULT POSITION: Top-Center (Integration into Header Area)
    if (_position.dx == -1) {
      _position = Offset(screenSize.width / 2 - 160, 6);
    }

    return Positioned(
      left: _position.dx,
      top: _position.dy,
      child: GestureDetector(
        onPanStart: (_) => setState(() => _isDragging = true),
        onPanUpdate: (details) {
          setState(() {
            _position += details.delta;
            _position = Offset(
              _position.dx.clamp(0.0, screenSize.width - 60),
              _position.dy.clamp(0.0, screenSize.height - 60),
            );
          });
        },
        onPanEnd: (_) => setState(() => _isDragging = false),
        onSecondaryTapDown: (details) =>
            _showDockMenu(context, details.globalPosition),
        child: AnimatedScale(
          scale: _isDragging ? 1.02 : 1.0,
          duration: const Duration(milliseconds: 100),
          child: Container(
            height: 36,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(_isHorizontal ? 40 : 12),
              border: Border.all(
                color: _isDragging
                    ? colors.accentPrimary
                    : const Color(0xFFE2E8F0),
                width: 1.5,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.15),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                )
              ],
            ),
            child: Flex(
              direction: _isHorizontal ? Axis.horizontal : Axis.vertical,
              mainAxisSize: MainAxisSize.min,
              children: [
                // UPDATED ROUTES TO MATCH v1.0 FROZEN ARCHITECTURE
                _DockItem(
                    icon: Icons.add_shopping_cart,
                    label: "SALE",
                    color: const Color(0xFF10B981),
                    route: 'sales/pos',
                    isHorizontal: _isHorizontal),
                _divider(colors),
                _DockItem(
                    icon: Icons.inventory_2_outlined,
                    label: "STOCK",
                    color: const Color(0xFF3B82F6),
                    route: 'inventory/products',
                    isHorizontal: _isHorizontal),
                _divider(colors),
                _DockItem(
                    icon: Icons.person_add_alt_1_outlined,
                    label: "CUST",
                    color: const Color(0xFFF59E0B),
                    route: 'crm/customers',
                    isHorizontal: _isHorizontal),
                _divider(colors),
                _DockItem(
                    icon: Icons.receipt_outlined,
                    label: "EXPENSE",
                    color: const Color(0xFFEF4444),
                    route: 'finance/expenses',
                    isHorizontal: _isHorizontal),

                const SizedBox(width: 8),
                _AIPulseButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _divider(ZenoSemanticColors colors) => Container(
        width: _isHorizontal ? 1 : 20,
        height: _isHorizontal ? 16 : 1,
        color: const Color(0xFFE2E8F0),
        margin: EdgeInsets.symmetric(horizontal: _isHorizontal ? 4 : 0),
      );

  void _showDockMenu(BuildContext context, Offset position) {
    showMenu(
      context: context,
      position: RelativeRect.fromLTRB(
          position.dx, position.dy, position.dx, position.dy),
      items: [
        PopupMenuItem(
          child: Row(
            children: [
              Icon(Icons.rotate_90_degrees_ccw_rounded,
                  size: 14,
                  color: _isHorizontal ? const Color(0xFF3B82F6) : Colors.grey),
              const SizedBox(width: 10),
              const Text("TOGGLE ORIENTATION",
                  style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
            ],
          ),
          onTap: () => setState(() => _isHorizontal = !_isHorizontal),
        ),
        PopupMenuItem(
          child: const Row(
            children: [
              Icon(Icons.center_focus_strong_rounded, size: 14),
              SizedBox(width: 10),
              Text("RESET TO TOP CENTER",
                  style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
            ],
          ),
          onTap: () {
            final sz = MediaQuery.of(context).size;
            setState(() {
              _position = Offset(sz.width / 2 - 160, 6);
              _isHorizontal = true;
            });
          },
        ),
      ],
    );
  }
}

class _DockItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final String route;
  final bool isHorizontal;

  const _DockItem({
    required this.icon,
    required this.label,
    required this.color,
    required this.route,
    required this.isHorizontal,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => NavigationController()
          .navigateTo(route), // FIXED: USE navigateTo FOR WINDOWS
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 14, color: color),
            if (isHorizontal) ...[
              const SizedBox(width: 6),
              Text(label,
                  style: TextStyle(
                      fontSize: 9,
                      fontWeight: FontWeight.w900,
                      color: color,
                      letterSpacing: 0.5)),
            ],
          ],
        ),
      ),
    );
  }
}

class _AIPulseButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => NavigationController().navigateTo('ai/home'),
      child: Container(
        width: 28,
        height: 28,
        decoration: const BoxDecoration(
          color: Color(0xFF3B82F6),
          shape: BoxShape.circle,
        ),
        child: const Icon(Icons.auto_awesome, color: Colors.white, size: 14),
      ),
    ).animate(onPlay: (c) => c.repeat(reverse: true)).scale(
        begin: const Offset(1, 1),
        end: const Offset(1.05, 1.05),
        duration: 2000.ms);
  }
}
