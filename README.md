<h1>Flutter Reactions</h1>

<p>
  <strong>A Flutter package that provides a fully handled reaction system with cross-platform gesture support and configurable reaction overlays.</strong>
</p>

<p>
<a href="https://pub.dev/packages/flutter_reactions"><img src="https://img.shields.io/pub/v/flutter_reactions.svg" alt="Pub Version"></a>
<a href="https://github.com/felangel/bloc/actions"><img src="https://github.com/felangel/bloc/actions/workflows/main.yaml/badge.svg" alt="build"></a>
<a href="https://github.com/lapphong/flutter_reactions/blob/main/screenshots/coverage.png">
  <img src="https://img.shields.io/badge/coverage-report-blue?logo=github" alt="Coverage Report">
</a>
<a href="https://github.com/lapphong/flutter_reactions"><img src="https://img.shields.io/github/stars/lapphong/flutter_reactions?style=social" alt="Star on Github"></a>
<a href="https://pub.dev/packages/flutter_reactions/example"><img src="https://img.shields.io/badge/flutter-samples-teal.svg?longCache=true" alt="Flutter Example"></a>
<a href="https://github.com/lapphong/flutter_reactions/blob/main/LICENSE"><img src="https://img.shields.io/github/license/lapphong/flutter_reactions.svg" alt="License: MIT"></a>
</p>

| Android |  iOS  | macOS |  Web  | Linux | Windows |
| :-----: | :---: | :---: | :---: | :---: | :-----: |
|✅|✅|✅|✅|✅|✅|

#### Requirements

- sdk: >= 3.0 < 4.0


## 📸  Screenshots

#### Demo: (`Normal`, `Safe Area`, `Debug mode`)

<table>
  <tr>
    <td><img src="https://raw.githubusercontent.com/lapphong/flutter_reactions/main/screenshots/demo_mobile.gif" alt="Dash light" width="258"/></td>
    <td><img src="https://raw.githubusercontent.com/lapphong/flutter_reactions/main/screenshots/demo_mobile_2.gif" alt="Dash dark" width="258"/></td>
    <td><img src="https://raw.githubusercontent.com/lapphong/flutter_reactions/main/screenshots/demo_debug.gif" alt="M3 baseline light" width="258"/></td>
  </tr>
</table>


## ✨ Features
- Fully handled reaction interactions with built-in gesture & pointer support
- Reaction overlay with automatic positioning
- Works consistently across **mobile, web, and desktop**
- Audio feedback **support**
- Localization **support** (**en, vi, fr, ja, zh, ko**)
- Smooth, customizable **animations**


## 🚀 Quick start

#### Add `flutter_reactions` to your `pubspec.yaml`:

```yaml
dependencies:
  flutter_reactions: ^1.0.0
```

#### Then run:

```bash
flutter pub get
```

#### Import the package:

```dart
import 'package:flutter_reactions/flutter_reactions.dart';
```

#### Basic

```dart
FlutterReactionButton(
  value: flutterReactionType,
  onChanged: (value) {
    setState(() {
      flutterReactionType = value;
    });
    if (value == null) {
      debugPrint('No Reaction');
    } else {
      debugPrint(value.toString());
    }
  },
);
```

## Parameters:

| Name                  | Description                                                         | Required | Default value |
| --------------------- | ------------------------------------------------------------------- | -------- | ------------- |
| `value`               | Current selected reaction type. Use `null` to indicate no reaction. | ✅       | -             |
| `onChanged`           | Callback triggered when the reaction value changes.                 | ✅       | -             |
| `config`              | Configuration for the reactions ovelay.                             | ❌       | `FlutterReactionConfig()` |
| `hasLabel`            | Whether to display the reaction label next to the icon.             | ❌       | true          |
| `child`               | Custom widget to wrap with reaction interactions.                   | ❌       | -             |

---

## 📄 License

MIT License - see [LICENSE](LICENSE) for details.

---

## 🤝 Contributing

<h4>Contributions are welcome! Please read our contributing guidelines before submitting a PR.</h4>

---

## 📬 Support

- 🐛 [Report bugs](https://github.com/lapphong/flutter_reactions/issues)
- 💡 [Request features](https://github.com/lapphong/flutter_reactions/issues)
- ⭐ Star the repo if you find it useful!

---

<p align="center">
  Made with ❤️ by <a href="https://github.com/lapphong">Buzzlp</a>
</p>
