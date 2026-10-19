import 'package:core_books/src/domain/models/book.dart';

/// Real Open Library works, so their covers load, and one book with nothing
/// but a title.
abstract final class SampleBooks {
  static const dune = Book(
    workId: 'OL893414W',
    title: 'Dune',
    authors: ['Frank Herbert'],
    coverId: 11481354,
    firstPublishYear: 1965,
    description:
        'A noble family takes charge of a desert planet that holds the most '
        'valuable substance in the universe, and its heir is drawn into a '
        'war over who controls it.',
    subjects: ['Science fiction', 'Ecology', 'Politics', 'Deserts'],
  );

  static const piranesi = Book(
    workId: 'OL20893680W',
    title: 'Piranesi',
    authors: ['Susanna Clarke'],
    coverId: 10226290,
    firstPublishYear: 2020,
  );

  static const wizardOfEarthsea = Book(
    workId: 'OL59798W',
    title: 'A Wizard of Earthsea',
    authors: ['Ursula K. Le Guin'],
    coverId: 13617691,
    firstPublishYear: 1968,
  );

  static const middlemarch = Book(
    workId: 'OL20867W',
    title: 'Middlemarch',
    authors: ['George Eliot'],
    coverId: 252882,
    firstPublishYear: 1871,
  );

  static const leftHandOfDarkness = Book(
    workId: 'OL59800W',
    title: 'The Left Hand of Darkness',
    authors: ['Ursula K. Le Guin'],
    coverId: 10618463,
    firstPublishYear: 1969,
  );

  static const remainsOfTheDay = Book(
    workId: 'OL59048W',
    title: 'The Remains of the Day',
    authors: ['Kazuo Ishiguro'],
    coverId: 95742,
    firstPublishYear: 1989,
  );

  static const jekyllAndHyde = Book(
    workId: 'OL24156W',
    title: 'The Strange Case of Dr. Jekyll and Mr. Hyde',
    authors: ['Robert Louis Stevenson'],
    coverId: 295773,
    firstPublishYear: 1886,
  );

  static const dispossessed = Book(
    workId: 'OL59863W',
    title: 'The Dispossessed',
    authors: ['Ursula K. Le Guin'],
    coverId: 6979680,
    firstPublishYear: 1974,
  );

  static const beloved = Book(
    workId: 'OL50548W',
    title: 'Beloved',
    authors: ['Toni Morrison'],
    coverId: 8261367,
    firstPublishYear: 1987,
  );

  /// No author, cover, year or description: what a sparse Open Library
  /// record looks like.
  static const untitled = Book(
    workId: 'OL0000001W',
    title: 'An Untitled Manuscript',
  );

  static const List<Book> all = [
    dune,
    piranesi,
    wizardOfEarthsea,
    middlemarch,
    leftHandOfDarkness,
    remainsOfTheDay,
    jekyllAndHyde,
    dispossessed,
    beloved,
    untitled,
  ];
}
