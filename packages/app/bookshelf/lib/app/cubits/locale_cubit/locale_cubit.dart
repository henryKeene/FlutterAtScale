import 'dart:async';

import 'package:core_l10n/core_l10n.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_ui/material_ui.dart';

class LocaleCubit extends Cubit<Locale?> {
  new(this._service) : super(null);

  final ILocaleService _service;
  StreamSubscription<Locale?>? _subscription;

  Future<void> load() async {
    _subscription ??= _service.changes.listen(emit);
    emit(await _service.locale());
  }

  @override
  Future<void> close() async {
    await _subscription?.cancel();
    await super.close();
  }
}
