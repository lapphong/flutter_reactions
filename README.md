<h1>Flutter Reactions</h1>

<p>
  <strong>A Flutter package that makes it easy to add a single reaction button that handles all events for multiple platforms, or to display reactions via overlay without the button.</strong>
</p>

<p>
<a href="https://pub.dev/packages/flutter_reactions"><img src="https://img.shields.io/pub/v/flutter_reactions.svg" alt="Pub Version"></a>
<a href="https://github.com/felangel/bloc/actions"><img src="https://github.com/felangel/bloc/actions/workflows/main.yaml/badge.svg" alt="build"></a>
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

<br> 

<table align="center">
  <thead>
    <tr>
      <th align="center" colspan="2">📱 Mobile & Safe Area</th>
    </tr>
  </thead>

  <tbody>
    <tr>
      <td align="center">
        <img src="https://github.com/user-attachments/assets/18701a12-1108-431d-961e-57f7d7e640bd"/>
      </td>
      <td align="center">
        <img src="https://github.com/user-attachments/assets/67cbb683-cbf6-4609-8887-45aa78a28514"/>
      </td>
    </tr>
  </tbody>
</table>

<br>

<table align="center">
<thead>
  <tr>
    <th align="center">🌐 Other Platforms</th>
  </tr>
</thead>
<tbody>
  <tr>
    <td align="center">
      <img
        src="https://github.com/user-attachments/assets/df3c1134-f88b-4508-bd3b-de1515c1f245"
        width="820"
      />
    </td>
  </tr>
</tbody>
</table>


## ✨ Features
- Fully handled reaction button with built-in gesture & pointer interactions
- Long-press reaction overlay with automatic positioning
- Consistent behavior across **mobile, web, and desktop**
- Built-in **audio feedback** support
- **Multi-language** (localization-ready)
- Smooth, customizable **animations**


## 🚀 Quick start

#### Add `flutter_reactions` to your `pubspec.yaml`:

```yaml
dependencies:
  flutter_reactions: ^0.0.1
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

#### `FlutterReactionButton` Parameters:

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

<h3>Contributions are welcome! Please read our contributing guidelines before submitting a PR.</h3>

---

## 📬 Support

- 🐛 [Report bugs](https://github.com/lapphong/flutter_reactions/issues)
- 💡 [Request features](https://github.com/lapphong/flutter_reactions/issues)
- ⭐ Star the repo if you find it useful!

---

<p align="center">
  Made with ❤️ by <a href="https://github.com/lapphong">Buzzlp</a>
</p>
