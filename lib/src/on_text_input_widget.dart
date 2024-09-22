// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:flutter/material.dart';

class OnTextInputWidget extends StatefulWidget {
  const OnTextInputWidget({
    Key? key,
    this.textEditingController,
    this.hintText = "",
    this.obscureText = false,
    this.obscuringCharacter = "•",
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
  }) : super(key: key);

  /// A controller for an editable text field.
  ///
  /// Whenever the user modifies a text field with an associated TextEditingController, the text field updates value and the controller notifies its listeners. Listeners can then read the text and selection properties to learn what the user has typed or how the selection has been updated.
  ///
  /// Similarly, if you modify the text or selection properties, the text field will be notified and will update itself appropriately.
  ///
  /// A TextEditingController can also be used to provide an initial value for a text field. If you build a text field with a controller that already has text, the text field will use that text as its initial value.
  ///
  /// The value (as well as text and selection) of this controller can be updated from within a listener added to this controller. Be aware of infinite loops since the listener will also be notified of the changes made from within itself. Modifying the composing region from within a listener can also have a bad interaction with some input methods. Gboard, for example, will try to restore the composing region of the text if it was modified programmatically, creating an infinite loop of communications between the framework and the input method. Consider using TextInputFormatters instead for as-you-type text modification.
  ///
  /// If both the text and selection properties need to be changed, set the controller's value instead. Setting text will clear the selection and composing range.
  ///
  /// Remember to dispose of the TextEditingController when it is no longer needed. This will ensure we discard any resources used by the object.
  final TextEditingController? textEditingController;

  /// Text that suggests what sort of input the field accepts.
  final String hintText;

  /// Obscure Text Default obscureText: false
  final bool obscureText;

  /// Obscuring character. Default: •
  final String obscuringCharacter;

  /// Max Number of line
  final int? maxLines;

  /// Min Number of line
  final int? minLines;

  /// Max Character length
  final int? maxLength;

  /// Animation Duration. Default: Duration(milliseconds: 500
  final Duration animationDuration;

  /// Animation Curve. Default: Curves.linear
  final Curve animationCurve;

  /// Animation clip behavior. Default: Clip.antiAlias
  final Clip clipBehavior;

  /// The vertical alignment of text within an input box.
  ///
  /// A single y value that can range from -1.0 to 1.0. -1.0 aligns to the top of an input box so that the top of the first line of text fits within the box and its padding. 0.0 aligns to the center of the box. 1.0 aligns so that the bottom of the last line of text aligns with the bottom interior edge of the input box.
  final TextAlignVertical? textAlignVertical;

  /// The border radius of the input box. Default: BorderRadius.circular(8)
  final BorderRadius? borderRadius;

  /// Initial Value of text field
  final String? initialValue;

  /// Focus Node of text field
  final FocusNode? focusNode;

  /// Configures how the platform keyboard will select an uppercase or lowercase keyboard.
  /// Only supports text keyboards, other keyboard types will ignore this configuration. Capitalization is locale-aware.
  final TextCapitalization textCapitalization;

  /// OnChangedProcessing function waiting duration. Default: Duration(milliseconds: 1000)
  final Duration onChangeDebouncer;

  /// Select full text inside the input field when it is clicked. Default: false
  final bool fullTextSelection;

  /// It will show error under the text field.
  final bool showDetailError;

  /// Widget that will be seen during the onChangedProcessing function is running
  final Widget? loadingIcon;

  /// Loading icon size. Default: 24
  final double? loadingIconsSize;

  /// Default loading icon color. Default: Theme.of(context).colorScheme.primary
  final Color? loadingIconColor;

  /// Padding between Icon & Text.
  final EdgeInsetsGeometry? contentPadding;

  /// Input text field box constraint.
  final BoxConstraints? boxConstraints;

  /// Text alignment in the Text Field
  final TextAlign textAlign;

  /// Error text style. Default: Theme.of(context).textTheme.bodySmall?.copyWith(color: widget.errorColor ?? Theme.of(context).colorScheme.error, fontWeight: FontWeight.bold)
  final TextStyle? errorTextStyle;

