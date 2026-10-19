/// Corner radii.
abstract final class Radii {
  /// Book covers and other small images.
  static const double xs = 4;

  /// Badges, tags and shelf tiles.
  static const double s = 8;

  /// Medium components, such as menus.
  static const double m = 12;

  /// Cards.
  static const double l = 16;

  /// Search fields and large sheets.
  static const double xl = 28;

  /// Pills and circles.
  static const double full = 999;

  /// Every radius, by name.
  static const Map<String, double> tokens = {
    'xs': xs,
    's': s,
    'm': m,
    'l': l,
    'xl': xl,
    'full': full,
  };

  /// What each token is for.
  static const Map<String, String> descriptions = {
    'xs': 'Book covers and other small images.',
    's': 'Badges, tags and shelf tiles.',
    'm': 'Medium components, such as menus.',
    'l': 'Cards.',
    'xl': 'Search fields and large sheets.',
    'full': 'Pills and circles.',
  };
}
