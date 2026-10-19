import 'package:material_ui/material_ui.dart';

/// The colour roles, one set for each theme mode: [light] and [dark].
///
/// The Material roles become the theme's [ColorScheme] through
/// [toColorScheme]. A role Material has no place for, such as [rating], is
/// read with [BookshelfColors.of].
final class BookshelfColors extends ThemeExtension<BookshelfColors> {
  const new({
    required this.primary,
    required this.onPrimary,
    required this.primaryContainer,
    required this.onPrimaryContainer,
    required this.primaryFixed,
    required this.primaryFixedDim,
    required this.onPrimaryFixed,
    required this.onPrimaryFixedVariant,
    required this.secondary,
    required this.onSecondary,
    required this.secondaryContainer,
    required this.onSecondaryContainer,
    required this.secondaryFixed,
    required this.secondaryFixedDim,
    required this.onSecondaryFixed,
    required this.onSecondaryFixedVariant,
    required this.tertiary,
    required this.onTertiary,
    required this.tertiaryContainer,
    required this.onTertiaryContainer,
    required this.tertiaryFixed,
    required this.tertiaryFixedDim,
    required this.onTertiaryFixed,
    required this.onTertiaryFixedVariant,
    required this.error,
    required this.onError,
    required this.errorContainer,
    required this.onErrorContainer,
    required this.surface,
    required this.onSurface,
    required this.surfaceDim,
    required this.surfaceBright,
    required this.surfaceContainerLowest,
    required this.surfaceContainerLow,
    required this.surfaceContainer,
    required this.surfaceContainerHigh,
    required this.surfaceContainerHighest,
    required this.onSurfaceVariant,
    required this.outline,
    required this.outlineVariant,
    required this.shadow,
    required this.scrim,
    required this.inverseSurface,
    required this.onInverseSurface,
    required this.inversePrimary,
    required this.surfaceTint,
    required this.rating,
  });

  /// The `light` theme.
  static const light = BookshelfColors(
    primary: Color(0xFF8A5022),
    onPrimary: Color(0xFFFFFFFF),
    primaryContainer: Color(0xFFFFDCC5),
    onPrimaryContainer: Color(0xFF6D390B),
    primaryFixed: Color(0xFFFFDCC5),
    primaryFixedDim: Color(0xFFFFB783),
    onPrimaryFixed: Color(0xFF301400),
    onPrimaryFixedVariant: Color(0xFF6D390B),
    secondary: Color(0xFF755845),
    onSecondary: Color(0xFFFFFFFF),
    secondaryContainer: Color(0xFFFFDCC5),
    onSecondaryContainer: Color(0xFF5B412F),
    secondaryFixed: Color(0xFFFFDCC5),
    secondaryFixedDim: Color(0xFFE4BFA7),
    onSecondaryFixed: Color(0xFF2A1708),
    onSecondaryFixedVariant: Color(0xFF5B412F),
    tertiary: Color(0xFF5F6135),
    onTertiary: Color(0xFFFFFFFF),
    tertiaryContainer: Color(0xFFE4E6AE),
    onTertiaryContainer: Color(0xFF474920),
    tertiaryFixed: Color(0xFFE4E6AE),
    tertiaryFixedDim: Color(0xFFC8CA94),
    onTertiaryFixed: Color(0xFF1B1D00),
    onTertiaryFixedVariant: Color(0xFF474920),
    error: Color(0xFFBA1A1A),
    onError: Color(0xFFFFFFFF),
    errorContainer: Color(0xFFFFDAD6),
    onErrorContainer: Color(0xFF93000A),
    surface: Color(0xFFFFF8F5),
    onSurface: Color(0xFF221A15),
    surfaceDim: Color(0xFFE7D7CE),
    surfaceBright: Color(0xFFFFF8F5),
    surfaceContainerLowest: Color(0xFFFFFFFF),
    surfaceContainerLow: Color(0xFFFFF1E9),
    surfaceContainer: Color(0xFFFBEBE1),
    surfaceContainerHigh: Color(0xFFF6E5DC),
    surfaceContainerHighest: Color(0xFFF0DFD6),
    onSurfaceVariant: Color(0xFF52443B),
    outline: Color(0xFF84746A),
    outlineVariant: Color(0xFFD6C3B7),
    shadow: Color(0xFF000000),
    scrim: Color(0xFF000000),
    inverseSurface: Color(0xFF382F29),
    onInverseSurface: Color(0xFFFEEEE4),
    inversePrimary: Color(0xFFFFB783),
    surfaceTint: Color(0xFF8A5022),
    rating: Color(0xFF825500),
  );

