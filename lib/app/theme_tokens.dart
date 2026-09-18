import 'package:flutter/material.dart';

class ZenoSpacing {
  static const double xs = 4.0;
  static const double sm = 8.0;
  static const double md = 16.0;
  static const double lg = 24.0;
  static const double xl = 32.0;
  static const double xxl = 48.0;
}

class ZenoRadius {
  static const double xs = 2.0;
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

  static const double rowDense = 40.0;
  static const double rowTactical = 44.0;
  static const double toolbarHeight = 40.0;
  static const double headerHeight = 64.0;
  static const double statusBarHeight = 28.0;
  static const double actionRailWidth = 125.0;
  static const double inspectorWidth = 380.0;
}

class ZenoGlass {
  static const double lightOpacity = 0.72;
  static const double lightStrongOpacity = 0.82;
  static const double darkOpacity = 0.72;
  static const double blur = 20.0;
  static const double borderOpacity = 0.18;
  static const double selectedOpacity = 0.10;
}

class ZenoElevation {
  static const double none = 0.0;
  static const List<BoxShadow> soft = [
    BoxShadow(color: Color(0x16000000), blurRadius: 16, offset: Offset(0, 5)),
  ];
  static const List<BoxShadow> heavy = [
    BoxShadow(color: Color(0x22000000), blurRadius: 28, offset: Offset(0, 10)),
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
