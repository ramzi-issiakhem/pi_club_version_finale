import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
abstract class Failure extends Equatable {
  final String message;
  String email = "";
  String displayName = "";

  Failure({required this.message});
}

// ignore: must_be_immutable
class ServerFailure extends Failure {
  final String message;
  ServerFailure({required this.message}) : super(message: message);

  @override
  List<Object?> get props => throw UnimplementedError();
}

// ignore: must_be_immutable
class ClientFailure extends Failure {
  final String message;
  ClientFailure({required this.message}) : super(message: message);

  @override
  List<Object?> get props => throw UnimplementedError();
}

// ignore: must_be_immutable
class UnknownFailure extends Failure {
  final String message;
  UnknownFailure({required this.message}) : super(message: message);

  @override
  List<Object?> get props => throw UnimplementedError();
}
