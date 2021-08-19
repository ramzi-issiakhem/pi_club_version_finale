import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:project_initiative_club_app/features/Maps/domain/entities/maps_data.dart';

class MapsDataModel extends MapsDataEntity {
  final String title;
  final String description;
  final List<String> images;
  final LatLng position;
  final int type;

  MapsDataModel(
      {required this.type,
      required this.position,
      required this.title,
      required this.description,
      required this.images})
      : super(
            type: type,
            title: title,
            description: description,
            images: images,
            position: position);

  ///
  ///  Return MapsDataModel from json or null !
  ///
  factory MapsDataModel.fromJson(dynamic json) {
    List<String> images = List<String>.from(json["images"]);
    int type = json["type"] != null ? json["type"] : 4;
    LatLng _position = new LatLng(json["position"][0], json["position"][1]);

    return MapsDataModel(
        type: type,
        position: _position,
        description: json["description"],
        images: images,
        title: json["title"]);
  }
}
