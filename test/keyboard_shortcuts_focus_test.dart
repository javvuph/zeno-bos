import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

/// Regression test for the shortcut layer's widget ordering.
///
/// Flutter dispatches key events to the primary focus node and then walks
/// *upwards* through its ancestors (FocusManager._handleKeyMessage). A
/// [CallbackShortcuts] placed **below** the focused node is therefore never
/// consulted. These tests pin that contract so the ordering cannot regress.
void main() {
  Future<int> pumpAndCount(
    WidgetTester tester,
    Widget Function(VoidCallback onFire) build,
  ) async {
    var fired = 0;
    await tester.pumpWidget(
      MaterialApp(home: build(() => fired++)),
    );
    await tester.pump();
    await tester.sendKeyDownEvent(LogicalKeyboardKey.f8);
    await tester.sendKeyUpEvent(LogicalKeyboardKey.f8);
    await tester.pump();
    return fired;
  }

  testWidgets('shortcuts do NOT fire when Focus wraps CallbackShortcuts',
      (tester) async {
    // This is the broken arrangement that shipped: the autofocus node is the
    // parent, so the bindings sit below it and never see the event.
    final fired = await pumpAndCount(
      tester,
      (onFire) => Focus(
        autofocus: true,
        child: CallbackShortcuts(
          bindings: {const SingleActivator(LogicalKeyboardKey.f8): onFire},
          child: const SizedBox(),
        ),
      ),
    );
    expect(fired, 0, reason: 'confirms the original root cause');
  });

  testWidgets('shortcuts fire when CallbackShortcuts wraps Focus',
      (tester) async {
    final fired = await pumpAndCount(
      tester,
      (onFire) => CallbackShortcuts(
        bindings: {const SingleActivator(LogicalKeyboardKey.f8): onFire},
        child: const Focus(
          autofocus: true,
          skipTraversal: true,
          child: SizedBox(),
        ),
      ),
    );
    expect(fired, 1);
  });

  testWidgets('nested layers: inner handles, outer does not double-fire',
      (tester) async {
    var outer = 0;
    var inner = 0;
    await tester.pumpWidget(
      MaterialApp(
        home: CallbackShortcuts(
          bindings: {
            const SingleActivator(LogicalKeyboardKey.keyP, control: true):
                () => outer++,
          },
          child: CallbackShortcuts(
            bindings: {
              const SingleActivator(LogicalKeyboardKey.keyP, control: true):
                  () => inner++,
            },
            child: const Focus(
              autofocus: true,
              skipTraversal: true,
              child: SizedBox(),
            ),
          ),
        ),
      ),
    );
    await tester.pump();
    await tester.sendKeyDownEvent(LogicalKeyboardKey.controlLeft);
    await tester.sendKeyDownEvent(LogicalKeyboardKey.keyP);
    await tester.sendKeyUpEvent(LogicalKeyboardKey.keyP);
    await tester.sendKeyUpEvent(LogicalKeyboardKey.controlLeft);
    await tester.pump();

    expect(inner, 1, reason: 'POS-level binding wins');
    expect(outer, 0, reason: 'handled events stop propagating to the global layer');
  });
}
