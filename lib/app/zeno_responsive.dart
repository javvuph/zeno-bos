import 'package:flutter/material.dart';

enum ZenoDeviceType { mobile, tablet, desktop, large }

class ZenoResponsive {
  static ZenoDeviceType getDeviceType(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    if (width < 640) return ZenoDeviceType.mobile;
    if (width < 1024) return ZenoDeviceType.tablet;
    if (width < 1440) return ZenoDeviceType.desktop;
    return ZenoDeviceType.large;
  }

  static bool isMobile(BuildContext context) =>
      getDeviceType(context) == ZenoDeviceType.mobile;
  static bool isTablet(BuildContext context) =>
      getDeviceType(context) == ZenoDeviceType.tablet;
  static bool isDesktop(BuildContext context) =>
      getDeviceType(context) == ZenoDeviceType.desktop;
  static bool isLarge(BuildContext context) =>
      getDeviceType(context) == ZenoDeviceType.large;

  // TACTICAL GRID HELPERS
  static int getGridColumnCount(BuildContext context) {
    ZenoDeviceType type = getDeviceType(context);
    switch (type) {
      case ZenoDeviceType.mobile:
        return 2;
      case ZenoDeviceType.tablet:
        return 4;
      case ZenoDeviceType.desktop:
        return 6;
      case ZenoDeviceType.large:
        return 8;
    }
  }

  static double getCardWidth(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    ZenoDeviceType type = getDeviceType(context);
    if (type == ZenoDeviceType.mobile) return screenWidth - 32;
    if (type == ZenoDeviceType.tablet) return (screenWidth - 48) / 2;
    return 300; // Standard tactical card width
  }
}
