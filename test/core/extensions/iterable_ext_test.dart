import 'package:flutter_reactions/src/core/core.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ExtendedIterableExt', () {
    test('mapIndexed maps elements with correct index', () {
      final list = ['a', 'b', 'c'];

      final result = list.mapIndexed((e, i) => '$e$i').toList();

      expect(result, ['a0', 'b1', 'c2']);
    });

    test('forEachIndexed iterates with correct index', () {
      final list = ['x', 'y', 'z'];
      final result = <String>[];

      list.forEachIndexed((e, i) {
        result.add('$e$i');
      });

      expect(result, ['x0', 'y1', 'z2']);
    });

    test('mapIndexed works with empty iterable', () {
      final list = <int>[];

      final result = list.mapIndexed((e, i) => e + i).toList();

      expect(result, isEmpty);
    });
  });
}
