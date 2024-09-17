import 'package:flutter/material.dart';

class OnTextInputWidget extends StatefulWidget {
  const OnTextInputWidget({
    super.key,
    this.obscureText = false,
    this.maxLines,
    this.minLines,
    this.maxLength,
  });

  /// Obscure Text
  /// Default
  ///   obscureText: false
  final bool obscureText;

  /// Max Number of line
  final int? maxLines;

  /// Min Number of line
  final int? minLines;

  /// Max Character length
  final int? maxLength;

  @override
  State<OnTextInputWidget> createState() => _OnTextInputWidgetState();
}

class _OnTextInputWidgetState extends State<OnTextInputWidget> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: widget.obscureText
          ? 1
          : (widget.maxLines ?? 1) <= (widget.minLines ?? 1)
              ? null
              : widget.maxLines,
      minLines: widget.obscureText ? 1 : widget.minLines,
      maxLength: widget.maxLength,
    );
  }
}
