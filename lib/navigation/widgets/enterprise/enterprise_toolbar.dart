import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';

class EnterpriseToolbar extends StatelessWidget {
  final List<Widget> actions;
  final List<Widget>? secondaryActions;

  const EnterpriseToolbar({
    super.key,
    required this.actions,
    this.secondaryActions,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      decoration: const BoxDecoration(
        color: ZenoTheme.surface,
        border: Border(bottom: BorderSide(color: ZenoTheme.border)),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            Row(
              children: actions
                  .map((a) => Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: a,
                      ))
                  .toList(),
            ),
            if (secondaryActions != null) ...[
              const VerticalDivider(
                  width: 32,
                  indent: 16,
                  endIndent: 16,
                  color: ZenoTheme.border),
              Row(
                children: secondaryActions!
                    .map((a) => Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: a,
                        ))
                    .toList(),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class ToolbarButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool isPrimary;
  final VoidCallback onTap;
  final Color? color;

  const ToolbarButton({
    super.key,
    required this.label,
    required this.icon,
    this.isPrimary = false,
    required this.onTap,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    if (isPrimary) {
      return ElevatedButton.icon(
        onPressed: onTap,
        icon: Icon(icon, size: 18),
        label: Text(label),
        style: ElevatedButton.styleFrom(
          backgroundColor: color ?? ZenoTheme.primary,
          foregroundColor: Colors.white,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 16),
        ),
      );
    }

    return OutlinedButton.icon(
      onPressed: onTap,
      icon: Icon(icon, size: 18, color: color ?? ZenoTheme.textPrimary),
      label:
          Text(label, style: TextStyle(color: color ?? ZenoTheme.textPrimary)),
      style: OutlinedButton.styleFrom(
        side: const BorderSide(color: ZenoTheme.border),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }
}
