---
name: on-text-input-widget
description: Use the on_text_input_widget Flutter package — OnTextInputWidget and OnTextInputWidgetUserField. Covers debounced async search, error display modes, controller ownership, loading icons, styling and accessibility. Use when adding, configuring or debugging either widget, building a search field or a login form with this package.
---

# on_text_input_widget

Two public widgets; everything else in the package is private.

| Widget | Use for |
|---|---|
| `OnTextInputWidget` | General-purpose field. Every feature lives here. |
| `OnTextInputWidgetUserField` | Login-form wrapper: SVG prefix icon + password eye toggle. Delegates to `OnTextInputWidget`. |

```dart
import 'package:on_text_input_widget/on_text_input_widget.dart';
```

Requires Flutter >=3.27.0 / Dart >=3.6.0 (floor set by `flutter_svg`).

**Version matters.** Behaviour below is 0.2.0+. In 0.1.0 and earlier,
`FormState.validate()` always returned `true`, a failed validation cleared the
user's input, `errorBuilder` rendered nothing without `showDetailError`, and
several parameters had different names (see Migration at the end).

## Debounced async search

The package's main reason to exist — search-as-you-type against a server.

```dart
OnTextInputWidget(
  hintText: 'Search',
  prefixIcon: const Icon(Icons.search),
  showPrefixLoadingIcon: true,
  debounceDuration: const Duration(milliseconds: 500), // default 1000ms
  onChangedProcessing: (String value) async {
    final List<Product> results = await api.search(value);
    setState(() => _results = results);
  },
)
```

- Fires once, `debounceDuration` after typing stops.
- Calls never overlap. Keystrokes arriving mid-flight are coalesced and only the
  **most recent** value is processed — intermediate values are dropped.
- **Exceptions are swallowed**, with nothing logged or rethrown. Handle errors
  inside the callback.
- `onChanged` (immediate, every keystroke) is independent and can be combined
  with it — use `onChanged` for local filtering.
- `showPrefixLoadingIcon` / `showSuffixLoadingIcon` render **only** while an
  `onChangedProcessing` call is in flight. Without that callback they do
  nothing. On `OnTextInputWidgetUserField` the prefix spinner is automatic.

## Validation and errors

`validator` returns `null` when valid, or a message. The result reaches the
enclosing `Form`, so this works normally:

```dart
if (_formKey.currentState!.validate()) submit();
```

A failed validation **never clears the field**. Three display choices:

```dart
// Default — built-in error text below the field.
OnTextInputWidget(hintText: 'Email', validator: _validate)

// Animated collapsible section below the field.
OnTextInputWidget(hintText: 'Email', validator: _validate,
    showDetailError: true)

// Custom widget — works with or without showDetailError.
OnTextInputWidget(
  hintText: 'Email',
  validator: _validate,
  errorBuilder: (String message) => Text(message),
)
```

When `showDetailError` or `errorBuilder` renders the message, the built-in error
text is kept at zero size to carry it to assistive technology, and the visible
copy is wrapped in `ExcludeSemantics` so it is not announced twice.

`onError` is a notification, not a check: `(true, message)` on failure, and
`(false, '')` when tapping the field clears an existing error. It does **not**
fire on successful validation.

## Controller and initialValue

Unlike `TextFormField`, both may be passed together — `initialValue` is written
into the controller after the first frame.

```dart
OnTextInputWidget(controller: _controller, initialValue: 'seed')
```

- No controller passed → created internally and **disposed for you**.
- Controller passed → **you** dispose it.
- Swapping the controller at runtime is handled in `didUpdateWidget`.

## Login form

```dart
OnTextInputWidgetUserField(
  hintText: 'Enter your email',
  keyboardType: TextInputType.emailAddress,
  svg: 'lib/assets/icons/message_icon.svg',
  validator: _validateEmail,
),
OnTextInputWidgetUserField(
  hintText: 'Enter your password',
  obscureText: true,
  keyboardType: TextInputType.visiblePassword,
  svg: 'lib/assets/icons/lock_icon.svg',
),
```

- `svg` is an asset **path string**, not a widget. Declare it in the consuming
  app's `pubspec.yaml`. Use `prefixChild` for a widget beside it.
- The eye toggle appears when `obscureText: true` **and** the field is
  non-empty; focus loss re-hides the text. It is a labelled semantic button
  ("Show password" / "Hide password") with a 48dp tap target.
- `border` applies to all five border states at once. For per-state styling use
  `OnTextInputWidget` directly.
- UserField exposes a small subset of the base widget's parameters; anything not
  in its constructor is unreachable.

## Styling

Input text defaults to `textTheme.titleMedium` in **`colorScheme.primary`,
bold** — override for conventional body text:

```dart
style: Theme.of(context).textTheme.bodyLarge,
```

Borders resolve: explicit `*Border` → `theme.inputDecorationTheme` →
`OutlineInputBorder` from `borderRadius`. The `*BorderColor` and `borderWidth`
shorthands override the winning border's `BorderSide`:

```dart
OnTextInputWidget(
  borderRadius: BorderRadius.circular(12),
  enabledBorderColor: Colors.grey,
  focusedBorderColor: Colors.green,
  borderWidth: 2,
  fillColor: Colors.grey.shade100,
)
```

Height is `boxConstraints?.minHeight`, else `theme.buttonTheme.height` (36dp).
The default is deliberate — it aligns the field with `on_process_button_widget`
in a `Row` — but it is **below the 48dp minimum touch target**. Where that
matters:

```dart
boxConstraints: const BoxConstraints(minHeight: 48),
```

Also: `fullTextSelection: true` selects all on first tap; tapping outside
unfocuses, with `onTapOutside` running after the built-in unfocus.

## Migration to 0.2.0

| Before | After | Widget |
|---|---|---|
| `textEditingController` | `controller` | both |
| `errorCheck` | `onError` | `OnTextInputWidget` |
| `onChangeDebounce` | `debounceDuration` | `OnTextInputWidget` |
| `maxLine` / `minLine` | `maxLines` / `minLines` | `OnTextInputWidgetUserField` |
| `enable` | `enabled` | `OnTextInputWidgetUserField` |

Behaviour also changed: `FormState.validate()` now reflects validity, failed
validation no longer clears the input, and `errorBuilder` renders without
`showDetailError`. Code that worked around any of those should be revisited.

## Reference

- `doc/using-on-text-input-widget.md` — the same material in prose.
- `doc/audit-2026-09-16.md` — remaining known gaps.
- `example/lib/main.dart` — runnable demo of each mode.
