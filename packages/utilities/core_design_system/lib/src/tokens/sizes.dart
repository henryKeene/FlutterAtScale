/// Sizes of icons and book covers.
abstract final class Sizes {
  /// Ratings in dense lists.
  static const double iconXs = 14;

  /// Rating stars and chip icons.
  static const double iconS = 18;

  /// Standard icons.
  static const double iconM = 24;

  /// Rating stars you can tap, when writing a review.
  static const double iconL = 36;

  /// The icon in an empty state.
  static const double iconXl = 56;

  /// Book covers in lists.
  static const double coverThumbnail = 48;

  /// The book cover on the details page.
  static const double coverDetail = 120;

  /// Every size, by name.
  static const Map<String, double> tokens = {
    'iconXs': iconXs,
    'iconS': iconS,
    'iconM': iconM,
    'iconL': iconL,
    'iconXl': iconXl,
    'coverThumbnail': coverThumbnail,
    'coverDetail': coverDetail,
  };

  /// What each token is for.
  static const Map<String, String> descriptions = {
    'iconXs': 'Ratings in dense lists.',
    'iconS': 'Rating stars and chip icons.',
    'iconM': 'Standard icons.',
    'iconL': 'Rating stars you can tap, when writing a review.',
    'iconXl': 'The icon in an empty state.',
    'coverThumbnail': 'Book covers in lists.',
    'coverDetail': 'The book cover on the details page.',
  };
}
