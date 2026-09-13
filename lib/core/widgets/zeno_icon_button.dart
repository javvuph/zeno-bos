import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';

class ZenoIconButton extends StatefulWidget {
  final IconData icon;
  final VoidCallback? onPressed;
  final Color? color;
  final double size;
  final String? tooltip;

  const ZenoIconButton({
    super.key,
    required this.icon,
    this.onPressed,
    this.color,
    this.size = ZenoSizing.iconMD,
    this.tooltip,
  });

  @override
  State<ZenoIconButton> createState() => _ZenoIconButtonState();
}

class _ZenoIconButtonState extends State<ZenoIconButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<ZenoSemanticColors>()!;
    final bool isEnabled = widget.onPressed != null;
    final Color iconColor =
        widget.color ?? (isEnabled ? colors.textPrimary : colors.textDisabled);

    Widget button = MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: isEnabled ? SystemMouseCursors.click : SystemMouseCursors.basic,
      child: GestureDetector(
        onTap: widget.onPressed,
        child: AnimatedContainer(
          duration: ZenoDuration.fast,
          padding: const EdgeInsets.all(ZenoSpacing.xs),
          decoration: BoxDecoration(
            color:
                _isHovered && isEnabled ? colors.bgHover : Colors.transparent,
            borderRadius: BorderRadius.circular(ZenoRadius.sm),
          ),
          child: Icon(
            widget.icon,
            size: widget.size,
            color: iconColor,
          ),
        ),
      ),
    );

    if (widget.tooltip != null) {
      return Tooltip(message: widget.tooltip!, child: button);
    }
    return button;
  }
}
