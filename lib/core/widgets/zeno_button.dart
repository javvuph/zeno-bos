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

    Color bgColor;
    Color textColor;
    Color borderColor = Colors.transparent;

    switch (widget.variant) {
      case ZenoButtonVariant.primary:
        bgColor = isEnabled
            ? (_isPressed
                ? colors.accentPrimary.withValues(alpha: 0.86)
                : (_isHovered
                    ? colors.accentPrimary.withValues(alpha: 0.94)
                    : colors.accentPrimary))
            : colors.textDisabled.withValues(alpha: 0.18);
        textColor = isEnabled ? Colors.white : colors.textDisabled;
        break;
      case ZenoButtonVariant.secondary:
        bgColor = isEnabled
            ? (_isHovered
                ? colors.bgHover.withValues(alpha: 0.88)
                : colors.bgSurface.withValues(alpha: 0.72))
            : colors.bgTier2;
        textColor = isEnabled ? colors.textPrimary : colors.textDisabled;
        borderColor = colors.borderSubtle;
        break;
      case ZenoButtonVariant.ghost:
        bgColor = _isHovered ? colors.bgHover.withValues(alpha: 0.72) : Colors.transparent;
        textColor = isEnabled ? colors.textPrimary : colors.textDisabled;
        break;
      case ZenoButtonVariant.danger:
        bgColor = isEnabled
            ? (_isHovered
                ? colors.statusDanger.withValues(alpha: 0.10)
                : Colors.transparent)
            : Colors.transparent;
        textColor = isEnabled ? colors.statusDanger : colors.textDisabled;
        borderColor = isEnabled
            ? colors.statusDanger.withValues(alpha: 0.30)
            : colors.borderSubtle;
        break;
    }

    double height;
    double padding;
    TextStyle textStyle;
    double iconSize;

    final bool isIconOnly = widget.label.isEmpty && widget.icon != null;

    switch (widget.size) {
      case ZenoButtonSize.sm:
        height = 32;
        padding = isIconOnly ? 8 : 12;
        textStyle = ZenoTypography.caption(textColor)
            .copyWith(fontWeight: FontWeight.w700, fontSize: 10);
        iconSize = 14;
        break;
      case ZenoButtonSize.md:
        height = 36;
        padding = isIconOnly ? 8 : 16;
        textStyle = ZenoTypography.bodyMD(textColor)
            .copyWith(fontWeight: FontWeight.w700);
        iconSize = 16;
        break;
      case ZenoButtonSize.lg:
        height = 40;
        padding = isIconOnly ? 10 : 20;
        textStyle = ZenoTypography.bodyLG(textColor)
            .copyWith(fontWeight: FontWeight.w700);
        iconSize = 18;
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
                      color: colors.accentPrimary.withValues(alpha: 0.18),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
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
                    strokeWidth: 2,
                    color: textColor,
                  ),
                )
              else ...[
                if (widget.icon != null)
                  Icon(widget.icon, size: iconSize, color: textColor),
                if (widget.icon != null && widget.label.isNotEmpty)
                  const SizedBox(width: 8),
                if (widget.label.isNotEmpty)
                  Text(widget.label.toUpperCase(), style: textStyle),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
