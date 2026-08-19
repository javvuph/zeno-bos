import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/core/models/zeno_window_models.dart';
import 'package:zeno/core/controllers/zeno_window_controller.dart';

class ZenoWindowShell extends StatefulWidget {
  final ZenoWindow window;

  const ZenoWindowShell({super.key, required this.window});

  @override
  State<ZenoWindowShell> createState() => _ZenoWindowShellState();
}

class _ZenoWindowShellState extends State<ZenoWindowShell> {
  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<ZenoSemanticColors>()!;
    final controller = ZenoWindowController();

    if (widget.window.status == ZenoWindowStatus.minimized) {
      return const SizedBox.shrink();
    }

    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    final double width =
        widget.window.isMaximized ? screenWidth : widget.window.size.width;
    final double height =
        widget.window.isMaximized ? screenHeight : widget.window.size.height;

    return SizedBox(
      width: width,
      height: height,
      child: GestureDetector(
        onTapDown: (_) => controller.focusWindow(widget.window.id),
        child: Stack(
          fit: StackFit.expand,
          clipBehavior: Clip.none,
          children: [
            // 1. External Shadow Layer
            if (!widget.window.isMaximized)
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.5),
                        blurRadius: 40,
                        offset: const Offset(0, 15),
                      ),
                    ],
                  ),
                ),
              ),

            // 2. Main Content & Background Layer
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  color: colors.bgTier1,
                  borderRadius:
                      BorderRadius.circular(widget.window.isMaximized ? 0 : 12),
                ),
                clipBehavior: Clip.antiAlias,
                child: _buildWindowContent(colors),
              ),
            ),

            // 3. THE BORDER LAYER (Fixed on top of everything, including content)
            Positioned.fill(
              child: IgnorePointer(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                        widget.window.isMaximized ? 0 : 12),
                    border: Border.all(
                      color: colors.accentPrimary,
                      width: 2.5, // Definitive solid border
                    ),
                  ),
                ),
              ),
            ),

            // 4. RESIZE HANDLES (Interactive top-most layer)
            if (!widget.window.isMaximized) ...[
              _ResizeHandle(
                  windowId: widget.window.id,
                  top: true,
                  cursor: SystemMouseCursors.resizeUpDown),
              _ResizeHandle(
                  windowId: widget.window.id,
                  bottom: true,
                  cursor: SystemMouseCursors.resizeUpDown),
              _ResizeHandle(
                  windowId: widget.window.id,
                  left: true,
                  cursor: SystemMouseCursors.resizeLeftRight),
              _ResizeHandle(
                  windowId: widget.window.id,
                  right: true,
                  cursor: SystemMouseCursors.resizeLeftRight),
              _ResizeHandle(
                  windowId: widget.window.id,
                  top: true,
                  left: true,
                  cursor: SystemMouseCursors.resizeUpLeftDownRight,
                  isCorner: true),
              _ResizeHandle(
                  windowId: widget.window.id,
                  top: true,
                  right: true,
                  cursor: SystemMouseCursors.resizeUpRightDownLeft,
                  isCorner: true),
              _ResizeHandle(
                  windowId: widget.window.id,
                  bottom: true,
                  left: true,
                  cursor: SystemMouseCursors.resizeUpRightDownLeft,
                  isCorner: true),
              _ResizeHandle(
                  windowId: widget.window.id,
                  bottom: true,
                  right: true,
                  cursor: SystemMouseCursors.resizeUpLeftDownRight,
                  isCorner: true),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildWindowContent(ZenoSemanticColors colors) {
    return Column(
      children: [
        // DRAGGABLE HEADER
        _WindowHeader(
          window: widget.window,
          colors: colors,
        ),

        // CONTENT AREA - RepaintBoundary for performance
        Expanded(
          child: RepaintBoundary(
            child: widget.window.content,
          ),
        ),
      ],
    );
  }
}

class _WindowHeader extends StatelessWidget {
  final ZenoWindow window;
  final ZenoSemanticColors colors;

  const _WindowHeader({
    required this.window,
    required this.colors,
  });

