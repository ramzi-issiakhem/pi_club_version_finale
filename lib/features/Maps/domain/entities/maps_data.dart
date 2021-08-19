import "package:google_maps_flutter/google_maps_flutter.dart";

class MapsDataEntity {
  final List<String> images;
  final String title;
  final String description;
  final LatLng position;
  final int type;

  MapsDataEntity(
      {required this.type,
      required this.position,
      required this.images,
      required this.title,
      required this.description});
}
