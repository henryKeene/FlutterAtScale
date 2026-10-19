import 'package:core_config/core_config.dart';
import 'package:core_feature_flags/core_feature_flags.dart';
import 'package:core_feature_flags/src/data/services/feature_flag_service.dart';
import 'package:core_feature_flags/src/domain/interfaces/i_remote_flag_source.dart';
import 'package:core_prelude/core_prelude.dart';
import 'package:core_storage/core_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockRemoteFlagSource extends Mock implements IRemoteFlagSource;

class _MockKeyValueStore extends Mock implements IKeyValueStore;

void main() {
  late _MockRemoteFlagSource remote;
  late _MockKeyValueStore store;

  setUp(() {
    remote = _MockRemoteFlagSource();
    store = _MockKeyValueStore();
    when(() => store.readString(any())).thenAnswer((_) async => null);
    when(() => store.writeString(any(), any())).thenAnswer((_) async {});
    when(() => store.delete(any())).thenAnswer((_) async {});
    when(() => remote.fetch()).thenAnswer((_) async => success({}));
  });

  FeatureFlagService buildService(AppEnvironment environment) =>
      FeatureFlagService(AppConfig.forEnvironment(environment), remote, store);

  group('FeatureFlagService', () {
    test('uses the environment defaults when nothing else is set', () async {
      final service = buildService(AppEnvironment.production);

      await service.load();

      expect(service.isEnabled(FeatureFlag.readingStats), isFalse);
      expect(
        service.current.resolved(FeatureFlag.readingStats).source,
        FlagSource.defaults,
      );
    });

    test('remote values win over defaults', () async {
      when(() => remote.fetch())
          .thenAnswer((_) async => success({'reading_stats': true}));
      final service = buildService(AppEnvironment.production);

      await service.load();

      expect(
        service.current.resolved(FeatureFlag.readingStats),
        const ResolvedFlag(enabled: true, source: FlagSource.remote),
      );
    });

    test('local overrides win over remote values', () async {
      when(() => remote.fetch())
          .thenAnswer((_) async => success({'shelf_grid': false}));
      final service = buildService(AppEnvironment.development);
      await service.load();

      await service.setOverride(FeatureFlag.shelfGrid, enabled: true);

      expect(
        service.current.resolved(FeatureFlag.shelfGrid),
        const ResolvedFlag(enabled: true, source: FlagSource.override),
      );
      verify(
        () =>
            store.writeString('feature_flag_overrides', '{"shelf_grid":true}'),
      ).called(1);
    });

    test('overrides are ignored in production', () async {
      when(() => store.readString(any()))
          .thenAnswer((_) async => '{"reading_stats":true}');
      final service = buildService(AppEnvironment.production);

      await service.load();

      expect(service.isEnabled(FeatureFlag.readingStats), isFalse);
    });

    test('keeps the last remote values when a refresh fails', () async {
      when(() => remote.fetch())
          .thenAnswer((_) async => success({'trending_books': false}));
      final service = buildService(AppEnvironment.development);
      await service.load();

      when(() => remote.fetch())
          .thenAnswer((_) async => failure(const RemoteFlagFailure()));
      await service.refreshRemote();

      expect(service.isEnabled(FeatureFlag.trendingBooks), isFalse);
    });

    test('clearing an override falls back to the next source', () async {
      final service = buildService(AppEnvironment.development);
      await service.load();
      await service.setOverride(FeatureFlag.bookReviews, enabled: false);

      await service.setOverride(FeatureFlag.bookReviews, enabled: null);

      expect(
        service.current.resolved(FeatureFlag.bookReviews).source,
        FlagSource.defaults,
      );
    });

    test('broadcasts every change', () async {
      final service = buildService(AppEnvironment.development);
      await service.load();

      final emitted = expectLater(
        service.changes.map((flags) => flags.isEnabled(FeatureFlag.shelfGrid)),
        emitsInOrder([false, true]),
      );
      await service.setOverride(FeatureFlag.shelfGrid, enabled: false);
      await service.clearOverrides();

      await emitted;
    });
  });
}
