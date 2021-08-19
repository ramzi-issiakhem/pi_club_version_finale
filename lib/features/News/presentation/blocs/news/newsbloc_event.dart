part of 'newsbloc_bloc.dart';

abstract class NewsblocEvent extends Equatable {
  const NewsblocEvent();

  @override
  List<Object> get props => [];
}

class UsthbNewsEvent extends NewsblocEvent {}

class ClubNewsEvent extends NewsblocEvent {}

class FormEvent extends NewsblocEvent {
  final AddNewsParam param;
  FormEvent({required this.param});
}
