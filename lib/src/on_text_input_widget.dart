part of '../on_text_input_widget.dart';

/// A highly customizable text input widget for Flutter applications.
///
/// This widget provides extensive customization options for styling,
/// behavior, validation, and interaction with text input fields.
class OnTextInputWidget extends StatefulWidget {
  /// Creates a customizable text input widget.
  ///
  /// This widget can be configured with numerous options to control
  /// its appearance and behavior.
  const OnTextInputWidget({
    super.key,
    this.controller,
    this.hintText = '',
    this.obscureText = false,
    this.obscuringCharacter = '•',
    this.maxLines,
    this.minLines,
    this.maxLength,
    this.textAlignVertical,
    this.borderRadius,
    this.initialValue,
    this.focusNode,
    this.textCapitalization = TextCapitalization.none,
    this.onFocusChange,
    this.onComplete,
    this.onTapOutside,
    this.onChanged,
    this.debounceDuration = const Duration(milliseconds: 1000),
    this.onChangedProcessing,
    this.onError,
    this.fullTextSelection = false,
    this.onTap,
    this.validator,
    this.errorBuilder,
    this.showDetailError = false,
    this.animationDuration = const Duration(milliseconds: 500),
    this.loadingIcon,
    this.loadingIconsSize = 24,
    this.contentPadding,
    this.boxConstraints,
    this.loadingIconColor,
    this.textAlign = TextAlign.start,
    this.errorTextStyle,
    this.errorColor,
    this.keyboardType = TextInputType.text,
    this.autofocus = false,
    this.autocorrect = true,
    this.enabled = true,
    this.readOnly = false,
    this.cursorColor,
    this.autofillHints,
    this.style,
    this.isDense = true,
    this.isCollapsed = false,
    this.label,
    this.labelText,
    this.labelStyle,
    this.floatingLabelBehavior,
    this.prefix,
    this.suffix,
    this.showPrefixLoadingIcon = false,
    this.prefixIcon,
    this.suffixIcon,
    this.showSuffixLoadingIcon = false,
    this.fillColor,
    this.hintStyle,
    this.errorStyle,
    this.enabledBorder,
    this.focusedBorder,
    this.errorBorder,
    this.focusedErrorBorder,
    this.disabledBorder,
    this.animationCurve = Curves.linear,
    this.clipBehavior = Clip.antiAlias,
    this.borderWidth,
    this.inputFormatters,
    this.enabledBorderColor,
    this.focusedBorderColor,
    this.errorBorderColor,
    this.focusedErrorBorderColor,
    this.disabledBorderColor,
  });

  /// A controller for an editable text field.
  ///
  /// If omitted, one is created internally and disposed automatically. If
  /// supplied, **disposing it remains the caller's responsibility**.
  ///
  /// Unlike [TextFormField], this may be combined with [initialValue],
  /// which is written into the controller after the first frame.
  final TextEditingController? controller;

  /// Text that suggests what sort of input the field accepts.
  final String hintText;

  /// Whether to hide the text being edited (for passwords).
  final bool obscureText;

  /// Character used to obscure text when obscureText is true.
  final String obscuringCharacter;

  /// Maximum number of lines for the text field.
  final int? maxLines;

  /// Minimum number of lines for the text field.
  final int? minLines;

  /// Maximum number of characters allowed in the text field.
  final int? maxLength;

  /// Duration for animations in the widget.
  final Duration animationDuration;

  /// Curve used for animations in the widget.
  final Curve animationCurve;

  /// How to clip animated content.
  final Clip clipBehavior;

  /// The vertical alignment of text within the input box.
  final TextAlignVertical? textAlignVertical;

  /// The border radius of the input box.
  final BorderRadius? borderRadius;

  /// Initial value of the text field.
  final String? initialValue;

  /// Focus node for controlling the focus of this text field.
  final FocusNode? focusNode;

  /// Controls keyboard capitalization behavior.
  final TextCapitalization textCapitalization;

  /// Debounce duration for processing text changes.
  final Duration debounceDuration;

  /// Whether to select all text when the field is tapped.
  final bool fullTextSelection;

