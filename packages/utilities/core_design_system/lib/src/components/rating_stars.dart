import 'package:core_design_system/src/tokens/tokens.dart';
import 'package:material_ui/material_ui.dart';

class RatingStars extends StatelessWidget {
  const new({
    required this.rating,
    this.onChanged,
    this.size = Sizes.iconS,
    super.key,
  });

  final int rating;
  final ValueChanged<int>? onChanged;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (var star = 1; star <= 5; star++)
          _Star(
            filled: star <= rating,
            size: size,
            onTap: onChanged == null ? null : () => onChanged!(star),
          ),
      ],
    );
  }
}

class _Star extends StatelessWidget {
  const new({required this.filled, required this.size, this.onTap});

  final bool filled;
  final double size;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final icon = Icon(
      filled ? Icons.star_rounded : Icons.star_outline_rounded,
      size: size,
      color: BookshelfColors.of(context).rating,
    );
    final onTap = this.onTap;

    if (onTap == null) return icon;
    return IconButton(onPressed: onTap, icon: icon);
  }
}
