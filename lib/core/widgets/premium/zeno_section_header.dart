import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';

class ZenoSectionHeader extends StatefulWidget {
  final String title;
  final IconData? icon;
  final List<Widget>? actions;
  final bool collapsible;
  final bool initiallyExpanded;
  final Function(bool)? onToggle;

  const ZenoSectionHeader({
    super.key,
    required this.title,
    this.icon,
    this.actions,
    this.collapsible = false,
    this.initiallyExpanded = true,
    this.onToggle,
  });

  @override
  State<ZenoSectionHeader> createState() => _ZenoSectionHeaderState();
}

class _ZenoSectionHeaderState extends State<ZenoSectionHeader> {
  late bool _isExpanded;

  @override
  void initState() {
    super.initState();
    _isExpanded = widget.initiallyExpanded;
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<ZenoSemanticColors>()!;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: InkWell(
        onTap: widget.collapsible
            ? () {
                setState(() => _isExpanded = !_isExpanded);
                widget.onToggle?.call(_isExpanded);
              }
            : null,
        child: Row(
          children: [
            if (widget.collapsible) ...[
              Icon(
                _isExpanded
                    ? Icons.keyboard_arrow_down_rounded
                    : Icons.keyboard_arrow_right_rounded,
                size: 18,
                color: colors.textDisabled,
              ),
              const SizedBox(width: 8),
            ],
            if (widget.icon != null) ...[
              Icon(widget.icon, size: 18, color: colors.accentPrimary),
              const SizedBox(width: 12),
            ],
            Text(
              widget.title.toUpperCase(),
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w900,
                color: colors.textPrimary,
                letterSpacing: 1.2,
              ),
            ),
            const SizedBox(width: 16),
            const Expanded(child: Divider(height: 1)),
            if (widget.actions != null) ...[
              const SizedBox(width: 16),
              ...widget.actions!,
            ],
          ],
        ),
      ),
    );
  }
}
