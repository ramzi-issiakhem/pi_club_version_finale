part of 'mapsdata_bloc.dart';

@immutable
abstract class MapsdataState {}

class EmptyData extends MapsdataState {}

class Loading extends MapsdataState {}

class MapsDataLoaded extends MapsdataState {
  final List<MapsDataEntity> mapsDataList;
  MapsDataLoaded({required this.mapsDataList});
}

class ItineraryLoaded extends MapsdataState {
  final PolyLineEntity routes;

  ItineraryLoaded({required this.routes});
}

class Error extends MapsdataState {
  final String message;

  Error({required this.message});
}
