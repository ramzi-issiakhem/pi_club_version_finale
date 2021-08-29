import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:project_initiative_club_app/features/News/domain/entities/newsEntity.dart';
import 'package:project_initiative_club_app/features/News/domain/usecases/add_news_usecase.dart';
import 'package:project_initiative_club_app/features/News/domain/usecases/edit_news_usecase.dart';
import 'package:project_initiative_club_app/features/News/domain/usecases/is_liked_usecase.dart';
import 'package:project_initiative_club_app/features/News/domain/usecases/likes_usecase.dart';
import 'package:project_initiative_club_app/features/News/domain/usecases/pi_news_usecase.dart'
    as Club;
import 'package:project_initiative_club_app/features/News/domain/usecases/remove_news_usecase.dart';
import 'package:project_initiative_club_app/features/News/domain/usecases/usthb_news_usecase.dart'
    as Usthb;

part 'newsbloc_event.dart';
part 'newsbloc_state.dart';

class NewsblocBloc extends Bloc<NewsblocEvent, NewsblocState> {
  final Club.PiNewsUseCase clubNewsUsecase;
  final Usthb.UsthbNewsCase usthbNewsUsecase;
  final AddNewsUseCase addNewsUseCase;
  final LikesUseCase likesUseCase;
  final IsLikedUseCase isLikedUseCase;
  final RemoveNewsUseCase removeNewsUseCase;
  final EditNewsUseCase editNewsUseCase;
  NewsblocBloc(
      {required this.editNewsUseCase,
      required this.isLikedUseCase,
      required this.removeNewsUseCase,
      required this.likesUseCase,
      required this.addNewsUseCase,
      required this.clubNewsUsecase,
      required this.usthbNewsUsecase})
      : super(EmptyUsthb());

  @override
  Stream<NewsblocState> mapEventToState(
    NewsblocEvent event,
  ) async* {
    if (event is ClubNewsEvent) {
      yield Loading();
      final failureOrList = await clubNewsUsecase.call(Club.NoParams());

      yield failureOrList.fold((failure) => Error(message: failure.message),
          (list) => LoadedClubNews(lists: list));
    } else if (event is UsthbNewsEvent) {
      yield Loading();
      final failureOrList = await usthbNewsUsecase.call(Usthb.NoParams());

      yield failureOrList.fold((failure) => Error(message: failure.message),
          (list) => LoadedUsthbNews(lists: list));
    } else if (event is FormEvent) {
      yield Loading();

      final failureOrBool = await addNewsUseCase.call(event.param);
      yield failureOrBool.fold((error) => Error(message: error.message),
          (state) => LoadedForm(type: state));
    } else if (event is LikeClick) {
      yield Loading();

      final failureOrInt = await likesUseCase.call(event.param);
      yield failureOrInt.fold((error) => Error(message: error.message),
          (state) => LoadedLike(news: state));
    } else if (event is IsLiked) {
      yield Loading();
      final failureOrBool = await isLikedUseCase.call(event.news);
      yield failureOrBool.fold((error) => Error(message: error.message),
          (state) => LoadedIsLiked(isLiked: state));
    } else if (event is RemoveNews) {
      yield Loading();
      final failureOrBool = await removeNewsUseCase.call(event.param);
      yield failureOrBool.fold((error) => Error(message: error.message),
          (state) => LoadedRemove(type: state));
    } else if (event is EditForm) {
      yield Loading();

      final failureOrBool = await editNewsUseCase.call(event.params);
      yield failureOrBool.fold((error) => Error(message: error.message),
          (state) => LoadedEditForm(newType: state));
    }
  }
}
