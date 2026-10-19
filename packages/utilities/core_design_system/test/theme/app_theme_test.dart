import 'package:core_design_system/core_design_system.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';

void main() {
  group('AppTheme', () {
    test('builds the colour scheme from the colour tokens', () {
      final light = AppTheme.light().colorScheme;
      final dark = AppTheme.dark().colorScheme;

      expect(light.primary, BookshelfColors.light.primary);
      expect(
        light.surfaceContainerLow,
        BookshelfColors.light.surfaceContainerLow,
      );
      expect(dark.primary, BookshelfColors.dark.primary);
    });

    test('works out the brightness from the surface', () {
      expect(AppTheme.light().brightness, Brightness.light);
      expect(AppTheme.dark().brightness, Brightness.dark);
    });

    test('registers the colour tokens as a theme extension', () {
      expect(
        AppTheme.dark().extension<BookshelfColors>(),
        BookshelfColors.dark,
      );
    });

    test('takes its type scale from the typography tokens', () {
      final textTheme = AppTheme.light().textTheme;

      expect(
        textTheme.titleLarge!.fontSize,
        BookshelfTypography.titleLarge.fontSize,
      );
      expect(
        textTheme.labelSmall!.letterSpacing,
        BookshelfTypography.labelSmall.letterSpacing,
      );
    });

    test('shapes components with the radius tokens', () {
      final card = AppTheme.light().cardTheme.shape! as RoundedRectangleBorder;

      expect(card.borderRadius, BorderRadius.circular(Radii.l));
    });

    test('builds a theme for every mode', () {
      for (final colors in BookshelfColors.modes.values) {
        expect(AppTheme.build(colors).colorScheme.surface, colors.surface);
      }
    });
  });

  group('BookshelfColors', () {
    testWidgets('falls back to the default mode outside an AppTheme', (
      tester,
    ) async {
      late BookshelfColors colors;
      await tester.pumpWidget(
        Theme(
          data: ThemeData(),
          child: Builder(
            builder: (context) {
              colors = BookshelfColors.of(context);
              return const SizedBox();
            },
          ),
        ),
      );

      expect(colors, BookshelfColors.light);
    });

    test('blends every token when the theme animates', () {
      final halfway = BookshelfColors.light.lerp(BookshelfColors.dark, 0.5);

      expect(
        halfway.surface,
        Color.lerp(
          BookshelfColors.light.surface,
          BookshelfColors.dark.surface,
          0.5,
        ),
      );
    });
  });
}
