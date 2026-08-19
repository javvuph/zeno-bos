import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/navigation/navigation_controller.dart';

class EnterpriseTopBar extends StatelessWidget {
  const EnterpriseTopBar({super.key});

  @override
  Widget build(BuildContext context) {
    final nav = NavigationController();

    return ListenableBuilder(
      listenable: nav,
      builder: (context, _) {
        return Container(
          height: 48,
          color: ZenoTheme.background,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              // SYSTEM TITLE
              const Icon(Icons.apps, color: ZenoTheme.accent, size: 24),
              const SizedBox(width: 12),
              const Flexible(
                child: Text(
                  "ZENO Business Operating System (ZBOS)",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: ZenoTheme.textPrimary,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),
              const SizedBox(width: 16),

              // NAVIGATION CONTROLS
              _TopAction(icon: Icons.arrow_back, onTap: () {}),
              _TopAction(icon: Icons.history, onTap: () {}),
              _TopAction(icon: Icons.refresh, onTap: () {}),

              const SizedBox(width: 16),

              // UNIVERSAL SEARCH
              Expanded(
                child: Center(
                  child: Container(
                    height: 32,
                    constraints: const BoxConstraints(maxWidth: 600),
                    decoration: BoxDecoration(
                      color: ZenoTheme.surface,
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(color: ZenoTheme.border),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: const Row(
                      children: [
                        Icon(Icons.search,
                            size: 16, color: ZenoTheme.textSecondary),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            "Search (Ctrl+K)",
                            style: TextStyle(
                                color: ZenoTheme.textSecondary, fontSize: 13),
                          ),
                        ),
                        _SearchKbdHint(),
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(width: 16),

              // TOOLS
              _TopAction(
                icon: Icons.auto_awesome,
                color: ZenoTheme.primary,
                label: "AI Assistant",
                onTap: () {},
              ),
              const SizedBox(width: 8),
              _TopAction(
                icon: Icons.notifications_none,
                badge: "8",
                onTap: () {},
              ),
              const SizedBox(width: 8),
              _TopAction(icon: Icons.help_outline, onTap: () {}),
              const SizedBox(width: 8),
              _TopAction(icon: Icons.settings_outlined, onTap: () {}),

              const SizedBox(width: 16),

              // PROFILE
              InkWell(
                onTap: () {},
                child: const Row(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          "John Perera",
                          style: TextStyle(
                              fontSize: 13, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "Administrator",
                          style: TextStyle(
                              fontSize: 11, color: ZenoTheme.textSecondary),
                        ),
                      ],
                    ),
                    SizedBox(width: 12),
                    CircleAvatar(
                      radius: 16,
                      backgroundColor: ZenoTheme.background,
                      child: Icon(Icons.person,
                          size: 20, color: ZenoTheme.primary),
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 16),

              // WINDOW CONTROLS
              const _WindowControl(icon: Icons.minimize),
              const _WindowControl(icon: Icons.crop_square),
              const _WindowControl(icon: Icons.close, isClose: true),
            ],
          ),
        );
      },
    );
  }
}

class _SearchKbdHint extends StatelessWidget {
  const _SearchKbdHint();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
      decoration: BoxDecoration(
        color: ZenoTheme.surface,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: ZenoTheme.border),
      ),
      child: const Text("⌘K",
          style: TextStyle(fontSize: 10, color: ZenoTheme.textSecondary)),
    );
  }
}

class _TopAction extends StatelessWidget {
  final IconData icon;
  final String? label;
  final String? badge;
  final Color? color;
  final VoidCallback onTap;

  const _TopAction({
    required this.icon,
    this.label,
    this.badge,
    this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: Row(
          children: [
            Stack(
              alignment: Alignment.topRight,
              children: [
                Icon(icon, size: 20, color: color ?? ZenoTheme.textSecondary),
                if (badge != null)
                  Container(
                    padding: const EdgeInsets.all(2),
                    decoration: const BoxDecoration(
                        color: ZenoTheme.danger, shape: BoxShape.circle),
                    constraints:
                        const BoxConstraints(minWidth: 14, minHeight: 14),
                    child: Text(
                      badge!,
                      style: const TextStyle(
                          fontSize: 8,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
              ],
            ),
            if (label != null) ...[
              const SizedBox(width: 8),
              Text(
                label!,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: color ?? ZenoTheme.textPrimary,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _WindowControl extends StatelessWidget {
  final IconData icon;
  final bool isClose;

  const _WindowControl({required this.icon, this.isClose = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 48,
      alignment: Alignment.center,
      child: Icon(
        icon,
        size: 16,
        color: isClose
            ? ZenoTheme.danger.withValues(alpha: 0.7)
            : ZenoTheme.textSecondary,
      ),
    );
  }
}