  /// Whether to show the error message in an animated section below the
  /// field, instead of replacing the hint text inside it.
  ///
  /// Prefer `true` for anything the user types at length: when this is
  /// `false`, a failed validation **clears the field**, and the message
  /// (shown as the hint) disappears again as soon as they start retyping.
  ///
  /// Must also be `true` for [errorBuilder] to have any effect.
  final bool showDetailError;

  /// Custom loading indicator widget.
  final Widget? loadingIcon;

  /// Size of the loading indicator.
  final double? loadingIconsSize;

  /// Color of the loading indicator.
  final Color? loadingIconColor;

  /// Padding within the text field.
  final EdgeInsets? contentPadding;

  /// Size constraints for the text field.
  final BoxConstraints? boxConstraints;

  /// Text alignment within the field.
  final TextAlign textAlign;

  /// Style for error text.
  final TextStyle? errorTextStyle;

  /// Color for error states.
  final Color? errorColor;

  /// Type of keyboard to display.
  final TextInputType keyboardType;

  /// Whether the field should automatically get focus.
  final bool autofocus;

  /// Whether to enable autocorrect.
  final bool autocorrect;

  /// Whether the field is enabled.
  final bool enabled;

  /// Whether the field is read-only.
  final bool readOnly;

  /// Color of the cursor.
  final Color? cursorColor;

  /// Hints for autofill functionality.
  final List<String>? autofillHints;

  /// Text style for the input. Default: textTheme.titleMedium
  final TextStyle? style;

  /// Whether the field uses less vertical space.
  final bool isDense;

  /// Whether the decoration is the same size as the input field.
  final bool isCollapsed;

  /// Optional widget that describes the input field.
  final Widget? label;

  /// Optional text that describes the input field.
  final String? labelText;

  /// Style for the label text.
  final TextStyle? labelStyle;

  /// How the floating label should behave.
  final FloatingLabelBehavior? floatingLabelBehavior;

  /// Widget to place before the input.
  final Widget? prefix;

  /// Widget to place after the input.
  final Widget? suffix;

  /// Icon to display before the input.
  final Widget? prefixIcon;

  /// Icon to display after the input.
  final Widget? suffixIcon;

  /// Whether to replace [prefixIcon] with a loading indicator while an
  /// [onChangedProcessing] call is in flight.
  ///
  /// Has no effect without [onChangedProcessing] — there is nothing to
  /// wait on, so the indicator never appears.
  final bool showPrefixLoadingIcon;

  /// Whether to replace [suffixIcon] with a loading indicator while an
  /// [onChangedProcessing] call is in flight.
  ///
  /// Has no effect without [onChangedProcessing] — there is nothing to
  /// wait on, so the indicator never appears.
  final bool showSuffixLoadingIcon;

  /// Background color of the text field.
  final Color? fillColor;

  /// Style for the hint text.
  final TextStyle? hintStyle;

  /// Style for error text.
  final TextStyle? errorStyle;

  /// Border style when the field is enabled.
  final InputBorder? enabledBorder;

  /// Border color when the field is enabled
  final Color? enabledBorderColor;

  /// Border style when the field is focused.
  final InputBorder? focusedBorder;

  /// Border color when the field is focused.
  final Color? focusedBorderColor;

  /// Border style when the field has an error.
  final InputBorder? errorBorder;

  /// Border color when the field has an error.
  final Color? errorBorderColor;

  /// Border style when the field has an error and is focused.

  final InputBorder? focusedErrorBorder;

  /// Border color when the field has an error and is focused.
  final Color? focusedErrorBorderColor;

  /// Border style when the field is disabled.
  final InputBorder? disabledBorder;

  /// Border color when the field is disabled.
  final Color? disabledBorderColor;

  /// Width of the border.
  final double? borderWidth;

  /// Called when the focus state changes.
  final Function(bool isFocused)? onFocusChange;

  /// Called when editing is complete.
  final void Function(String? value)? onComplete;

  /// Called when tapping outside the field.
  final void Function(PointerDownEvent pointerDownEvent)? onTapOutside;

  /// Validates the input, returning an error message, or `null` if valid.
  ///
  /// Note: this drives the widget's own error display only. The underlying
  /// [FormField] validator always reports success, so an enclosing
  /// [FormState.validate] returns `true` even when this fails and **cannot be
  /// used to gate a submit**. Call your validation function directly for
  /// that.
  final String? Function(String? value)? validator;

