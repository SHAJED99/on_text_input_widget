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
    Key? key,
    this.textEditingController,
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
    this.onChangeDebouncer = const Duration(milliseconds: 1000),
    this.onChangedProcessing,
    this.errorCheck,
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
  }) : super(key: key);

  /// A controller for an editable text field.
  ///
  /// Whenever the user modifies a text field with an associated
  /// TextEditingController, the text field updates value and the controller
  /// notifies its listeners.
  final TextEditingController? textEditingController;

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
  final Duration onChangeDebouncer;

  /// Whether to select all text when the field is tapped.
  final bool fullTextSelection;

  /// Whether to show detailed error messages below the field.
  final bool showDetailError;

  /// Custom loading indicator widget.
  final Widget? loadingIcon;

  /// Size of the loading indicator.
  final double? loadingIconsSize;

  /// Color of the loading indicator.
  final Color? loadingIconColor;

  /// Padding within the text field.
  final EdgeInsetsGeometry? contentPadding;

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

  /// Text style for the input.
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

  /// Whether to show a loading indicator before the input.
  final bool showPrefixLoadingIcon;

  /// Whether to show a loading indicator after the input.
  final bool showSuffixLoadingIcon;

  /// Background color of the text field.
  final Color? fillColor;

  /// Style for the hint text.
  final TextStyle? hintStyle;

  /// Style for error text.
  final TextStyle? errorStyle;

  /// Border style when the field is enabled.
  final InputBorder? enabledBorder;

  /// Border style when the field is focused.
  final InputBorder? focusedBorder;

  /// Border style when the field has an error.
  final InputBorder? errorBorder;

  /// Border style when the field has an error and is focused.
  final InputBorder? focusedErrorBorder;

  /// Border style when the field is disabled.
  final InputBorder? disabledBorder;

  /// Width of the border.
  final double? borderWidth;

  /// Called when the focus state changes.
  final Function(bool isFocused)? onFocusChange;

  /// Called when editing is complete.
  final void Function(String? value)? onComplete;

  /// Called when tapping outside the field.
  final void Function(PointerDownEvent pointerDownEvent)? onTapOutside;

  /// Validates the input and returns an error message if invalid.
  final String? Function(String? value)? validator;

  /// Called when the field is tapped.
  final void Function()? onTap;

  /// Called when the text changes.
  final void Function(String value)? onChanged;

  /// Async callback for processing text changes with debouncing.
  final Future<void>? Function(String value)? onChangedProcessing;

  /// Called when validation fails.
  final void Function(bool error, String message)? errorCheck;

  /// Custom builder for error messages.
  final Widget Function(String message)? errorBuilder;

  @override
  State<OnTextInputWidget> createState() => _OnTextInputWidgetState();
}

class _OnTextInputWidgetState extends State<OnTextInputWidget> {
  bool isFocused = false;
  late BorderRadius borderRadius;
  Offset? focusNode;
  bool firstTimeTap = false;
  Timer? debounce;
  List<String> searchProductList = <String>[];
  bool isIdle = true;
  bool error = false;
  String? message;
  late EdgeInsetsGeometry contentPadding;
  late double height;

  late TextEditingController textEditingController;
  late String hintText;

