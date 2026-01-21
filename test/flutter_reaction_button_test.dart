import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter_reactions/flutter_reactions.dart';
import 'package:flutter_reactions/src/core/core.dart';
import 'package:flutter_reactions/src/ui/flutter_reaction_box.dart';
import 'package:flutter_reactions/src/ui/widgets/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

import 'wrap_widget.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    AppConstants.isMobile = true;
  });

  tearDown(() {
    debugDefaultTargetPlatformOverride = null;
  });

  group('FlutterReactionButton - basic interactions', () {
    testWidgets('tap selects LIKE reaction', (tester) async {
      await tester.pumpWidget(wrap());

      await tester.tap(find.byType(FlutterReactionButton));
      await tester.pump(const Duration(milliseconds: 300));
      final state1 = tester.state<WrapWidgetState>(find.byType(WrapWidget));
      expect(state1.flutterReactionType, FlutterReactionType.like);

      await tester.tap(find.byType(FlutterReactionButton));
      await tester.pump(const Duration(milliseconds: 300));
      final state2 = tester.state<WrapWidgetState>(find.byType(WrapWidget));
      expect(state2.flutterReactionType, isNull);
    });

    testWidgets('double tap selects LOVE reaction', (tester) async {
      await tester.pumpWidget(wrap());

      final finder = find.byType(FlutterReactionButton);

      final gesture = await tester.startGesture(tester.getCenter(finder));
      await tester.pump(const Duration(milliseconds: 20));
      await gesture.up();

      await tester.pump(const Duration(milliseconds: 40));

      final gesture2 = await tester.startGesture(tester.getCenter(finder));
      await tester.pump(const Duration(milliseconds: 20));
      await gesture2.up();

      await tester.pump(const Duration(milliseconds: 300));

      final state = tester.state<WrapWidgetState>(find.byType(WrapWidget));
      expect(state.flutterReactionType, FlutterReactionType.love);
    });
  });

  testWidgets('on NON-MOBILE platform', (tester) async {
    debugDefaultTargetPlatformOverride = TargetPlatform.macOS;
    AppConstants.isMobile = false;

    await tester.pumpWidget(wrap());

    final buttonFinder = find.byType(FlutterReactionButton);
    final buttonCenter = tester.getCenter(buttonFinder);

    final mouse = await tester.createGesture(kind: PointerDeviceKind.mouse);
    await mouse.addPointer(location: buttonCenter);

    // ------------------------------------------------------
    // 1. Hover over the button → open reaction overlay
    // ------------------------------------------------------
    await mouse.moveTo(buttonCenter);
    await tester.pump(const Duration(milliseconds: 600));

    expect(find.byType(FlutterReactionsBox), findsOneWidget);

    final items = find.byType(FlutterReactionItemWidget);
    expect(items, findsNWidgets(FlutterReactionType.values.length));

    // ------------------------------------------------------
    // 2. Hover over each reaction item (focus / unfocus)
    // ------------------------------------------------------
    for (var i = 0; i < FlutterReactionType.values.length; i++) {
      final center = tester.getCenter(items.at(i));
      await mouse.moveTo(center);
      await tester.pump(const Duration(milliseconds: 120));
    }

    // --------------------------------------------------
    // 3. Tap cancel on a reaction item (onTapCancel)
    // --------------------------------------------------
    final targetItem = items.at(1);
    final targetCenter = tester.getCenter(targetItem);

    await mouse.moveTo(targetCenter);
    await tester.pump(const Duration(milliseconds: 80));

    await mouse.down(targetCenter);
    await tester.pump(const Duration(milliseconds: 50));

    // Cancel tap
    await mouse.cancel();
    await tester.pump(const Duration(milliseconds: 200));

    // No reaction should be selected
    final stateAfterCancel = tester.state<WrapWidgetState>(find.byType(WrapWidget));
    expect(stateAfterCancel.flutterReactionType, isNull);

    // Overlay should still be visible
    expect(find.byType(FlutterReactionsBox), findsOneWidget);

    // ------------------------------------------------------
    // 4. Click to select CARE reaction (index = 2)
    // ------------------------------------------------------
    final careItem = items.at(2);
    final careCenter = tester.getCenter(careItem);

    await mouse.moveTo(careCenter);
    await tester.pump(const Duration(milliseconds: 50));

    await mouse.down(careCenter);
    await tester.pump(const Duration(milliseconds: 30));
    await mouse.up();
    await tester.pump(const Duration(milliseconds: 400));

    // ------------------------------------------------------
    // 5. Verify state + overlay closed
    // ------------------------------------------------------
    final state = tester.state<WrapWidgetState>(find.byType(WrapWidget));
    expect(state.flutterReactionType, FlutterReactionType.care);

    expect(find.byType(FlutterReactionsBox), findsNothing);
    debugDefaultTargetPlatformOverride = null;
  });

  testWidgets('on MOBILE platform', (tester) async {
    await tester.pumpWidget(wrap());

    final button = tester.getCenter(find.byType(FlutterReactionButton));

    // ------------------------------------------------------
    // Case 1: Drag to select a reaction
    // ------------------------------------------------------

    // 1. Long press the button → open reaction overlay
    final gesture1 = await tester.startGesture(button);
    await tester.pump(const Duration(milliseconds: 600));
    expect(find.byType(FlutterReactionsBox), findsOneWidget);

    final items = find.byType(FlutterReactionItemWidget);
    expect(items, findsNWidgets(FlutterReactionType.values.length));

    // 2. Drag across each item
    for (var i = 0; i < items.evaluate().length; i++) {
      final center = tester.getCenter(items.at(i));
      await gesture1.moveTo(center);
      await tester.pump(const Duration(milliseconds: 80));
    }

    // 3. Release on item index = 4 to select it
    final targetCenter1 = tester.getCenter(items.at(3));
    await gesture1.moveTo(targetCenter1);
    await tester.pump(const Duration(milliseconds: 80));

    await gesture1.up();
    await tester.pumpAndSettle();

    // Selected reaction should be item 4, overlay should be closed
    final stateAfterFirst = tester.state<WrapWidgetState>(find.byType(WrapWidget));
    expect(stateAfterFirst.flutterReactionType, FlutterReactionType.values[3]);
    expect(find.byType(FlutterReactionsBox), findsNothing);

    // ------------------------------------------------------
    // Case 2: Drag outside without selection, then tap outside to close
    // ------------------------------------------------------

    // 4. Long press again to reopen the overlay
    final gesture2 = await tester.startGesture(button);
    await tester.pump(const Duration(milliseconds: 600));
    expect(find.byType(FlutterReactionsBox), findsOneWidget);

    // 5. Drag pointer outside the reaction box area
    await gesture2.moveBy(const Offset(0, -300));
    await tester.pump(const Duration(milliseconds: 120));

    // 6. Release outside → no reaction should be selected
    await gesture2.up();
    await tester.pump(const Duration(milliseconds: 200));
    expect(find.byType(FlutterReactionsBox), findsOneWidget);

    // 7. Tap outside to close overlay
    final outsideGesture = await tester.startGesture(const Offset(0, 0));
    await tester.pump(const Duration(milliseconds: 20));

    await outsideGesture.up();
    await tester.pumpAndSettle();

    // 8. Reaction should remain item 4
    final finalState = tester.state<WrapWidgetState>(find.byType(WrapWidget));
    expect(finalState.flutterReactionType, FlutterReactionType.values[3]);
  });
}
