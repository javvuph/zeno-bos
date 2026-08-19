import 'package:flutter/material.dart';

enum ZenoWindowStatus { open, minimized, closed }

class ZenoWindow {
  final String id;
  final String title;
  final Widget content;
  final IconData icon;
  Offset position;
  Size size;
  bool isMaximized;
  bool isDragging;
  ZenoWindowStatus status;
  int zIndex;

  ZenoWindow({
    required this.id,
    required this.title,
    required this.content,
    required this.icon,
    this.position = const Offset(100, 100),
    this.size = const Size(880, 600),
    this.isMaximized = false,
    this.isDragging = false,
    this.status = ZenoWindowStatus.open,
    this.zIndex = 0,
  });

  ZenoWindow copyWith({
    String? title,
    Widget? content,
    IconData? icon,
    Offset? position,
    Size? size,
    bool? isMaximized,
    bool? isDragging,
    ZenoWindowStatus? status,
    int? zIndex,
  }) {
    return ZenoWindow(
      id: id,
      title: title ?? this.title,
      content: content ?? this.content,
      icon: icon ?? this.icon,
      position: position ?? this.position,
      size: size ?? this.size,
      isMaximized: isMaximized ?? this.isMaximized,
      isDragging: isDragging ?? this.isDragging,
      status: status ?? this.status,
      zIndex: zIndex ?? this.zIndex,
    );
  }
}
