import 'package:flutter/material.dart' hide AnimatedSlide;
import 'package:flutter_reactions/src/core/animations/animated_slide.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('AnimatedSlide renders child correctly', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: AnimatedSlide(
          delay: Duration.zero,
          child: Text('Hello'),
        ),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.text('Hello'), findsOneWidget);
  });

  testWidgets('AnimatedSlide starts animation after delay', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: AnimatedSlide(
          delay: Duration(milliseconds: 50),
          child: Text('Animated'),
        ),
      ),
    );

    await tester.pump(const Duration(milliseconds: 300));
    await tester.pumpAndSettle();

    expect(find.text('Animated'), findsOneWidget);
  });
}
