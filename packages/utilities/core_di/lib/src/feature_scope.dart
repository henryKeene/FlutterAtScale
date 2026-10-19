import 'package:get_it/get_it.dart';

extension FeatureScope on GetIt {
  void pushFeatureScope(String name, void Function(GetIt getIt) init) {
    if (hasScope(name)) return;
    pushNewScope(scopeName: name, init: init);
  }

  Future<void> dropFeatureScope(String name) async {
    if (!hasScope(name)) return;
    await dropScope(name);
  }
}
