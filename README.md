# Flutter Text Input Widget

A feature-rich, highly customizable text input widget for Flutter with built-in debounced async processing, validation, and error display.

## Requirements

| Platform | Minimum Version |
|----------|----------------|
| Dart SDK | >=3.0.0 |
| Flutter | >=3.3.0 |

## Installation

```yaml
dependencies:
  on_text_input_widget: ^0.0.8
```

Then import:

```dart
import 'package:on_text_input_widget/on_text_input_widget.dart';
```

## Widgets

### OnTextInputWidget

The primary text input widget. Wraps `TextFormField` with debounced async processing, animated loading icons, inline/expanded error display, and full border customization.

#### Basic Usage

```dart
OnTextInputWidget(
  hintText: 'Search',
  prefixIcon: Icon(Icons.search),
  showPrefixLoadingIcon: true,
  onChangedProcessing: (value) async {
    // Debounced API call — only fires after user stops typing
    await fetchResults(value);
  },
)
```

#### Form Validation

```dart
Form(
  key: _formKey,
  child: OnTextInputWidget(
    hintText: 'Email',
    validator: (value) {
      if (value?.isEmpty ?? true) return 'Required';
      return null;
    },
    showDetailError: true,  // Show error below the field
  ),
)
```

#### Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `textEditingController` | `TextEditingController?` | Auto-created | Controller for the text field |
| `hintText` | `String` | `''` | Placeholder text |
| `initialValue` | `String?` | null | Initial text (use only without controller) |
| `obscureText` | `bool` | false | Hide text (passwords) |
| `obscuringCharacter` | `String` | `'•'` | Character for obscured text |
| `maxLines` | `int?` | 1 | Maximum lines (null = auto-expand) |
| `minLines` | `int?` | null | Minimum lines |
| `maxLength` | `int?` | null | Max character count |
| `textAlign` | `TextAlign` | `TextAlign.start` | Horizontal text alignment |
| `textAlignVertical` | `TextAlignVertical?` | null | Vertical text alignment |
| `textCapitalization` | `TextCapitalization` | `TextCapitalization.none` | Keyboard capitalization |
| `keyboardType` | `TextInputType` | `TextInputType.text` | Keyboard type |
| `autofocus` | `bool` | false | Auto-focus on mount |
| `autocorrect` | `bool` | true | Enable autocorrect |
| `enabled` | `bool` | true | Whether editable |
| `readOnly` | `bool` | false | Read-only mode |
| `autofillHints` | `List<String>?` | null | Autofill hints |
| `inputFormatters` | `List<TextInputFormatter>?` | null | Input formatters |
| `focusNode` | `FocusNode?` | null | External focus control |
| `fullTextSelection` | `bool` | false | Select all text on first tap |
| **Styling** | | | |
| `style` | `TextStyle?` | `textTheme.titleMedium` | Input text style |
| `hintStyle` | `TextStyle?` | Faded primary | Placeholder style |
| `errorStyle` | `TextStyle?` | Error color | Error hint style |
| `errorTextStyle` | `TextStyle?` | `bodySmall` bold error | Detail error text style |
| `errorColor` | `Color?` | `colorScheme.error` | Error state color |
| `fillColor` | `Color?` | Theme default | Background fill |
| `contentPadding` | `EdgeInsets?` | `8h, 6v` | Internal padding |
| `boxConstraints` | `BoxConstraints?` | minHeight 48 | Size constraints |
| `borderRadius` | `BorderRadius?` | 8px circular | Input border radius |
| `isDense` | `bool` | true | Reduced vertical space |
| `isCollapsed` | `bool` | false | Collapse decoration |
| `cursorColor` | `Color?` | `colorScheme.primary` | Cursor color |
| **Borders** | | | |
| `borderWidth` | `double?` | Theme default | Border thickness |
| `enabledBorder` | `InputBorder?` | `OutlineInputBorder` | Enabled border |
| `focusedBorder` | `InputBorder?` | `OutlineInputBorder` | Focused border |
| `errorBorder` | `InputBorder?` | `OutlineInputBorder` | Error border |
| `focusedErrorBorder` | `InputBorder?` | `OutlineInputBorder` | Focused+error border |
| `disabledBorder` | `InputBorder?` | `OutlineInputBorder` | Disabled border |
| `enabledBorderColor` | `Color?` | Faded primary | Enabled border color |
| `focusedBorderColor` | `Color?` | `colorScheme.primary` | Focused border color |
| `errorBorderColor` | `Color?` | `colorScheme.error` | Error border color |
| `focusedErrorBorderColor` | `Color?` | Faded primary | Focused+error border color |
| `disabledBorderColor` | `Color?` | Faded primary | Disabled border color |
| **Labels** | | | |
| `label` | `Widget?` | null | Custom label widget |
| `labelText` | `String?` | null | Label text |
| `labelStyle` | `TextStyle?` | null | Label style |
| `floatingLabelBehavior` | `FloatingLabelBehavior?` | null | Floating label mode |
| **Icons** | | | |
| `prefixIcon` | `Widget?` | null | Icon before input |
| `suffixIcon` | `Widget?` | null | Icon after input |
| `prefix` | `Widget?` | null | Widget before input (inside decoration) |
| `suffix` | `Widget?` | null | Widget after input (inside decoration) |
| `showPrefixLoadingIcon` | `bool` | false | Show spinner at prefix |
| `showSuffixLoadingIcon` | `bool` | false | Show spinner at suffix |
| `loadingIcon` | `Widget?` | `CircularProgressIndicator` | Custom spinner |
| `loadingIconsSize` | `double?` | 24 | Spinner size |
| `loadingIconColor` | `Color?` | `colorScheme.primary` | Spinner color |
| **Animation** | | | |
| `animationDuration` | `Duration` | 500ms | Transition duration |
| `animationCurve` | `Curve` | `Curves.linear` | Transition curve |
| `clipBehavior` | `Clip` | `Clip.antiAlias` | Clip for animated content |
| **Callbacks** | | | |
| `onChanged` | `void Function(String)?` | null | Fires on every keystroke |
| `onChangedProcessing` | `Future<void>? Function(String)?` | null | Debounced async callback |
| `onChangeDebounce` | `Duration` | 1000ms | Debounce delay for processing |
| `onComplete` | `void Function(String?)?` | null | Fires on editing complete |
| `onTap` | `void Function()?` | null | Fires on tap |
| `onTapOutside` | `void Function(PointerDownEvent)?` | null | Fires on tap outside |
| `onFocusChange` | `Function(bool)?` | null | Focus state changed |
| `validator` | `String? Function(String?)?` | null | Form field validator |
| `errorCheck` | `void Function(bool, String)?` | null | Called when validation runs |
| `errorBuilder` | `Widget Function(String)?` | null | Custom error widget |
| `showDetailError` | `bool` | false | Show error below field |

