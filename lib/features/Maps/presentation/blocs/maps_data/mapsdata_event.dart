part of 'mapsdata_bloc.dart';

@immutable
abstract class MapsdataEvent {}

class GetMapsDataEvent implements MapsdataEvent {}

class ItineraryEvent implements MapsdataEvent {
  final Map<String, List<LatLng>> positionList;

  ItineraryEvent({required this.positionList});
}
