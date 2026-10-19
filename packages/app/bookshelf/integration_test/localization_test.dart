import 'package:bookshelf/app/view/app.dart';
import 'package:bookshelf/di/di_initializer.dart' as di;
import 'package:core_books/core_books.dart';
import 'package:core_config/core_config.dart';
import 'package:core_di/core_di.dart';
import 'package:core_l10n/core_l10n.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('choosing a language in Settings translates every package', (
    tester,
  ) async {
    await di.initialize(AppConfig.forEnvironment(AppEnvironment.development));
    await getIt<ILocaleService>().setLocale(AppLocales.english);
    await getIt<ILibraryService>().shelve(
      const Book(
        workId: 'OL893414W',
        title: 'Dune',
        authors: ['Frank Herbert'],
      ),
      status: ReadingStatus.reading,
    );
    await tester.pumpWidget(const App());
    await tester.pumpAndSettle();

    expect(find.text('My books'), findsNWidgets(2));

    await tester.tap(find.text('Settings'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Español'));
    await tester.pumpAndSettle();

    expect(find.text('Ajustes'), findsNWidgets(2));
    expect(find.text('Idioma'), findsOneWidget);
    expect(find.text('Objetivo anual'), findsOneWidget);

    await tester.tap(find.text('Mis libros'));
    await tester.pumpAndSettle();

    expect(find.text('Mis libros'), findsNWidgets(2));
    expect(find.text('Leyendo'), findsOneWidget);
    expect(find.text('Por leer'), findsOneWidget);

    await getIt<ILibraryService>().remove('OL893414W');
    await getIt<ILocaleService>().setLocale(null);
    await tester.pumpAndSettle();
  });
}
