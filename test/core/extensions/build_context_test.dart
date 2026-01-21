import 'package:flutter/material.dart';
import 'package:flutter_reactions/src/core/app_constants.dart';
import 'package:flutter_reactions/src/core/extensions/build_context_ext.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('BuildContextExt.calculateReactionBoxPosition', () {
    testWidgets('returns Offset.zero when target is not mounted', (tester) async {
      final key = GlobalKey();
      const overlaySize = Size(100, 50);

      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) {
              final offset = context.calculateReactionBoxPosition(key: key, overlaySize: overlaySize);
              expect(offset, Offset.zero);
              return const SizedBox();
            },
          ),
        ),
      );
    });

    testWidgets('positions box below target when not enough space above', (tester) async {
      AppConstants.isMobile = false;

      final key = GlobalKey();
      const overlaySize = Size(100, 50);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SizedBox(key: key, width: 50, height: 30),
          ),
        ),
      );

      final context = key.currentContext!;
      final offset = context.calculateReactionBoxPosition(key: key, overlaySize: overlaySize);

      expect(offset.dy, greaterThan(0));
    });

    testWidgets('centers horizontally on mobile', (tester) async {
      AppConstants.isMobile = true;

      final key = GlobalKey();
      const overlaySize = Size(120, 50);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SizedBox(key: key, width: 40, height: 40),
          ),
        ),
      );

      final context = key.currentContext!;
      final offset = context.calculateReactionBoxPosition(key: key, overlaySize: overlaySize);

      final screenWidth = MediaQuery.of(context).size.width;
      final expectedLeft = (screenWidth - overlaySize.width) / 2;

      expect(offset.dy, closeTo(expectedLeft, 0.1));
    });
  });

  group('BuildContextExt.isInsideReactionDragArea', () {
    testWidgets('returns true when position is inside extended area', (tester) async {
      late BuildContext context;

      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (ctx) {
              context = ctx;
              return const SizedBox();
            },
          ),
        ),
      );

      const boxRect = Rect.fromLTWH(0, 100, 200, 50);
      const position = Offset(100, 120);

      final result = context.isInsideReactionDragArea(position: position, boxRect: boxRect);
      expect(result, isTrue);
    });

    testWidgets('returns false when position is outside extended area', (tester) async {
      late BuildContext context;

      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (ctx) {
              context = ctx;
              return const SizedBox();
            },
          ),
        ),
      );

      const boxRect = Rect.fromLTWH(0, 100, 200, 50);
      const position = Offset(100, 500);

      final result = context.isInsideReactionDragArea(position: position, boxRect: boxRect);
      expect(result, isFalse);
    });
  });
}
