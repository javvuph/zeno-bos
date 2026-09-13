import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';

class ZenoBadge extends StatelessWidget {
  final String label;
  final Color color;
  final bool isSolid;

  const ZenoBadge({
    super.key,
    required this.label,
    required this.color,
    this.isSolid = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          const EdgeInsets.symmetric(horizontal: ZenoSpacing.sm, vertical: 2),
      decoration: BoxDecoration(
        color: isSolid ? color : color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(ZenoRadius.sm),
        border: Border.all(
            color: color.withValues(alpha: 0.3),
            width: ZenoBorderWidth.hairline),
      ),
      child: Text(
        label.toUpperCase(),
        style: ZenoTypography.micro(isSolid ? Colors.white : color)
            .copyWith(fontWeight: FontWeight.w900),
      ),
    );
  }
}
