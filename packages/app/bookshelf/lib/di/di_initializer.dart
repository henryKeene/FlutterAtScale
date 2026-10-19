import 'package:bookshelf/app/cubits/locale_cubit/locale_cubit.dart';
import 'package:bookshelf/app/cubits/theme_cubit/theme_cubit.dart';
import 'package:core_books/core_books.dart' as books;
import 'package:core_config/core_config.dart';
import 'package:core_design_system/core_design_system.dart' as design_system;
import 'package:core_di/core_di.dart';
import 'package:core_feature_flags/core_feature_flags.dart' as flags;
import 'package:core_l10n/core_l10n.dart' as l10n;
import 'package:core_network/core_network.dart' as network;
import 'package:core_storage/core_storage.dart' as storage;
import 'package:navigation/navigation.dart' as navigation;

Future<void> initialize(AppConfig config) async {
  getIt
    ..registerSingleton<AppConfig>(config)
    ..registerFactory<ThemeCubit>(() => ThemeCubit(getIt()))
    ..registerFactory<LocaleCubit>(() => LocaleCubit(getIt()));

  storage.initialize();
  network.initialize();
  design_system.initialize();
  l10n.initialize();
  books.initialize();
  flags.initialize();
  navigation.initialize();

  await getIt<flags.IFeatureFlagService>().load();
}
