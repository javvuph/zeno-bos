import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:zeno/app/zeno_theme_controller.dart';
import 'package:zeno/core/widgets/keyboard_shortcuts.dart';
import 'package:zeno/navigation/navigation_controller.dart';

/// End-to-end checks against the real [ZenoShortcuts] widget and the real
/// (singleton) [NavigationController] — not a stand-in. These prove the chords
/// actually reach the controller with no manual click to seed focus first.
void main() {
  final nav = NavigationController();

  /// The controller is a singleton, so collapse it back to a single tab
  /// between tests to keep them order-independent.
  void resetTabs() {
    for (final t in nav.tabs.skip(1).toList()) {
      nav.closeTab(t.id);
    }
  }

  setUp(resetTabs);
  tearDown(resetTabs);

  Future<void> pumpShell(WidgetTester tester) async {
    // ZENO is a desktop POS shell; the 800x600 test default is narrower than
    // any real window and makes wide dialogs report false overflows.
    await tester.binding.setSurfaceSize(const Size(1600, 1000));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    await tester.pumpWidget(
      MaterialApp(
        // The real theme, so ZenoSemanticColors extension lookups resolve the
        // same way they do in the running app.
        theme: ZenoThemeController().currentTheme,
        home: const ZenoShortcuts(child: Scaffold(body: Text('shell'))),
      ),
    );
    await tester.pump();
  }

  Future<void> press(WidgetTester tester, LogicalKeyboardKey key,
      {bool control = false, bool shift = false}) async {
    if (control) await tester.sendKeyDownEvent(LogicalKeyboardKey.controlLeft);
    if (shift) await tester.sendKeyDownEvent(LogicalKeyboardKey.shiftLeft);
    await tester.sendKeyDownEvent(key);
    await tester.sendKeyUpEvent(key);
    if (shift) await tester.sendKeyUpEvent(LogicalKeyboardKey.shiftLeft);
    if (control) await tester.sendKeyUpEvent(LogicalKeyboardKey.controlLeft);
    await tester.pump();
  }

  testWidgets('Ctrl+N opens a new tab with no prior click', (tester) async {
    await pumpShell(tester);
    final before = nav.tabs.length;

    await press(tester, LogicalKeyboardKey.keyN, control: true);

    expect(nav.tabs.length, before + 1,
        reason: 'Ctrl+N must work on a freshly mounted shell');
    expect(nav.tabs.last.route, 'billing/sales/new');
  });

  testWidgets('Ctrl+Tab cycles forward, Ctrl+Shift+Tab cycles back',
      (tester) async {
    await pumpShell(tester);
    // Three tabs total: the default dashboard plus two opened here.
    await press(tester, LogicalKeyboardKey.keyN, control: true);
    await press(tester, LogicalKeyboardKey.keyN, control: true);
    expect(nav.tabs.length, 3);

    final ids = nav.tabs.map((t) => t.id).toList();
    // Ctrl+N leaves the last-opened tab active.
    expect(nav.activeTabId, ids[2]);

    await press(tester, LogicalKeyboardKey.tab, control: true);
    expect(nav.activeTabId, ids[0], reason: 'wraps past the end');

    await press(tester, LogicalKeyboardKey.tab, control: true);
    expect(nav.activeTabId, ids[1]);

    await press(tester, LogicalKeyboardKey.tab, control: true, shift: true);
    expect(nav.activeTabId, ids[0], reason: 'shift reverses direction');

    await press(tester, LogicalKeyboardKey.tab, control: true, shift: true);
    expect(nav.activeTabId, ids[2], reason: 'wraps backwards past the start');
  });

  testWidgets('Ctrl+W closes the active tab', (tester) async {
    await pumpShell(tester);
    await press(tester, LogicalKeyboardKey.keyN, control: true);
    expect(nav.tabs.length, 2);

    await press(tester, LogicalKeyboardKey.keyW, control: true);
    expect(nav.tabs.length, 1);
  });

  testWidgets('Ctrl+F toggles the search flag', (tester) async {
    await pumpShell(tester);
    final before = nav.isSearchOpen;

    await press(tester, LogicalKeyboardKey.keyF, control: true);
    expect(nav.isSearchOpen, !before);

    await press(tester, LogicalKeyboardKey.keyF, control: true);
    expect(nav.isSearchOpen, before);
  });

  testWidgets('F1 opens the cheat sheet, and a held chord does not stack it',
      (tester) async {
    await pumpShell(tester);

    await press(tester, LogicalKeyboardKey.f1);
    await tester.pumpAndSettle();
    expect(find.text('KEYBOARD SHORTCUTS CHEAT-SHEET'), findsOneWidget);

    // Re-firing while the dialog is open must not push a second route.
    await press(tester, LogicalKeyboardKey.f1);
    await tester.pumpAndSettle();
    expect(find.text('KEYBOARD SHORTCUTS CHEAT-SHEET'), findsOneWidget,
        reason: '_overlayOpen guard should suppress the duplicate');

    Navigator.of(tester.element(find.text('shell'))).pop();
    await tester.pumpAndSettle();
  });
}
