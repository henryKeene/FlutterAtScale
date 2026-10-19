import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';

@module
abstract class FeatureFlagsModule {
  @lazySingleton
  AssetBundle get bundle => rootBundle;
}
