import 'package:core_di/core_di.dart';

extension RegisterFake on GetIt {
  /// Registers [fake] as the [T] that flows resolve, unless it is already
  /// registered.
  ///
  /// Several Widgetbooks can run in one app, and each registers the fakes
  /// its own flows need. Fakes of a core service are shared instances, such
  /// as `FakeLibraryService.shared`, so whichever registers first, they all
  /// get the same one.
  void registerFake<T extends Object>(T fake) {
    if (!isRegistered<T>()) {
      registerSingleton<T>(fake);
      return;
    }
    assert(
      identical(get<T>(), fake),
      'Two Widgetbooks registered different fakes of $T. Use its shared '
      'instance in both.',
    );
  }
}
