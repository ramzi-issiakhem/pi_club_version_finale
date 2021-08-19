import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:project_initiative_club_app/features/Maps/domain/entities/polyline_entity.dart';

class PolylineModel extends PolyLineEntity {
  final PolylineId id;
  final Color color;
  final List<LatLng> points;

  PolylineModel({required this.id, required this.color, required this.points})
      : super(id: id, points: points, color: color);

  ///
  ///  Return MapsDataModel from json or null !
  ///
  factory PolylineModel.fromJson(Map<String, dynamic> json) {
    List<LatLng> points = List<LatLng>.from(json["position"]);
    String id = json["id"] != null ? json["id"] : "error";
    Color color = json["color"];

    return PolylineModel(id: PolylineId(id), color: color, points: points);
  }
}
