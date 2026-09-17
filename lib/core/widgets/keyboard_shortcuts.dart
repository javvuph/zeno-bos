import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../navigation/navigation_controller.dart';
import 'premium/zeno_command_palette.dart';
import 'zeno_keyboard_shortcuts_dialog.dart';

/// Application-wide shortcut layer.
///
/// Why this does **not** use [CallbackShortcuts]:
///
/// [CallbackShortcuts] (and [Shortcuts]) install a [Focus] node and rely on key
/// events walking from the primary focus node *up through its ancestors*
/// (`FocusManager._handleKeyMessage`). That only works while something inside
/// this subtree holds focus. The moment the user clicks a non-focusable area —
/// a section heading, a toolbar label, dead space — Flutter drops focus to the
/// enclosing route's `FocusScopeNode`, which is an **ancestor** of this widget.
/// The event then never passes through us and every global chord dies until the
/// user happens to click something focusable again. That was the original bug.
///
/// Instead we register with [FocusManager.addLateKeyEventHandler], which is
/// focus-independent: it fires for every key event that nothing else claimed.
/// "Late" is deliberate — a focused [TextField], data grid or POS screen still
/// gets first refusal, so typing `n` in a search box never opens a tab, and a
/// screen-local binding always beats the global one.
class ZenoShortcuts extends StatefulWidget {
  final Widget child;
  const ZenoShortcuts({super.key, required this.child});

  @override
  State<ZenoShortcuts> createState() => _ZenoShortcutsState();
}

class _ZenoShortcutsState extends State<ZenoShortcuts> {
  final NavigationController _nav = NavigationController();
  bool _overlayOpen = false;

  late final Map<ShortcutActivator, VoidCallback> _bindings = {
    const SingleActivator(LogicalKeyboardKey.keyK, control: true):
        _showCommandPalette,
    const SingleActivator(LogicalKeyboardKey.keyK, meta: true):
        _showCommandPalette,
    const SingleActivator(LogicalKeyboardKey.f1): _showCheatSheet,
    const SingleActivator(LogicalKeyboardKey.slash, control: true):
        _showCheatSheet,
    const SingleActivator(LogicalKeyboardKey.keyF, control: true):
        _nav.toggleSearch,
    const SingleActivator(LogicalKeyboardKey.keyN, control: true): () =>
        _nav.openTab('billing/sales/new'),
    const SingleActivator(LogicalKeyboardKey.keyP, control: true):
        _showPrintDialog,
    const SingleActivator(LogicalKeyboardKey.keyW, control: true): () =>
        _nav.closeTab(_nav.activeTabId),
    const SingleActivator(LogicalKeyboardKey.tab, control: true): () =>
        _cycleTab(1),
    const SingleActivator(LogicalKeyboardKey.tab, control: true, shift: true):
        () => _cycleTab(-1),
  };

  @override
  void initState() {
    super.initState();
    FocusManager.instance.addLateKeyEventHandler(_handleKey);
  }

  @override
  void dispose() {
    FocusManager.instance.removeLateKeyEventHandler(_handleKey);
    super.dispose();
  }

  KeyEventResult _handleKey(KeyEvent event) {
    // SingleActivator matches on key-down (and repeats); ignore the rest so a
    // chord fires once per press rather than again on release.
    if (event is! KeyDownEvent && event is! KeyRepeatEvent) {
      return KeyEventResult.ignored;
    }
    if (!mounted) return KeyEventResult.ignored;

    for (final entry in _bindings.entries) {
      if (entry.key.accepts(event, HardwareKeyboard.instance)) {
        entry.value();
        return KeyEventResult.handled;
      }
    }
    return KeyEventResult.ignored;
  }

  @override
  Widget build(BuildContext context) => widget.child;

  void _cycleTab(int delta) {
    final tabs = _nav.tabs;
    if (tabs.length < 2) return;
    final activeIdx = tabs.indexWhere((t) => t.id == _nav.activeTabId);
    if (activeIdx == -1) return;
    final nextIdx = (activeIdx + delta + tabs.length) % tabs.length;
    _nav.switchTab(tabs[nextIdx].id);
  }

  void _showCommandPalette() => _showExclusive(
        (ctx) => const ZenoCommandPalette(),
        barrierColor: Colors.black.withValues(alpha: 0.4),
      );

  void _showCheatSheet() =>
      _showExclusive((ctx) => const ZenoKeyboardShortcutsDialog());

  /// Guards against a held chord stacking duplicate modal routes.
  Future<void> _showExclusive(WidgetBuilder builder,
      {Color? barrierColor}) async {
    if (_overlayOpen) return;
    _overlayOpen = true;
    try {
      await showDialog<void>(
        context: context,
        barrierColor: barrierColor,
        builder: builder,
      );
    } finally {
      if (mounted) _overlayOpen = false;
    }
  }

  void _showPrintDialog() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Preparing enterprise print service...")),
    );
  }
}
