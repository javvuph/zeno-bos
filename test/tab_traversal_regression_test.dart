import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:zeno/core/widgets/keyboard_shortcuts.dart';

/// Plain Tab traversal and text editing must keep working *through* the global
/// shortcut layer. The layer's anchor Focus node takes primary focus on mount,
/// so if that node is excluded from traversal the very first Tab press has no
/// traversal origin and focus never moves.
void main() {
  testWidgets('Tab moves focus between fields under ZenoShortcuts',
      (tester) async {
    final a = FocusNode(debugLabel: 'fieldA');
    final b = FocusNode(debugLabel: 'fieldB');
    addTearDown(a.dispose);
    addTearDown(b.dispose);

    await tester.pumpWidget(
      MaterialApp(
        home: ZenoShortcuts(
          child: Scaffold(
            body: Column(
              children: [
                TextField(focusNode: a),
                TextField(focusNode: b),
              ],
            ),
          ),
        ),
      ),
    );
    await tester.pump();

    debugPrint('=== on mount, primaryFocus = '
        '${FocusManager.instance.primaryFocus?.debugLabel ?? "anchor(unlabelled)"}');
    debugPrint('=== fieldA focused? ${a.hasFocus} / fieldB? ${b.hasFocus}');

    // First Tab from a cold start — the case a user hits immediately.
    await tester.sendKeyDownEvent(LogicalKeyboardKey.tab);
    await tester.sendKeyUpEvent(LogicalKeyboardKey.tab);
    await tester.pump();

    debugPrint('=== after 1st Tab: A=${a.hasFocus} B=${b.hasFocus}');
    expect(a.hasFocus || b.hasFocus, isTrue,
        reason: 'first Tab must land on a real field, not go nowhere');

    // And Tab must continue to advance.
    await tester.sendKeyDownEvent(LogicalKeyboardKey.tab);
    await tester.sendKeyUpEvent(LogicalKeyboardKey.tab);
    await tester.pump();
    debugPrint('=== after 2nd Tab: A=${a.hasFocus} B=${b.hasFocus}');
  });

  testWidgets('typing and select-all still work in a field under the layer',
      (tester) async {
    final ctrl = TextEditingController();
    addTearDown(ctrl.dispose);

    await tester.pumpWidget(
      MaterialApp(
        home: ZenoShortcuts(
          child: Scaffold(body: TextField(controller: ctrl)),
        ),
      ),
    );
    await tester.pump();

    await tester.tap(find.byType(TextField));
    await tester.pump();
    await tester.enterText(find.byType(TextField), 'HEADING');
    await tester.pump();
    expect(ctrl.text, 'HEADING');

    // Ctrl+A select-all is what "copy the field heading" depends on.
    await tester.sendKeyDownEvent(LogicalKeyboardKey.controlLeft);
    await tester.sendKeyDownEvent(LogicalKeyboardKey.keyA);
    await tester.sendKeyUpEvent(LogicalKeyboardKey.keyA);
    await tester.sendKeyUpEvent(LogicalKeyboardKey.controlLeft);
    await tester.pump();

    debugPrint('=== selection after Ctrl+A: ${ctrl.selection}');
    expect(ctrl.selection.textInside(ctrl.text), 'HEADING',
        reason: 'Ctrl+A must still select the field text');
  });
}
