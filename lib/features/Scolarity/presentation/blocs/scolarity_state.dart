part of 'scolarity_bloc.dart';

abstract class ScolarityState extends Equatable {
  const ScolarityState();

  @override
  List<Object> get props => [];
}

class Empty extends ScolarityState {}

class Loading extends ScolarityState {}

class Loaded extends ScolarityState {
  final Map<String, ScolarityEntity> scolarityEntities;

  Loaded({required this.scolarityEntities});
}

class Error extends ScolarityState {
  final String message;
  Error({required this.message});
}
