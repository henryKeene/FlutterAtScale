import 'dart:math';

import 'package:core_design_system/core_design_system.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';

/// The WCAG contrast ratio between two colours, from 1 to 21.
double contrast(Color a, Color b) {
  final lighter = max(a.computeLuminance(), b.computeLuminance());
  final darker = min(a.computeLuminance(), b.computeLuminance());
  return (lighter + 0.05) / (darker + 0.05);
}

/// Design rules for the colour tokens, checked in every mode.
///
/// Anyone can change a colour. If the new one fails WCAG AA, this test fails
/// on the pull request that brings it in.
void main() {
  for (final MapEntry(key: mode, value: colors)
      in BookshelfColors.modes.entries) {
    group('$mode mode', () {
      final text = {
        'onPrimary on primary': (colors.onPrimary, colors.primary),
        'onPrimaryContainer on primaryContainer': (
          colors.onPrimaryContainer,
          colors.primaryContainer,
        ),
        'onSecondary on secondary': (colors.onSecondary, colors.secondary),
        'onSecondaryContainer on secondaryContainer': (
          colors.onSecondaryContainer,
          colors.secondaryContainer,
        ),
        'onTertiary on tertiary': (colors.onTertiary, colors.tertiary),
        'onTertiaryContainer on tertiaryContainer': (
          colors.onTertiaryContainer,
          colors.tertiaryContainer,
        ),
        'onError on error': (colors.onError, colors.error),
        'onErrorContainer on errorContainer': (
          colors.onErrorContainer,
          colors.errorContainer,
        ),
        'onSurface on surface': (colors.onSurface, colors.surface),
        'onSurfaceVariant on surface': (
          colors.onSurfaceVariant,
          colors.surface,
        ),
        'onSurfaceVariant on surfaceContainerHighest': (
          colors.onSurfaceVariant,
          colors.surfaceContainerHighest,
        ),
        'onInverseSurface on inverseSurface': (
          colors.onInverseSurface,
          colors.inverseSurface,
        ),
      };
      for (final MapEntry(key: pair, value: (foreground, background))
          in text.entries) {
        test('$pair is readable text (4.5:1)', () {
          expect(contrast(foreground, background), greaterThanOrEqualTo(4.5));
        });
      }

      final graphics = {
        'rating on surface': (colors.rating, colors.surface),
        'rating on a card': (colors.rating, colors.surfaceContainerLow),
        'outline on surface': (colors.outline, colors.surface),
      };
      for (final MapEntry(key: pair, value: (foreground, background))
          in graphics.entries) {
        test('$pair is a visible graphic (3:1)', () {
          expect(contrast(foreground, background), greaterThanOrEqualTo(3));
        });
      }
    });
  }
}
