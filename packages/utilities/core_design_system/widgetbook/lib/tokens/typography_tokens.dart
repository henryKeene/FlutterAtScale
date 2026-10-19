import 'package:core_design_system/core_design_system.dart';
import 'package:material_ui/material_ui.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'All', type: TypographyTokens, path: '[Tokens]')
Widget typographyTokens(BuildContext context) => TypographyTokens(
  sample: context.knobs.string(
    label: 'Sample',
    initialValue: 'The Left Hand of Darkness',
  ),
);

/// Every text style, with its size, line height and weight.
class TypographyTokens extends StatelessWidget {
  const new({required this.sample, super.key});

  final String sample;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final caption = theme.textTheme.bodySmall?.copyWith(
      color: theme.colorScheme.onSurfaceVariant,
    );

    return ListView(
      padding: const EdgeInsets.all(Spacing.m),
      children: [
        for (final MapEntry(key: name, value: style)
            in BookshelfTypography.tokens.entries) ...[
          Text(
            '$name · ${style.fontSize?.round()}/'
            '${((style.fontSize ?? 0) * (style.height ?? 1)).round()} · '
            'w${style.fontWeight?.value}',
            style: caption,
          ),
          Text(
            sample,
            style: style.copyWith(color: theme.colorScheme.onSurface),
          ),
          if (BookshelfTypography.descriptions[name] case final description?)
            Text(description, style: caption),
          const Gap(Spacing.l),
        ],
      ],
    );
  }
}
