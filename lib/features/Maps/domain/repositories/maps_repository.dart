import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:project_initiative_club_app/features/Maps/domain/entities/polyline_entity.dart';

import '../../../../ressources/errors/failures.dart';
import '../entities/maps_data.dart';
import 'package:dartz/dartz.dart';

abstract class MapsRepository {
  /// Return The List of all the data maps
  ///
  /// Return a [Failure] in case of any error .
  Future<Either<Failure, List<MapsDataEntity>>> getMapsData();

  /// Return The List of all the data maps
  ///
  /// Return a [Failure] in case of any error .
  Future<Either<Failure, PolyLineEntity>> getRoutesFromPositions(
      Map<String, List<LatLng>> positions);
}