  /// Called when the field is tapped.
  final void Function()? onTap;

  /// Called when the text changes.
  final void Function(String value)? onChanged;

  /// Async callback for processing text changes, debounced by
  /// [debounceDuration]. Intended for server-backed search-as-you-type.
  ///
  /// Calls never overlap. Keystrokes arriving while a call is in flight are
  /// coalesced, and only the most recent value is processed once it
  /// completes — intermediate values are dropped, not replayed.
  ///
  /// Exceptions thrown by this callback are **swallowed** so the field can
  /// recover; nothing is logged or rethrown. Handle errors inside it.
  final Future<void>? Function(String value)? onChangedProcessing;

  /// Called with `(true, message)` when validation fails, and with
  /// `(false, '')` when tapping the field clears an existing error.
  ///
  /// Not called on successful validation.
  final void Function(bool error, String message)? onError;

  /// Custom builder for the error message shown below the field.
  ///
  /// **Requires [showDetailError] to be `true`.** Supplying a builder
  /// disables the default in-field error display, but the builder itself is
  /// only rendered when [showDetailError] is set — supplying this alone
  /// means the error is displayed nowhere.
  final Widget Function(String message)? errorBuilder;

  /// Creates a [FormField] that contains a [TextField].
  ///
  /// When a controller is specified, [initialValue] must be null (the default).
  /// If controller is null, then a [TextEditingController] will be constructed
  /// automatically and its text will be initialized to [initialValue] or the
  /// empty string.
  ///
  /// For documentation about the various parameters, see the [TextField] class
  /// and [TextField.new], the constructor.
  final List<TextInputFormatter>? inputFormatters;

  @override
  State<OnTextInputWidget> createState() => _OnTextInputWidgetState();
}

class _OnTextInputWidgetState extends State<OnTextInputWidget> {
  bool isFocused = false;
  late BorderRadius borderRadius;
  Offset? focusOffset;
  bool firstTimeTap = false;
  Timer? debounce;
  List<String> searchProductList = <String>[];
  bool isIdle = true;
  bool error = false;
  String? message;
  late EdgeInsets contentPadding;
  late double height;

  late TextEditingController _controller;
  late String hintText;
  bool _controllerIsInternal = false;

