import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:zeno/core/widgets/keyboard_shortcuts.dart';
import 'package:zeno/navigation/navigation_controller.dart';

/// The real-app failure mode.
///
/// Clicking a non-focusable area (a plain Container, a label, dead space in a
/// toolbar) drops the primary focus up to the enclosing route's FocusScope.
/// That scope is an *ancestor* of [ZenoShortcuts], and key events only walk
/// from the focused node upwards — so a shortcut layer that lives below the
/// scope stops receiving anything. Tests that never click dead space miss this.
void main() {
  final nav = NavigationController();

  void resetTabs() {
    for (final t in nav.tabs.skip(1).toList()) {
      nav.closeTab(t.id);
    }
  }

  setUp(resetTabs);
  tearDown(resetTabs);

  Future<void> pump(WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: ZenoShortcuts(
          child: Scaffold(
            body: Column(
              children: const [
                // Deliberately non-focusable, like a heading or toolbar label.
                SizedBox(height: 40, child: Text('field heading')),
              ],
            ),
          ),
        ),
      ),
    );
    await tester.pump();
  }

  Future<void> ctrlN(WidgetTester tester) async {
    await tester.sendKeyDownEvent(LogicalKeyboardKey.controlLeft);
    await tester.sendKeyDownEvent(LogicalKeyboardKey.keyN);
    await tester.sendKeyUpEvent(LogicalKeyboardKey.keyN);
    await tester.sendKeyUpEvent(LogicalKeyboardKey.controlLeft);
    await tester.pump();
  }

  testWidgets('Ctrl+N works before focus is dropped', (tester) async {
    await pump(tester);
    final before = nav.tabs.length;
    await ctrlN(tester);
    expect(nav.tabs.length, before + 1);
  });

  testWidgets('Ctrl+N must STILL work after focus is dropped to route scope',
      (tester) async {
    await pump(tester);

    // Simulate clicking dead space / a non-focusable heading.
    FocusManager.instance.primaryFocus?.unfocus();
    await tester.pump();
    debugPrint('=== primaryFocus after unfocus: '
        '${FocusManager.instance.primaryFocus?.runtimeType} '
        'label=${FocusManager.instance.primaryFocus?.debugLabel}');

    final before = nav.tabs.length;
    await ctrlN(tester);
    debugPrint('=== tabs before=$before after=${nav.tabs.length}');

    expect(nav.tabs.length, before + 1,
        reason: 'global shortcuts must survive focus being dropped');
  });
}
