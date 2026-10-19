import 'package:core_design_system/core_design_system.dart';
import 'package:material_ui/material_ui.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'Read only', type: RatingStars, path: '[Components]')
Widget ratingStars(BuildContext context) => RatingStars(
  rating: context.knobs.int.slider(label: 'Rating', initialValue: 3, max: 5),
  size:
      Sizes.tokens[context.knobs.object.dropdown(
        label: 'Size',
        options: const ['iconXs', 'iconS', 'iconM', 'iconL'],
        initialOption: 'iconS',
      )]!,
);

@widgetbook.UseCase(
  name: 'Interactive',
  type: RatingStars,
  path: '[Components]',
)
Widget ratingStarsInteractive(BuildContext context) => const _RateABook();

class _RateABook extends StatefulWidget {
  const new();

  @override
  State<_RateABook> createState() => _RateABookState();
}

class _RateABookState extends State<_RateABook> {
  var _rating = 0;

  @override
  Widget build(BuildContext context) => RatingStars(
    rating: _rating,
    size: Sizes.iconL,
    onChanged: (rating) => setState(() => _rating = rating),
  );
}
