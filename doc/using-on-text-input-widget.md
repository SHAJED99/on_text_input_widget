---
name: using-on-text-input-widget
description: How to use the on_text_input_widget package — OnTextInputWidget and OnTextInputWidgetUserField. Covers debounced async search, the three error-display modes and their traps, controller/initialValue rules, loading icons, borders and theming. Use when adding, configuring or debugging either widget in a Flutter app.
---

# Using `on_text_input_widget`

Two public widgets. Everything else in the package is private.

| Widget | Use it for |
|---|---|
| `OnTextInputWidget` | The general-purpose field. Every feature lives here. |
| `OnTextInputWidgetUserField` | A thin login-form wrapper: SVG prefix icon + automatic password eye toggle. Delegates to `OnTextInputWidget`. |

```dart
import 'package:on_text_input_widget/on_text_input_widget.dart';
```

Requires Flutter >=3.27.0 / Dart >=3.6.0 (floor set by `flutter_svg`).

---

## 1. The four things that actually matter

Most of the ~70 parameters are pass-throughs to `TextFormField` / `InputDecoration`
and behave as you would expect. These four do not, and are where mistakes happen.

### 1.1 Debounced async search — `onChangedProcessing`

This is the package's reason to exist. Use it for search-as-you-type against a
server.

```dart
OnTextInputWidget(
  hintText: 'Search',
  prefixIcon: const Icon(Icons.search),
  showPrefixLoadingIcon: true,
  onChangeDebounce: const Duration(milliseconds: 500), // default: 1000ms
  onChangedProcessing: (String value) async {
    final List<Product> results = await api.search(value);
    setState(() => _results = results);
  },
)
```

How it behaves:

- Each keystroke cancels the pending timer and restarts it. The callback fires
  once, `onChangeDebounce` after typing stops.
- While a call is in flight, further keystrokes queue; when it finishes, only the
  **most recent** value is processed. Intermediate values are dropped, not
  replayed. This is intentional — you want the latest query, not all of them.
- Calls never overlap.
- If your callback throws, the exception is **swallowed** and the field recovers.
  You get no error and no log. Handle your own errors inside the callback.

`onChanged` and `onChangedProcessing` are independent and can be combined —
`onChanged` fires immediately on every keystroke (use it for local filtering),
`onChangedProcessing` fires debounced.

### 1.2 Error display — three modes, two of them working

Validation is driven by `validator`, returning `null` for valid or a message
string for invalid. Which mode you get depends on `showDetailError`:

```dart
// Mode A — default. Message replaces the hint text INSIDE the box.
OnTextInputWidget(hintText: 'Email', validator: _validate)

// Mode B — message appears in an animated section BELOW the box.
OnTextInputWidget(hintText: 'Email', validator: _validate, showDetailError: true)

// Mode C — custom widget below the box. showDetailError is REQUIRED.
OnTextInputWidget(
  hintText: 'Email',
  validator: _validate,
  showDetailError: true, // omit this and NOTHING renders
  errorBuilder: (String message) => Text(message),
)
```

Three traps, in order of how likely you are to hit them:

1. **`errorBuilder` without `showDetailError: true` silently shows nothing.** The
   builder is only consulted inside a branch guarded by `showDetailError`, but
   supplying a builder also disables the Mode A fallback. Always pair them.
2. **Mode A clears the field.** A failed validation calls `clear()` on the
   controller — the user's text is gone, and the message (living in the hint) is
   visible only while the field is empty, so it disappears as soon as they
   retype. Prefer `showDetailError: true` for anything typed at length.
3. **`Form.validate()` always returns `true`.** The internal validator returns
   `null` on every path, including failure, so it cannot gate a submit. Call your
   validation function directly if you need a real guard:

   ```dart
   if (_validate(_controller.text) != null) return; // do not rely on _formKey
   ```

`errorCheck` is a notification, not a check: it fires with `(true, message)` on
failure, and `(false, '')` when tapping the field clears an existing error. It
does **not** fire on successful validation.

### 1.3 Controller and `initialValue`

Unlike `TextFormField`, you may pass **both**. `initialValue` is written into the
controller in a post-frame callback.

```dart
OnTextInputWidget(textEditingController: _controller, initialValue: 'seed')
```

Ownership rules — get this wrong and you either leak or crash:

- Pass no controller: the widget creates one and **disposes it for you**.
- Pass your own: **you** dispose it. The widget will not.
- Swap the controller at runtime: handled correctly in `didUpdateWidget`.

