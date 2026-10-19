import 'package:equatable/equatable.dart';

abstract class AppFailure extends Equatable {
  const new(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}