  /// The `dark` theme.
  static const dark = BookshelfColors(
    primary: Color(0xFFFFB783),
    onPrimary: Color(0xFF4F2500),
    primaryContainer: Color(0xFF6D390B),
    onPrimaryContainer: Color(0xFFFFDCC5),
    primaryFixed: Color(0xFFFFDCC5),
    primaryFixedDim: Color(0xFFFFB783),
    onPrimaryFixed: Color(0xFF301400),
    onPrimaryFixedVariant: Color(0xFF6D390B),
    secondary: Color(0xFFE4BFA7),
    onSecondary: Color(0xFF422B1B),
    secondaryContainer: Color(0xFF5B412F),
    onSecondaryContainer: Color(0xFFFFDCC5),
    secondaryFixed: Color(0xFFFFDCC5),
    secondaryFixedDim: Color(0xFFE4BFA7),
    onSecondaryFixed: Color(0xFF2A1708),
    onSecondaryFixedVariant: Color(0xFF5B412F),
    tertiary: Color(0xFFC8CA94),
    onTertiary: Color(0xFF30330B),
    tertiaryContainer: Color(0xFF474920),
    onTertiaryContainer: Color(0xFFE4E6AE),
    tertiaryFixed: Color(0xFFE4E6AE),
    tertiaryFixedDim: Color(0xFFC8CA94),
    onTertiaryFixed: Color(0xFF1B1D00),
    onTertiaryFixedVariant: Color(0xFF474920),
    error: Color(0xFFFFB4AB),
    onError: Color(0xFF690005),
    errorContainer: Color(0xFF93000A),
    onErrorContainer: Color(0xFFFFDAD6),
    surface: Color(0xFF19120D),
    onSurface: Color(0xFFF0DFD6),
    surfaceDim: Color(0xFF19120D),
    surfaceBright: Color(0xFF413731),
    surfaceContainerLowest: Color(0xFF140D08),
    surfaceContainerLow: Color(0xFF221A15),
    surfaceContainer: Color(0xFF261E18),
    surfaceContainerHigh: Color(0xFF312822),
    surfaceContainerHighest: Color(0xFF3C332D),
    onSurfaceVariant: Color(0xFFD6C3B7),
    outline: Color(0xFF9F8D83),
    outlineVariant: Color(0xFF52443B),
    shadow: Color(0xFF000000),
    scrim: Color(0xFF000000),
    inverseSurface: Color(0xFFF0DFD6),
    onInverseSurface: Color(0xFF382F29),
    inversePrimary: Color(0xFF8A5022),
    surfaceTint: Color(0xFFFFB783),
    rating: Color(0xFFFFB94E),
  );

  /// Every theme mode, by name.
  static const Map<String, BookshelfColors> modes = {
    'light': light,
    'dark': dark,
  };

  /// The tokens of the closest [Theme], or [light] when it has none.
  static BookshelfColors of(BuildContext context) =>
      Theme.of(context).extension<BookshelfColors>() ?? light;

