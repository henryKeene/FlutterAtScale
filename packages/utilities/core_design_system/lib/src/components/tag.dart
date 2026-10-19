import 'package:core_design_system/src/tokens/tokens.dart';
import 'package:material_ui/material_ui.dart';

/// Which colour roles a [Tag] is drawn in.
enum TagTone { neutral, secondary, tertiary }

/// A short label in a rounded box, such as where a feature flag's value
/// came from. It is not interactive. Use a chip for that.
class Tag extends StatelessWidget {
  const new(this.label, {this.tone = TagTone.neutral, super.key});

  final String label;
  final TagTone tone;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final (background, foreground) = switch (tone) {
      TagTone.neutral => (
        colors.surfaceContainerHighest,
        colors.onSurfaceVariant,
      ),
      TagTone.secondary => (
        colors.secondaryContainer,
        colors.onSecondaryContainer,
      ),
      TagTone.tertiary => (
        colors.tertiaryContainer,
        colors.onTertiaryContainer,
      ),
    };

    return DecoratedBox(
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(Radii.s),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: Spacing.s,
          vertical: Spacing.xxs,
        ),
        child: Text(
          label,
          style: theme.textTheme.labelSmall?.copyWith(color: foreground),
        ),
      ),
    );
  }
}
