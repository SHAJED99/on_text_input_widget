# AGENTS.md

## Project Overview

`on_text_input_widget` — a Flutter package providing `OnTextInputWidget` (a highly customizable text input) and `OnTextInputWidgetUserField` (a login-form-oriented wrapper with password toggle and SVG icons).

## Further Reading

- `doc/using-on-text-input-widget.md` — how to *use* the two public widgets
  (debounce pipeline, error modes and their traps, controller ownership, styling).
- `doc/audit-2026-09-16.md` — known bugs and accessibility gaps, deliberately
  unfixed, with rationale.

## Build & Test Commands

```bash
# Install dependencies (uses FVM)
fvm flutter pub get

# Static analysis
fvm dart analyze

# Run package tests (15 tests)
fvm flutter test

# Run example app tests (must run from inside example/ — `flutter test example/`
# from the root cannot resolve `package:example`)
cd example && fvm flutter test
```

## Architecture

```
lib/
  on_text_input_widget.dart       # Library declaration + part directives
  src/
    components.dart               # Private constants (padding, border radius, default height)
    on_text_input_widget.dart     # OnTextInputWidget + _OnTextInputWidgetState
    widgets/
      animated_size.dart          # _CustomAnimatedSize (FractionallySizedBox + AnimatedSize)
      svg.dart                    # _SVG (SvgPicture.asset wrapper with color filter)
      user_field.dart             # OnTextInputWidgetUserField + _OnTextInputWidgetUserFieldState

test/
  on_text_input_widget_test.dart   # 15 widget tests covering both widgets
```

The package uses `part`/`part of` to avoid exporting internal widgets. All private types (`_CustomAnimatedSize`, `_SVG`, `_default*` constants) are accessible across all source files within the library.

## Key Design Decisions

### Controller Ownership
`OnTextInputWidget` tracks whether it created the `TextEditingController` internally (`_controllerIsInternal` flag). If created internally, it disposes the controller in `dispose()`. If provided externally by the caller, it leaves disposal to the caller. The flag is updated in `didUpdateWidget` when the controller parameter changes.

### Debounce Pipeline
`onChangedProcessing` uses a debounce timer. On each keystroke, the previous timer is cancelled and a new one starts. When the timer fires, it drains a `searchProductList` queue (processing the most recent value). The `isIdle` flag prevents overlapping async calls. If `onChangedProcessing` throws, the try/catch ensures `isIdle` is reset so future calls can proceed.

### Error Handling
- Validator returns `String?` — `null` means valid, non-null means error
- In default mode: input is cleared, hint text shows the error message
- In `showDetailError` mode: error appears in an animated collapsible section below the field
- `errorBuilder` customises the `showDetailError` section — it is only consulted
  when `showDetailError` is true (see `errorChild()`)
- `errorCheck` fires when validation *fails*, and again with `false` when tapping
  the field clears an error. It does not fire on successful validation

### UserField Password Toggle
When `obscureText` is true, a visibility toggle (eye icon) appears as the suffix icon once text is entered. On focus loss, the text is automatically re-hidden for security.

### Theme Integration
- Uses `Theme.of(context).colorScheme` for colors (primary, error, onSurface)
- Uses `Theme.of(context).textTheme` for typography (titleMedium, bodySmall)
- Uses `Theme.of(context).inputDecorationTheme` for border defaults
- Falls back to `theme.buttonTheme.height` (deprecated) for default height — this is a known backward-compat choice

## Flutter Version Requirements

- **Declared**: Flutter >=3.27.0, Dart SDK >=3.6.0
- The floor is set by `flutter_svg` (`^2.0.10+1` resolves to 2.2.0, which itself
  requires Dart `^3.6.0` / Flutter `>=3.27.0`), not by any API used here.
- Previously declared Flutter >=3.3.0 / Dart >=3.0.0, which was unsatisfiable:
  Flutter 3.3 ships Dart 2.18, and Dart 3.0 first shipped in Flutter 3.10.
- Developed and tested against the FVM pin, Flutter 3.27.4 / Dart 3.6.2.

## File Manifest

| File | Purpose |
|------|---------|
| `pubspec.yaml` | Package metadata, dependencies, asset declarations |
| `analysis_options.yaml` | Lint rules (flutter_lints + additional rules) |
| `lib/on_text_input_widget.dart` | Library entry point |
| `lib/src/components.dart` | Shared constants |
| `lib/src/on_text_input_widget.dart` | Main widget + state |
| `lib/src/widgets/animated_size.dart` | Size transition wrapper |
| `lib/src/widgets/svg.dart` | SVG asset loader |
| `lib/src/widgets/user_field.dart` | Login form wrapper |
| `assets/svg/eye_opened_icon.svg` | Password visible icon |
| `assets/svg/eye_closed_icon.svg` | Password hidden icon |
| `test/on_text_input_widget_test.dart` | Widget tests |
| `example/` | Demo app |

## Notes for Contributors

- Run `fvm dart analyze` before committing (not `analyze lib/` — that hides issues under `test/`)
- Run `fvm flutter test` — all 15 tests must pass
- Do not commit auto-generated files from `example/android/`, `example/linux/`, `example/macos/`, `example/windows/` unless a Flutter SDK upgrade requires it
- All private types start with underscore and are accessible across the library via `part`/`part of`
- FVM is configured at Flutter 3.27.4 — install with `fvm install`