Note the parameter is `textEditingController`, not `controller`.

### 1.4 Loading icons need `onChangedProcessing`

`showPrefixLoadingIcon` / `showSuffixLoadingIcon` only render while an
`onChangedProcessing` call is in flight. With no async callback they never
appear — the flag alone does nothing. The spinner replaces `prefixIcon` /
`suffixIcon` in place, animating the width change.

```dart
loadingIcon: const MyCustomSpinner(), // optional; default CircularProgressIndicator
loadingIconColor: Colors.blue,        // ignored when loadingIcon is set
loadingIconsSize: 24,
```

---

## 2. `OnTextInputWidgetUserField`

For login forms. Adds two things over the base widget.

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

- **`svg`** is an asset *path string*, not a widget — rendered as the prefix icon,
  tinted `colorScheme.primary` (50% alpha while the field is empty). Use
  `prefixChild` to place a widget alongside it. The asset must be declared in
  *your* app's `pubspec.yaml`.
- **Password toggle** appears automatically when `obscureText: true`, but only
  once the field is non-empty. Losing focus re-hides the text.
- **`border`** is a single `InputBorder` fanned out to all five border states
  (enabled / focused / error / disabled / focusedError). States cannot be styled
  separately here — drop to `OnTextInputWidget` for that.
- **Loading icon is automatic**: supplying `onChangedProcessing` implicitly
  enables the prefix loading icon.

**Parameter names differ from the base widget** — a known wart:

| UserField | `OnTextInputWidget` |
|---|---|
| `maxLine` / `minLine` | `maxLines` / `minLines` |
| `enable` | `enabled` |

UserField exposes a deliberately small subset. Anything not in its constructor is
unreachable — use `OnTextInputWidget` directly.

---

## 3. Styling

Defaults are theme-driven but opinionated. Input text defaults to
`textTheme.titleMedium` in **`colorScheme.primary`, bold**. Override `style` for
conventional body text:

```dart
style: Theme.of(context).textTheme.bodyLarge, // common override
```

Borders resolve in this order: explicit `*Border` parameter →
`theme.inputDecorationTheme` → an `OutlineInputBorder` built from `borderRadius`.
The `*BorderColor` and `borderWidth` shorthands override the `BorderSide` of
whichever border wins, so you can recolour without rebuilding the whole border:

```dart
OnTextInputWidget(
  borderRadius: BorderRadius.circular(12),
  focusedBorderColor: Colors.green,
  enabledBorderColor: Colors.grey,
  borderWidth: 2,
  fillColor: Colors.grey.shade100,
)
```

Sizing: height comes from `boxConstraints?.minHeight`, else the deprecated
`theme.buttonTheme.height` (36dp default). This is deliberate — it matches
`on_process_button_widget` so a field and a button align in a `Row`. Override
with `boxConstraints: const BoxConstraints(minHeight: 48)`.

`contentPadding` defaults to `EdgeInsets.symmetric(horizontal: 8, vertical: 6)`
and also drives the gap between the prefix icon and the text.

Other behaviour flags: `fullTextSelection: true` selects all text on first tap;
tapping outside unfocuses (`onTapOutside` runs after the built-in unfocus).

---

## 4. Accessibility — known gaps

The package ships **no** `Semantics`, `semanticLabel` or `Tooltip` anywhere. For
an accessible form, compensate at the call site:

- The password toggle is an unlabelled `GestureDetector` at 24x24 — below the
  48dp minimum target, and silent to screen readers.
- Errors are conveyed by hint-text colour only, and `errorStyle` is forced to
  `fontSize: 0`, so nothing reaches `InputDecoration.errorText` — the channel
  assistive tech announces. Wrap in your own `Semantics` with `liveRegion` if
  error announcement matters.
- The default 36dp height is under the 48dp touch-target minimum.

---

## 5. Quick reference

| Want | Use |
|---|---|
| Immediate per-keystroke callback | `onChanged` |
| Debounced async/server callback | `onChangedProcessing` + `onChangeDebounce` |
| Error below the field | `showDetailError: true` |
| Custom error widget | `showDetailError: true` **and** `errorBuilder` |
| React to validation failure | `errorCheck` |
| Block a form submit | Call your validator directly — `Form.validate()` is unreliable |
| Password field with toggle | `OnTextInputWidgetUserField(obscureText: true)` |
| Per-state border styling | `OnTextInputWidget`, not UserField |
| Field matching a button's height | Leave height default, or set `boxConstraints` |

See `example/lib/main.dart` for a runnable demo of each mode.
