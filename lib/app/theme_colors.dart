import 'package:flutter/material.dart';

extension ZenoGradientExtension on LinearGradient {
  LinearGradient withValues({double? alpha}) {
    return LinearGradient(
      begin: begin,
      end: end,
      stops: stops,
      tileMode: tileMode,
      transform: transform,
      colors: colors.map((c) => c.withValues(alpha: alpha ?? 1.0)).toList(),
    );
  }
}

class ZenoSemanticColors extends ThemeExtension<ZenoSemanticColors> {
  final Color bgTier1;
  final Color bgTier2;
  final Color bgTier3;
  final Color bgTier4;
  final Color bgSurface;
  final Color bgHover;
  final Color borderSubtle;
  final Color textPrimary;
  final Color textSecondary;
  final Color textDisabled;
  final Color accentPrimary;
  final Color accentPurple;
  final Color statusSuccess;
  final Color statusWarning;
  final Color statusDanger;
  final Color statusInfo;
  final Color amberGold;

  const ZenoSemanticColors({
    required this.bgTier1,
    required this.bgTier2,
    required this.bgTier3,
    required this.bgTier4,
    required this.bgSurface,
    required this.bgHover,
    required this.borderSubtle,
    required this.textPrimary,
    required this.textSecondary,
    required this.textDisabled,
    required this.accentPrimary,
    required this.accentPurple,
    required this.statusSuccess,
    required this.statusWarning,
    required this.statusDanger,
    required this.statusInfo,
    required this.amberGold,
  });

  @override
  ZenoSemanticColors copyWith({
    Color? bgTier1,
    Color? bgTier2,
    Color? bgTier3,
    Color? bgTier4,
    Color? bgSurface,
    Color? bgHover,
    Color? borderSubtle,
    Color? textPrimary,
    Color? textSecondary,
    Color? textDisabled,
    Color? accentPrimary,
    Color? accentPurple,
    Color? statusSuccess,
    Color? statusWarning,
    Color? statusDanger,
    Color? statusInfo,
    Color? amberGold,
  }) =>
      ZenoSemanticColors(
        bgTier1: bgTier1 ?? this.bgTier1,
        bgTier2: bgTier2 ?? this.bgTier2,
        bgTier3: bgTier3 ?? this.bgTier3,
        bgTier4: bgTier4 ?? this.bgTier4,
        bgSurface: bgSurface ?? this.bgSurface,
        bgHover: bgHover ?? this.bgHover,
        borderSubtle: borderSubtle ?? this.borderSubtle,
        textPrimary: textPrimary ?? this.textPrimary,
        textSecondary: textSecondary ?? this.textSecondary,
        textDisabled: textDisabled ?? this.textDisabled,
        accentPrimary: accentPrimary ?? this.accentPrimary,
        accentPurple: accentPurple ?? this.accentPurple,
        statusSuccess: statusSuccess ?? this.statusSuccess,
        statusWarning: statusWarning ?? this.statusWarning,
        statusDanger: statusDanger ?? this.statusDanger,
        statusInfo: statusInfo ?? this.statusInfo,
        amberGold: amberGold ?? this.amberGold,
      );

  @override
  ZenoSemanticColors lerp(ThemeExtension<ZenoSemanticColors>? other, double t) {
    if (other is! ZenoSemanticColors) return this;
    return ZenoSemanticColors(
      bgTier1: Color.lerp(bgTier1, other.bgTier1, t)!,
      bgTier2: Color.lerp(bgTier2, other.bgTier2, t)!,
      bgTier3: Color.lerp(bgTier3, other.bgTier3, t)!,
      bgTier4: Color.lerp(bgTier4, other.bgTier4, t)!,
      bgSurface: Color.lerp(bgSurface, other.bgSurface, t)!,
      bgHover: Color.lerp(bgHover, other.bgHover, t)!,
      borderSubtle: Color.lerp(borderSubtle, other.borderSubtle, t)!,
      textPrimary: Color.lerp(textPrimary, other.textPrimary, t)!,
      textSecondary: Color.lerp(textSecondary, other.textSecondary, t)!,
      textDisabled: Color.lerp(textDisabled, other.textDisabled, t)!,
      accentPrimary: Color.lerp(accentPrimary, other.accentPrimary, t)!,
      accentPurple: Color.lerp(accentPurple, other.accentPurple, t)!,
      statusSuccess: Color.lerp(statusSuccess, other.statusSuccess, t)!,
      statusWarning: Color.lerp(statusWarning, other.statusWarning, t)!,
      statusDanger: Color.lerp(statusDanger, other.statusDanger, t)!,
      statusInfo: Color.lerp(statusInfo, other.statusInfo, t)!,
      amberGold: Color.lerp(amberGold, other.amberGold, t)!,
    );
  }
}
