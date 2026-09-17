import 'package:flutter/material.dart';
import 'theme_colors.dart';

export 'theme_colors.dart';
export 'theme_tokens.dart';

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

  static const Color indigo500 = Color(0xFF6366F1);
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
          textPrimary: Color(0xFF1E293B),
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