### OnTextInputWidgetUserField

A higher-level wrapper around `OnTextInputWidget` designed for login/register forms. Features:

- **Password visibility toggle** — eye icon appears when `obscureText: true` and text is entered
- **SVG prefix icons** — pass `svg` asset path to show an SVG icon before the input
- **Auto-hides password on focus loss** — when obscured field loses focus, text is re-hidden
- **Auto-loading on debounce** — shows prefix loading spinner when `onChangedProcessing` is provided

#### Usage

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

#### Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `textEditingController` | `TextEditingController?` | Auto-created | Controller |
| `hintText` | `String` | `''` | Placeholder |
| `initialValue` | `String?` | null | Initial text |
| `svg` | `String` | `''` | SVG asset path for prefix icon |
| `prefixChild` | `Widget?` | null | Extra widget after SVG icon |
| `suffixIcon` | `Widget?` | null | Custom suffix (overrides eye icon) |
| `obscureText` | `bool` | false | Password mode |
| `keyboardType` | `TextInputType` | `TextInputType.text` | Keyboard type |
| `autofocus` | `bool` | false | Auto-focus |
| `enable` | `bool` | true | Editable |
| `readOnly` | `bool` | false | Read-only |
| `maxLine` | `int?` | 1 | Max lines |
| `minLine` | `int?` | 1 | Min lines |
| `border` | `InputBorder?` | null | Border for all states |
| `isDense` | `bool` | true | Dense layout |
| `isCollapsed` | `bool` | false | Collapsed decoration |
| `boxConstraints` | `BoxConstraints?` | null | Size constraints |
| `contentPadding` | `EdgeInsets?` | null | Internal padding |
| `autofillHints` | `List<String>?` | null | Autofill hints |
| `showDetailError` | `bool` | false | Show error below |
| `onChanged` | `void Function(String)?` | null | Text changed |
| `onChangedProcessing` | `Future<void>? Function(String)?` | null | Debounced async |
| `validator` | `String? Function(String?)?` | null | Validator |

## Features in Detail

### Debounced Async Processing

The `onChangedProcessing` callback fires only after the user stops typing for `onChangeDebounce` duration. If processing is running, the spinner automatically shows at the prefix/suffix icon.

```dart
OnTextInputWidget(
  hintText: 'Search products',
  prefixIcon: Icon(Icons.search),
  showPrefixLoadingIcon: true,
  onChangeDebounce: Duration(milliseconds: 500),
  onChangedProcessing: (query) async {
    final results = await api.search(query);
    // Update UI with results
  },
)
```

### Error Display Modes

- **Default (in-box)**: Error message replaces the hint text and the input is cleared
- **showDetailError**: Error message appears below the field in a collapsible animated section
- **errorBuilder**: Full custom widget for error display

```dart
OnTextInputWidget(
  hintText: 'Email',
  validator: (v) => v?.contains('@') != true ? 'Invalid email' : null,
  showDetailError: true,
)

// Or custom error widget:
OnTextInputWidget(
  hintText: 'Email',
  validator: (v) => v?.contains('@') != true ? 'Invalid email' : null,
  showDetailError: true,
  errorBuilder: (msg) => Card(
    color: Colors.red.shade50,
    child: Padding(
      padding: EdgeInsets.all(8),
      child: Row(children: [
        Icon(Icons.error, color: Colors.red),
        SizedBox(width: 8),
        Expanded(child: Text(msg)),
      ]),
    ),
  ),
)
```

### Border Control

Each border state (enabled, focused, error, focused+error, disabled) can be independently styled with either a full `InputBorder` or just a color. If `borderWidth` is provided, it applies to all states.

```dart
OnTextInputWidget(
  hintText: 'Custom borders',
  borderWidth: 3,
  enabledBorderColor: Colors.grey,
  focusedBorderColor: Colors.blue,
  errorBorderColor: Colors.red,
  borderRadius: BorderRadius.circular(16),
)
```

### Full Text Selection

Automatically selects all text on first tap — useful for editable fields where the user needs to replace the entire content (e.g., OTP inputs, numeric amounts).

```dart
OnTextInputWidget(
  hintText: 'Enter amount',
  keyboardType: TextInputType.number,
  fullTextSelection: true,
)
```

## License

BSD 3-Clause. See `LICENSE` file.
