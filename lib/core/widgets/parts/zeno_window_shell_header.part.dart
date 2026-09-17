part of '../zeno_window_shell.dart';

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
          color: colors.accentPrimary,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(window.isMaximized ? 0 : 10),
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
