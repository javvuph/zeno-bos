import 'dart:async';
import 'package:flutter/material.dart';
import 'package:zeno/navigation/menu_registry.dart';
import 'package:zeno/navigation/widgets/zeno_mega_menu.dart';

class ZenoMegaMenuOverlay extends StatefulWidget {
  final ValueChanged<ZenoMenuCategory?> onCategoryChanged;

  const ZenoMegaMenuOverlay({
    super.key,
    required this.onCategoryChanged,
  });

  @override
  State<ZenoMegaMenuOverlay> createState() => ZenoMegaMenuOverlayState();
}

class ZenoMegaMenuOverlayState extends State<ZenoMegaMenuOverlay> {
  ZenoMenuCategory? _activeCategory;
  Offset? _activeOffset;
  Timer? _hideTimer;

  void showMenu(ZenoMenuCategory? category, Offset? offset) {
    _hideTimer?.cancel();
    if (category == null) {
      hideMenu();
      return;
    }

    // Defer state update to avoid MouseTracker assertions
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        if (_activeCategory?.id == category.id) return;
        setState(() {
          _activeCategory = category;
          _activeOffset = offset;
        });
        widget.onCategoryChanged(_activeCategory);
      }
    });
  }

  void hideMenu() {
    _hideTimer?.cancel();
    _hideTimer = Timer(const Duration(milliseconds: 150), () {
      if (mounted) {
        setState(() {
          _activeCategory = null;
        });
        widget.onCategoryChanged(null);
      }
    });
  }

  void cancelHide() {
    _hideTimer?.cancel();
  }

  @override
  void dispose() {
    _hideTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_activeCategory == null || _activeOffset == null) {
      return const SizedBox.shrink();
    }

    const double menuWidth = 260;
    final screenHeight = MediaQuery.of(context).size.height;

    // Position relative to Vertical Rail
    double leftPos = 64; // Fixed rail width
    double topPos = _activeOffset!.dy;

    // Boundary check: ensure menu doesn't overflow bottom
    const double menuHeight = 420;
    if (topPos + menuHeight > screenHeight) {
      topPos = screenHeight - menuHeight - 16;
    }
    // ensure it doesn't go above top command bar (48px)
    if (topPos < 48) topPos = 48;

    return Positioned(
      top: topPos,
      left: leftPos + 4, // 4px gap for transition
      child: MouseRegion(
        onEnter: (_) => cancelHide(),
        onExit: (_) => hideMenu(),
        child: Material(
          type: MaterialType.transparency,
          child: SizedBox(
            width: menuWidth,
            height: menuHeight,
            child: ZenoMegaMenu(
              category: _activeCategory!,
              onEnter: cancelHide,
              onExit: hideMenu,
              onAction: () {
                setState(() => _activeCategory = null);
                widget.onCategoryChanged(null);
              },
            ),
          ),
        ),
      ),
    );
  }
}
