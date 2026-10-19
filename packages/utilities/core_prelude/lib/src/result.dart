import 'package:flutter/foundation.dart';

sealed class Result<S, F> {
  const new _();

  B fold<B>(B Function(S value) ifSuccess, B Function(F error) ifFailure);

  Result<S2, F> map<S2>(S2 Function(S value) transform) =>
      fold((value) => success(transform(value)), failure);

  Result<S, F2> mapFailure<F2>(F2 Function(F error) transform) =>
      fold(success, (error) => failure(transform(error)));

  Result<S2, F> flatMap<S2>(Result<S2, F> Function(S value) transform) =>
      fold(transform, failure);

  Future<Result<S2, F>> asyncFlatMap<S2>(
    Future<Result<S2, F>> Function(S value) transform,
  ) => fold(transform, (error) => Future.value(failure(error)));

  S getOrElse(S Function() orElse) => fold((value) => value, (_) => orElse());

  S? getOrNull() => fold((value) => value, (_) => null);

  bool get isSuccess => this is Success<S, F>;

  bool get isFailure => this is Failure<S, F>;
}

@immutable
final class Success<S, F> extends Result<S, F> {
  const new _(this.value) : super._();

  final S value;

  @override
  B fold<B>(B Function(S value) ifSuccess, B Function(F error) ifFailure) =>
      ifSuccess(value);

  @override
  bool operator ==(Object other) => other is Success && other.value == value;

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() => 'Success($value)';
}

@immutable
final class Failure<S, F> extends Result<S, F> {
  const new _(this.error) : super._();

  final F error;

  @override
  B fold<B>(B Function(S value) ifSuccess, B Function(F error) ifFailure) =>
      ifFailure(error);

  @override
  bool operator ==(Object other) => other is Failure && other.error == error;

  @override
  int get hashCode => error.hashCode;

  @override
  String toString() => 'Failure($error)';
}

Result<S, F> success<S, F>(S value) => Success._(value);

Result<S, F> failure<S, F>(F error) => Failure._(error);
