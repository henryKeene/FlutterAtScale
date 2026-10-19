import 'package:core_design_system/core_design_system.dart';
import 'package:material_ui/material_ui.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'All', type: ColorTokens, path: '[Tokens]')
Widget colorTokens(BuildContext context) => const ColorTokens();

/// Every colour token in the current mode, with what it is for. Switch the
/// theme to see the other modes.
class ColorTokens extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = BookshelfColors.of(context);

    return ListView(
      padding: const EdgeInsets.all(Spacing.m),
      children: [
        for (final MapEntry(key: name, value: color) in colors.tokens.entries)
          _Swatch(
            name: name,
            color: color,
            description: BookshelfColors.descriptions[name],
          ),
      ],
    );
  }
}

class _Swatch extends StatelessWidget {
  const new({required this.name, required this.color, this.description});

  final String name;
  final Color color;
  final String? description;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final hex = (color.toARGB32() & 0xFFFFFF)
        .toRadixString(16)
        .padLeft(6, '0')
        .toUpperCase();
    final description = this.description;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: Spacing.s),
      child: Row(
        children: [
          DecoratedBox(
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(Radii.s),
              border: Border.all(color: theme.colorScheme.outlineVariant),
            ),
            child: const SizedBox.square(dimension: Sizes.coverThumbnail),
          ),
          const Gap(Spacing.m),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('$name  #$hex', style: theme.textTheme.titleSmall),
                if (description != null)
                  Text(
                    description,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
