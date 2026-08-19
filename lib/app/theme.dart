import 'package:flutter/material.dart';

class ZenoTheme {
  static TextTheme _safeInterTextTheme([TextTheme? base]) {
    return base ?? ThemeData.light().textTheme;
  }

  // --- PRIMITIVE PALETTE (Core Values) ---
  static const Color obsidian900 = Color(0xFF0A0A0F);
  static const Color obsidian800 = Color(0xFF131722);
  static const Color obsidian700 = Color(0xFF1B1E2B);
  static const Color slate500 = Color(0xFF5A6275);
  static const Color slate400 = Color(0xFF8A92A6);
  static const Color slate300 = Color(0xFFCBD5E1);
  static const Color cyan500 = Color(0xFF00F0FF);
  static const Color violet500 = Color(0xFF8B5CF6);
  static const Color magenta500 = Color(0xFFEC4899);
  static const Color green500 = Color(0xFF00FF88);
  static const Color amber500 = Color(0xFFFFB800);
  static const Color ruby500 = Color(0xFFFF4D4D);

  static const Color indigo500 = Color(0xFF6366F1); // ZDL standard indigo
  static const Color indigo600 = Color(0xFF4F46E5);

  // --- GRADIENTS ---
  static const LinearGradient aiGlowGradient = LinearGradient(
    colors: [cyan500, violet500],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient aiVioletGradient = LinearGradient(
    colors: [violet500, magenta500],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static ThemeData darkTheme() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      primaryColor: cyan500,
      scaffoldBackgroundColor: obsidian900,
      cardColor: obsidian700,
      dividerColor: const Color(0xFF1B1E2B).withValues(alpha: 0.5),
      extensions: const [
        ZenoSemanticColors(
          bgTier1: obsidian900,
          bgTier2: obsidian800,
          bgTier3: obsidian700,
          bgTier4: Color(0xFF0D0F17),
          bgSurface: obsidian700,
          bgHover: Color(0xFF242838),
          borderSubtle: Color(0xFF2A2E3D),
          textPrimary: Colors.white,
          textSecondary: slate400,
          textDisabled: slate500,
          accentPrimary: cyan500,
          accentPurple: violet500,
          statusSuccess: green500,
          statusWarning: amber500,
          statusDanger: ruby500,
          statusInfo: cyan500,
          amberGold: amber500,
        ),
      ],
      textTheme: _safeInterTextTheme().apply(
        bodyColor: Colors.white,
        displayColor: Colors.white,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: obsidian900,
        elevation: 0,
      ),
      colorScheme: const ColorScheme.dark(
        primary: cyan500,
        secondary: violet500,
        surface: obsidian700,
        onSurface: Colors.white,
        outline: Color(0xFF2A2E3D),
      ),
    );
  }

  static ThemeData lightTheme() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      primaryColor: indigo500,
      scaffoldBackgroundColor: Colors.white,
      cardColor: const Color(0xFFF8FAFC),
      dividerColor: const Color(0xFFE2E8F0),
      extensions: const [
        ZenoSemanticColors(
          bgTier1: Colors.white,
          bgTier2: Color(0xFFF8FAFC),
          bgTier3: Color(0xFFF1F5F9),
          bgTier4: Color(0xFFF1F5F9),
          bgSurface: Colors.white,
          bgHover: Color(0xFFE2E8F0),
          borderSubtle: Color(0xFFE2E8F0),
          textPrimary: Color(0xFF1E293B), // Slate-Dark for eye comfort
          textSecondary: Color(0xFF475569),
          textDisabled: Color(0xFF94A3B8),
          accentPrimary: indigo500,
          accentPurple: Color(0xFF7C3AED),
          statusSuccess: Color(0xFF16A34A),
          statusWarning: Color(0xFFD97706),
          statusDanger: Color(0xFFDC2626),
          statusInfo: Color(0xFF0284C7),
          amberGold: Color(0xFFD97706),
        ),
      ],
      textTheme: _safeInterTextTheme().apply(
        bodyColor: const Color(0xFF1E293B),
        displayColor: const Color(0xFF1E293B),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      colorScheme: const ColorScheme.light(
        primary: indigo500,
        secondary: Color(0xFF7C3AED),
        surface: Colors.white,
        onSurface: Color(0xFF1E293B),
        outline: Color(0xFFE2E8F0),
      ),
    );
  }

  // --- LEGACY MAPPING ---
  static const Color background = obsidian900;
  static const Color primary = indigo500;
  static const Color accent = cyan500;
  static const Color textPrimary = Colors.white;
  static const Color textSecondary = slate400;
  static const Color border = Color(0xFF2A2E3D);
  static const Color surface = obsidian700;
  static const Color success = green500;
  static const Color danger = ruby500;
  static const Color warning = amber500;
  static const Color neonGreen = green500;
  static const Color neonCyan = cyan500;
  static const Color workspaceBackground = obsidian900;
  static const Color card = obsidian700;
  static const Color navigationBackground = obsidian800;

  static const Color darkTextPrimary = Colors.white;
  static const Color darkBgCanvas = obsidian900;
}

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

