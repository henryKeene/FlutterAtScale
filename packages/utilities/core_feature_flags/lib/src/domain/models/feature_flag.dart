enum FeatureFlag {
  readingStats(
    key: 'reading_stats',
    title: 'Reading stats',
    description: 'Adds the Stats tab and its route.',
  ),
  bookReviews(
    key: 'book_reviews',
    title: 'Book reviews',
    description: 'Asks for a rating and review when a book is marked as read.',
  ),
  shelfGrid(
    key: 'shelf_grid',
    title: 'Shelf grid',
    description: 'Shows My books as a grid of covers instead of a list.',
  ),
  trendingBooks(
    key: 'trending_books',
    title: 'Trending books',
    description: 'Shows what is trending on Open Library before you search.',
  );

  new({required this.key, required this.title, required this.description});

  final String key;
  final String title;
  final String description;
}
