import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:project_initiative_club_app/features/Maps/data/models/PolyLineModel.dart';
import 'package:project_initiative_club_app/features/Maps/domain/entities/polyline_entity.dart';
import 'package:project_initiative_club_app/features/News/domain/entities/newsEntity.dart';
import 'package:project_initiative_club_app/ressources/errors/exceptions.dart';
import 'package:project_initiative_club_app/ressources/globals.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class NewsLocalDataSource {
  Future<bool> isLiked({required NewsEntity news});

  /// VReturn the JSON Format .
  ///
  /// Throws a [ClientException] in any error case .
  Future<Map<String, dynamic>> getJsonData();

  Future<bool> like(bool isAnAdd, NewsEntity newsEntity);

  Either<bool, PolyLineEntity> getPolyline(Map<String, List<LatLng>> positions);
}

class NewsLocalDataSourceImpl implements NewsLocalDataSource {
  NewsLocalDataSourceImpl();

  @override
  Future<Map<String, dynamic>> getJsonData() async {
    try {
      mapsStyle = await rootBundle.loadString('json/styles.json');
      dynamic result =
          await jsonDecode(await rootBundle.loadString('json/info_map.json'));

      //polylinesJson = await rootBundle.loadString('json/routing.json');

      return result;
    } catch (e) {
      throw ClientException(e.toString());
    }
  }

  Either<bool, PolyLineEntity> getPolyline(
      Map<String, List<LatLng>> positions) {
    if (polylinesJson[positions.keys.first] != null) {
      dynamic json = polylinesJson[positions.keys.first];
      return Right(PolylineModel.fromJson(json));
    } else {
      return Left(true);
    }
  }

  @override
  Future<bool> isLiked({required NewsEntity news}) async {
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      bool state = sharedPreferences.getBool('news' + news.uid) ?? false;
      return state;
    } catch (e) {
      throw (ClientException(e.toString()));
    }
  }

  @override
  Future<bool> like(bool isAnAdd, NewsEntity newsEntity) async {
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      sharedPreferences.setBool('news' + newsEntity.uid, isAnAdd);
      return true;
    } catch (e) {
      throw (ClientException(e.toString()));
    }
  }
}
