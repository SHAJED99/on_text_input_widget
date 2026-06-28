# Flutter Text Input Widget

A feature-rich, highly customizable text input widget with built-in search, validation, and async processing support.

## Features

- Debounced async text processing (ideal for API search)
- Built-in form validation with detailed error display
- Password visibility toggle via `OnTextInputWidgetUserField`
- Loading indicators on prefix/suffix icons
- Full animation support (size, border transitions)
- Compatible with `OnProcessButtonWidget` for same-height layouts

## Installation

```yaml
dependencies:
  on_text_input_widget: ^0.0.8
```

If you use SVG assets from this package (e.g. `OnTextInputWidgetUserField` with `svg:` parameter), the package includes them automatically.

## Usage

```dart
import 'package:on_text_input_widget/on_text_input_widget.dart';

OnTextInputWidget(
  hintText: 'Search',
  prefixIcon: Icon(Icons.search),
  showPrefixLoadingIcon: true,
  onChangedProcessing: (value) async {
    // Simulate API call
    await Future.delayed(Duration(seconds: 1));
    print('Searching: $value');
  },
)
```

### With Form validation

```dart
Form(
  key: _formKey,
  child: OnTextInputWidget(
    hintText: 'Email',
    validator: (value) {
      if (value?.isEmpty ?? true) return 'Please enter your email';
      return null;
    },
    showDetailError: true,
  ),
)
```

### Login fields with UserField

```dart
OnTextInputWidgetUserField(
  keyboardType: TextInputType.emailAddress,
  hintText: 'Enter your email',
  svg: 'packages/on_text_input_widget/assets/svg/message_icon.svg',
)

OnTextInputWidgetUserField(
  obscureText: true,
  hintText: 'Enter your password',
  svg: 'packages/on_text_input_widget/assets/svg/lock_icon.svg',
)
```

## License

BSD 3-Clause
