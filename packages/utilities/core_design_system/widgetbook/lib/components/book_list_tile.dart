import 'package:core_design_system/core_design_system.dart';
import 'package:material_ui/material_ui.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'Default', type: BookListTile, path: '[Components]')
Widget bookListTile(BuildContext context) {
  final rated = context.knobs.boolean(label: 'Rated', initialValue: true);
  final rating = context.knobs.int.slider(
    label: 'Rating',
    initialValue: 4,
    max: 5,
  );

  return BookListTile(
    title: context.knobs.string(
      label: 'Title',
      initialValue: 'A Wizard of Earthsea',
    ),
    subtitle: context.knobs.string(
      label: 'Subtitle',
      initialValue: 'Ursula K. Le Guin · 1968',
    ),
    footer: rated ? RatingStars(rating: rating, size: Sizes.iconXs) : null,
    onTap: () {},
  );
}

@widgetbook.UseCase(
  name: 'Long title',
  type: BookListTile,
  path: '[Components]',
)
Widget bookListTileLongTitle(BuildContext context) => BookListTile(
  title:
      'The Strange Case of Dr Jekyll and Mr Hyde, with Other Fables and '
      'Stories of the Supernatural',
  subtitle: 'Robert Louis Stevenson · 1886',
  onTap: () {},
);
