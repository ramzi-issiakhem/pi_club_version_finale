import 'package:dartz/dartz.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:project_initiative_club_app/features/Maps/domain/entities/polyline_entity.dart';
import 'package:project_initiative_club_app/features/Maps/domain/repositories/maps_repository.dart';
import 'package:project_initiative_club_app/ressources/errors/failures.dart';
import 'package:project_initiative_club_app/ressources/usecases/usecase.dart';

class ItineraryCase implements UseCase<PolyLineEntity, ItineraryCaseParams> {
  final MapsRepository mapsRepository;

  ItineraryCase({required this.mapsRepository});

  @override
  Future<Either<Failure, PolyLineEntity>> call(
      ItineraryCaseParams params) async {
    return await mapsRepository.getRoutesFromPositions(params.positions);
  }
}

class ItineraryCaseParams {
  final Map<String, List<LatLng>> positions;

  ItineraryCaseParams({required this.positions});
}
