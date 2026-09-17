import 'package:flutter/material.dart';

class ZenoMenuItem {
  final String label;
  final String? description;
  final IconData icon;
  final String? route;
  final bool isAI;
  final Color? color;

  const ZenoMenuItem({
    required this.label,
    this.description,
    required this.icon,
    this.route,
    this.isAI = false,
    this.color,
  });
}

class ZenoMenuColumn {
  final String title;
  final List<ZenoMenuItem> items;
  final Color? color;

  const ZenoMenuColumn({
    required this.title,
    required this.items,
    this.color,
  });
}

class ZenoMenuCategory {
  final String id;
  final String label;
  final IconData icon;
  final Color color;
  final List<ZenoMenuColumn> columns;
  final bool hasDropdown;

  const ZenoMenuCategory({
    required this.id,
    required this.label,
    required this.icon,
    required this.color,
    required this.columns,
    this.hasDropdown = true,
  });
}
