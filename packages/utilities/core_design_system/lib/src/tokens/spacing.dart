/// Space between and inside components.
abstract final class Spacing {
  /// Inside small components, such as the height of a tag.
  static const double xxs = 2;

  /// Between an icon and its label, or tightly related text.
  static const double xs = 4;

  /// Between related elements inside a component.
  static const double s = 8;

  /// Screen margins and the padding inside cards.
  static const double m = 16;

  /// Between sections.
  static const double l = 24;

  /// Around empty states and other spacious layouts.
  static const double xl = 32;

  /// Every spacing, by name.
  static const Map<String, double> tokens = {
    'xxs': xxs,
    'xs': xs,
    's': s,
    'm': m,
    'l': l,
    'xl': xl,
  };

  /// What each token is for.
  static const Map<String, String> descriptions = {
    'xxs': 'Inside small components, such as the height of a tag.',
    'xs': 'Between an icon and its label, or tightly related text.',
    's': 'Between related elements inside a component.',
    'm': 'Screen margins and the padding inside cards.',
    'l': 'Between sections.',
    'xl': 'Around empty states and other spacious layouts.',
  };
}
