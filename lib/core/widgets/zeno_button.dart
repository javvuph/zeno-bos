import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';

enum ZenoButtonVariant { primary, secondary, ghost, danger }

enum ZenoButtonSize { sm, md, lg }

class ZenoButton extends StatefulWidget {
  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  final ZenoButtonVariant variant;
  final ZenoButtonSize size;
  final bool isLoading;
  final bool isFullWidth;

  const ZenoButton({
    super.key,
    required this.label,
    this.onPressed,
    this.icon,
    this.variant = ZenoButtonVariant.primary,
    this.size = ZenoButtonSize.md,
    this.isLoading = false,
    this.isFullWidth = false,
  });

  @override
  State<ZenoButton> createState() => _ZenoButtonState();
}

class _ZenoButtonState extends State<ZenoButton> {
  bool _isHovered = false;
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<ZenoSemanticColors>()!;
    final bool isEnabled = widget.onPressed != null && !widget.isLoading;

    // Resolve Colors
    Color bgColor;
    Color textColor;
    Color borderColor = Colors.transparent;

    switch (widget.variant) {
      case ZenoButtonVariant.primary:
        bgColor = isEnabled
            ? (_isPressed
                ? colors.accentPrimary.withValues(alpha: 0.8)
                : (_isHovered
                    ? colors.accentPrimary.withValues(alpha: 0.95)
                    : colors.accentPrimary))
            : colors.textDisabled.withValues(alpha: 0.2);
        textColor = isEnabled ? Colors.black : colors.textDisabled;
        break;
      case ZenoButtonVariant.secondary:
        bgColor = isEnabled
            ? (_isHovered ? colors.bgTier3 : colors.bgTier2)
            : colors.bgTier2;
        textColor = isEnabled ? colors.textPrimary : colors.textDisabled;
        borderColor = colors.borderSubtle;
        break;
      case ZenoButtonVariant.ghost:
        bgColor = _isHovered ? colors.bgHover : Colors.transparent;
        textColor = isEnabled ? colors.textPrimary : colors.textDisabled;
        break;
      case ZenoButtonVariant.danger:
        bgColor = isEnabled
            ? (_isHovered
                ? colors.statusDanger.withValues(alpha: 0.1)
                : Colors.transparent)
            : Colors.transparent;
        textColor = isEnabled ? colors.statusDanger : colors.textDisabled;
        borderColor = isEnabled
            ? colors.statusDanger.withValues(alpha: 0.3)
            : colors.borderSubtle;
        break;
    }

    // Resolve Sizing
    double height;
    double padding;
    TextStyle textStyle;
    double iconSize;

    final bool isIconOnly = widget.label.isEmpty && widget.icon != null;

    switch (widget.size) {
      case ZenoButtonSize.sm:
        height = 34;
        padding = isIconOnly ? 8 : 12;
        textStyle = ZenoTypography.caption(textColor)
            .copyWith(fontWeight: FontWeight.w800, fontSize: 9.5);
        iconSize = 14;
        break;
      case ZenoButtonSize.md:
        height = 42;
        padding = isIconOnly ? 10 : 20;
        textStyle = ZenoTypography.bodyMD(textColor)
            .copyWith(fontWeight: FontWeight.w800);
        iconSize = 18;
        break;
      case ZenoButtonSize.lg:
        height = 54;
        padding = isIconOnly ? 14 : 32;
        textStyle = ZenoTypography.bodyLG(textColor)
            .copyWith(fontWeight: FontWeight.w900, letterSpacing: 0.5);
        iconSize = 22;
        break;
    }

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: isEnabled ? SystemMouseCursors.click : SystemMouseCursors.basic,
      child: GestureDetector(
        onTapDown: (_) => setState(() => _isPressed = true),
        onTapUp: (_) => setState(() => _isPressed = false),
        onTapCancel: () => setState(() => _isPressed = false),
        onTap: isEnabled ? widget.onPressed : null,
        child: AnimatedContainer(
          duration: ZenoDuration.fast,
          curve: ZenoMotion.standard,
          height: height,
          width: widget.isFullWidth ? double.infinity : null,
          padding: EdgeInsets.symmetric(horizontal: padding),
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(ZenoRadius.md),
            border: borderColor != Colors.transparent
                ? Border.all(color: borderColor, width: ZenoBorderWidth.thin)
                : null,
            boxShadow: (widget.variant == ZenoButtonVariant.primary &&
                    _isHovered &&
                    isEnabled)
                ? [
                    BoxShadow(
                        color: colors.accentPrimary.withValues(alpha: 0.25),
                        blurRadius: 12,
                        offset: const Offset(0, 4))
                  ]
                : null,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (widget.isLoading)
                SizedBox(
                  width: iconSize,
                  height: iconSize,
                  child: CircularProgressIndicator(
                      strokeWidth: 2, color: textColor),
                )
              else ...[
                if (widget.icon != null) Icon(widget.icon, size: iconSize, color: textColor),
                if (widget.icon != null && !widget.label.isEmpty) const SizedBox(width: 10),
                if (!widget.label.isEmpty) Text(widget.label.toUpperCase(), style: textStyle),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