  /// Error text color. Default: Theme.of(context).colorScheme.error
  final Color? errorColor;

  /// Keyboard Type of the text input. Default: TextInputType.text
  final TextInputType keyboardType;

  /// If true it will automatically open virtual keyboard. Default: false
  final bool autofocus;

  /// If true, it will show suggestion. Default: true
  final bool autocorrect;

  /// Enable or disable the textfield. Default: true
  final bool enabled;

  /// If true, the textfield is only readable. Default: false
  final bool readOnly;

  /// Cursor color of the text field. Default: Theme.of(context).colorScheme.primary
  final Color? cursorColor;

  /// Auto fill hint texts.
  final List<String>? autofillHints;

  /// Text style. Default: Theme.of(context).textTheme.titleMedium?.copyWith(color: Theme.of(context).colorScheme.primary, fontWeight: FontWeight.bold),
  final TextStyle? style;

  /// Whether the [InputDecorator.child] is part of a dense form (i.e., uses less vertical space). Default: True
  final bool isDense;

  /// Whether the decoration is the same size as the input field. A collapsed decoration cannot have [labelText], [errorText], an [icon]. To create a collapsed input decoration, use [InputDecoration.collapsed].
  final bool isCollapsed;

  /// Optional widget that describes the input field.
  final Widget? label;

  /// Optional text that describes the input field.
  final String? labelText;

  /// The style to use for [InputDecoration.labelText] when the label is on top of the input field.  If null, the default style is used.
  final TextStyle? labelStyle;

  /// Defines how the floating label should behave.
  final FloatingLabelBehavior? floatingLabelBehavior;

  /// Optional widget to place on the line before the input.
  final Widget? prefix;

  /// Optional widget to place on the line after the input.
  final Widget? suffix;

  /// Prefix/Before Icon
  final Widget? prefixIcon;

  /// Suffix/After Icon
  final Widget? suffixIcon;

  /// If true, the loading Icon will be shown on the left side of the text field. Default: false
  final bool showPrefixLoadingIcon;

  /// If true, the loading Icon will be shown on the right side of the text field. Default: false
  final bool showSuffixLoadingIcon;

  /// Text field fill color. Default: widget.fillColor == null ? Theme.of(context).inputDecorationTheme.filled : true
  final Color? fillColor;

  /// Hint text style. Default: Theme.of(context).colorScheme.primary.withOpacity(0.5)
  final TextStyle? hintStyle;

  /// Error text style. Default: widget.hintStyle?.copyWith(color: Theme.of(context).colorScheme.error) ?? TextStyle(color: Theme.of(context).colorScheme.error)
  final TextStyle? errorStyle;

  /// Border style when enabled
  final InputBorder? enabledBorder;

  /// Border style when focused
  final InputBorder? focusedBorder;

  /// Border style when error occurred
  final InputBorder? errorBorder;

  /// Border style when error occurred and focused
  final InputBorder? focusedErrorBorder;

  /// Border style when disabled
  final InputBorder? disabledBorder;

  //! Functions
  /// Function runs when the focused is change. It will be called when the text field is focused or unfocused.
  final Function(bool isFocused)? onFocusChange;

  /// Function runs when text field editing is completed.
  final void Function(String? value)? onComplete;

  /// Function runs when pressing outside of the text field
  final void Function(PointerDownEvent pointerDownEvent)? onTapOutside;

  /// Creates a [FormField] that contains a [TextField].
  final String? Function(String? value)? validator;

  /// Function runs when the text field is tapped
  final void Function()? onTap;

  /// Function runs when the text is changed in the text field. (Not async operation, Used for offline search)
  final void Function(String value)? onChanged;

  /// Function runs when the text is changed in the text field. (Async operation, Used for online search)
  final Future<void>? Function(String value)? onChangedProcessing;

  /// Function runs when the form is wrongly submitted.
  final void Function(bool error, String message)? errorCheck;

