import 'package:core_network/src/domain/failures/network_failure.dart';
import 'package:core_prelude/core_prelude.dart';

typedef Json = Map<String, dynamic>;

abstract interface class IApiClient {
  Future<Result<Json, NetworkFailure>> getJson(
    String path, {
    Map<String, String> query,
  });
}
