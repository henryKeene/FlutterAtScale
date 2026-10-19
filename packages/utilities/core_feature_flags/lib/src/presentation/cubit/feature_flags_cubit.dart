import 'dart:async';

import 'package:core_feature_flags/src/domain/interfaces/i_feature_flag_service.dart';
import 'package:core_feature_flags/src/domain/models/feature_flags.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class FeatureFlagsCubit extends Cubit<FeatureFlags> {
  new(IFeatureFlagService service) : super(service.current) {
    _subscription = service.changes.listen(emit);
  }

  late final StreamSubscription<FeatureFlags> _subscription;

  @override
  Future<void> close() async {
    await _subscription.cancel();
    await super.close();
  }
}
