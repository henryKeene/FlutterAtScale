import 'package:bookshelf/app/cubits/locale_cubit/locale_cubit.dart';
import 'package:bookshelf/app/cubits/theme_cubit/theme_cubit.dart';
import 'package:bookshelf/app/view/environment_banner.dart';
import 'package:core_books/core_books.dart' show CoreBooksLocalizations;
import 'package:core_config/core_config.dart';
import 'package:core_design_system/core_design_system.dart';
import 'package:core_di/core_di.dart';
import 'package:core_feature_flags/core_feature_flags.dart';
import 'package:core_l10n/core_l10n.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_ui/material_ui.dart';
import 'package:navigation/navigation.dart';

class App extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => getIt<FeatureFlagsCubit>()),
        BlocProvider(create: (_) => getIt<ThemeCubit>()..load()),
        BlocProvider(create: (_) => getIt<LocaleCubit>()..load()),
      ],
      child: const _AppView(),
    );
  }
}

class _AppView extends StatelessWidget {
  const new();

  static final ThemeData _light = AppTheme.light();
  static final ThemeData _dark = AppTheme.dark();

  @override
  Widget build(BuildContext context) {
    final config = getIt<AppConfig>();
    final themeMode = context.select<ThemeCubit, ThemeMode>(
      (cubit) => cubit.state,
    );
    final locale = context.select<LocaleCubit, Locale?>((cubit) => cubit.state);

    return MaterialApp.router(
      title: config.appName,
      theme: _light,
      darkTheme: _dark,
      themeMode: themeMode,
      locale: locale,
      supportedLocales: AppLocales.supported,
      localizationsDelegates: const [
        ...GlobalMaterialLocalizations.delegates,
        CoreDesignSystemLocalizations.delegate,
        CoreBooksLocalizations.delegate,
        ...featureLocalizationsDelegates,
      ],
      routerConfig: router,
      debugShowCheckedModeBanner: false,
      builder: (context, child) => EnvironmentBanner(
        environment: config.environment,
        child: child ?? const SizedBox.shrink(),
      ),
    );
  }
}
