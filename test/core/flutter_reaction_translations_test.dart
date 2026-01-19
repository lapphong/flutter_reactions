import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_reactions/src/core/flutter_reaction_translations.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final binding = TestWidgetsFlutterBinding.ensureInitialized();
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(FlutterReactionTranslations.cache.clear);

  test('load loads translations for current locale and caches result', () async {
    const fakeJson = '{"like": "Like", "love": "Love"}';

    binding.defaultBinaryMessenger.setMockMessageHandler(
      'flutter/assets',
      (ByteData? message) async {
        final assetKey = utf8.decode(message!.buffer.asUint8List());
        if (assetKey.endsWith('/en.json')) {
          return ByteData.view(utf8.encode(fakeJson).buffer);
        }
        return null;
      },
    );
    await FlutterReactionTranslations.load();

    expect(FlutterReactionTranslations.text('like'), 'Like');
    expect(FlutterReactionTranslations.text('love'), 'Love');
  });

  test('load does not reload if locale already cached', () async {
    FlutterReactionTranslations.cache['en'] = {
      'like': 'Like',
    };

    await FlutterReactionTranslations.load();
    expect(FlutterReactionTranslations.text('like'), 'Like');
  });
}
