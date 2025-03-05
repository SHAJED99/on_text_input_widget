part of '../../on_text_input_widget.dart';

class _SVG extends StatelessWidget {
  const _SVG(
    this.svgLink, {
    this.color,
  });
  final String svgLink;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    return SvgPicture.asset(
      svgLink,
      colorFilter: ColorFilter.mode(
        color ?? colorScheme.onSurface,
        BlendMode.srcIn,
      ),
    );
  }
}
