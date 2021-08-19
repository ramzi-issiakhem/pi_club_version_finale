import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PolyLineEntity extends Polyline {
  final PolylineId id;
  final Color color;
  final List<LatLng> points;
  PolyLineEntity({required this.id, required this.color, required this.points})
      : super(polylineId: id, points: points, color: color);
}
