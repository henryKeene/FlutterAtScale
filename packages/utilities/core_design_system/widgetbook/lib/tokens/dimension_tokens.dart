import 'package:core_design_system/core_design_system.dart';
import 'package:material_ui/material_ui.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'Spacing', type: DimensionTokens, path: '[Tokens]')
Widget spacingTokens(BuildContext context) => const DimensionTokens(
  tokens: Spacing.tokens,
  descriptions: Spacing.descriptions,
  kind: DimensionKind.length,
);

@widgetbook.UseCase(name: 'Radius', type: DimensionTokens, path: '[Tokens]')
Widget radiusTokens(BuildContext context) => const DimensionTokens(
  tokens: Radii.tokens,
  descriptions: Radii.descriptions,
  kind: DimensionKind.radius,
);

@widgetbook.UseCase(name: 'Size', type: DimensionTokens, path: '[Tokens]')
Widget sizeTokens(BuildContext context) => const DimensionTokens(
  tokens: Sizes.tokens,
  descriptions: Sizes.descriptions,
  kind: DimensionKind.square,
);

enum DimensionKind { length, radius, square }

/// A group of dimension tokens, each drawn at its real size.
class DimensionTokens extends StatelessWidget {
  const new({
    required this.tokens,
    required this.descriptions,
    required this.kind,
    super.key,
  });

  final Map<String, double> tokens;
  final Map<String, String> descriptions;
  final DimensionKind kind;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ListView(
      padding: const EdgeInsets.all(Spacing.m),
      children: [
        for (final MapEntry(key: name, :value) in tokens.entries)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: Spacing.s),
            child: Row(
              children: [
                SizedBox(
                  width: Sizes.coverDetail,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: _Sample(value: value, kind: kind),
                  ),
                ),
                const Gap(Spacing.m),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '$name  ${value.round()}px',
                        style: theme.textTheme.titleSmall,
                      ),
                      if (descriptions[name] case final description?)
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
          ),
      ],
    );
  }
}

class _Sample extends StatelessWidget {
  const new({required this.value, required this.kind});

  final double value;
  final DimensionKind kind;

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.primaryContainer;

    return switch (kind) {
      DimensionKind.length => ColoredBox(
        color: color,
        child: SizedBox(width: value, height: Spacing.m),
      ),
      DimensionKind.radius => DecoratedBox(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(value),
        ),
        child: const SizedBox.square(dimension: Sizes.iconXl),
      ),
      DimensionKind.square => ColoredBox(
        color: color,
        child: SizedBox.square(dimension: value),
      ),
    };
  }
}
