import 'package:core_design_system/core_design_system.dart';
import 'package:material_ui/material_ui.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'No cover', type: BookCover, path: '[Components]')
Widget bookCoverPlaceholder(BuildContext context) => SizedBox(
  width: _width(context),
  child: BookCover(url: null, radius: _radius(context)),
);

@widgetbook.UseCase(
  name: 'From Open Library',
  type: BookCover,
  path: '[Components]',
)
Widget bookCoverNetwork(BuildContext context) => SizedBox(
  width: _width(context),
  child: BookCover(
    url: Uri.tryParse(
      context.knobs.string(
        label: 'Cover URL',
        initialValue: 'https://covers.openlibrary.org/b/id/12547191-L.jpg',
      ),
    ),
    radius: _radius(context),
  ),
);

/// Knobs offer token names rather than free numbers, because components
/// should only ever be given values from the design system.
double _width(BuildContext context) =>
    Sizes.tokens[context.knobs.object.dropdown(
      label: 'Width',
      options: const ['coverThumbnail', 'coverDetail'],
      initialOption: 'coverDetail',
    )]!;

double _radius(BuildContext context) =>
    Radii.tokens[context.knobs.object.dropdown(
      label: 'Radius',
      options: Radii.tokens.keys.toList(),
    )]!;
