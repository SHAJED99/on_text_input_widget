# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

`AGENTS.md` covers the same ground in more detail (file manifest, API notes); keep the two in sync when architecture changes.

## Commands

The project pins Flutter 3.27.4 via FVM (`.fvmrc`, `.vscode/settings.json` points at `.fvm/versions/3.27.4`). Prefix every Flutter/Dart command with `fvm`.

```bash
fvm install                       # one-time SDK setup
fvm flutter pub get               # deps (run in example/ separately for the demo app)
fvm dart analyze lib/             # must report 0 issues before committing
fvm flutter test                  # package widget tests (test/on_text_input_widget_test.dart)
fvm flutter test --plain-name 'toggles password visibility'   # single test by name
fvm flutter test example/         # example app test
cd example && fvm flutter run     # run the demo app
```

## Architecture

Single-library package built with `part` / `part of`, not `export`. `lib/on_text_input_widget.dart` holds the only `library` declaration and all imports; every file under `lib/src/` is a `part` of it. Consequences to respect when editing:

- Add new source files as `part` directives in `lib/on_text_input_widget.dart`, and never add `import` statements to `src/` files — imports live only in the entry file.
- Private types (`_CustomAnimatedSize`, `_SVG`, `_default*` constants in `src/components.dart`) are shared across the whole library. Underscore prefixes are the mechanism for keeping internals out of the public API.
- Only `OnTextInputWidget` (`src/on_text_input_widget.dart`, ~780 lines, the bulk of the package) and `OnTextInputWidgetUserField` (`src/widgets/user_field.dart`) are public.

### Behaviors that span files / are easy to break

**Controller ownership** — `_OnTextInputWidgetState` tracks `_controllerIsInternal`. A controller it created is disposed in `dispose()`; a caller-supplied one is not. `didUpdateWidget` re-evaluates the flag when the `textEditingController` parameter changes (including switching between internal and external). Any change to controller handling must keep all three sites consistent.

**Debounce pipeline** — `onChangedProcessing` keystrokes feed a `searchProductList` queue behind a `Timer` (`onChangeDebounce`). Each keystroke cancels the pending timer; when it fires, the loop drains the queue taking only the *latest* value, guarded by `isIdle` so async calls never overlap. The `await` is wrapped in `try/catch` specifically so a throwing callback still resets `isIdle` — do not remove that catch.

**Error rendering** is driven by a `String?` validator (null = valid), with two working modes: default (clears the input, surfaces the message as hint text) and `showDetailError` (animated collapsible section below the field via `_CustomAnimatedSize`, optionally rendered by `errorBuilder`). `errorCheck` fires only when the validator returns a message, and again with `false` when tapping the field clears an existing error — not on successful validation.

Two sharp edges in this area (see the audit notes below before touching it): `errorBuilder` is only consulted inside `errorChild()`, which returns `SizedBox()` unless `showDetailError` is true, so `errorBuilder` alone silently swallows the error; and the `validator` returns `null` on every path, so an enclosing `Form.validate()` always reports success.

**UserField password toggle** — the eye icon appears as a suffix only once text exists, and focus loss re-obscures the text. Icons come from `assets/svg/` through `_SVG`, declared in `pubspec.yaml`.

### Theming

Colors/typography/borders come from `Theme.of(context)` (`colorScheme`, `textTheme.titleMedium` / `bodySmall`, `inputDecorationTheme`). Default height deliberately falls back to the deprecated `theme.buttonTheme.height` for sizing consistency with existing consumers — this was reverted to on purpose (see commit f8af1a9); don't "fix" it without a reason.

## Constraints

- Published package: `environment` declares Flutter >=3.27.0 / Dart >=3.6.0. That floor comes from `flutter_svg` (`^2.0.10+1` resolves to 2.2.0, which requires Flutter >=3.27.0), not from any API used here. Changing the `flutter_svg` constraint means rechecking this. Bump the CHANGELOG when the floor moves.
- `analysis_options.yaml` enables `public_member_api_docs`, `always_specify_types`, `prefer_single_quotes`, `require_trailing_commas`, `sort_constructors_first`, and `lines_longer_than_80_chars`, plus `implicit-casts: false`. New public members need doc comments and explicit types.
- Generated platform files under `example/android|linux|macos|windows/` churn on SDK changes; leave them out of commits unless a deliberate SDK upgrade requires them.
