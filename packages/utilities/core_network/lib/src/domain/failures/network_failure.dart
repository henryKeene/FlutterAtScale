import 'package:core_prelude/core_prelude.dart';

sealed class NetworkFailure extends AppFailure {
  const new(super.message);
}

final class ConnectionFailure extends NetworkFailure {
  const new() : super('No connection');
}

final class TimeoutFailure extends NetworkFailure {
  const new() : super('The request timed out');
}

final class ServerFailure extends NetworkFailure {
  const new(this.statusCode) : super('Server responded with $statusCode');

  final int statusCode;

  @override
  List<Object?> get props => [...super.props, statusCode];
}

final class MalformedResponseFailure extends NetworkFailure {
  const new() : super('The response was not valid JSON');
}
