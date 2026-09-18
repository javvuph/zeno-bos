import 'package:flutter/material.dart';
import 'theme_colors.dart';

export 'theme_colors.dart';
export 'theme_tokens.dart';

class ZenoTheme {
  static TextTheme _safeInterTextTheme([TextTheme? base]) {
    return base ?? ThemeData.light().textTheme;
  }

  // --- ZENO AURORA GLASS MASTER PALETTE ---
  static const Color obsidian900 = Color(0xFF0A0A0F);
  static const Color obsidian800 = Color(0xFF131722);
  static const Color obsidian700 = Color(0xFF1B1E2B);
  static const Color slate500 = Color(0xFF5A6275);
  static const Color slate400 = Color(0xFF8A92A6);
  static const Color slate300 = Color(0xFFCBD5E1);

  static const Color cyan500 = Color(0xFF06B6D4);
  static const Color violet500 = Color(0xFF8B5CF6);
  static const Color magenta500 = Color(0xFFEC4899);
  static const Color green500 = Color(0xFF16A34A);
  static const Color amber500 = Color(0xFFD97706);
  static const Color ruby500 = Color(0xFFDC2626);

  static const Color indigo500 = Color(0xFF6366F1);
  static const Color indigo600 = Color(0xFF4F46E5);
  static const Color auroraLightBackground = Color(0xFFF3F6FF);
  static const Color auroraLightSurface = Color(0xFFFFFFFF);
  static const Color auroraLightSecondary = Color(0xFFF8FAFC);
  static const Color auroraLightNested = Color(0xFFF1F4FB);
  static const Color auroraLightBorder = Color(0xFFD9DFF2);
  static const Color auroraLightText = Color(0xFF26324A);
  static const Color auroraLightSecondaryText = Color(0xFF526078);

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
      scaffoldBackgroundColor: auroraLightBackground,
      cardColor: auroraLightSurface,
      dividerColor: auroraLightBorder,
      extensions: const [
        ZenoSemanticColors(
          bgTier1: auroraLightBackground,
          bgTier2: auroraLightSecondary,
          bgTier3: auroraLightNested,
          bgTier4: Color(0xFFEDF1FA),
          bgSurface: auroraLightSurface,
          bgHover: Color(0xFFE8ECF8),
          borderSubtle: auroraLightBorder,
          textPrimary: auroraLightText,
          textSecondary: auroraLightSecondaryText,
          textDisabled: Color(0xFF98A3B8),
          accentPrimary: indigo500,
          accentPurple: Color(0xFF7C3AED),
          statusSuccess: green500,
          statusWarning: amber500,
          statusDanger: ruby500,
          statusInfo: Color(0xFF0284C7),
          amberGold: amber500,
        ),
      ],
      textTheme: _safeInterTextTheme().apply(
        bodyColor: auroraLightText,
        displayColor: auroraLightText,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      colorScheme: const ColorScheme.light(
        primary: indigo500,
        secondary: Color(0xFF7C3AED),
        surface: auroraLightSurface,
        onSurface: auroraLightText,
        outline: auroraLightBorder,
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
