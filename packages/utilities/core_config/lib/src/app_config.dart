import 'package:core_config/src/app_environment.dart';
import 'package:equatable/equatable.dart';

class AppConfig extends Equatable {
  const new({
    required this.environment,
    required this.appName,
    required this.openLibraryUrl,
  });

  factory forEnvironment(AppEnvironment environment) => switch (environment) {
    AppEnvironment.development => AppConfig(
      environment: environment,
      appName: 'Bookshelf Dev',
      openLibraryUrl: Uri.https('openlibrary.org'),
    ),
    AppEnvironment.staging => AppConfig(
      environment: environment,
      appName: 'Bookshelf Staging',
      openLibraryUrl: Uri.https('openlibrary.org'),
    ),
    AppEnvironment.production => AppConfig(
      environment: environment,
      appName: 'Bookshelf',
      openLibraryUrl: Uri.https('openlibrary.org'),
    ),
  };

  final AppEnvironment environment;
  final String appName;
  final Uri openLibraryUrl;

  bool get isProduction => environment == AppEnvironment.production;

  @override
  List<Object?> get props => [environment, appName, openLibraryUrl];
}
