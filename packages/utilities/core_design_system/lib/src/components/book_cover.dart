import 'package:core_design_system/src/tokens/tokens.dart';
import 'package:material_ui/material_ui.dart';

class BookCover extends StatelessWidget {
  const new({required this.url, this.radius = Radii.xs, super.key});

  final Uri? url;
  final double radius;

  @override
  Widget build(BuildContext context) {
    final url = this.url;

    return AspectRatio(
      aspectRatio: 2 / 3,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(radius),
        child: url == null
            ? const _CoverPlaceholder()
            : Image.network(
                url.toString(),
                fit: BoxFit.cover,
                errorBuilder: (_, _, _) => const _CoverPlaceholder(),
              ),
      ),
    );
  }
}

class _CoverPlaceholder extends StatelessWidget {
  const new();

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return ColoredBox(
      color: colors.surfaceContainerHighest,
      child: Center(
        child: Icon(Icons.menu_book_outlined, color: colors.onSurfaceVariant),
      ),
    );
  }
}
