import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/app/zeno_theme_controller.dart';
import 'package:zeno/navigation/navigation_controller.dart';

class TopCommandBar extends StatefulWidget {
  const TopCommandBar({super.key});

  @override
  State<TopCommandBar> createState() => _TopCommandBarState();
}

class _TopCommandBarState extends State<TopCommandBar> {
  final FocusNode _searchFocusNode = FocusNode();

  @override
  void dispose() {
    _searchFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<ZenoSemanticColors>()!;

    return CallbackShortcuts(
      bindings: {
        const SingleActivator(LogicalKeyboardKey.keyK, control: true): () =>
            _searchFocusNode.requestFocus(),
        const SingleActivator(LogicalKeyboardKey.keyK, meta: true): () =>
            _searchFocusNode.requestFocus(),
        const SingleActivator(LogicalKeyboardKey.keyT,
            control: true,
            shift: true): () => ZenoThemeController().cycleTheme(),
        const SingleActivator(LogicalKeyboardKey.space, control: true): () =>
            NavigationController().toggleSidePanel(),
        const SingleActivator(LogicalKeyboardKey.arrowLeft, alt: true): () =>
            debugPrint("History Back"),
        const SingleActivator(LogicalKeyboardKey.arrowRight, alt: true): () =>
            debugPrint("History Forward"),
        const SingleActivator(LogicalKeyboardKey.slash, shift: true): () =>
            debugPrint("Opening Shortcuts Modal via ?"),
      },
      child: Container(
        height: 48,
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: colors.bgTier1.withValues(alpha: 0.95),
          border: Border(
            bottom: BorderSide(color: colors.borderSubtle),
          ),
        ),
        child: Row(
          children: [
            const _AppLauncherGrid(),
            const SizedBox(width: 12),
            const _BrandTitle(),
            const SizedBox(width: 12),
            const _VerticalDivider(),
            const SizedBox(width: 12),
            const _BranchSelector(),

            const Spacer(),
            _OmniSearchVessel(focusNode: _searchFocusNode),
            const Spacer(),

            const _LiveStatusWidget(),
            const SizedBox(width: 16),
            const _ShortcutsButton(),
            const SizedBox(width: 16),
            const _LocalizationSelector(),
            const SizedBox(width: 8),
            const _ThemeModeSelector(),
            const SizedBox(width: 8),
            const _AIAssistantTrigger(),
            const SizedBox(width: 8),
            const _NotificationCenter(),
            const SizedBox(width: 4),
            const _QuickSettings(),
            const SizedBox(width: 8),
            const _UserProfileChip(),
          ],
        ),
      ),
    );
  }
}

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

class _AppLauncherGrid extends StatelessWidget {
  const _AppLauncherGrid();

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<ZenoSemanticColors>()!;
    return InkWell(
      onTap: () {},
      borderRadius: BorderRadius.circular(6),
      child: Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
        ),
        child: Icon(Icons.grid_view_rounded,
            size: 20, color: colors.accentPrimary),
      ),
    );
  }
}

class _BrandTitle extends StatelessWidget {
  const _BrandTitle();

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<ZenoSemanticColors>()!;
    return InkWell(
      onTap: () => NavigationController().navigateTo('dashboard'),
      child: Text(
        "ZENO BOS",
        style: TextStyle(
          color: colors.textPrimary,
          fontSize: 16,
          fontFamily: 'Inter',
          fontWeight: FontWeight.w700,
          letterSpacing: -0.02 * 16,
        ),
      ),
    );
  }
}

class _VerticalDivider extends StatelessWidget {
  const _VerticalDivider();

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<ZenoSemanticColors>()!;
    return Container(
      width: 1,
      height: 20,
      color: colors.borderSubtle,
    );
  }
}

