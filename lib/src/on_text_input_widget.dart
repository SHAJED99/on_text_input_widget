// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:flutter/material.dart';

class OnTextInputWidget extends StatefulWidget {
  const OnTextInputWidget({
    Key? key,
    this.textEditingController,
    this.hintText = "",
    this.obscureText = false,
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
    this.onChangeDebouncer = const Duration(milliseconds: 500),
    this.onChangedProcessing,
    this.errorCheck,
    this.fullTextSelection = false,
    this.onTap,
    this.validator,
    this.errorBuilder,
    this.showDetailError = true,
    this.animationDuration = const Duration(milliseconds: 500),
    this.loadingIcon,
    this.loadingIconsSize = 24,
    this.contentPadding,
    this.boxConstraints,
    this.loadingIconColor,
    this.textAlign = TextAlign.start,
    this.errorTextStyle,
    this.errorColor,
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

  /// Max Number of line
  final int? maxLines;

  /// Min Number of line
  final int? minLines;

  /// Max Character length
  final int? maxLength;

  /// Animation Duration. Default: Duration(milliseconds: 500
  final Duration animationDuration;

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

  /// OnChangedProcessing function waiting duration. Default: Duration(milliseconds: 500)
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

  //! Functions
  /// Function runs when the focused is change. It will be called when the text field is focused or unfocused.
  final Function(bool isFocused)? onFocusChange;

  /// Function runs when text field editing is completed.
  final void Function(String? value)? onComplete;

  /// Function runs when pressing outside of the text field
  final void Function(PointerDownEvent pointerDownEvent)? onTapOutside;

  ///
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
    if (focusNode == FocusManager.instance.primaryFocus?.offset) {
      FocusManager.instance.primaryFocus?.unfocus();
      FocusManager.instance.rootScope.unfocus();
      FocusScope.of(context).unfocus();
      focusNode = null;
    } else {
      focusNode = FocusManager.instance.primaryFocus?.offset;
    }

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
            focusNode: widget.focusNode,
            textCapitalization: widget.textCapitalization,

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
                if (widget.errorCheck != null) widget.errorCheck!(error, "");
              }
              if (mounted) setState(() {});
            },
            onTap: () {
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
          ),
        ),
      ],
    );
  }
}

// class CustomAnimatedSize extends StatelessWidget {
//   const CustomAnimatedSize({
//     super.key,
//     this.child,
//     this.alignment = Alignment.center,
//     required this.duration,
//     this.curve = Curves.linear,
//     this.clipBehavior = Clip.antiAlias,
//     this.widthFactor,
//     this.heightFactor,
//   });
//   final Widget? child;
//   final AlignmentGeometry alignment;
//   final Duration duration;
//   final Curve curve;
//   final Clip clipBehavior;
//   final double? widthFactor;
//   final double? heightFactor;

//   @override
//   Widget build(BuildContext context) {
//     return FractionallySizedBox(
//       widthFactor: widthFactor,
//       heightFactor: heightFactor,
//       child: AnimatedSize(
//         curve: Curves.easeInOut,
//         clipBehavior: clipBehavior,
//         alignment: alignment,
//         duration: duration,
//         child: child ?? const SizedBox(),
//       ),
//     );
//   }
// }
