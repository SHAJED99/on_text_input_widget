import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/svg.dart';
import 'package:on_text_input_widget/on_text_input_widget.dart';

get defaultPadding => 24;

class CustomTextField1 extends StatefulWidget {
  final bool autofocus;
  final String hintText;
  final String svg;
  final Widget? prefixChild;
  final TextEditingController? textEditingController;
  final void Function(String value)? onChanged;
  final Future<void>? Function(String)? onChangedProcessing;
  final String? Function(String? value)? validator;
  final TextInputType keyboardType;
  final bool obscureText;
  final String? initialValue;
  final int? maxLine;
  final int? minLine;
  final bool enable;
  final bool readOnly;
  final InputBorder? border;
  final bool isCollapsed;
  final bool isDense;
  final BoxConstraints? boxConstraints;
  final EdgeInsetsGeometry? contentPadding;
  final List<String>? autofillHints;
  final Widget? suffixIcon;

  const CustomTextField1({
    super.key,
    this.autofocus = false,
    this.hintText = "",
    this.svg = "",
    this.textEditingController,
    this.onChanged,
    this.validator,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.initialValue,
    this.onChangedProcessing,
    this.maxLine = 1,
    this.minLine = 1,
    this.prefixChild,
    this.enable = true,
    this.readOnly = false,
    this.border,
    this.isCollapsed = false,
    this.boxConstraints,
    this.isDense = false,
    this.contentPadding,
    this.autofillHints,
    this.suffixIcon,
  });

  @override
  State<CustomTextField1> createState() => _CustomTextField1State();
}

class _CustomTextField1State extends State<CustomTextField1> {
  final RxString s = "".obs;
  final RxBool errorStatus = false.obs;
  late final RxBool showText = true.obs;

  @override
  initState() {
    super.initState();
    s.value = widget.textEditingController?.text ?? "";
    showText.value = !widget.obscureText;
  }

  Widget? setSuffixIcon() {
    if (widget.suffixIcon != null) return widget.suffixIcon;

    if (widget.obscureText) {
      return s.isEmpty
          ? null
          : GestureDetector(
              onTap: () => showText.value = !showText.value,
              child: SvgPicture.asset(
                showText.value
                    ? "lib/assets/icons/eye_opened_icon.svg"
                    : "lib/assets/icons/eye_closed_icon.svg",
                colorFilter: ColorFilter.mode(
                    Theme.of(context).colorScheme.primary, BlendMode.srcIn),
              ),
            );
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => OnTextInputWidget(
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
        obscureText: !showText.value,
        maxLines: widget.maxLine,
        minLines: widget.minLine,
        boxConstraints: widget.boxConstraints,
        onFocusChange: (isFocused) =>
            {if (widget.obscureText && !isFocused) showText.value = false},
        //! Eye button
        suffixIcon: setSuffixIcon(),
        validator: widget.validator,
        errorCheck: (error, message) {
          s.value = "";
          errorStatus.value = error;
        },
        onChanged: (value) {
          s.value = value;
          if (widget.onChanged != null) widget.onChanged!(value.trim());
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
                children: [
                  if (widget.svg.isNotEmpty)
                    SvgPicture.asset(
                      widget.svg,
                      height: defaultPadding / 1.5,
                      colorFilter: ColorFilter.mode(
                        errorStatus.value
                            ? Theme.of(context).colorScheme.error
                            : s.isEmpty
                                ? Theme.of(context)
                                    .colorScheme
                                    .primary
                                    .withOpacity(0.5)
                                : Theme.of(context).colorScheme.primary,
                        BlendMode.srcIn,
                      ),
                    ),
                  if (widget.svg.isNotEmpty && widget.prefixChild != null)
                    SizedBox(
                        width: (widget.contentPadding?.horizontal ?? 0) / 2),
                  if (widget.prefixChild != null) widget.prefixChild!,
                ],
              ),
      ),
    );
  }
}
