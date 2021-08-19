import 'package:dartz/dartz.dart';
import 'package:project_initiative_club_app/features/Maps/domain/entities/maps_data.dart';
import 'package:project_initiative_club_app/features/Maps/domain/repositories/maps_repository.dart';
import 'package:project_initiative_club_app/ressources/errors/failures.dart';
import 'package:project_initiative_club_app/ressources/usecases/usecase.dart';

class MapsDataCase implements UseCase<List<MapsDataEntity>, NoParams> {
  final MapsRepository mapsRepository;

  MapsDataCase({required this.mapsRepository});

  @override
  Future<Either<Failure, List<MapsDataEntity>>> call(NoParams noParams) async {
    return await mapsRepository.getMapsData();
  }
}

class NoParams {}
