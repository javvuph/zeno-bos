import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/features/billing/presentation/controllers/billing_studio_controller.dart';
import 'package:zeno/features/billing/presentation/controllers/billing_event.dart';
import 'package:zeno/features/billing/domain/models/bill.dart';

class BillingQuickActionBar extends StatelessWidget {
  const BillingQuickActionBar({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<ZenoSemanticColors>()!;

    return Container(
      height: 54,
      padding: const EdgeInsets.symmetric(horizontal: ZenoSpacing.lg),
      decoration: BoxDecoration(
        color: colors.bgTier2,
        border: Border(top: BorderSide(color: colors.borderSubtle, width: 0.5)),
      ),
      child: Row(
        children: [
          _QuickButton(
              label: 'HOLD (F4)',
              icon: Icons.pause_circle_outline,
              onTap: () => context
                  .read<BillingStudioController>()
                  .add(BillHoldRequested()),
              colors: colors),
          _QuickButton(
              label: 'RECALL (F6)',
              icon: Icons.history_edu_outlined,
              onTap: () {
                final state = context.read<BillingStudioController>().state;
                if (state.heldBills.isNotEmpty) {
                  _showRecallDialog(context, state.heldBills);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('No held bills')),
                  );
                }
              },
              colors: colors),
          const VerticalDivider(width: 32, indent: 16, endIndent: 16),
          _QuickButton(
              label: 'DISCOUNT',
              icon: Icons.sell_outlined,
              onTap: () {},
              colors: colors),
          _QuickButton(
              label: 'TAX OVERRIDE',
              icon: Icons.receipt_long_outlined,
              onTap: () {},
              colors: colors),
          _QuickButton(
              label: 'NOTES',
              icon: Icons.edit_note_outlined,
              onTap: () {},
              colors: colors),
          const Spacer(),
          _QuickButton(
            label: 'CLEAR CART',
            icon: Icons.delete_sweep_outlined,
            onTap: () => context
                .read<BillingStudioController>()
                .add(ClearCartRequested()),
            colors: colors,
            isDestructive: true,
          ),
        ],
      ),
    );
  }

  void _showRecallDialog(BuildContext context, List<Bill> heldBills) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('RECALL BILL'),
        content: SizedBox(
          width: 300,
          height: 400,
          child: ListView.builder(
            itemCount: heldBills.length,
            itemBuilder: (context, index) {
              final bill = heldBills[index];
              return ListTile(
                title: Text('Bill ID: ${bill.id.toUpperCase()}'),
                subtitle: Text(
                    'Items: ${bill.items.length} | Total: \$${bill.grandTotal.toStringAsFixed(2)}'),
                trailing: Text(bill.timestamp.toString().substring(11, 16)),
                onTap: () {
                  context
                      .read<BillingStudioController>()
                      .add(BillRecallRequested(bill.id));
                  Navigator.pop(context);
                },
              );
            },
          ),
        ),
      ),
    );
  }
}

class _QuickButton extends StatefulWidget {
  final String label;
  final IconData icon;
  final VoidCallback onTap;
  final ZenoSemanticColors colors;
  final bool isDestructive;

  const _QuickButton({
    required this.label,
    required this.icon,
    required this.onTap,
    required this.colors,
    this.isDestructive = false,
  });

  @override
  State<_QuickButton> createState() => _QuickButtonState();
}

class _QuickButtonState extends State<_QuickButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final baseColor = widget.isDestructive
        ? widget.colors.statusDanger
        : widget.colors.textSecondary;
    final activeColor = widget.isDestructive
        ? widget.colors.statusDanger
        : widget.colors.accentPrimary;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: TextButton.icon(
        onPressed: widget.onTap,
        icon: Icon(widget.icon,
            size: 18, color: _isHovered ? activeColor : baseColor),
        label: Text(
          widget.label,
          style: TextStyle(
            color: _isHovered ? widget.colors.textPrimary : baseColor,
            fontSize: 11,
            fontWeight: _isHovered ? FontWeight.w900 : FontWeight.w700,
            letterSpacing: 0.5,
          ),
        ),
        style: TextButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: ZenoSpacing.md),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(ZenoRadius.sm)),
          backgroundColor: _isHovered
              ? activeColor.withValues(alpha: 0.05)
              : Colors.transparent,
        ),
      ),
    );
  }
}
