import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/app/zeno_theme_controller.dart';
import 'package:zeno/navigation/navigation_controller.dart';

part 'parts/top_command_bar_left.part.dart';
part 'parts/top_command_bar_right.part.dart';
part 'parts/top_command_bar_user_profile.part.dart';

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