  @override
  Widget build(BuildContext context) {
    final controller = ZenoWindowController();
    final screenSize = MediaQuery.of(context).size;

    return GestureDetector(
      onPanStart: (_) => controller.setDragging(window.id, true),
      onPanEnd: (_) => controller.setDragging(window.id, false),
      onPanUpdate: window.isMaximized
          ? null
          : (details) {
              final newPos = window.position + details.delta;
              // Permissive clamping: Allow title bar to go to the absolute top (0)
              final clampedPos = Offset(
                newPos.dx
                    .clamp(-window.size.width + 100, screenSize.width - 100),
                newPos.dy.clamp(0.0, screenSize.height - 42),
              );
              controller.updatePosition(window.id, clampedPos);
            },
      onDoubleTap: () => controller.toggleMaximize(window.id),
      child: Container(
        height: 42,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          // "Windows Blue" Header style
          color: colors.accentPrimary,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(window.isMaximized
                ? 0
                : 10), // Reduced to fit inside parent padding
          ),
          border: Border(
            bottom: BorderSide(
                color: Colors.black.withValues(alpha: 0.1), width: 1.0),
          ),
        ),
        child: Row(
          children: [
            const SizedBox(width: 12),
            Icon(window.icon,
                size: 16, color: Colors.black.withValues(alpha: 0.6)),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                window.title.toUpperCase(),
                style: const TextStyle(
                  fontSize: 10,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w900,
                  color: Colors.black,
                  letterSpacing: 0.8,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),

            // WINDOW CONTROLS BACK ON THE RIGHT
            _ControlBtn(
                icon: Icons.minimize_rounded,
                onTap: () => controller.minimizeWindow(window.id),
                colors: colors,
                iconColor: Colors.black54),
            _ControlBtn(
              icon: window.isMaximized
                  ? Icons.close_fullscreen_rounded
                  : Icons.crop_square_rounded,
              onTap: () => controller.toggleMaximize(window.id),
              colors: colors,
              size: 14,
              iconColor: Colors.black54,
            ),
            _ControlBtn(
                icon: Icons.close_rounded,
                onTap: () => controller.closeWindow(window.id),
                colors: colors,
                isClose: true,
                iconColor: Colors.black87),
          ],
        ),
      ),
    );
  }
}

class _ControlBtn extends StatefulWidget {
  final IconData icon;
  final VoidCallback onTap;
  final ZenoSemanticColors colors;
  final bool isClose;
  final double size;
  final Color? iconColor;

  const _ControlBtn({
    required this.icon,
    required this.onTap,
    required this.colors,
    this.isClose = false,
    this.size = 18,
    this.iconColor,
  });

  @override
  State<_ControlBtn> createState() => _ControlBtnState();
}

class _ResizeHandle extends StatelessWidget {
  final String windowId;
  final bool top;
  final bool bottom;
  final bool left;
  final bool right;
  final MouseCursor cursor;
  final bool isCorner;

  const _ResizeHandle({
    required this.windowId,
    this.top = false,
    this.bottom = false,
    this.left = false,
    this.right = false,
    required this.cursor,
    this.isCorner = false,
  });

  @override
  Widget build(BuildContext context) {
    final double handleSize = isCorner ? 20.0 : 8.0;

    return Positioned(
      top: top ? -handleSize / 2 : (bottom ? null : 0),
      bottom: bottom ? -handleSize / 2 : (top ? null : 0),
      left: left ? -handleSize / 2 : (right ? null : 0),
      right: right ? -handleSize / 2 : (left ? null : 0),
      width: (left || right) ? handleSize : (isCorner ? handleSize : null),
      height: (top || bottom) ? handleSize : (isCorner ? handleSize : null),
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onPanStart: (_) => ZenoWindowController().setDragging(windowId, true),
        onPanEnd: (_) => ZenoWindowController().setDragging(windowId, false),
        onPanUpdate: (details) {
          ZenoWindowController().resizeWindow(
            windowId,
            delta: details.delta,
            top: top,
            bottom: bottom,
            left: left,
            right: right,
          );
        },
        child: MouseRegion(
          cursor: cursor,
          child: Container(
            color: Colors
                .transparent, // Debug: change to Colors.red.withOpacity(0.2) to see handles
          ),
        ),
      ),
    );
  }
}

class _ControlBtnState extends State<_ControlBtn> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: InkWell(
        onTap: widget.onTap,
        child: Container(
          width: 42,
          height: 42,
          alignment: Alignment.center,
          color: _isHovered
              ? (widget.isClose
                  ? const Color(0xFFFF4D4D)
                  : Colors.black.withValues(alpha: 0.1))
              : Colors.transparent,
          child: Icon(widget.icon,
              size: widget.size,
              color: _isHovered
                  ? Colors.white
                  : (widget.iconColor ??
                      widget.colors.textPrimary.withValues(alpha: 0.7))),
        ),
      ),
    );
  }
}
