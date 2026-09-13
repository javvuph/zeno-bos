import 'package:flutter/material.dart';
import 'package:zeno/core/controllers/zeno_window_controller.dart';
import 'package:zeno/core/models/zeno_window_models.dart';
import 'package:zeno/core/widgets/zeno_window_shell.dart';

class ZenoWindowLayer extends StatelessWidget {
  const ZenoWindowLayer({super.key});

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: ZenoWindowController(),
      builder: (context, _) {
        final windowController = ZenoWindowController();
        final activeWindows = windowController.activeWindows;

        if (activeWindows.isEmpty) return const SizedBox.shrink();

        final screenHeight = MediaQuery.of(context).size.height;
        final screenWidth = MediaQuery.of(context).size.width;

        return Stack(
          children: activeWindows.map((win) {
            final bool isMinimized = win.status == ZenoWindowStatus.minimized;

            // Calculate explicit dimensions for AnimatedPositioned
            // If minimized, shrink to 0 to avoid blocking hits
            final double width = isMinimized
                ? 0
                : (win.isMaximized ? screenWidth : win.size.width);
            final double height = isMinimized
                ? 0
                : (win.isMaximized ? screenHeight : win.size.height);
            final double left = win.isMaximized ? 0 : win.position.dx;
            final double top = win.isMaximized ? 0 : win.position.dy;

            return AnimatedPositioned(
              key: ValueKey(win.id),
              duration: win.isDragging
                  ? Duration.zero
                  : const Duration(milliseconds: 200),
              curve: Curves.easeOutCubic,
              left: left,
              top: top,
              width: width,
              height: height,
              child: ZenoWindowShell(window: win),
            );
          }).toList(),
        );
      },
    );
  }
}
