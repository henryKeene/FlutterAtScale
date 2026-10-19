import 'package:core_books/core_books.dart';
import 'package:core_books/fakes.dart';

/// Nine books with alternating statuses, so even a few of them spread across
/// the filters. The last has no author or cover.
final List<ShelfEntry> sampleShelf = [
  _entry(SampleBooks.piranesi, ReadingStatus.reading),
  _entry(SampleBooks.wizardOfEarthsea, ReadingStatus.read, rating: 5),
  _entry(SampleBooks.middlemarch, ReadingStatus.wantToRead),
  _entry(SampleBooks.leftHandOfDarkness, ReadingStatus.reading),
  _entry(SampleBooks.remainsOfTheDay, ReadingStatus.read, rating: 4),
  _entry(SampleBooks.jekyllAndHyde, ReadingStatus.wantToRead),
  _entry(SampleBooks.dispossessed, ReadingStatus.read, rating: 3),
  _entry(SampleBooks.beloved, ReadingStatus.wantToRead),
  _entry(SampleBooks.untitled, ReadingStatus.reading),
];

ShelfEntry _entry(Book book, ReadingStatus status, {int? rating}) => ShelfEntry(
  book: book,
  status: status,
  updatedAt: DateTime(2026, 10),
  rating: rating,
);
