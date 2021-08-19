import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:project_initiative_club_app/features/News/domain/entities/newsEntity.dart';
import 'package:project_initiative_club_app/features/News/domain/usecases/add_news_usecase.dart';
import 'package:project_initiative_club_app/features/News/domain/usecases/pi_news_usecase.dart'
    as Club;
import 'package:project_initiative_club_app/features/News/domain/usecases/usthb_news_usecase.dart'
    as Usthb;

part 'newsbloc_event.dart';
part 'newsbloc_state.dart';

class NewsblocBloc extends Bloc<NewsblocEvent, NewsblocState> {
  final Club.PiNewsUseCase clubNewsUsecase;
  final Usthb.UsthbNewsCase usthbNewsUsecase;
  final AddNewsUseCase addNewsUseCase;
  NewsblocBloc(
      {required this.addNewsUseCase,
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
          (list) => LoadedClubNews(list: list));
    } else if (event is UsthbNewsEvent) {
      yield Loading();
      final failureOrList = await usthbNewsUsecase.call(Usthb.NoParams());

      yield failureOrList.fold((failure) => Error(message: failure.message),
          (list) => LoadedUsthbNews(list: list));
    } else if (event is FormEvent) {
      yield Loading();
      FormEvent formEvent = cast<FormEvent>(event);
      final failureOrBool = await addNewsUseCase.call(formEvent.param);
      yield failureOrBool.fold(
          (error) => Error(message: error.message), (state) => LoadedForm());
    }
  }
}