class ZenoSpacing {
  static const double xs = 4.0;
  static const double sm = 8.0;
  static const double md = 16.0;
  static const double lg = 24.0;
  static const double xl = 32.0;
  static const double xxl = 48.0;
}

class ZenoRadius {
  static const double sm = 4.0;
  static const double md = 8.0;
  static const double lg = 12.0;
  static const double xl = 16.0;
  static const double full = 999.0;
}

class ZenoBorderWidth {
  static const double none = 0.0;
  static const double hairline = 0.5;
  static const double thin = 1.0;
  static const double thick = 1.5;
  static const double heavy = 2.0;
}

class ZenoDuration {
  static const Duration fast = Duration(milliseconds: 150);
  static const Duration std = Duration(milliseconds: 250);
  static const Duration slow = Duration(milliseconds: 400);
}

class ZenoMotion {
  static const Curve entrance = Curves.easeOutQuart;
  static const Curve exit = Curves.easeInQuart;
  static const Curve standard = Curves.easeInOutCubic;
}

class ZenoSizing {
  static const double iconSM = 14.0;
  static const double iconMD = 18.0;
  static const double iconLG = 24.0;

  static const double rowTactical = 46.0;
  static const double toolbarHeight = 48.0;
  static const double headerHeight = 64.0;
  static const double statusBarHeight = 28.0;
  static const double actionRailWidth = 125.0;
  static const double inspectorWidth = 380.0;
}

class ZenoElevation {
  static const double none = 0.0;
  static const List<BoxShadow> soft = [
    BoxShadow(color: Color(0x0D000000), blurRadius: 12, offset: Offset(0, 4)),
  ];
  static const List<BoxShadow> heavy = [
    BoxShadow(color: Color(0x1A000000), blurRadius: 24, offset: Offset(0, 8)),
  ];
}

class ZenoZIndex {
  static const int base = 0;
  static const int sidebar = 100;
  static const int header = 200;
  static const int modal = 1000;
  static const int toast = 2000;
}

class ZenoTypography {
  static const String primaryFamily = 'Inter';
  static const String monoFamily = 'monospace';

  static TextStyle displayXL(Color color) => TextStyle(
      fontFamily: primaryFamily,
      fontSize: 42,
      fontWeight: FontWeight.w500,
      color: color,
      letterSpacing: -1.0);
  static TextStyle displayLG(Color color) => TextStyle(
      fontFamily: primaryFamily,
      fontSize: 32,
      fontWeight: FontWeight.w500,
      color: color,
      letterSpacing: -0.5);
  static TextStyle headlineMD(Color color) => TextStyle(
      fontFamily: primaryFamily,
      fontSize: 18,
      fontWeight: FontWeight.w700,
      color: color);
  static TextStyle headlineSM(Color color) => TextStyle(
      fontFamily: primaryFamily,
      fontSize: 16,
      fontWeight: FontWeight.w700,
      color: color);
  static TextStyle bodyLG(Color color) => TextStyle(
      fontFamily: primaryFamily,
      fontSize: 14,
      fontWeight: FontWeight.w500,
      color: color);
  static TextStyle bodyMD(Color color) => TextStyle(
      fontFamily: primaryFamily,
      fontSize: 12,
      fontWeight: FontWeight.w400,
      color: color);
  static TextStyle caption(Color color) => TextStyle(
      fontFamily: primaryFamily,
      fontSize: 10,
      fontWeight: FontWeight.w600,
      color: color,
      letterSpacing: 0.5);
  static TextStyle micro(Color color) => TextStyle(
      fontFamily: primaryFamily,
      fontSize: 8,
      fontWeight: FontWeight.w700,
      color: color,
      letterSpacing: 1.0);
}
