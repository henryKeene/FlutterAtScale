import 'package:core_prelude/core_prelude.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Result', () {
    test('fold calls the success branch for a success', () {
      final result = success<int, String>(2);

      expect(result.fold((value) => value * 2, (_) => 0), 4);
    });

    test('fold calls the failure branch for a failure', () {
      final result = failure<int, String>('nope');

      expect(result.fold((_) => '', (error) => error), 'nope');
    });

    test('map transforms a success and leaves a failure alone', () {
      expect(
        success<int, String>(2).map((value) => '$value'),
        success<String, String>('2'),
      );
      expect(
        failure<int, String>('nope').map((value) => '$value'),
        failure<String, String>('nope'),
      );
    });

    test('mapFailure transforms a failure and leaves a success alone', () {
      expect(
        failure<int, String>('nope').mapFailure((error) => error.length),
        failure<int, int>(4),
      );
      expect(
        success<int, String>(2).mapFailure((error) => error.length),
        success<int, int>(2),
      );
    });

    test('flatMap chains results and short circuits on failure', () {
      Result<int, String> half(int value) =>
          value.isEven ? success(value ~/ 2) : failure('odd');

      expect(
        success<int, String>(8).flatMap(half).flatMap(half),
        success<int, String>(2),
      );
      expect(
        success<int, String>(6).flatMap(half).flatMap(half),
        failure<int, String>('odd'),
      );
    });

    test('asyncFlatMap chains asynchronous work', () async {
      final result = await success<int, String>(3)
          .asyncFlatMap((value) async => success<int, String>(value + 1));

      expect(result, success<int, String>(4));
    });

    test('getOrElse and getOrNull unwrap values', () {
      expect(success<int, String>(1).getOrElse(() => 0), 1);
      expect(failure<int, String>('nope').getOrElse(() => 0), 0);
      expect(failure<int, String>('nope').getOrNull(), isNull);
    });

    test('isSuccess and isFailure describe the variant', () {
      expect(success<int, String>(1).isSuccess, isTrue);
      expect(failure<int, String>('nope').isFailure, isTrue);
    });
  });
}
