## 0.2.0

- **Breaking**: Raised minimum Flutter to 3.27.0 and Dart SDK to 3.6.0.
  The previously declared pair (Flutter >=3.3.0 with Dart >=3.0.0) was
  unsatisfiable — Flutter 3.3 ships Dart 2.18, and Dart 3.0 first shipped in
  Flutter 3.10. The real floor comes from `flutter_svg`, whose resolved 2.2.0
  requires Dart ^3.6.0 / Flutter >=3.27.0.
- Docs: Documented the behaviour of `errorBuilder`, which renders nothing
  unless `showDetailError` is also `true`
- Docs: Documented that `validator` does not gate `FormState.validate()`,
  which always reports success
- Docs: Documented that the default error mode clears the field, that
  `onChangedProcessing` drops intermediate values and swallows exceptions,
  and that the loading-icon flags are inert without it
- Docs: Documented controller disposal ownership, and that `initialValue`
  may be combined with a controller
- Docs: Corrected `errorCheck`, which fires on validation failure and on
  error-clearing only, never on success
- Docs: Added `doc/using-on-text-input-widget.md` (usage guide) and
  `doc/audit-2026-09-16.md` (known bugs and accessibility gaps)
- Docs: Added `CLAUDE.md`; corrected the analyze and example-test commands
  in `AGENTS.md`

## 0.1.0

- **Breaking**: Renamed `onChangeDebouncer` to `onChangeDebounce`
- **Breaking**: Narrowed `contentPadding` type from `EdgeInsetsGeometry` to `EdgeInsets`
- **Breaking**: Bumped minimum Flutter to 3.3.0 and Dart SDK to 3.0.0
- Fixed: Controller memory leak — internally created controllers now disposed
- Fixed: Missing `didUpdateWidget` — stale `hintText`, `borderRadius`, `textEditingController` after rebuild
- Fixed: `postFrameCallback` now has `mounted` guard
- Fixed: Debounce pipeline now recovers from `onChangedProcessing` exceptions
- Fixed: Validator no longer returns empty string as Form error
- Fixed: `_CustomAnimatedSize` now uses the passed `curve` parameter
- Fixed: Replaced deprecated `theme.buttonTheme.height` usage
- Fixed: `errorCheck` no longer clears text on successful validation
- Fixed: `Set<void>` literal replaced with normal void callback
- Fixed: `focusNode` shadowing — state field renamed to `focusOffset`
- Fixed: `_defaultBorderRadius` changed to `final`
- Added: 15 widget tests for both `OnTextInputWidget` and `OnTextInputWidgetUserField`
- Added: `AGENTS.md` for contributor instructions
- Docs: Rewrote README with full API reference

## 0.0.8

- Border Color added

## 0.0.7

- Refactored - Size

## 0.0.6

- Refactored - Size

## 0.0.5

- Refactored - showDetailError added to the OnTextInputWidgetUserField

## 0.0.4

- OnTextInputWidgetUserField added. It is a sub-widget implemented with OnProcessButtonWidget

## 0.0.3

- Some size error fixed

## 0.0.2

- Some size error fixed

## 0.0.1

- on_text_input_widget with many functionalities
