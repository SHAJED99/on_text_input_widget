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
    Key? key,
    this.autofocus = false,
    this.hintText = '',
    this.svg = '',
    this.prefixChild,
    this.textEditingController,
    this.onChanged,
    this.onChangedProcessing,
    this.validator,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.initialValue,
    this.maxLine = 1,
    this.minLine = 1,
    this.enable = true,
    this.readOnly = false,
    this.border,
    this.isCollapsed = false,
    this.isDense = true,
    this.boxConstraints,
    this.contentPadding,
    this.autofillHints,
    this.suffixIcon,
    this.showDetailError = false,
  }) : super(key: key);

  /// Whether the text field should automatically acquire focus when displayed.
  final bool autofocus;

  /// Placeholder text displayed when the text field is empty.
  final String hintText;

  /// Path to an SVG asset to be displayed as a prefix icon.
  final String svg;

  /// Optional widget to display before the text input, alongside the SVG icon.
  final Widget? prefixChild;

  /// Controller for the text field. If not provided, a new controller will be
  /// created.
  final TextEditingController? textEditingController;

  /// Callback function triggered when the text changes.
  final void Function(String value)? onChanged;

  /// Async callback function for processing text changes with debouncing.
  /// Useful for search operations or API calls.
  final Future<void>? Function(String)? onChangedProcessing;

  /// Validation function that returns an error message string or null if valid.
  final String? Function(String? value)? validator;

  /// The type of keyboard to use for editing the text.
  final TextInputType keyboardType;

  /// Whether to hide the text being edited (for passwords).
  final bool obscureText;

  /// Initial value of the text field.
  final String? initialValue;

  /// Maximum number of lines for the text field.
  final int? maxLine;

  /// Minimum number of lines for the text field.
  final int? minLine;

  /// Whether the text field is enabled.
  final bool enable;

  /// Whether the text field is read-only.
  final bool readOnly;

  /// Custom border for the text field.
  final InputBorder? border;

  /// Whether the decoration is collapsed (compact).
  final bool isCollapsed;

  /// Whether the decoration is dense (uses less vertical space).
  final bool isDense;

  /// Size constraints for the text field.
  final BoxConstraints? boxConstraints;

  /// Padding within the text field.
  final EdgeInsetsGeometry? contentPadding;

  /// List of autofill hints for the keyboard.
  final List<String>? autofillHints;

  /// Optional widget to display after the text input.
  final Widget? suffixIcon;

  /// Whether to show detailed error messages below the field.
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
    _string = widget.textEditingController?.text ?? '';
    _showText = !widget.obscureText;
  }

  @override
  void didUpdateWidget(OnTextInputWidgetUserField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.textEditingController != oldWidget.textEditingController) {
      _string = widget.textEditingController?.text ?? '';
    }
    if (widget.obscureText != oldWidget.obscureText) {
      _showText = !widget.obscureText;
    }
  }

  Widget? _setSuffixIcon() {
    if (widget.suffixIcon != null) return widget.suffixIcon;

    if (widget.obscureText) {
      return _string.isEmpty
          ? null
          : GestureDetector(
              onTap: () => setState(() => _showText = !_showText),
              child: _sized(
                child: _SVG(
                  _showText
                      ? 'packages/on_text_input_widget/assets/svg/eye_opened_icon.svg'
                      : 'packages/on_text_input_widget/assets/svg/eye_closed_icon.svg',
                  color: Theme.of(context).colorScheme.primary,
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
      enabled: widget.enable,
      autofocus: widget.autofocus,
      textEditingController: widget.textEditingController,
      initialValue: widget.initialValue,
      hintText: widget.hintText,
      keyboardType: widget.keyboardType,
      obscureText: !_showText,
      maxLines: widget.maxLine,
      minLines: widget.minLine,
      boxConstraints: widget.boxConstraints,
      showDetailError: widget.showDetailError,
      onFocusChange: (bool isFocused) {
        if (widget.obscureText && !isFocused) setState(() => _showText = false);
      },
      suffixIcon: _setSuffixIcon(),
      validator: widget.validator,
      errorCheck: (bool error, String message) {
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
