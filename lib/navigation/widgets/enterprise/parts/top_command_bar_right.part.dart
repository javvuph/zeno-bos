part of '../top_command_bar.dart';

class _LiveStatusWidget extends StatefulWidget {
  const _LiveStatusWidget();

  @override
  State<_LiveStatusWidget> createState() => _LiveStatusWidgetState();
}

class _LiveStatusWidgetState extends State<_LiveStatusWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<ZenoSemanticColors>()!;

    return Tooltip(
      message: "WebSocket Connected: Real-time sync active",
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          FadeTransition(
            opacity: Tween(begin: 0.4, end: 1.0).animate(_pulseController),
            child: Container(
              width: 6,
              height: 6,
              decoration: BoxDecoration(
                color: colors.statusSuccess,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: colors.statusSuccess.withValues(alpha: 0.6),
                    blurRadius: 4,
                    spreadRadius: 1,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 6),
          const Text(
            "LIVE",
            style: TextStyle(
              fontSize: 10,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w700,
              color: Color(0xFFA0A7B8),
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );
  }
}

class _ShortcutsButton extends StatefulWidget {
  const _ShortcutsButton();

  @override
  State<_ShortcutsButton> createState() => _ShortcutsButtonState();
}

class _ShortcutsButtonState extends State<_ShortcutsButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<ZenoSemanticColors>()!;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(4),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
          decoration: BoxDecoration(
            color: _isHovered ? colors.bgHover : Colors.transparent,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Icon(Icons.keyboard_outlined,
              size: 18, color: colors.textSecondary),
        ),
      ),
    );
  }
}

class _LocalizationSelector extends StatelessWidget {
  const _LocalizationSelector();

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<ZenoSemanticColors>()!;
    return InkWell(
      onTap: () {},
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: colors.bgTier2,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: colors.borderSubtle),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.language_rounded, size: 14, color: colors.textPrimary),
            const SizedBox(width: 8),
            Text(
              "EN / USD",
              style: TextStyle(
                color: colors.textPrimary,
                fontSize: 12,
                fontWeight: FontWeight.w500,
                fontFamily: 'Inter',
              ),
            ),
            const SizedBox(width: 4),
            Icon(Icons.keyboard_arrow_down_rounded,
                size: 14, color: colors.textSecondary),
          ],
        ),
      ),
    );
  }
}

class _ThemeModeSelector extends StatelessWidget {
  const _ThemeModeSelector();

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<ZenoSemanticColors>()!;
    final controller = ZenoThemeController();

    IconData getIcon() {
      switch (controller.themeMode) {
        case ZenoThemeMode.light:
          return Icons.wb_sunny_outlined;
        case ZenoThemeMode.dark:
          return Icons.nightlight_round_outlined;
        case ZenoThemeMode.system:
          return Icons.settings_brightness_outlined;
        default:
          return Icons.nightlight_round_outlined;
      }
    }

    String getLabel() {
      switch (controller.themeMode) {
        case ZenoThemeMode.light:
          return "Light";
        case ZenoThemeMode.dark:
          return "Dark";
        case ZenoThemeMode.system:
          return "System";
        default:
          return "Dark";
      }
    }

    return PopupMenuButton<ZenoThemeMode>(
      onSelected: (mode) => controller.setThemeMode(mode),
      offset: const Offset(0, 40),
      color: colors.bgSurface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(color: colors.borderSubtle),
      ),
      itemBuilder: (context) => [
        _buildThemeItem(
            ZenoThemeMode.light, "Light Mode", Icons.wb_sunny_outlined, colors),
        _buildThemeItem(ZenoThemeMode.dark, "Dark Mode",
            Icons.nightlight_round_outlined, colors),
        _buildThemeItem(ZenoThemeMode.system, "System Sync",
            Icons.settings_brightness_outlined, colors),
      ],
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: colors.bgTier2,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: colors.borderSubtle),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(getIcon(), size: 14, color: colors.textPrimary),
            const SizedBox(width: 8),
            Text(
              getLabel(),
              style: TextStyle(
                color: colors.textPrimary,
                fontSize: 12,
                fontWeight: FontWeight.w500,
                fontFamily: 'Inter',
              ),
            ),
            const SizedBox(width: 4),
            Icon(Icons.keyboard_arrow_down_rounded,
                size: 14, color: colors.textSecondary),
          ],
        ),
      ),
    );
  }

  PopupMenuItem<ZenoThemeMode> _buildThemeItem(ZenoThemeMode mode, String label,
      IconData icon, ZenoSemanticColors colors) {
    return PopupMenuItem(
      value: mode,
      child: Row(
        children: [
          Icon(icon, size: 16, color: colors.textPrimary),
          const SizedBox(width: 12),
          Text(
            label,
            style: TextStyle(
                color: colors.textPrimary, fontSize: 13, fontFamily: 'Inter'),
          ),
        ],
      ),
    );
  }
}

class _AIAssistantTrigger extends StatelessWidget {
  const _AIAssistantTrigger();

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<ZenoSemanticColors>()!;
    return InkWell(
      onTap: () => NavigationController().navigateTo('ai/home'),
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: colors.accentPurple, width: 1.5),
          boxShadow: [
            BoxShadow(
                color: colors.accentPurple.withValues(alpha: 0.3),
                blurRadius: 8),
          ],
        ),
        child: ShaderMask(
          shaderCallback: (bounds) =>
              ZenoTheme.aiVioletGradient.createShader(bounds),
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.auto_awesome, size: 14, color: Colors.white),
              SizedBox(width: 8),
              Text(
                "AI Copilot",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Inter',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
