import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:meta/meta.dart';
import 'package:project_initiative_club_app/features/Maps/domain/entities/maps_data.dart';
import 'package:project_initiative_club_app/features/Maps/domain/entities/polyline_entity.dart';
import 'package:project_initiative_club_app/features/Maps/domain/usecases/itinerary.dart';
import 'package:project_initiative_club_app/features/Maps/domain/usecases/maps_data.dart';

part 'mapsdata_event.dart';
part 'mapsdata_state.dart';

class MapsdataBloc extends Bloc<MapsdataEvent, MapsdataState> {
  final MapsDataCase mapsDataCase;
  final ItineraryCase itineraryCase;

  MapsdataBloc({required this.mapsDataCase, required this.itineraryCase})
      : super(EmptyData());

  @override
  Stream<MapsdataState> mapEventToState(MapsdataEvent event) async* {
    if (event is GetMapsDataEvent) {
      yield Loading();
      final failureOrList = await mapsDataCase.call(NoParams());

      yield failureOrList.fold(
        (error) => Error(message: error.message),
        (list) => MapsDataLoaded(mapsDataList: list),
      );
    } else if (event is ItineraryEvent) {
      event = cast<ItineraryEvent>(event);

      yield Loading();
      final failureOrMaps = await itineraryCase
          .call(ItineraryCaseParams(positions: event.positionList));

      yield failureOrMaps.fold(
        (error) => Error(message: error.message),
        (routes) => ItineraryLoaded(routes: routes),
      );
    }
  }
}
