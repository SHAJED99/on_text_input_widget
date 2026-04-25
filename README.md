# OnTextInputWidget

📦 A feature-rich Flutter text input widget with search, validation, login form, and Material 3 support.

[![Pub Version](https://img.shields.io/pub/v/on_text_input_widget?style=flat-square)](https://pub.dev/packages/on_text_input_widget)
[![Flutter](https://img.shields.io/badge/Flutter-3.x-blue?style=flat-square)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-3.x-blue?style=flat-square)](https://dart.dev)
[![License](https://img.shields.io/badge/License-BSD--3-blue?style=flat-square)](LICENSE)

---

## ✨ Features

- 🔍 **Smart Search** — Debounced online/offline search with loading indicators
- ✅ **Form Validation** — Built-in validator with inline/below-field error display
- 🔐 **Login Fields** — Pre-styled username & password fields with SVG icons
- 📐 **Button-Matched Height** — Same height as `OnProcessButtonWidget` for cohesive UI
- 🎨 **Material 3** — Native Material 3 theming support

---

## 🚀 Quick Start

```yaml
dependencies:
  on_text_input_widget: ^latest
```

```dart
import 'package:on_text_input_widget/on_text_input_widget.dart';

// Basic usage
OnTextInputWidget(
  hintText: "Search...",
  prefixIcon: Icon(Icons.search),
  onChangedProcessing: (value) async {
    // Search with 500ms debounce
    await searchAPI(value);
  },
)
```

---

## 📱 Demo

| Search | Validation | Login Form |
|--------|------------|-------------|
| ![Search Demo](https://raw.githubusercontent.com/SHAJED99/on_text_input_widget/refs/heads/main/screenshots/2.gif) | ![Validation Demo](https://raw.githubusercontent.com/SHAJED99/on_text_input_widget/refs/heads/main/screenshots/3.gif) | ![Login Demo](https://raw.githubusercontent.com/SHAJED99/on_text_input_widget/refs/heads/main/screenshots/4.gif) |

---

## 💡 Usage Examples

### Online Search with Debounce

```dart
OnTextInputWidget(
  hintText: "Search products...",
  prefixIcon: Icon(Icons.search),
  showPrefixLoadingIcon: true,
  onChangedProcessing: (value) async {
    // Automatically debounced — only fires after user stops typing
    final results = await api.search(value);
    setState(() => searchResults = results);
  },
)
```

### Form Validation

```dart
OnTextInputWidget(
  hintText: "Email",
  prefixIcon: Icon(Icons.email),
  validator: (value) {
    if (value?.isEmpty ?? true) return "Email is required";
    if (!value!.contains('@')) return "Invalid email";
    return null;
  },
  showDetailError: true,
)
```

### Login Form Pair

```dart
Column(
  children: [
    OnTextInputWidgetUserField(
      hintText: "Email",
      svg: "assets/icons/email.svg",
      keyboardType: TextInputType.emailAddress,
    ),
    SizedBox(height: 16),
    OnTextInputWidgetUserField(
      hintText: "Password",
      svg: "assets/icons/lock.svg",
      obscureText: true,
    ),
  ],
)
```

---

## 🛠️ Configuration Options

| Property | Type | Description |
|----------|------|-------------|
| `hintText` | `String?` | Placeholder text |
| `prefixIcon` | `Widget?` | Leading icon |
| `showPrefixLoadingIcon` | `bool` | Show spinner while searching |
| `validator` | `String? Function(String?)?` | Validation function |
| `showDetailError` | `bool` | Show error below field |
| `onChanged` | `void Function(String)?` | Offline change handler |
| `onChangedProcessing` | `Future<void> Function(String)?` | Async search handler |
| `obscureText` | `bool` | Hide text (passwords) |

---

## 📦 Related Packages

| Package | Description |
|---------|-------------|
| [`on_process_button_widget`](https://github.com/SHAJED99/on_process_button_widget) | Loading-state button widget |
| [`on_popup_window_widget`](https://github.com/SHAJED99/on_popup_window_widget) | Popup dialog widget |

---

## 🤝 Contributing

Contributions welcome! Open an issue or submit a PR.

## 📄 License

BSD 3-Clause License — see [LICENSE](LICENSE)