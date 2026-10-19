import 'dart:async';

import 'package:discover/discover.dart';
import 'package:navigation/src/router.dart';
import 'package:navigation/src/routes.dart';

class DiscoverNavigation implements IDiscoverNavigation {
  @override
  void openBook(String workId) =>
      unawaited(router.push(Routes.bookFor(workId)));
}