  @override
  void initState() {
    super.initState();
    textEditingController =
        widget.textEditingController ?? TextEditingController();
    hintText = widget.hintText;
    borderRadius = widget.borderRadius ?? _defaultBorderRadius;

    if (widget.initialValue != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        textEditingController.text = widget.initialValue!;
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    // textEditingController.dispose();
    debounce?.cancel();
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

  Widget? widgetReplacement(Widget? wez, EdgeInsetsGeometry padding) {
    // print(contentPadding.horizontal);

    if (wez == null) return SizedBox(width: padding.horizontal);

    // widget.boxConstraints.minWidth ??
    // BoxConstraints(minWidth: Theme.of(context).buttonTheme.height),

    return Container(
      // const BoxConstraints(minWidth: 16)
      // (widget.boxConstraints?.minWidth ??
      // color: Colors.amber,
      margin: EdgeInsets.symmetric(horizontal: padding.horizontal / 2),
      constraints: BoxConstraints(minWidth: padding.horizontal),
      child: wez,
    );
  }

  Widget errorChild() {
    final ThemeData theme = Theme.of(context);
    final ColorScheme colorScheme = theme.colorScheme;
    final TextTheme textTheme = theme.textTheme;
    if (error && widget.showDetailError && message != null) {
      return widget.errorBuilder != null
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
            );
    } else {
      return const SizedBox();
    }
  }

  void unfocusKeyboard() {
    try {
      if (focusNode == FocusManager.instance.primaryFocus?.offset) {
        FocusManager.instance.primaryFocus?.unfocus();
        FocusManager.instance.rootScope.unfocus();
        FocusScope.of(context).unfocus();
        focusNode = null;
      } else {
        focusNode = FocusManager.instance.primaryFocus?.offset;
      }
    } catch (_) {}

    // FocusManager.instance.primaryFocus?.unfocus();
    // FocusManager.instance.rootScope.unfocus();
    // FocusScope.of(context).unfocus();
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
            if (value) focusNode = FocusManager.instance.primaryFocus?.offset;
            firstTimeTap = false;
            if (!value) {
              unfocusKeyboard();
            }

            if (mounted) setState(() => isFocused = value);
            if (widget.onFocusChange != null) widget.onFocusChange!(value);
          },
          child: TextFormField(
            controller: textEditingController,
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
            style: widget.style ??
                textTheme.titleMedium?.copyWith(
                  color: colorScheme.primary,
                  fontWeight: FontWeight.bold,
                  height: 1,
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
                widget.onComplete!(textEditingController.text);
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
                  widget.onChangeDebouncer,
                  () async {
                    while (isIdle && searchProductList.isNotEmpty) {
                      String searchingProduct = searchProductList.last;
                      searchProductList = <String>[];
                      if (mounted) setState(() => isIdle = false);
                      await widget.onChangedProcessing!(searchingProduct);
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
              // focusNode = FocusManager.instance.primaryFocus?.offset;
              if (widget.fullTextSelection && !firstTimeTap) {
                textEditingController.selection = TextSelection(
                  baseOffset: 0,
                  extentOffset: textEditingController.value.text.length,
                );
                firstTimeTap = true;
              }
              if (widget.onTap != null) widget.onTap!();
              if (error) {
                hintText = widget.hintText;
                error = false;
                if (widget.errorCheck != null) widget.errorCheck!(error, '');
              }
              if (mounted) setState(() {});
            },
            validator: (String? value) {
              message = null;
              if (mounted) setState(() {});

              if (widget.validator == null) return null;
              message = widget.validator!(value);
              if (message == null) return null;
              error = true;
              if (widget.errorCheck != null) {
                widget.errorCheck!(error, message!);
              }

              if (widget.showDetailError || widget.errorBuilder != null) {
              } else {
                textEditingController.clear();
                hintText = message!;
              }

              if (mounted) setState(() {});
              return '';
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
              errorStyle: const TextStyle(fontSize: 0),
              // errorMaxLines: 1,
              // error: const SizedBox(),
              // errorText: "",

              contentPadding: contentPadding,
              enabledBorder: widget.enabledBorder?.copyWith(
                    borderSide: BorderSide(
                      width: widget.borderWidth ??
                          theme.inputDecorationTheme.enabledBorder?.borderSide
                              .width ??
                          2,
                      color: colorScheme.primary.withAlpha(127),
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
                      color: colorScheme.primary.withAlpha(127),
                    ),
                  ),
              focusedBorder: widget.focusedBorder?.copyWith(
                    borderSide: BorderSide(
                      width: widget.borderWidth ??
                          theme.inputDecorationTheme.focusedBorder?.borderSide
                              .width ??
                          2,
                      color: colorScheme.primary,
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
                      color: colorScheme.primary,
                    ),
                  ),
              errorBorder: widget.errorBorder?.copyWith(
                    borderSide: BorderSide(
                      width: widget.borderWidth ??
                          theme.inputDecorationTheme.errorBorder?.borderSide
                              .width ??
                          2,
                      color: colorScheme.error,
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
                      color: colorScheme.error,
                    ),
                  ),
              focusedErrorBorder: widget.focusedErrorBorder?.copyWith(
                    borderSide: BorderSide(
                      width: widget.borderWidth ??
                          theme.inputDecorationTheme.focusedErrorBorder
                              ?.borderSide.width ??
                          2,
                      color: colorScheme.primary.withAlpha(127),
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
                      color: colorScheme.primary.withAlpha(127),
                    ),
                  ),
              disabledBorder: widget.disabledBorder?.copyWith(
                    borderSide: BorderSide(
                      width: widget.borderWidth ??
                          theme.inputDecorationTheme.disabledBorder?.borderSide
                              .width ??
                          2,
                      color: colorScheme.primary.withAlpha(25),
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
                      color: colorScheme.primary.withAlpha(127),
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
