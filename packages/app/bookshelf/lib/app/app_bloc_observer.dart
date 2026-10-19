import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppBlocObserver extends BlocObserver {
  const new();

  @override
  void onChange(BlocBase<dynamic> bloc, Change<dynamic> change) {
    super.onChange(bloc, change);
    if (kDebugMode) {
      log('${bloc.runtimeType} -> ${change.nextState}', name: 'bloc');
    }
  }

  @override
  void onError(BlocBase<dynamic> bloc, Object error, StackTrace stackTrace) {
    log(
      '${bloc.runtimeType} failed',
      error: error,
      stackTrace: stackTrace,
      name: 'bloc',
    );
    super.onError(bloc, error, stackTrace);
  }
}
