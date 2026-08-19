import 'package:flutter/material.dart';

class DashboardKPI {
  final String id;
  final String label;
  final String value;
  final double change;
  final IconData icon;
  final Color color;

  const DashboardKPI({
    required this.id,
    required this.label,
    required this.value,
    required this.change,
    required this.icon,
    required this.color,
  });

  bool get isPositive => change >= 0;
}
