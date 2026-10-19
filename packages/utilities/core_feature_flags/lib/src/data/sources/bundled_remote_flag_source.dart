import 'dart:convert';

import 'package:core_feature_flags/src/domain/interfaces/i_remote_flag_source.dart';
import 'package:core_prelude/core_prelude.dart';
import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: IRemoteFlagSource)
class BundledRemoteFlagSource implements IRemoteFlagSource {
  new(this._bundle);

  static const _path = 'packages/core_feature_flags/assets/remote_flags.json';

  final AssetBundle _bundle;

  @override
  Future<Result<Map<String, bool>, RemoteFlagFailure>> fetch() async {
    try {
      final json = jsonDecode(await _bundle.loadString(_path, cache: false));
      if (json is! Map<String, dynamic>) {
        return failure(const RemoteFlagFailure());
      }
      return success({
        for (final MapEntry(:key, :value) in json.entries)
          if (value is bool) key: value,
      });
    } on Exception {
      return failure(const RemoteFlagFailure());
    }
  }
}
