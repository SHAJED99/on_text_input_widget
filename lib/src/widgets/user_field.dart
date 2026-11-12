part of '../../on_text_input_widget.dart';

/// A specialized text input field for user data entry with built-in
/// features like password visibility toggling and icon styling.
///
/// This widget extends the functionality of [OnTextInputWidget] with specific
/// features for user input fields such as username and password fields.
class OnTextInputWidgetUserField extends StatefulWidget {
  /// Creates a text input field optimized for user data entry.
  ///
  /// The [hintText] parameter is used as placeholder text.
  /// The [svg] parameter specifies an SVG icon to display as prefix.
  /// The [obscureText] parameter determines if this is a password field.
  const OnTextInputWidgetUserField({
    super.key,
    this.autofocus = false,
    this.hintText = '',
    this.svg = '',
    this.prefixChild,
    this.controller,
    this.onChanged,
    this.onChangedProcessing,
    this.validator,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.initialValue,
    this.maxLines = 1,
    this.minLines = 1,
    this.maxLength,
    this.enabled = true,
    this.readOnly = false,
    this.border,
    this.isCollapsed = false,
    this.isDense = true,
    this.boxConstraints,
    this.contentPadding,
    this.autofillHints,
    this.suffixIcon,
    this.showDetailError = false,
  });

  /// Whether the text field should automatically acquire focus when displayed.
  final bool autofocus;

  /// Placeholder text displayed when the text field is empty.
  final String hintText;

  /// Path to an SVG asset displayed as the prefix icon — an asset path
  /// string, not a widget. The asset must be declared in the consuming
  /// app's `pubspec.yaml`.
  final String svg;

  /// Optional widget to display before the text input, alongside the SVG icon.
  final Widget? prefixChild;

  /// Controller for the text field. If omitted, one is created internally
  /// and disposed automatically; if supplied, disposing it remains the
  /// caller's responsibility.
  final TextEditingController? controller;

  /// Callback function triggered when the text changes.
  final void Function(String value)? onChanged;

  /// Async callback for processing text changes, debounced. Useful for
  /// search operations or API calls.
  ///
  /// Supplying this automatically enables the prefix loading icon. Calls
  /// never overlap, only the most recent value is processed, and thrown
  /// exceptions are swallowed — handle errors inside the callback.
  final Future<void>? Function(String)? onChangedProcessing;

  /// Validation function returning an error message, or `null` if valid.
  ///
  /// Drives this widget's error display only; an enclosing [FormState.validate]
  /// always returns `true` and cannot be used to gate a submit.
  final String? Function(String? value)? validator;

  /// The type of keyboard to use for editing the text.
  final TextInputType keyboardType;

  /// Whether to hide the text being edited (for passwords).
  final bool obscureText;

  /// Initial value of the text field.
  final String? initialValue;

  /// Maximum number of lines for the text field.
  final int? maxLines;

  /// Minimum number of lines for the text field.
  final int? minLines;

  /// Maximum number of characters allowed in the text field. When set, a
  /// character counter is shown below the field.
  final int? maxLength;

  /// Whether the text field is enabled.
  final bool enabled;

  /// Whether the text field is read-only.
  final bool readOnly;

  /// Custom border, applied to all five border states (enabled, focused,
  /// error, disabled, focusedError). Use [OnTextInputWidget] directly to
  /// style states separately.
  final InputBorder? border;

  /// Whether the decoration is collapsed (compact).
  final bool isCollapsed;

  /// Whether the decoration is dense (uses less vertical space).
  final bool isDense;

  /// Size constraints for the text field.
  final BoxConstraints? boxConstraints;

  /// Padding within the text field.
  final EdgeInsets? contentPadding;

  /// List of autofill hints for the keyboard.
  final List<String>? autofillHints;

  /// Optional widget to display after the text input.
  final Widget? suffixIcon;

  /// Whether to show the error message below the field instead of
  /// replacing the hint text inside it.
  ///
  /// When `false`, a failed validation clears the field.
  final bool showDetailError;

