import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:project_initiative_club_app/features/Scolarity/domain/entities/scolarity_entity.dart';

part 'scolarity_event.dart';
part 'scolarity_state.dart';

class ScolarityBloc extends Bloc<ScolarityEvent, ScolarityState> {
  ScolarityBloc() : super(Empty());

  @override
  Stream<ScolarityState> mapEventToState(
    ScolarityEvent event,
  ) async* {
    if (event is InitEvent) {}
  }
}
