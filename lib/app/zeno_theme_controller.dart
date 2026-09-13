import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';

enum ZenoThemeMode {
  dark,
  light,
  system,
  highContrast,
}

class ZenoThemeController extends ChangeNotifier {
  static final ZenoThemeController _instance = ZenoThemeController._internal();
  factory ZenoThemeController() => _instance;
  ZenoThemeController._internal();

  Color _accentColor = const Color(0xFF0066FF);
  ZenoThemeMode _themeMode = ZenoThemeMode.light;
  double _fontScale = 1.0;

  Color get accentColor => _accentColor;
  ZenoThemeMode get themeMode => _themeMode;
  double get fontScale => _fontScale;

  void setAccentColor(Color color) {
    _accentColor = color;
    notifyListeners();
  }

  void setThemeMode(ZenoThemeMode mode) {
    _themeMode = mode;
    notifyListeners();
  }

  void cycleTheme() {
    switch (_themeMode) {
      case ZenoThemeMode.dark:
        setThemeMode(ZenoThemeMode.light);
        break;
      case ZenoThemeMode.light:
        setThemeMode(ZenoThemeMode.system);
        break;
      case ZenoThemeMode.system:
        setThemeMode(ZenoThemeMode.dark);
        break;
      default:
        setThemeMode(ZenoThemeMode.dark);
    }
  }

  void setFontScale(double scale) {
    _fontScale = scale;
    notifyListeners();
  }

  ThemeData get currentTheme {
    if (_themeMode == ZenoThemeMode.light) {
      return ZenoTheme.lightTheme();
    }

    if (_themeMode == ZenoThemeMode.system) {
      // Note: In a real app, you'd use WidgetsBinding.instance.platformDispatcher.platformBrightness
      // For this implementation, we'll return a special value or let MaterialApp handle it if we use themeMode: ThemeMode.system
      // However, the current structure uses currentTheme getter.
      return ZenoTheme.darkTheme();
    }

    final isHighContrast = _themeMode == ZenoThemeMode.highContrast;

    // Default to Dark Theme
    final baseTheme = ZenoTheme.darkTheme();
    if (!isHighContrast && _fontScale == 1.0) return baseTheme;

    final baseTextTheme = baseTheme.textTheme;

    return baseTheme.copyWith(
      textTheme: baseTextTheme.apply(
        bodyColor: isHighContrast ? Colors.white : ZenoTheme.darkTextPrimary,
        displayColor: isHighContrast ? Colors.white : ZenoTheme.darkTextPrimary,
        fontSizeFactor: _fontScale,
      ),
      scaffoldBackgroundColor:
          isHighContrast ? Colors.black : ZenoTheme.darkBgCanvas,
    );
  }
}
