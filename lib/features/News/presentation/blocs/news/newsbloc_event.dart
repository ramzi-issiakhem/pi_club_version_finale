part of 'newsbloc_bloc.dart';

abstract class NewsblocEvent extends Equatable {
  const NewsblocEvent();

  @override
  List<Object> get props => [];
}

class UsthbNewsEvent extends NewsblocEvent {}

class ClubNewsEvent extends NewsblocEvent {}

class LikeClick extends NewsblocEvent {
  final LikesParams param;
  LikeClick({required this.param});
}

class IsLiked extends NewsblocEvent {
  final NewsEntity news;
  IsLiked({required this.news});
}

class FormEvent extends NewsblocEvent {
  final AddNewsParam param;
  FormEvent({required this.param});
}

class RemoveNews extends NewsblocEvent {
  final RemoveNewsParam param;
  RemoveNews({required this.param});
}

class EditForm extends NewsblocEvent {
  final EditNewsParam params;

  EditForm({required this.params});
}
