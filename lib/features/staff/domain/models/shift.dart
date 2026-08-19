import 'package:flutter/material.dart';

class Shift {
  final String id;
  final String name;
  final TimeOfDay startTime;
  final TimeOfDay endTime;
  final int graceMinutes;

  const Shift({
    required this.id,
    required this.name,
    required this.startTime,
    required this.endTime,
    this.graceMinutes = 15,
  });
}
