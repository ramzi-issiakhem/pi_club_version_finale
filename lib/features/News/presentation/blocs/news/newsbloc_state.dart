part of 'newsbloc_bloc.dart';

abstract class NewsblocState extends Equatable {
  const NewsblocState();

  @override
  List<Object> get props => [];
}

class EmptyUsthb extends NewsblocState {}

class EmptyClub extends NewsblocState {}

class Loading extends NewsblocState {}

class LoadedLike extends NewsblocState {
  final bool state;
  LoadedLike({required this.state});
}

class LoadedClubNews extends NewsblocState {
  final List<NewsEntity> list;
  LoadedClubNews({required this.list});
}

class LoadedUsthbNews extends NewsblocState {
  final List<NewsEntity> list;
  LoadedUsthbNews({required this.list});
}

class Error extends NewsblocState {
  final String message;
  Error({required this.message});
}

class LoadedIsLiked extends NewsblocState {
  final bool isLiked;
  LoadedIsLiked({required this.isLiked});
}

class LoadedRemove extends NewsblocState {}

class LoadedForm extends NewsblocState {}

class LoadedEditForm extends NewsblocState {}
