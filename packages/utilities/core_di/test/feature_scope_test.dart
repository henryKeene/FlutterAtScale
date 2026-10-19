import 'package:core_di/core_di.dart';
import 'package:test/test.dart';

class _Counter {
  int value = 0;
}

void main() {
  late GetIt getIt;

  setUp(() => getIt = GetIt.asNewInstance());

  group('FeatureScope', () {
    test('registers dependencies inside a named scope', () {
      getIt.pushFeatureScope(
        'books',
        (scope) => scope.registerSingleton<_Counter>(_Counter()),
      );

      expect(getIt.hasScope('books'), isTrue);
      expect(getIt.isRegistered<_Counter>(), isTrue);
    });

    test('ignores a second push of the same scope', () {
      getIt
        ..pushFeatureScope(
          'books',
          (scope) => scope.registerSingleton<_Counter>(_Counter()..value = 1),
        )
        ..pushFeatureScope(
          'books',
          (scope) => scope.registerSingleton<_Counter>(_Counter()..value = 2),
        );

      expect(getIt<_Counter>().value, 1);
    });

    test('drops the scope and everything registered in it', () async {
      getIt.pushFeatureScope(
        'books',
        (scope) => scope.registerSingleton<_Counter>(_Counter()),
      );

      await getIt.dropFeatureScope('books');

      expect(getIt.hasScope('books'), isFalse);
      expect(getIt.isRegistered<_Counter>(), isFalse);
    });

    test('dropping a scope that does not exist is a no-op', () async {
      await expectLater(getIt.dropFeatureScope('missing'), completes);
    });
  });
}
