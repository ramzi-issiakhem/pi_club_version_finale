import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:project_initiative_club_app/features/Maps/data/datasources/maps_local_data_source.dart';
import 'package:project_initiative_club_app/features/Maps/data/datasources/maps_remote_data_source.dart';
import 'package:project_initiative_club_app/features/Maps/data/models/MapsDataModel.dart';
import 'package:project_initiative_club_app/features/Maps/domain/entities/maps_data.dart';
import 'package:project_initiative_club_app/features/Maps/domain/entities/polyline_entity.dart';
import 'package:project_initiative_club_app/features/Maps/domain/repositories/maps_repository.dart';
import 'package:project_initiative_club_app/ressources/errors/exceptions.dart';
import 'package:project_initiative_club_app/ressources/errors/failures.dart';
import 'package:project_initiative_club_app/ressources/globals.dart';

class MapsRepositoryImpl implements MapsRepository {
  final MapsRemoteDataSource remoteDataSource;
  final MapsLocalDataSource localDataSource;

  MapsRepositoryImpl(
      {required this.remoteDataSource, required this.localDataSource});

  @override
  Future<Either<Failure, List<MapsDataEntity>>> getMapsData() async {
    try {
      List<MapsDataEntity> list = [];

      await initializeBitMaps();

      Map<String, dynamic> json = await localDataSource.getJsonData();
      List<dynamic> listJson = json['infos'];

      listJson.forEach((element) {
        list.add(MapsDataModel.fromJson(element));
      });
      listMapData = list;
      return Right(list);
    } on ClientException catch (error) {
      return Left(ClientFailure(message: error.message));
    }
  }

  Future<Either<Failure, PolyLineEntity>> getRoutesFromPositions(
      Map<String, List<LatLng>> positions) async {
    try {
      dynamic boolOrPolyline = localDataSource.getPolyline(positions);

      if (boolOrPolyline.isLeft()) {
        return Right(await remoteDataSource.getRoutes(positions));
      } else if (boolOrPolyline.isRight()) {
        return Right(boolOrPolyline);
      }
      return Left(ClientFailure(message: "Erreur récuperation Polyline"));
    } on ClientException catch (error) {
      return Left(ClientFailure(message: error.message));
    }
  }

  Future<void> initializeBitMaps() async {
    iconFood = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5, size: Size(10, 10)),
        'images/icons/icon_food_marker.png');

    iconEntry = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5, size: Size(10, 10)),
        'images/icons/icon_entry_marker.png');
    iconAdminsitration = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5, size: Size(10, 10)),
        'images/icons/icon_administration_marker.png');

    iconOther = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5, size: Size(10, 10)),
        'images/icons/icon_other_marker.png');

    iconFaculty = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5, size: Size(10, 10)),
        'images/icons/icon_faculty_marker.png');

    /*iconEntry = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5),
        'icons/icon_entry_marker.png');

    iconAdminsitration = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5),
        'icons/icon_administration_marker.png');

    iconOther = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5),
        'icons/icon_other_marker.png');

    iconFaculty = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5),
        'icons/icon_faculty_marker.png');*/
  }
}
