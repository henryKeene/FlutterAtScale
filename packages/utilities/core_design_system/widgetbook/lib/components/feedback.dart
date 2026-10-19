import 'package:core_design_system/core_design_system.dart';
import 'package:material_ui/material_ui.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'Default', type: EmptyState, path: '[Components]')
Widget emptyState(BuildContext context) {
  final withAction = context.knobs.boolean(
    label: 'With action',
    initialValue: true,
  );

  return EmptyState(
    icon: Icons.auto_stories_outlined,
    title: context.knobs.string(
      label: 'Title',
      initialValue: 'Your shelf is empty',
    ),
    message: context.knobs.string(
      label: 'Message',
      initialValue: 'Books you add from Discover show up here.',
    ),
    action: withAction
        ? FilledButton(onPressed: () {}, child: const Text('Find a book'))
        : null,
  );
}

/// Its title and button come from the design system's own strings, so the
/// locale addon shows them in every language.
@widgetbook.UseCase(name: 'Default', type: ErrorView, path: '[Components]')
Widget errorView(BuildContext context) {
  final retry = context.knobs.boolean(label: 'Can retry', initialValue: true);

  return ErrorView(
    message: context.knobs.string(
      label: 'Message',
      initialValue: 'Open Library did not answer. Check your connection.',
    ),
    onRetry: retry ? () {} : null,
  );
}

@widgetbook.UseCase(name: 'Tones', type: Tag, path: '[Components]')
Widget tags(BuildContext context) {
  final label = context.knobs.string(label: 'Label', initialValue: 'Remote');

  return Wrap(
    spacing: Spacing.s,
    children: [for (final tone in TagTone.values) Tag(label, tone: tone)],
  );
}

@widgetbook.UseCase(name: 'Default', type: SectionHeader, path: '[Components]')
Widget sectionHeader(BuildContext context) => SectionHeader(
  context.knobs.string(label: 'Title', initialValue: 'Reading now'),
);
