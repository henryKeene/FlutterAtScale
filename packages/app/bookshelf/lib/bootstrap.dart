import 'dart:developer';

import 'package:bookshelf/app/app_bloc_observer.dart';
import 'package:bookshelf/app/view/app.dart';
import 'package:bookshelf/di/di_initializer.dart';
import 'package:core_config/core_config.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_ui/material_ui.dart';

Future<void> bootstrap(AppEnvironment environment) async {
  WidgetsFlutterBinding.ensureInitialized();

  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };
  Bloc.observer = const AppBlocObserver();

  await initialize(AppConfig.forEnvironment(environment));

  runApp(const App());
}
