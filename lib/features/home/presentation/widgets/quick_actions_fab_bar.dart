import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:flutter_animate/flutter_animate.dart';

class QuickActionsFABBar extends StatelessWidget {
  const QuickActionsFABBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: ZenoTheme.surface.withValues(alpha: 0.95),
        borderRadius: BorderRadius.circular(40),
        border: Border.all(color: ZenoTheme.border),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.5),
            blurRadius: 20,
            offset: const Offset(0, 10),
          )
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const _QuickActionItem(
              icon: Icons.add_shopping_cart,
              label: "SALE",
              color: ZenoTheme.neonGreen),
          const _VerticalDivider(),
          const _QuickActionItem(
              icon: Icons.inventory_2_outlined,
              label: "PURCHASE",
              color: ZenoTheme.neonCyan),
          const _VerticalDivider(),
          const _QuickActionItem(
              icon: Icons.person_add_alt_1_outlined,
              label: "CUST",
              color: Colors.orange),
          const _VerticalDivider(),
          const _QuickActionItem(
              icon: Icons.business_outlined,
              label: "SUPP",
              color: Colors.purple),
          const _VerticalDivider(),
          const _QuickActionItem(
              icon: Icons.add_box_outlined, label: "PROD", color: Colors.blue),
          const _VerticalDivider(),
          const _QuickActionItem(
              icon: Icons.receipt_outlined,
              label: "EXPENSE",
              color: Colors.red),
          const _VerticalDivider(),
          const _QuickActionItem(
              icon: Icons.payments_outlined,
              label: "RECV",
              color: Colors.amber),
          const SizedBox(width: 8),
          Container(
            width: 44,
            height: 44,
            decoration: const BoxDecoration(
                color: ZenoTheme.accent, shape: BoxShape.circle),
            child: IconButton(
              icon: const Icon(Icons.auto_awesome, color: Colors.white),
              onPressed: () {},
            ),
          )
              .animate(onPlay: (controller) => controller.repeat(reverse: true))
              .shimmer(duration: 2.seconds, color: Colors.white24),
        ],
      ),
    );
  }
}

class _QuickActionItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;

  const _QuickActionItem(
      {required this.icon, required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: label,
      child: InkWell(
        onTap: () {},
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 18, color: color),
              const SizedBox(height: 2),
              Text(label,
                  style: TextStyle(
                      fontSize: 7,
                      fontWeight: FontWeight.w900,
                      color: color,
                      letterSpacing: 0.5)),
            ],
          ),
        ),
      ),
    );
  }
}

class _VerticalDivider extends StatelessWidget {
  const _VerticalDivider();
  @override
  Widget build(BuildContext context) {
    return Container(width: 1, height: 24, color: ZenoTheme.border);
  }
}