class _BranchSelector extends StatelessWidget {
  const _BranchSelector();

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<ZenoSemanticColors>()!;
    return InkWell(
      onTap: () {},
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(
          color: colors.bgTier3,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: colors.borderSubtle),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.location_on_rounded,
                size: 14, color: colors.statusSuccess),
            const SizedBox(width: 8),
            Text(
              "Main HQ",
              style: TextStyle(
                color: colors.textPrimary,
                fontSize: 13,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w500,
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

class _OmniSearchVessel extends StatefulWidget {
  final FocusNode focusNode;
  const _OmniSearchVessel({required this.focusNode});

  @override
  State<_OmniSearchVessel> createState() => _OmniSearchVesselState();
}

class _OmniSearchVesselState extends State<_OmniSearchVessel> {
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    widget.focusNode.addListener(() {
      setState(() => _isFocused = widget.focusNode.hasFocus);
    });
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<ZenoSemanticColors>()!;
    return Flexible(
      flex: 10,
      child: Container(
        constraints: const BoxConstraints(maxWidth: 540),
        height: 32,
        decoration: BoxDecoration(
          color: colors.bgTier3,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: _isFocused ? colors.accentPrimary : colors.borderSubtle,
          ),
          boxShadow: _isFocused
              ? [
                  BoxShadow(
                      color: colors.accentPrimary.withValues(alpha: 0.2),
                      blurRadius: 4),
                ]
              : null,
        ),
        child: Row(
          children: [
            const SizedBox(width: 4),
            _HistoryButton(
                icon: Icons.arrow_back_ios_new_rounded,
                tooltip: "In-App Back (Alt + Left)",
                onTap: () => debugPrint("History Back")),
            _HistoryButton(
                icon: Icons.arrow_forward_ios_rounded,
                tooltip: "In-App Forward (Alt + Right)",
                onTap: () => debugPrint("History Forward")),
            const SizedBox(width: 4),
            Container(
              width: 1,
              height: 16,
              color: colors.borderSubtle,
              margin: const EdgeInsets.symmetric(horizontal: 8),
            ),
            Icon(Icons.search_rounded, size: 16, color: colors.textSecondary),
            const SizedBox(width: 8),
            Expanded(
              child: TextField(
                focusNode: widget.focusNode,
                style: TextStyle(
                    color: colors.textPrimary,
                    fontSize: 13,
                    fontFamily: 'Inter'),
                decoration: InputDecoration(
                  hintText: "Search commands, products, customers... (Ctrl+K)",
                  hintStyle:
                      TextStyle(color: colors.textSecondary, fontSize: 13),
                  border: InputBorder.none,
                  isDense: true,
                  contentPadding: EdgeInsets.zero,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
              margin: const EdgeInsets.only(right: 8),
              decoration: BoxDecoration(
                color: colors.bgTier1,
                borderRadius: BorderRadius.circular(4),
                border: Border.all(color: colors.borderSubtle),
              ),
              child: Text(
                "⌘K",
                style: TextStyle(
                  color: colors.amberGold,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Inter',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _HistoryButton extends StatelessWidget {
  final IconData icon;
  final String tooltip;
  final VoidCallback onTap;

  const _HistoryButton(
      {required this.icon, required this.tooltip, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltip,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(4),
        child: Container(
          width: 24,
          height: 24,
          alignment: Alignment.center,
          child: Icon(icon, size: 12, color: const Color(0xFF8A92A6)),
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
      // ACTIVATED: OPENS THE AI COPILOT WINDOW
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
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.auto_awesome, size: 14, color: Colors.white),
              const SizedBox(width: 8),
              const Text(
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

class _NotificationCenter extends StatelessWidget {
  const _NotificationCenter();

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<ZenoSemanticColors>()!;
    return Stack(
      alignment: Alignment.topRight,
      children: [
        const IconButton(
          onPressed: null,
          icon: Icon(Icons.notifications_none_rounded,
              size: 22, color: Color(0xFF8A92A6)),
          visualDensity: VisualDensity.compact,
        ),
        Positioned(
          right: 4,
          top: 4,
          child: Container(
            padding: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              color: colors.statusDanger,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                    color: colors.statusDanger.withValues(alpha: 0.4),
                    blurRadius: 4),
              ],
            ),
            constraints: const BoxConstraints(minWidth: 14, minHeight: 14),
            child: const Text(
              "8",
              style: TextStyle(
                  fontSize: 8,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    );
  }
}

class _QuickSettings extends StatelessWidget {
  const _QuickSettings();

  @override
  Widget build(BuildContext context) {
    return const IconButton(
      onPressed: null,
      icon: Icon(Icons.settings_outlined, size: 20, color: Color(0xFF8A92A6)),
      visualDensity: VisualDensity.compact,
    );
  }
}

class _UserProfileChip extends StatelessWidget {
  const _UserProfileChip();

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<ZenoSemanticColors>()!;
    return InkWell(
      onTap: () {},
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.only(left: 4, right: 12, top: 4, bottom: 4),
        decoration: BoxDecoration(
          color: colors.bgTier2,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: colors.borderSubtle),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(
              radius: 14,
              backgroundColor: colors.borderSubtle,
              child: Icon(Icons.person_rounded,
                  size: 18, color: colors.textPrimary),
            ),
            const SizedBox(width: 8),
            Flexible(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "John Perera",
                    style: TextStyle(
                      color: Color(0xFF1E293B),
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Inter',
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                  Text(
                    "Administrator",
                    style: TextStyle(
                      color: colors.textSecondary,
                      fontSize: 10,
                      fontFamily: 'Inter',
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
