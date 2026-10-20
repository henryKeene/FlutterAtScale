import 'package:core_design_system/core_design_system.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';

Widget _app(Widget child, {ThemeData? theme}) => MaterialApp(
  theme: theme ?? AppTheme.light(),
  home: Scaffold(body: child),
);

void main() {
  group('RatingStars', () {
    testWidgets('draws the stars in the rating colour of the theme', (
      tester,
    ) async {
      await tester.pumpWidget(
        _app(const RatingStars(rating: 3), theme: AppTheme.dark()),
      );

      final stars = tester.widgetList<Icon>(find.byType(Icon));
      expect(stars, hasLength(5));
      expect(stars.map((star) => star.color).toSet(), {
        BookshelfColors.dark.rating,
      });
      expect(
        stars.where((star) => star.icon == Icons.star_rounded),
        hasLength(3),
      );
    });

    testWidgets('reports the star that was tapped', (tester) async {
      int? rated;
      await tester.pumpWidget(
        _app(RatingStars(rating: 1, onChanged: (rating) => rated = rating)),
      );

      await tester.tap(find.byType(IconButton).at(3));

      expect(rated, 4);
    });
  });

  group('Tag', () {
    testWidgets('fills each tone with its container colour', (tester) async {
      final scheme = AppTheme.light().colorScheme;
      final expected = {
        TagTone.neutral: scheme.surfaceContainerHighest,
        TagTone.secondary: scheme.secondaryContainer,
        TagTone.tertiary: scheme.tertiaryContainer,
      };

      for (final MapEntry(key: tone, value: color) in expected.entries) {
        await tester.pumpWidget(_app(Tag('Remote', tone: tone)));

        final box = tester.widget<DecoratedBox>(
          find.descendant(
            of: find.byType(Tag),
            matching: find.byType(DecoratedBox),
          ),
        );
        expect((box.decoration as BoxDecoration).color, color);
      }
    });
  });

  group('BookListTile', () {
    testWidgets('shows the title, the subtitle and an optional footer', (
      tester,
    ) async {
      var taps = 0;
      await tester.pumpWidget(
        _app(
          BookListTile(
            title: 'Middlemarch',
            subtitle: 'George Eliot · 1871',
            footer: const Text('Loved it'),
            onTap: () => taps++,
          ),
        ),
      );

      expect(find.text('Middlemarch'), findsOneWidget);
      expect(find.text('George Eliot · 1871'), findsOneWidget);
      expect(find.text('Loved it'), findsOneWidget);

      await tester.tap(find.byType(BookListTile));
      expect(taps, 1);
    });

    testWidgets('is only as tall as its content outside a list', (
      tester,
    ) async {
      await tester.pumpWidget(
        _app(
          Center(
            child: BookListTile(title: 'Emma', subtitle: '1815', onTap: () {}),
          ),
        ),
      );

      const cover = Sizes.coverThumbnail * 3 / 2;
      expect(
        tester.getSize(find.byType(BookListTile)).height,
        cover + Spacing.s * 2,
      );
    });
  });

  group('LoadingIndicator', () {
    double? valueOf(WidgetTester tester) => tester
        .widget<CircularProgressIndicator>(
          find.byType(CircularProgressIndicator),
        )
        .value;

    testWidgets('spins while animations run', (tester) async {
      await tester.pumpWidget(_app(const LoadingIndicator()));

      expect(valueOf(tester), isNull);
      expect(tester.binding.hasScheduledFrame, isTrue);
    });

    testWidgets('holds still as a ring while animations are paused', (
      tester,
    ) async {
      await tester.pumpWidget(
        _app(const TickerMode(enabled: false, child: LoadingIndicator())),
      );
      // Settling fails while anything still moves.
      await tester.pumpAndSettle();

      expect(valueOf(tester), LoadingIndicator.pausedValue);
    });
  });
}
