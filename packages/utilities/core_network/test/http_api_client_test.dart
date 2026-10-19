import 'package:core_config/core_config.dart';
import 'package:core_network/core_network.dart';
import 'package:core_network/src/data/services/http_api_client.dart';
import 'package:core_prelude/core_prelude.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';

void main() {
  final config = AppConfig.forEnvironment(AppEnvironment.development);

  HttpApiClient clientReturning(
    Future<http.Response> Function(http.Request request) handler,
  ) => HttpApiClient(MockClient(handler), config);

  group('HttpApiClient', () {
    test('builds the url from the configured host, path and query', () async {
      late Uri requested;
      final client = clientReturning((request) async {
        requested = request.url;
        return http.Response('{}', 200);
      });

      await client.getJson('/search.json', query: {'q': 'dune'});

      expect(
        requested.toString(),
        'https://openlibrary.org/search.json?q=dune',
      );
    });

    test('returns the decoded body on success', () async {
      final client = clientReturning(
        (_) async => http.Response('{"title":"Dune"}', 200),
      );

      final result = await client.getJson('/works/OL1W.json');

      expect(result.getOrNull(), {'title': 'Dune'});
    });

    test('maps a non 200 response to a ServerFailure', () async {
      final client = clientReturning((_) async => http.Response('', 404));

      final result = await client.getJson('/works/missing.json');

      expect(result, failure<Json, NetworkFailure>(const ServerFailure(404)));
    });

    test('maps invalid json to a MalformedResponseFailure', () async {
      final client = clientReturning((_) async => http.Response('<html>', 200));

      final result = await client.getJson('/search.json');

      expect(
        result,
        failure<Json, NetworkFailure>(const MalformedResponseFailure()),
      );
    });

    test('maps a client exception to a ConnectionFailure', () async {
      final client = clientReturning(
        (_) async => throw http.ClientException('offline'),
      );

      final result = await client.getJson('/search.json');

      expect(result, failure<Json, NetworkFailure>(const ConnectionFailure()));
    });
  });
}
