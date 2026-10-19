import 'package:core_config/core_config.dart';
import 'package:material_ui/material_ui.dart';

class EnvironmentBanner extends StatelessWidget {
  const new({required this.environment, required this.child, super.key});

  final AppEnvironment environment;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final message = switch (environment) {
      AppEnvironment.development => 'DEV',
      AppEnvironment.staging => 'STAGING',
      AppEnvironment.production => null,
    };

    if (message == null) return child;
    return Banner(
      message: message,
      location: BannerLocation.topEnd,
      color: Theme.of(context).colorScheme.tertiary,
      child: child,
    );
  }
}
