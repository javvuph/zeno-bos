import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';

class ZenoCard extends StatefulWidget {
  final Widget child;
  final String? title;
  final Color? titleColor;
  final String? subtitle;
  final Widget? trailing;
  final EdgeInsetsGeometry? padding;
  final Color? color;
  final double? width;
  final double? height;
  final bool isSelected;
  final VoidCallback? onTap;

  const ZenoCard({
    super.key,
    required this.child,
    this.title,
    this.titleColor,
    this.subtitle,
    this.trailing,
    this.padding,
    this.color,
    this.width,
    this.height,
    this.isSelected = false,
    this.onTap,
  });

  @override
  State<ZenoCard> createState() => _ZenoCardState();
}

class _ZenoCardState extends State<ZenoCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<ZenoSemanticColors>()!;
    final bool isClickable = widget.onTap != null;
    final bool useGlass = widget.color == null;

    final card = ClipRRect(
      borderRadius: BorderRadius.circular(ZenoRadius.lg),
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: useGlass ? ZenoGlass.blur : 0,
          sigmaY: useGlass ? ZenoGlass.blur : 0,
        ),
        child: AnimatedContainer(
          duration: ZenoDuration.fast,
          width: widget.width,
          height: widget.height,
          decoration: BoxDecoration(
            color: widget.color ??
                colors.bgSurface.withValues(
                  alpha: Theme.of(context).brightness == Brightness.light
                      ? ZenoGlass.lightOpacity
                      : ZenoGlass.darkOpacity,
                ),
            borderRadius: BorderRadius.circular(ZenoRadius.lg),
            border: Border.all(
              color: widget.isSelected
                  ? colors.accentPrimary
                  : (_isHovered && isClickable
                      ? colors.accentPrimary.withValues(alpha: 0.50)
                      : colors.borderSubtle),
              width: widget.isSelected
                  ? ZenoBorderWidth.thick
                  : ZenoBorderWidth.hairline,
            ),
            boxShadow: (widget.isSelected || (_isHovered && isClickable))
                ? ZenoElevation.soft
                : null,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (widget.title != null || widget.trailing != null)
                Padding(
                  padding: const EdgeInsets.fromLTRB(12, 6, 8, 0),
                  child: Row(
                    children: [
                      if (widget.title != null)
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.title!.toUpperCase(),
                                style: ZenoTypography.caption(
                                  widget.titleColor ?? colors.textPrimary,
                                ).copyWith(
                                  fontWeight: FontWeight.w900,
                                  letterSpacing: 1.0,
                                ),
                              ),
                              if (widget.subtitle != null)
                                Text(
                                  widget.subtitle!,
                                  style: ZenoTypography.micro(colors.textDisabled),
                                ),
                            ],
                          ),
                        ),
                      if (widget.trailing != null) widget.trailing!,
                    ],
                  ),
                ),
              Flexible(
                child: Padding(
                  padding: widget.padding ?? const EdgeInsets.all(ZenoSpacing.md),
                  child: widget.child,
                ),
              ),
            ],
          ),
        ),
      ),
    );

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: isClickable ? SystemMouseCursors.click : SystemMouseCursors.basic,
      child: GestureDetector(onTap: widget.onTap, child: card),
    );
  }
}

class ZenoStatCard extends StatelessWidget {
  final String label;
  final String value;
  final String? change;
  final bool isPositive;
  final IconData icon;
  final Color? iconColor;

  const ZenoStatCard({
    super.key,
    required this.label,
    required this.value,
    this.change,
    this.isPositive = true,
    required this.icon,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<ZenoSemanticColors>()!;
    final Color accent = iconColor ?? colors.accentPrimary;

    return ZenoCard(
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(ZenoSpacing.sm),
            decoration: BoxDecoration(
              color: accent.withValues(alpha: 0.10),
              borderRadius: BorderRadius.circular(ZenoRadius.md),
            ),
            child: Icon(icon, color: accent, size: ZenoSizing.iconLG),
          ),
          const SizedBox(width: ZenoSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  label.toUpperCase(),
                  style: ZenoTypography.micro(colors.textSecondary)
                      .copyWith(letterSpacing: 0.5),
                ),
                const SizedBox(height: ZenoSpacing.xs / 2),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    Text(
                      value,
                      style: ZenoTypography.headlineMD(colors.textPrimary)
                          .copyWith(fontWeight: FontWeight.w900),
                    ),
                    if (change != null) ...[
                      const SizedBox(width: ZenoSpacing.sm),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            isPositive ? Icons.trending_up : Icons.trending_down,
                            size: ZenoSizing.iconSM - 4,
                            color: isPositive
                                ? colors.statusSuccess
                                : colors.statusDanger,
                          ),
                          const SizedBox(width: 2),
                          Text(
                            change!,
                            style: ZenoTypography.micro(
                              isPositive
                                  ? colors.statusSuccess
                                  : colors.statusDanger,
                            ).copyWith(fontWeight: FontWeight.w900),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