  @override
  void initState() {
    super.initState();
    if (widget.controller == null) {
      _controller = TextEditingController();
      _controllerIsInternal = true;
    } else {
      _controller = widget.controller!;
    }
    hintText = widget.hintText;
    borderRadius = widget.borderRadius ?? _defaultBorderRadius;

    if (widget.initialValue != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          _controller.text = widget.initialValue!;
        }
      });
    }
  }

  @override
  void didUpdateWidget(OnTextInputWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.controller != oldWidget.controller) {
      if (_controllerIsInternal) {
        _controller.dispose();
      }
      if (widget.controller == null) {
        _controller = TextEditingController();
        _controllerIsInternal = true;
      } else {
        _controller = widget.controller!;
        _controllerIsInternal = false;
      }
    }
    if (widget.hintText != oldWidget.hintText && !error) {
      hintText = widget.hintText;
    }
    if (widget.borderRadius != oldWidget.borderRadius) {
      borderRadius = widget.borderRadius ?? _defaultBorderRadius;
    }
  }

  @override
  void dispose() {
    if (_controllerIsInternal) {
      _controller.dispose();
    }
    debounce?.cancel();
    super.dispose();
  }

  Widget? showLoadingIcon(bool value) {
    if (value && !isIdle) {
      return widget.loadingIcon ??
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                constraints: BoxConstraints(
                  maxHeight: widget.loadingIconsSize ?? double.infinity,
                  maxWidth: widget.loadingIconsSize ?? double.infinity,
                ),
                child: FittedBox(
                  child: CircularProgressIndicator(
                    color: widget.loadingIconColor ??
                        Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
            ],
          );
    } else {
      return null;
    }
  }

  /// Whether the error message is rendered by this widget below the field
  /// (via [OnTextInputWidget.showDetailError] or
  /// [OnTextInputWidget.errorBuilder]) rather than by the built-in
  /// [InputDecoration.errorText].
  bool get _usesCustomErrorDisplay =>
      widget.showDetailError || widget.errorBuilder != null;

  Widget? _setIcon(Widget? icon) {
    if (icon == null) return null;

    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Flexible(child: icon),
      ],
    );
  }

  Widget? widgetReplacement(Widget? wez, EdgeInsets padding) {
    if (wez == null) return SizedBox(width: padding.horizontal);

    return Container(
      margin: EdgeInsets.symmetric(horizontal: padding.horizontal / 2),
      constraints: BoxConstraints(minWidth: padding.horizontal),
      child: wez,
    );
  }

  Widget errorChild() {
    final ThemeData theme = Theme.of(context);
    final ColorScheme colorScheme = theme.colorScheme;
    final TextTheme textTheme = theme.textTheme;
    if (error && _usesCustomErrorDisplay && message != null) {
      //* The built-in error text is still present (rendered at zero size) and
      //* carries the message to assistive technology, so this visible copy is
      //* excluded from semantics to avoid announcing it twice.
      return ExcludeSemantics(
        child: widget.errorBuilder != null
          ? widget.errorBuilder!(message ?? '')
          : Padding(
              padding: EdgeInsets.symmetric(
                vertical: widget.contentPadding?.vertical ?? 4,
              ),
              child: Text(
                message!,
                textAlign: widget.textAlign,
                style: widget.errorTextStyle ??
                    textTheme.bodySmall?.copyWith(
                      color: widget.errorColor ?? colorScheme.error,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
      );
    } else {
      return const SizedBox();
    }
  }

  void unfocusKeyboard() {
    try {
      if (focusOffset == FocusManager.instance.primaryFocus?.offset) {
        FocusManager.instance.primaryFocus?.unfocus();
        FocusManager.instance.rootScope.unfocus();
        FocusScope.of(context).unfocus();
        focusOffset = null;
      } else {
        focusOffset = FocusManager.instance.primaryFocus?.offset;
      }
    } catch (_) {}
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme colorScheme = theme.colorScheme;
    final TextTheme textTheme = theme.textTheme;

    height = widget.boxConstraints?.minHeight ?? theme.buttonTheme.height;
    contentPadding = widget.contentPadding ?? _defaultContentPadding;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Focus(
          onFocusChange: (bool value) {
            if (value) focusOffset = FocusManager.instance.primaryFocus?.offset;
            firstTimeTap = false;
            if (!value) {
              unfocusKeyboard();
            }

            if (mounted) setState(() => isFocused = value);
            if (widget.onFocusChange != null) widget.onFocusChange!(value);
          },
          child: TextFormField(
            controller: _controller,
            obscureText: widget.obscureText,
            obscuringCharacter: widget.obscuringCharacter,
            focusNode: widget.focusNode,
            textCapitalization: widget.textCapitalization,
            keyboardType: widget.keyboardType,
            autofocus: widget.autofocus,
            autocorrect: widget.autocorrect,
            enabled: widget.enabled,
            readOnly: widget.readOnly,
            cursorColor: widget.cursorColor ?? colorScheme.primary,
            autofillHints: widget.autofillHints,
            inputFormatters: widget.inputFormatters,
            style: widget.style ??
                textTheme.titleMedium?.copyWith(
                  color: colorScheme.primary,
                  fontWeight: FontWeight.bold,
                  decorationThickness: 0,
                ),

            // -----------------------------------------------------------------
            maxLines: widget.obscureText
                ? 1
                : (widget.maxLines ?? 1) < (widget.minLines ?? 1)
                    ? null
                    : widget.maxLines,
            minLines: widget.obscureText ? 1 : widget.minLines,
            maxLength: widget.maxLength,

            // -----------------------------------------------------------------
            textAlignVertical: widget.textAlignVertical,
            textAlign: widget.textAlign,

            //! Functions ------------------------------------------------------
            onEditingComplete: () {
              unfocusKeyboard();
              if (widget.onComplete != null) {
                widget.onComplete!(_controller.text);
              }
            },
            onTapOutside: (PointerDownEvent pointerDownEvent) {
              unfocusKeyboard();
              if (widget.onTapOutside != null) {
                widget.onTapOutside!(pointerDownEvent);
              }
            },
            onChanged: (String value) {
              //* On change without processing
              if (widget.onChanged != null) widget.onChanged!(value);

              //* On change with processing
              if (widget.onChangedProcessing != null) {
                if (debounce?.isActive ?? false) debounce?.cancel();
                searchProductList.add(value);
                debounce = Timer(
                  widget.debounceDuration,
                  () async {
                    while (isIdle && searchProductList.isNotEmpty) {
                      String searchingProduct = searchProductList.last;
                      searchProductList = <String>[];
                      if (mounted) setState(() => isIdle = false);
                      try {
                        await widget.onChangedProcessing!(searchingProduct);
                      } catch (_) {}
                      if (mounted) setState(() => isIdle = true);
                    }
                  },
                );
              }
              if (error) {
                hintText = widget.hintText;
                error = false;
              }
              if (mounted) setState(() {});
            },
            onTap: () {
              if (widget.fullTextSelection && !firstTimeTap) {
                _controller.selection = TextSelection(
                  baseOffset: 0,
                  extentOffset: _controller.value.text.length,
                );
                firstTimeTap = true;
              }
              if (widget.onTap != null) widget.onTap!();
              if (error) {
                hintText = widget.hintText;
                error = false;
                if (widget.onError != null) widget.onError!(error, '');
              }
              if (mounted) setState(() {});
            },
            validator: (String? value) {
              message = null;
              error = false;
              if (mounted) setState(() {});

              if (widget.validator == null) return null;
              message = widget.validator!(value);
              if (message == null) {
                if (mounted) setState(() {});
                return null;
              }

              error = true;
              if (widget.onError != null) {
                widget.onError!(error, message!);
              }
              if (mounted) setState(() {});

              //* Reported to the enclosing Form so validate() can fail.
              //* When a custom display is in use the built-in error text is
              //* hidden via errorStyle, to avoid showing the message twice.
              return message;
            },
            decoration: InputDecoration(
              isDense: widget.isDense,
              isCollapsed: widget.isCollapsed,
              hintText: hintText.isEmpty ? null : hintText,
              label: widget.label,
              labelText: widget.labelText,
              labelStyle: widget.labelStyle,
              floatingLabelBehavior: widget.floatingLabelBehavior,
              constraints:
                  widget.boxConstraints ?? BoxConstraints(minHeight: height),
              prefix: widget.prefix,
              suffix: widget.suffix,
              suffixIconConstraints: const BoxConstraints(),
              prefixIconConstraints: const BoxConstraints(),
              prefixIcon: SizedBox(
                height: height,
                child: _CustomAnimatedSize(
                  alignment: Alignment.centerLeft,
                  duration: widget.animationDuration,
                  curve: widget.animationCurve,
                  clipBehavior: widget.clipBehavior,
                  child: widgetReplacement(
                    showLoadingIcon(widget.showPrefixLoadingIcon) ??
                        _setIcon(widget.prefixIcon),
                    contentPadding,
                  ),
                ),
              ),
              suffixIcon: SizedBox(
                height: height,
                child: _CustomAnimatedSize(
                  alignment: Alignment.centerRight,
                  duration: widget.animationDuration,
                  curve: widget.animationCurve,
                  clipBehavior: widget.clipBehavior,
                  child: widgetReplacement(
                    showLoadingIcon(widget.showSuffixLoadingIcon) ??
                        _setIcon(widget.suffixIcon),
                    contentPadding,
                  ),
                ),
              ),
              filled: widget.fillColor == null
                  ? theme.inputDecorationTheme.filled
                  : true,
              fillColor:
                  widget.fillColor ?? theme.inputDecorationTheme.fillColor,
              hintStyle: !error
                  ? widget.hintStyle ??
                      TextStyle(color: colorScheme.primary.withAlpha(127))
                  : widget.errorStyle ??
                      widget.hintStyle?.copyWith(
                        color: colorScheme.error,
                      ) ??
                      TextStyle(color: colorScheme.error),
              errorStyle: _usesCustomErrorDisplay
                  ? const TextStyle(fontSize: 0)
                  : widget.errorStyle ??
                      textTheme.bodySmall?.copyWith(
                        color: widget.errorColor ?? colorScheme.error,
                      ),
              contentPadding: contentPadding,
              enabledBorder: widget.enabledBorder?.copyWith(
                    borderSide: BorderSide(
                      width: widget.borderWidth ??
                          theme.inputDecorationTheme.enabledBorder?.borderSide
                              .width ??
                          2,
                      color: widget.enabledBorderColor ??
                          colorScheme.primary.withAlpha(127),
                    ),
                  ) ??
                  theme.inputDecorationTheme.enabledBorder ??
                  OutlineInputBorder(
                    borderRadius: borderRadius,
                    borderSide: BorderSide(
                      width: widget.borderWidth ??
                          theme.inputDecorationTheme.enabledBorder?.borderSide
                              .width ??
                          2,
                      color: widget.enabledBorderColor ??
                          colorScheme.primary.withAlpha(127),
                    ),
                  ),
              focusedBorder: widget.focusedBorder?.copyWith(
                    borderSide: BorderSide(
                      width: widget.borderWidth ??
                          theme.inputDecorationTheme.focusedBorder?.borderSide
                              .width ??
                          2,
                      color: widget.focusedBorderColor ?? colorScheme.primary,
                    ),
                  ) ??
                  theme.inputDecorationTheme.focusedBorder ??
                  OutlineInputBorder(
                    borderRadius: borderRadius,
                    borderSide: BorderSide(
                      width: widget.borderWidth ??
                          theme.inputDecorationTheme.focusedBorder?.borderSide
                              .width ??
                          2,
                      color: widget.focusedBorderColor ?? colorScheme.primary,
                    ),
                  ),
              errorBorder: widget.errorBorder?.copyWith(
                    borderSide: BorderSide(
                      width: widget.borderWidth ??
                          theme.inputDecorationTheme.errorBorder?.borderSide
                              .width ??
                          2,
                      color: widget.errorBorderColor ?? colorScheme.error,
                    ),
                  ) ??
                  theme.inputDecorationTheme.errorBorder ??
                  OutlineInputBorder(
                    borderRadius: borderRadius,
                    borderSide: BorderSide(
                      width: widget.borderWidth ??
                          theme.inputDecorationTheme.errorBorder?.borderSide
                              .width ??
                          2,
                      color: widget.errorBorderColor ?? colorScheme.error,
                    ),
                  ),
              focusedErrorBorder: widget.focusedErrorBorder?.copyWith(
                    borderSide: BorderSide(
                      width: widget.borderWidth ??
                          theme.inputDecorationTheme.focusedErrorBorder
                              ?.borderSide.width ??
                          2,
                      color: widget.focusedErrorBorderColor ??
                          colorScheme.primary.withAlpha(127),
                    ),
                  ) ??
                  theme.inputDecorationTheme.focusedBorder ??
                  OutlineInputBorder(
                    borderRadius: borderRadius,
                    borderSide: BorderSide(
                      width: widget.borderWidth ??
                          theme.inputDecorationTheme.focusedErrorBorder
                              ?.borderSide.width ??
                          2,
                      color: widget.focusedErrorBorderColor ??
                          colorScheme.primary.withAlpha(127),
                    ),
                  ),
              disabledBorder: widget.disabledBorder?.copyWith(
                    borderSide: BorderSide(
                      width: widget.borderWidth ??
                          theme.inputDecorationTheme.disabledBorder?.borderSide
                              .width ??
                          2,
                      color: widget.disabledBorderColor ??
                          colorScheme.primary.withAlpha(25),
                    ),
                  ) ??
                  theme.inputDecorationTheme.disabledBorder ??
                  OutlineInputBorder(
                    borderRadius: borderRadius,
                    borderSide: BorderSide(
                      width: widget.borderWidth ??
                          theme.inputDecorationTheme.disabledBorder?.borderSide
                              .width ??
                          2,
                      color: widget.disabledBorderColor ??
                          colorScheme.primary.withAlpha(127),
                    ),
                  ),
            ),
          ),
        ),
        _CustomAnimatedSize(
          alignment: Alignment.topCenter,
          widthFactor: 1,
          duration: widget.animationDuration,
          curve: widget.animationCurve,
          clipBehavior: widget.clipBehavior,
          child: errorChild(),
        ),
      ],
    );
  }
}
