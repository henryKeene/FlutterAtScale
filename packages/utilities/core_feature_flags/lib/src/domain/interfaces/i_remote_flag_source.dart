import 'package:core_prelude/core_prelude.dart';

final class RemoteFlagFailure extends AppFailure {
  const new() : super('Remote flags could not be fetched');
}

abstract interface class IRemoteFlagSource {
  Future<Result<Map<String, bool>, RemoteFlagFailure>> fetch();
}
