import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';

@module
abstract class NetworkModule {
  @LazySingleton(dispose: disposeClient)
  http.Client get client => http.Client();
}

void disposeClient(http.Client client) => client.close();
