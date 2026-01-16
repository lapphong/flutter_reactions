import 'dart:convert';
import 'dart:ui';

import 'package:flutter/services.dart';

class FlutterReactionTranslations {
  static final Map<String, Map<String, String>> _cache = {};

  static Future<void> load() async {
    final locale = PlatformDispatcher.instance.locale;
    final code = locale.languageCode;

    if (_cache.containsKey(code)) return;
    final data = await rootBundle.loadString('packages/flutter_reactions/assets/l10n/$code.json');
    _cache[code] = Map<String, String>.from(json.decode(data));
  }

  static String? text(String key) {
    final code = PlatformDispatcher.instance.locale.languageCode;
    final map = _cache[code] ?? _cache['en'];

    if (map == null) return null;

    final actualKey = key.contains('.') ? key.split('.').last : key;
    return map[actualKey] ?? actualKey;
  }
}