  /// What each token is for.
  static const Map<String, String> descriptions = {
    'primary':
        'The brand colour, for key actions and the most important components.',
    'onPrimary': 'Text and icons on primary.',
    'primaryContainer':
        'A softer fill for prominent components, such as the selected shelf.',
    'onPrimaryContainer': 'Text and icons on primary container.',
    'primaryFixed': 'A primary fill that stays the same in light and dark.',
    'primaryFixedDim':
        'A stronger primary fill that stays the same in light and dark.',
    'onPrimaryFixed': 'Text and icons on primary fixed.',
    'onPrimaryFixedVariant': 'Lower emphasis text and icons on primary fixed.',
    'secondary': 'Less prominent components, such as filter chips.',
    'onSecondary': 'Text and icons on secondary.',
    'secondaryContainer': 'Fill for tonal buttons and selected chips.',
    'onSecondaryContainer': 'Text and icons on secondary container.',
    'secondaryFixed': 'A secondary fill that stays the same in light and dark.',
    'secondaryFixedDim':
        'A stronger secondary fill that stays the same in light and dark.',
    'onSecondaryFixed': 'Text and icons on secondary fixed.',
    'onSecondaryFixedVariant':
        'Lower emphasis text and icons on secondary fixed.',
    'tertiary': 'Contrasting accents that balance primary and secondary.',
    'onTertiary': 'Text and icons on tertiary.',
    'tertiaryContainer':
        'A softer tertiary fill, such as for a remote flag badge.',
    'onTertiaryContainer': 'Text and icons on tertiary container.',
    'tertiaryFixed': 'A tertiary fill that stays the same in light and dark.',
    'tertiaryFixedDim':
        'A stronger tertiary fill that stays the same in light and dark.',
    'onTertiaryFixed': 'Text and icons on tertiary fixed.',
    'onTertiaryFixedVariant':
        'Lower emphasis text and icons on tertiary fixed.',
    'error': 'Errors and destructive actions.',
    'onError': 'Text and icons on error.',
    'errorContainer': 'A softer fill for errors.',
    'onErrorContainer': 'Text and icons on error container.',
    'surface': 'The background of every screen.',
    'onSurface': 'Text and icons on any surface.',
    'surfaceDim': 'The dimmest surface.',
    'surfaceBright': 'The brightest surface.',
    'surfaceContainerLowest': 'The container with the least emphasis.',
    'surfaceContainerLow': 'Cards.',
    'surfaceContainer': 'Navigation bars and other default containers.',
    'surfaceContainerHigh': 'Text fields, such as search.',
    'surfaceContainerHighest':
        'The container with the most emphasis, such as a missing book cover.',
    'onSurfaceVariant': 'Secondary text, such as an author or publish year.',
    'outline': 'Borders of interactive components.',
    'outlineVariant': 'Decorative dividers.',
    'shadow': 'Shadows.',
    'scrim': 'Behind modal sheets and dialogs.',
    'inverseSurface':
        'Snackbars and other elements that contrast with the surface.',
    'onInverseSurface': 'Text and icons on inverse surface.',
    'inversePrimary': 'Actions on inverse surface, such as a snackbar button.',
    'surfaceTint': 'Tints raised surfaces.',
    'rating':
        "Rating stars. Bookshelf's own role, which Material does not have.",
  };

  /// The brand colour, for key actions and the most important components.
  final Color primary;

  /// Text and icons on primary.
  final Color onPrimary;

  /// A softer fill for prominent components, such as the selected shelf.
  final Color primaryContainer;

  /// Text and icons on primary container.
  final Color onPrimaryContainer;

  /// A primary fill that stays the same in light and dark.
  final Color primaryFixed;

  /// A stronger primary fill that stays the same in light and dark.
  final Color primaryFixedDim;

  /// Text and icons on primary fixed.
  final Color onPrimaryFixed;

  /// Lower emphasis text and icons on primary fixed.
  final Color onPrimaryFixedVariant;

  /// Less prominent components, such as filter chips.
  final Color secondary;

  /// Text and icons on secondary.
  final Color onSecondary;

  /// Fill for tonal buttons and selected chips.
  final Color secondaryContainer;

  /// Text and icons on secondary container.
  final Color onSecondaryContainer;

  /// A secondary fill that stays the same in light and dark.
  final Color secondaryFixed;

  /// A stronger secondary fill that stays the same in light and dark.
  final Color secondaryFixedDim;

  /// Text and icons on secondary fixed.
  final Color onSecondaryFixed;

  /// Lower emphasis text and icons on secondary fixed.
  final Color onSecondaryFixedVariant;

  /// Contrasting accents that balance primary and secondary.
  final Color tertiary;

  /// Text and icons on tertiary.
  final Color onTertiary;

  /// A softer tertiary fill, such as for a remote flag badge.
  final Color tertiaryContainer;

