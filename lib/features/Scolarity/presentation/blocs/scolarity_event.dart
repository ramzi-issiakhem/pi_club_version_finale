part of 'scolarity_bloc.dart';

abstract class ScolarityEvent extends Equatable {
  const ScolarityEvent();

  @override
  List<Object> get props => [];
}

class InitEvent extends ScolarityEvent {}
