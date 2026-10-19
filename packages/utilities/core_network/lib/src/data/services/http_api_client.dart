import 'dart:async';
import 'dart:convert';

import 'package:core_config/core_config.dart';
import 'package:core_network/src/domain/failures/network_failure.dart';
import 'package:core_network/src/domain/interfaces/i_api_client.dart';
import 'package:core_prelude/core_prelude.dart';
import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';

@LazySingleton(as: IApiClient)
class HttpApiClient implements IApiClient {
  new(this._client, this._config);

  static const _timeout = Duration(seconds: 15);

  final http.Client _client;
  final AppConfig _config;

  @override
  Future<Result<Json, NetworkFailure>> getJson(
    String path, {
    Map<String, String> query = const {},
  }) async {
    final uri = _config.openLibraryUrl.replace(
      path: path,
      queryParameters: query.isEmpty ? null : query,
    );

    try {
      final response = await _client.get(uri).timeout(_timeout);
      if (response.statusCode != 200) {
        return failure(ServerFailure(response.statusCode));
      }
      final body = jsonDecode(response.body);
      if (body is! Json) return failure(const MalformedResponseFailure());
      return success(body);
    } on TimeoutException {
      return failure(const TimeoutFailure());
    } on http.ClientException {
      return failure(const ConnectionFailure());
    } on FormatException {
      return failure(const MalformedResponseFailure());
    }
  }
}