  /// Text and icons on tertiary container.
  final Color onTertiaryContainer;

  /// A tertiary fill that stays the same in light and dark.
  final Color tertiaryFixed;

  /// A stronger tertiary fill that stays the same in light and dark.
  final Color tertiaryFixedDim;

  /// Text and icons on tertiary fixed.
  final Color onTertiaryFixed;

  /// Lower emphasis text and icons on tertiary fixed.
  final Color onTertiaryFixedVariant;

  /// Errors and destructive actions.
  final Color error;

  /// Text and icons on error.
  final Color onError;

  /// A softer fill for errors.
  final Color errorContainer;

  /// Text and icons on error container.
  final Color onErrorContainer;

  /// The background of every screen.
  final Color surface;

  /// Text and icons on any surface.
  final Color onSurface;

  /// The dimmest surface.
  final Color surfaceDim;

  /// The brightest surface.
  final Color surfaceBright;

  /// The container with the least emphasis.
  final Color surfaceContainerLowest;

  /// Cards.
  final Color surfaceContainerLow;

  /// Navigation bars and other default containers.
  final Color surfaceContainer;

  /// Text fields, such as search.
  final Color surfaceContainerHigh;

  /// The container with the most emphasis, such as a missing book cover.
  final Color surfaceContainerHighest;

  /// Secondary text, such as an author or publish year.
  final Color onSurfaceVariant;

  /// Borders of interactive components.
  final Color outline;

  /// Decorative dividers.
  final Color outlineVariant;

  /// Shadows.
  final Color shadow;

  /// Behind modal sheets and dialogs.
  final Color scrim;

  /// Snackbars and other elements that contrast with the surface.
  final Color inverseSurface;

  /// Text and icons on inverse surface.
  final Color onInverseSurface;

  /// Actions on inverse surface, such as a snackbar button.
  final Color inversePrimary;

  /// Tints raised surfaces.
  final Color surfaceTint;

  /// Rating stars. Bookshelf's own role, which Material does not have.
  final Color rating;

  /// Every colour role, by name.
  Map<String, Color> get tokens => {
    'primary': primary,
    'onPrimary': onPrimary,
    'primaryContainer': primaryContainer,
    'onPrimaryContainer': onPrimaryContainer,
    'primaryFixed': primaryFixed,
    'primaryFixedDim': primaryFixedDim,
    'onPrimaryFixed': onPrimaryFixed,
    'onPrimaryFixedVariant': onPrimaryFixedVariant,
    'secondary': secondary,
    'onSecondary': onSecondary,
    'secondaryContainer': secondaryContainer,
    'onSecondaryContainer': onSecondaryContainer,
    'secondaryFixed': secondaryFixed,
    'secondaryFixedDim': secondaryFixedDim,
    'onSecondaryFixed': onSecondaryFixed,
    'onSecondaryFixedVariant': onSecondaryFixedVariant,
    'tertiary': tertiary,
    'onTertiary': onTertiary,
    'tertiaryContainer': tertiaryContainer,
    'onTertiaryContainer': onTertiaryContainer,
    'tertiaryFixed': tertiaryFixed,
    'tertiaryFixedDim': tertiaryFixedDim,
    'onTertiaryFixed': onTertiaryFixed,
    'onTertiaryFixedVariant': onTertiaryFixedVariant,
    'error': error,
    'onError': onError,
    'errorContainer': errorContainer,
    'onErrorContainer': onErrorContainer,
    'surface': surface,
    'onSurface': onSurface,
    'surfaceDim': surfaceDim,
    'surfaceBright': surfaceBright,
    'surfaceContainerLowest': surfaceContainerLowest,
    'surfaceContainerLow': surfaceContainerLow,
    'surfaceContainer': surfaceContainer,
    'surfaceContainerHigh': surfaceContainerHigh,
    'surfaceContainerHighest': surfaceContainerHighest,
    'onSurfaceVariant': onSurfaceVariant,
    'outline': outline,
    'outlineVariant': outlineVariant,
    'shadow': shadow,
    'scrim': scrim,
    'inverseSurface': inverseSurface,
    'onInverseSurface': onInverseSurface,
    'inversePrimary': inversePrimary,
    'surfaceTint': surfaceTint,
    'rating': rating,
  };

