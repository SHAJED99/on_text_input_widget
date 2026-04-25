# 📝 OnTextInputWidget

> A powerful and customizable text input widget for Flutter with built-in search, validation, and debounce support.

![Flutter](https://img.shields.io/badge/Flutter-02569B?style=flat-square&logo=flutter&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-0175C2?style=flat-square&logo=dart&logoColor=white)
![License](https://img.shields.io/badge/License-MIT-green?style=flat-square)
![Pub](https://img.shields.io/badge/Pub-1.0.0-blue?style=flat-square)

📦 **Ready for pub.dev!** Add it to your `pubspec.yaml` and start building beautiful input fields in minutes.

---

## ✨ Features

- 🔍 **Built-in Search** — Filter suggestions as you type with debounce support
- ✅ **Form Validation** — Email, phone, password strength, and custom validators
- 🎨 **Fully Customizable** — Colors, borders, radius, prefix/suffix icons, hints
- ⌨️ **Keyboard Support** — `TextInputAction`, `TextInputType`, focus management
- ♿ **Accessible** — Semantic labels and proper keyboard navigation
- 📱 **Platform Ready** — Works on Android, iOS, Web, macOS, Windows, Linux

---

## 📦 Installation

```bash
flutter pub add on_text_input_widget
```

Or add manually to `pubspec.yaml`:

```yaml
dependencies:
  on_text_input_widget: ^1.0.0
```

---

## 🚀 Quick Start

```dart
import 'package:on_text_input_widget/on_text_input_widget.dart';

// Simple text field
OnTextInputWidget(
  hintText: 'Enter your name',
  onChanged: (value) => print('Name: $value'),
);

// With validation
OnTextInputWidget(
  hintText: 'Enter email',
  keyboardType: TextInputType.emailAddress,
  validator: (value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    if (!value.contains('@')) {
      return 'Enter a valid email';
    }
    return null;
  },
);

// Search input with debounce
OnTextInputWidget(
  hintText: 'Search...',
  isSearchField: true,
  debounceMs: 300,
  onSearch: (query) => print('Searching for: $query'),
  suffixIcon: Icons.search,
);
```

---

## 🎛️ Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `hintText` | `String` | `''` | Placeholder text |
| `controller` | `TextEditingController` | `null` | External controller |
| `keyboardType` | `TextInputType` | `TextInputType.text` | Keyboard type |
| `textInputAction` | `TextInputAction` | `TextInputAction.done` | Action button |
| `validator` | `String Function(String?)` | `null` | Custom validator |
| `onChanged` | `void Function(String)` | `null` | On change callback |
| `onSubmitted` | `void Function(String)` | `null` | On submit callback |
| `isSearchField` | `bool` | `false` | Enable search mode |
| `debounceMs` | `int` | `300` | Debounce delay in ms |
| `onSearch` | `void Function(String)` | `null` | Search callback |
| `prefixIcon` | `IconData` | `null` | Leading icon |
| `suffixIcon` | `IconData` | `null` | Trailing icon |
| `fillColor` | `Color` | `null` | Background fill |
| `borderRadius` | `double` | `8.0` | Border radius |
| `enabled` | `bool` | `true` | Enable/disable field |

---

## 🎨 Customization Examples

### Password Field
```dart
OnTextInputWidget(
  hintText: 'Password',
  obscureText: true,
  suffixIcon: Icons.visibility_off,
  validator: (value) {
    if (value == null || value.length < 6) {
      return 'Min 6 characters required';
    }
    return null;
  },
)
```

### Phone Number Field
```dart
OnTextInputWidget(
  hintText: 'Phone number',
  keyboardType: TextInputType.phone,
  prefixIcon: Icons.phone,
  validator: (value) {
    if (value == null || value.length < 11) {
      return 'Enter valid phone number';
    }
    return null;
  },
)
```

### Search with Suggestions
```dart
List<String> suggestions = ['Flutter', 'Dart', 'Firebase', 'Widget'];

OnTextInputWidget(
  hintText: 'Search packages...',
  isSearchField: true,
  debounceMs: 200,
  onSearch: (query) {
    final filtered = suggestions
        .where((s) => s.toLowerCase().contains(query.toLowerCase()))
        .toList();
    print('Filtered: $filtered');
  },
)
```

---

## 📸 Screenshots

| Light Mode | Dark Mode |
|------------|-----------|
| ![Light](screenshots/light.png) | ![Dark](screenshots/dark.png) |

---

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing`)
5. Open a Pull Request

---

## 📄 License

```
MIT License
Copyright (c) 2024 Shajedur Rahman Panna
Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:
The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.
THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```

---

<p align="center">
  Made with ❤️ by <a href="https://github.com/SHAJED99">Shajedur Rahman Panna</a>
</p>
