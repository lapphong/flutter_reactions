import 'package:flutter_reactions/src/core/animations/animation_state.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('DirectionExt.toOffsets', () {
    test('Direction.left returns correct offsets', () {
      final (begin, end) = Direction.left.toOffsets();

      expect(begin, const Offset(-1, 0));
      expect(end, Offset.zero);
    });

    test('Direction.right returns correct offsets', () {
      final (begin, end) = Direction.right.toOffsets();

      expect(begin, const Offset(1, 0));
      expect(end, Offset.zero);
    });

    test('Direction.top returns correct offsets', () {
      final (begin, end) = Direction.top.toOffsets();

      expect(begin, const Offset(0, -1));
      expect(end, Offset.zero);
    });

    test('Direction.bottom returns correct offsets', () {
      final (begin, end) = Direction.bottom.toOffsets();

      expect(begin, const Offset(0, 1));
      expect(end, Offset.zero);
    });
  });
}