  /// The Material colour roles, from the tokens named after them.
  ColorScheme toColorScheme() => ColorScheme(
    brightness: ThemeData.estimateBrightnessForColor(surface),
    primary: primary,
    onPrimary: onPrimary,
    primaryContainer: primaryContainer,
    onPrimaryContainer: onPrimaryContainer,
    primaryFixed: primaryFixed,
    primaryFixedDim: primaryFixedDim,
    onPrimaryFixed: onPrimaryFixed,
    onPrimaryFixedVariant: onPrimaryFixedVariant,
    secondary: secondary,
    onSecondary: onSecondary,
    secondaryContainer: secondaryContainer,
    onSecondaryContainer: onSecondaryContainer,
    secondaryFixed: secondaryFixed,
    secondaryFixedDim: secondaryFixedDim,
    onSecondaryFixed: onSecondaryFixed,
    onSecondaryFixedVariant: onSecondaryFixedVariant,
    tertiary: tertiary,
    onTertiary: onTertiary,
    tertiaryContainer: tertiaryContainer,
    onTertiaryContainer: onTertiaryContainer,
    tertiaryFixed: tertiaryFixed,
    tertiaryFixedDim: tertiaryFixedDim,
    onTertiaryFixed: onTertiaryFixed,
    onTertiaryFixedVariant: onTertiaryFixedVariant,
    error: error,
    onError: onError,
    errorContainer: errorContainer,
    onErrorContainer: onErrorContainer,
    surface: surface,
    onSurface: onSurface,
    surfaceDim: surfaceDim,
    surfaceBright: surfaceBright,
    surfaceContainerLowest: surfaceContainerLowest,
    surfaceContainerLow: surfaceContainerLow,
    surfaceContainer: surfaceContainer,
    surfaceContainerHigh: surfaceContainerHigh,
    surfaceContainerHighest: surfaceContainerHighest,
    onSurfaceVariant: onSurfaceVariant,
    outline: outline,
    outlineVariant: outlineVariant,
    shadow: shadow,
    scrim: scrim,
    inverseSurface: inverseSurface,
    onInverseSurface: onInverseSurface,
    inversePrimary: inversePrimary,
    surfaceTint: surfaceTint,
  );

