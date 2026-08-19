import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../navigation/navigation_controller.dart';

class ZenoShortcuts extends StatelessWidget {
  final Widget child;
  const ZenoShortcuts({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Shortcuts(
      shortcuts: {
        LogicalKeySet(LogicalKeyboardKey.control, LogicalKeyboardKey.keyK):
            const SearchIntent(),
        LogicalKeySet(LogicalKeyboardKey.meta, LogicalKeyboardKey.keyK):
            const SearchIntent(),
        LogicalKeySet(LogicalKeyboardKey.control, LogicalKeyboardKey.keyN):
            const NewRecordIntent(),
        LogicalKeySet(LogicalKeyboardKey.control, LogicalKeyboardKey.keyP):
            const PrintIntent(),
        LogicalKeySet(LogicalKeyboardKey.control, LogicalKeyboardKey.keyW):
            const CloseTabIntent(),
        LogicalKeySet(LogicalKeyboardKey.control, LogicalKeyboardKey.tab):
            const NextTabIntent(),
      },
      child: Actions(
        actions: {
          SearchIntent: CallbackAction<SearchIntent>(
              onInvoke: (_) => NavigationController().toggleSearch()),
          NewRecordIntent: CallbackAction<NewRecordIntent>(
              onInvoke: (_) =>
                  NavigationController().openTab('billing/sales/new')),
          PrintIntent: CallbackAction<PrintIntent>(
              onInvoke: (_) => _showPrintDialog(context)),
          CloseTabIntent: CallbackAction<CloseTabIntent>(
              onInvoke: (_) => NavigationController()
                  .closeTab(NavigationController().activeTabId)),
          NextTabIntent: CallbackAction<NextTabIntent>(onInvoke: (_) {
            final nav = NavigationController();
            final tabs = nav.tabs;
            final activeIdx = tabs.indexWhere((t) => t.id == nav.activeTabId);
            final nextIdx = (activeIdx + 1) % tabs.length;
            nav.switchTab(tabs[nextIdx].id);
            return null;
          }),
        },
        child: child,
      ),
    );
  }

  void _showPrintDialog(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Preparing enterprise print service...")),
    );
  }
}

class SearchIntent extends Intent {
  const SearchIntent();
}

class NewRecordIntent extends Intent {
  const NewRecordIntent();
}

class PrintIntent extends Intent {
  const PrintIntent();
}

class CloseTabIntent extends Intent {
  const CloseTabIntent();
}

class NextTabIntent extends Intent {
  const NextTabIntent();
}
