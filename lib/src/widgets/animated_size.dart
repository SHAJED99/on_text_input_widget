part of '../../on_text_input_widget.dart';

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