  @override
  BookshelfColors copyWith({
    Color? primary,
    Color? onPrimary,
    Color? primaryContainer,
    Color? onPrimaryContainer,
    Color? primaryFixed,
    Color? primaryFixedDim,
    Color? onPrimaryFixed,
    Color? onPrimaryFixedVariant,
    Color? secondary,
    Color? onSecondary,
    Color? secondaryContainer,
    Color? onSecondaryContainer,
    Color? secondaryFixed,
    Color? secondaryFixedDim,
    Color? onSecondaryFixed,
    Color? onSecondaryFixedVariant,
    Color? tertiary,
    Color? onTertiary,
    Color? tertiaryContainer,
    Color? onTertiaryContainer,
    Color? tertiaryFixed,
    Color? tertiaryFixedDim,
    Color? onTertiaryFixed,
    Color? onTertiaryFixedVariant,
    Color? error,
    Color? onError,
    Color? errorContainer,
    Color? onErrorContainer,
    Color? surface,
    Color? onSurface,
    Color? surfaceDim,
    Color? surfaceBright,
    Color? surfaceContainerLowest,
    Color? surfaceContainerLow,
    Color? surfaceContainer,
    Color? surfaceContainerHigh,
    Color? surfaceContainerHighest,
    Color? onSurfaceVariant,
    Color? outline,
    Color? outlineVariant,
    Color? shadow,
    Color? scrim,
    Color? inverseSurface,
    Color? onInverseSurface,
    Color? inversePrimary,
    Color? surfaceTint,
    Color? rating,
  }) => BookshelfColors(
    primary: primary ?? this.primary,
    onPrimary: onPrimary ?? this.onPrimary,
    primaryContainer: primaryContainer ?? this.primaryContainer,
    onPrimaryContainer: onPrimaryContainer ?? this.onPrimaryContainer,
    primaryFixed: primaryFixed ?? this.primaryFixed,
    primaryFixedDim: primaryFixedDim ?? this.primaryFixedDim,
    onPrimaryFixed: onPrimaryFixed ?? this.onPrimaryFixed,
    onPrimaryFixedVariant: onPrimaryFixedVariant ?? this.onPrimaryFixedVariant,
    secondary: secondary ?? this.secondary,
    onSecondary: onSecondary ?? this.onSecondary,
    secondaryContainer: secondaryContainer ?? this.secondaryContainer,
    onSecondaryContainer: onSecondaryContainer ?? this.onSecondaryContainer,
    secondaryFixed: secondaryFixed ?? this.secondaryFixed,
    secondaryFixedDim: secondaryFixedDim ?? this.secondaryFixedDim,
    onSecondaryFixed: onSecondaryFixed ?? this.onSecondaryFixed,
    onSecondaryFixedVariant:
        onSecondaryFixedVariant ?? this.onSecondaryFixedVariant,
    tertiary: tertiary ?? this.tertiary,
    onTertiary: onTertiary ?? this.onTertiary,
    tertiaryContainer: tertiaryContainer ?? this.tertiaryContainer,
    onTertiaryContainer: onTertiaryContainer ?? this.onTertiaryContainer,
    tertiaryFixed: tertiaryFixed ?? this.tertiaryFixed,
    tertiaryFixedDim: tertiaryFixedDim ?? this.tertiaryFixedDim,
    onTertiaryFixed: onTertiaryFixed ?? this.onTertiaryFixed,
    onTertiaryFixedVariant:
        onTertiaryFixedVariant ?? this.onTertiaryFixedVariant,
    error: error ?? this.error,
    onError: onError ?? this.onError,
    errorContainer: errorContainer ?? this.errorContainer,
    onErrorContainer: onErrorContainer ?? this.onErrorContainer,
    surface: surface ?? this.surface,
    onSurface: onSurface ?? this.onSurface,
    surfaceDim: surfaceDim ?? this.surfaceDim,
    surfaceBright: surfaceBright ?? this.surfaceBright,
    surfaceContainerLowest:
        surfaceContainerLowest ?? this.surfaceContainerLowest,
    surfaceContainerLow: surfaceContainerLow ?? this.surfaceContainerLow,
    surfaceContainer: surfaceContainer ?? this.surfaceContainer,
    surfaceContainerHigh: surfaceContainerHigh ?? this.surfaceContainerHigh,
    surfaceContainerHighest:
        surfaceContainerHighest ?? this.surfaceContainerHighest,
    onSurfaceVariant: onSurfaceVariant ?? this.onSurfaceVariant,
    outline: outline ?? this.outline,
    outlineVariant: outlineVariant ?? this.outlineVariant,
    shadow: shadow ?? this.shadow,
    scrim: scrim ?? this.scrim,
    inverseSurface: inverseSurface ?? this.inverseSurface,
    onInverseSurface: onInverseSurface ?? this.onInverseSurface,
    inversePrimary: inversePrimary ?? this.inversePrimary,
    surfaceTint: surfaceTint ?? this.surfaceTint,
    rating: rating ?? this.rating,
  );