  /// Function used to customize the error widget.
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
  List<String> searchProductList = [];
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
    textEditingController = widget.textEditingController ?? TextEditingController();
    hintText = widget.hintText;
    borderRadius = widget.borderRadius ?? BorderRadius.circular(8);

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
            children: [
              Container(
                constraints: BoxConstraints(
                  maxHeight: widget.loadingIconsSize ?? double.infinity,
                  maxWidth: widget.loadingIconsSize ?? double.infinity,
                ),
                child: FittedBox(child: CircularProgressIndicator(color: widget.loadingIconColor ?? Theme.of(context).colorScheme.primary)),
              ),
            ],
          );
    } else {
      return null;
    }
  }

  Widget? _setIcon(Widget? icon) {
    if (icon == null) return null;

    return SizedBox(
      height: Theme.of(context).buttonTheme.height,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          icon
        ],
      ),
    );
  }

  Widget? widgetReplacement(Widget? wez, EdgeInsetsGeometry padding) {
    // print(contentPadding.horizontal);

    if (wez == null) return SizedBox(width: padding.horizontal);

    // widget.boxConstraints.minWidth ?? BoxConstraints(minWidth: Theme.of(context).buttonTheme.height),

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
    if (error && widget.showDetailError && message != null) {
      return Text(
        message!,
        textAlign: widget.textAlign,
        style: widget.errorTextStyle ?? Theme.of(context).textTheme.bodySmall?.copyWith(color: widget.errorColor ?? Theme.of(context).colorScheme.error, fontWeight: FontWeight.bold),
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
    height = widget.boxConstraints?.minHeight ?? Theme.of(context).buttonTheme.height;
    contentPadding = widget.contentPadding ?? const EdgeInsets.symmetric(horizontal: 8, vertical: 4);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Focus(
          onFocusChange: (value) {
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
            cursorColor: widget.cursorColor ?? Theme.of(context).colorScheme.primary,
            autofillHints: widget.autofillHints,
            style: widget.style ?? Theme.of(context).textTheme.titleMedium?.copyWith(color: Theme.of(context).colorScheme.primary, fontWeight: FontWeight.bold),

            // -------------------------------------------------------------------------------------
            maxLines: widget.obscureText
                ? 1
                : (widget.maxLines ?? 1) <= (widget.minLines ?? 1)
                    ? null
                    : widget.maxLines,
            minLines: widget.obscureText ? 1 : widget.minLines,
            maxLength: widget.maxLength,

            // -------------------------------------------------------------------------------------
            textAlignVertical: widget.textAlignVertical,
            textAlign: widget.textAlign,

            //! Functions --------------------------------------------------------------------------
            onEditingComplete: () {
              unfocusKeyboard();
              if (widget.onComplete != null) widget.onComplete!(textEditingController.text);
            },
            onTapOutside: (PointerDownEvent pointerDownEvent) {
              unfocusKeyboard();
              if (widget.onTapOutside != null) widget.onTapOutside!(pointerDownEvent);
            },
            onChanged: (value) {
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
                      searchProductList = [];
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
                if (widget.errorCheck != null) widget.errorCheck!(error, "");
              }
              if (mounted) setState(() {});
            },
            validator: (value) {
              message = null;
              if (mounted) setState(() {});

              if (widget.validator == null) return null;
              message = widget.validator!(value);
              if (message == null) return null;
              error = true;
              if (widget.errorCheck != null) widget.errorCheck!(error, message!);

              if (widget.showDetailError || widget.errorBuilder != null) {
              } else {
                textEditingController.clear();
                hintText = message!;
              }

              if (mounted) setState(() {});
              return "";
            },
            decoration: InputDecoration(
              isDense: widget.isDense,
              isCollapsed: widget.isCollapsed,
              hintText: hintText.isEmpty ? null : hintText,
              label: widget.label,
              labelText: widget.labelText,
              labelStyle: widget.labelStyle,
              floatingLabelBehavior: widget.floatingLabelBehavior,
              constraints: widget.boxConstraints ?? BoxConstraints(minHeight: height),
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
                  child: widgetReplacement(showLoadingIcon(widget.showPrefixLoadingIcon) ?? _setIcon(widget.prefixIcon), contentPadding),
                ),
              ),
              suffixIcon: SizedBox(
                height: height,
                child: _CustomAnimatedSize(
                  alignment: Alignment.centerRight,
                  duration: widget.animationDuration,
                  curve: widget.animationCurve,
                  clipBehavior: widget.clipBehavior,
                  child: widgetReplacement(showLoadingIcon(widget.showSuffixLoadingIcon) ?? _setIcon(widget.suffixIcon), contentPadding),
                ),
              ),
              filled: widget.fillColor == null ? Theme.of(context).inputDecorationTheme.filled : true,
              fillColor: widget.fillColor ?? Theme.of(context).inputDecorationTheme.fillColor,
              hintStyle: !error ? widget.hintStyle ?? TextStyle(color: Theme.of(context).colorScheme.primary.withOpacity(0.5)) : widget.errorStyle ?? widget.hintStyle?.copyWith(color: Theme.of(context).colorScheme.error) ?? TextStyle(color: Theme.of(context).colorScheme.error),
              errorStyle: const TextStyle(height: -1),
              contentPadding: contentPadding,
              enabledBorder: widget.enabledBorder?.copyWith(borderSide: BorderSide(width: 2, color: Theme.of(context).colorScheme.primary.withOpacity(0.5))) ??
                  Theme.of(context).inputDecorationTheme.enabledBorder ??
                  OutlineInputBorder(
                    borderRadius: borderRadius,
                    borderSide: BorderSide(width: 2, color: Theme.of(context).colorScheme.primary.withOpacity(0.5)),
                  ),
              focusedBorder: widget.focusedBorder?.copyWith(borderSide: BorderSide(width: 2, color: Theme.of(context).colorScheme.primary)) ??
                  Theme.of(context).inputDecorationTheme.focusedBorder ??
                  OutlineInputBorder(
                    borderRadius: borderRadius,
                    borderSide: BorderSide(width: 2, color: Theme.of(context).colorScheme.primary),
                  ),
              errorBorder: widget.errorBorder?.copyWith(borderSide: BorderSide(width: 2, color: Theme.of(context).colorScheme.error)) ??
                  Theme.of(context).inputDecorationTheme.errorBorder ??
                  OutlineInputBorder(
                    borderRadius: borderRadius,
                    borderSide: BorderSide(width: 2, color: Theme.of(context).colorScheme.error),
                  ),
              focusedErrorBorder: widget.focusedErrorBorder?.copyWith(borderSide: BorderSide(width: 2, color: Theme.of(context).colorScheme.primary.withOpacity(0.5))) ??
                  Theme.of(context).inputDecorationTheme.focusedBorder ??
                  OutlineInputBorder(
                    borderRadius: borderRadius,
                    borderSide: BorderSide(width: 2, color: Theme.of(context).colorScheme.primary.withOpacity(0.5)),
                  ),
              disabledBorder: widget.disabledBorder?.copyWith(borderSide: BorderSide(width: 2, color: Theme.of(context).colorScheme.primary.withOpacity(0.1))) ??
                  Theme.of(context).inputDecorationTheme.disabledBorder ??
                  OutlineInputBorder(
                    borderRadius: borderRadius,
                    borderSide: BorderSide(width: 2, color: Theme.of(context).colorScheme.primary.withOpacity(0.1)),
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
          child: widget.errorBuilder != null ? widget.errorBuilder!(message ?? "") : errorChild(),
        ),
      ],
    );
  }
}

class _CustomAnimatedSize extends StatelessWidget {
  const _CustomAnimatedSize({
    Key? key,
    this.child,
    required this.alignment,
    required this.duration,
    required this.curve,
    required this.clipBehavior,
    this.widthFactor,
  }) : super(key: key);
  final Widget? child;
  final AlignmentGeometry alignment;
  final Duration duration;
  final Curve curve;
  final Clip clipBehavior;
  final double? widthFactor;

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: widthFactor,
      child: AnimatedSize(
        curve: Curves.easeInOut,
        clipBehavior: clipBehavior,
        alignment: alignment,
        duration: duration,
        child: child ?? const SizedBox(),
      ),
    );
  }
}