  @override
  State<OnTextInputWidgetUserField> createState() =>
      _OnTextInputWidgetUserFieldState();
}

/// The state for the [OnTextInputWidgetUserField] widget.
class _OnTextInputWidgetUserFieldState
    extends State<OnTextInputWidgetUserField> {
  String _string = '';

  bool _showText = true;

  @override
  void initState() {
    super.initState();
    _string = widget.controller?.text ?? '';
    _showText = !widget.obscureText;
  }

  @override
  void didUpdateWidget(OnTextInputWidgetUserField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.controller != oldWidget.controller) {
      _string = widget.controller?.text ?? '';
    }
    if (widget.obscureText != oldWidget.obscureText) {
      _showText = !widget.obscureText;
    }
  }

  Widget? _setSuffixIcon() {
    if (widget.suffixIcon != null) return widget.suffixIcon;

    if (widget.obscureText) {
      if (_string.isEmpty) return null;

      final String label = _showText ? 'Hide password' : 'Show password';
      return Semantics(
        button: true,
        label: label,
        child: Tooltip(
          message: label,
          child: GestureDetector(
            onTap: () => setState(() => _showText = !_showText),
            //* Opaque so the whole padded area is tappable, not just the
            //* glyph, which is well under the 48dp minimum target on its own.
            behavior: HitTestBehavior.opaque,
            child: ConstrainedBox(
              constraints: const BoxConstraints(minWidth: _minTapTarget),
              child: Center(
                widthFactor: 1,
                child: _sized(
                  child: _SVG(
                    _showText
                        ? 'packages/on_text_input_widget/assets/svg/eye_opened_icon.svg'
                        : 'packages/on_text_input_widget/assets/svg/eye_closed_icon.svg',
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    }

    return null;
  }

  Widget _sized({required Widget child}) {
    const double h = _defaultHeight;
    return Container(
      constraints: const BoxConstraints(
        maxWidth: h / 2,
        maxHeight: h / 2,
      ),
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    return OnTextInputWidget(
      autofillHints: widget.autofillHints,
      contentPadding: widget.contentPadding,
      isDense: widget.isDense,
      isCollapsed: widget.isCollapsed,
      readOnly: widget.readOnly,
      enabled: widget.enabled,
      autofocus: widget.autofocus,
      controller: widget.controller,
      initialValue: widget.initialValue,
      hintText: widget.hintText,
      keyboardType: widget.keyboardType,
      obscureText: !_showText,
      maxLines: widget.maxLines,
      minLines: widget.minLines,
      maxLength: widget.maxLength,
      boxConstraints: widget.boxConstraints,
      showDetailError: widget.showDetailError,
      onFocusChange: (bool isFocused) {
        if (widget.obscureText && !isFocused) setState(() => _showText = false);
      },
      suffixIcon: _setSuffixIcon(),
      validator: widget.validator,
      onError: (bool error, String message) {
        if (error) {
          setState(() {
            _string = '';
          });
        }
      },
      onChanged: (String value) {
        setState(() {
          _string = value;
        });
        if (widget.onChanged != null) widget.onChanged!(value);
      },
      errorBorder: widget.border,
      enabledBorder: widget.border,
      focusedBorder: widget.border,
      disabledBorder: widget.border,
      focusedErrorBorder: widget.border,
      onChangedProcessing: widget.onChangedProcessing,
      showPrefixLoadingIcon: widget.onChangedProcessing != null,
      prefixIcon: widget.svg.isEmpty && widget.prefixChild == null
          ? null
          : Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                if (widget.svg.isNotEmpty)
                  _sized(
                    child: _SVG(
                      widget.svg,
                      color: _string.isEmpty
                            ? Theme.of(context)
                                .colorScheme
                                .primary
                                .withAlpha(127)
                            : Theme.of(context).colorScheme.primary,
                    ),
                  ),
                if (widget.svg.isNotEmpty && widget.prefixChild != null)
                  SizedBox(width: (widget.contentPadding?.horizontal ?? 0) / 2),
                if (widget.prefixChild != null) widget.prefixChild!,
              ],
            ),
    );
  }
}