  @override
  BookshelfColors lerp(BookshelfColors? other, double t) {
    if (other is! BookshelfColors) return this;
    return BookshelfColors(
      primary: Color.lerp(primary, other.primary, t)!,
      onPrimary: Color.lerp(onPrimary, other.onPrimary, t)!,
      primaryContainer: Color.lerp(
        primaryContainer,
        other.primaryContainer,
        t,
      )!,
      onPrimaryContainer: Color.lerp(
        onPrimaryContainer,
        other.onPrimaryContainer,
        t,
      )!,
      primaryFixed: Color.lerp(primaryFixed, other.primaryFixed, t)!,
      primaryFixedDim: Color.lerp(primaryFixedDim, other.primaryFixedDim, t)!,
      onPrimaryFixed: Color.lerp(onPrimaryFixed, other.onPrimaryFixed, t)!,
      onPrimaryFixedVariant: Color.lerp(
        onPrimaryFixedVariant,
        other.onPrimaryFixedVariant,
        t,
      )!,
      secondary: Color.lerp(secondary, other.secondary, t)!,
      onSecondary: Color.lerp(onSecondary, other.onSecondary, t)!,
      secondaryContainer: Color.lerp(
        secondaryContainer,
        other.secondaryContainer,
        t,
      )!,
      onSecondaryContainer: Color.lerp(
        onSecondaryContainer,
        other.onSecondaryContainer,
        t,
      )!,
      secondaryFixed: Color.lerp(secondaryFixed, other.secondaryFixed, t)!,
      secondaryFixedDim: Color.lerp(
        secondaryFixedDim,
        other.secondaryFixedDim,
        t,
      )!,
      onSecondaryFixed: Color.lerp(
        onSecondaryFixed,
        other.onSecondaryFixed,
        t,
      )!,
      onSecondaryFixedVariant: Color.lerp(
        onSecondaryFixedVariant,
        other.onSecondaryFixedVariant,
        t,
      )!,
      tertiary: Color.lerp(tertiary, other.tertiary, t)!,
      onTertiary: Color.lerp(onTertiary, other.onTertiary, t)!,
      tertiaryContainer: Color.lerp(
        tertiaryContainer,
        other.tertiaryContainer,
        t,
      )!,
      onTertiaryContainer: Color.lerp(
        onTertiaryContainer,
        other.onTertiaryContainer,
        t,
      )!,
      tertiaryFixed: Color.lerp(tertiaryFixed, other.tertiaryFixed, t)!,
      tertiaryFixedDim: Color.lerp(
        tertiaryFixedDim,
        other.tertiaryFixedDim,
        t,
      )!,
      onTertiaryFixed: Color.lerp(onTertiaryFixed, other.onTertiaryFixed, t)!,
      onTertiaryFixedVariant: Color.lerp(
        onTertiaryFixedVariant,
        other.onTertiaryFixedVariant,
        t,
      )!,
      error: Color.lerp(error, other.error, t)!,
      onError: Color.lerp(onError, other.onError, t)!,
      errorContainer: Color.lerp(errorContainer, other.errorContainer, t)!,
      onErrorContainer: Color.lerp(
        onErrorContainer,
        other.onErrorContainer,
        t,
      )!,
      surface: Color.lerp(surface, other.surface, t)!,
      onSurface: Color.lerp(onSurface, other.onSurface, t)!,
      surfaceDim: Color.lerp(surfaceDim, other.surfaceDim, t)!,
      surfaceBright: Color.lerp(surfaceBright, other.surfaceBright, t)!,
      surfaceContainerLowest: Color.lerp(
        surfaceContainerLowest,
        other.surfaceContainerLowest,
        t,
      )!,
      surfaceContainerLow: Color.lerp(
        surfaceContainerLow,
        other.surfaceContainerLow,
        t,
      )!,
      surfaceContainer: Color.lerp(
        surfaceContainer,
        other.surfaceContainer,
        t,
      )!,
      surfaceContainerHigh: Color.lerp(
        surfaceContainerHigh,
        other.surfaceContainerHigh,
        t,
      )!,
      surfaceContainerHighest: Color.lerp(
        surfaceContainerHighest,
        other.surfaceContainerHighest,
        t,
      )!,
      onSurfaceVariant: Color.lerp(
        onSurfaceVariant,
        other.onSurfaceVariant,
        t,
      )!,
      outline: Color.lerp(outline, other.outline, t)!,
      outlineVariant: Color.lerp(outlineVariant, other.outlineVariant, t)!,
      shadow: Color.lerp(shadow, other.shadow, t)!,
      scrim: Color.lerp(scrim, other.scrim, t)!,
      inverseSurface: Color.lerp(inverseSurface, other.inverseSurface, t)!,
      onInverseSurface: Color.lerp(
        onInverseSurface,
        other.onInverseSurface,
        t,
      )!,
      inversePrimary: Color.lerp(inversePrimary, other.inversePrimary, t)!,
      surfaceTint: Color.lerp(surfaceTint, other.surfaceTint, t)!,
      rating: Color.lerp(rating, other.rating, t)!,
    );
  }
}
