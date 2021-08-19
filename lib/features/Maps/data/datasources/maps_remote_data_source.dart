import 'dart:convert';

import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:project_initiative_club_app/features/Maps/domain/entities/polyline_entity.dart';
import 'package:project_initiative_club_app/ressources/errors/exceptions.dart';
import 'package:project_initiative_club_app/ressources/globals.dart';

abstract class MapsRemoteDataSource {
  Future<PolyLineEntity> getRoutes(Map<String, List<LatLng>> positions);
}

class MapsRemoteDataSourceImpl implements MapsRemoteDataSource {
  MapsRemoteDataSourceImpl();

  Future<PolyLineEntity> getRoutes(Map<String, List<LatLng>> positions) async {
    PolylinePoints polylinePoints = PolylinePoints();
    List<LatLng> polylineCoordinates = [];

    try {
      String key = positions.keys.first;
      List<LatLng> listPositions = positions.values.first;
      PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
          googleApiKey,
          PointLatLng(listPositions[0].latitude, listPositions[0].longitude),
          PointLatLng(listPositions[1].latitude, listPositions[1].longitude),
          travelMode: TravelMode.walking);

      if (result.points.isNotEmpty) {
        result.points.forEach((PointLatLng point) {
          polylineCoordinates.add(LatLng(point.latitude, point.longitude));
        });
      }

      PolyLineEntity polyline = PolyLineEntity(
          id: PolylineId("poly"),
          points: polylineCoordinates,
          color: mainColor);

      routingDataBase[key] = polyline;
      String json = jsonEncode(routingDataBase);
      print("json: " + json);

      /*Directory? appDocDir = await getDownloadsDirectory();
      String appDocPath = appDocDir!.path;

      File file = File('$appDocPath/routing.json');
      file.writeAsString(json);*/

      return polyline;
    } catch (e) {
      throw ClientException(e.toString());
    }
  }

  /*@override
  UserObjectModel getUser() {
    try {
      final fireBaseUser = fireBaseAuth.currentUser;
      return UserObjectModel.fromFireBaseUser(fireBaseUser);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  bool isConnected() {
    try {
      final fireBaseUser = fireBaseAuth.currentUser;

      if (fireBaseUser == null) {
        return false;
      } else {
        return true;
      }
    } catch (e) {
      throw ServerException("Servor Error");
    }
  }

  @override
  Future<UserObject> logginIn({String email, String password}) async {
    try {
      var result = await fireBaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return UserObjectModel.fromFireBaseUser(result.user);
    } on FirebaseAuthException catch (error) {
      throw LoginException(error.code);
    } catch (error) {
      throw ServerException(error.toString());
    }
  }

  Future<UserObject> createUser(
      {String email, String password, String displayName}) async {
    try {
      var result = await fireBaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      var user = result.user;
      await user.updateProfile(displayName: displayName, photoURL: "default");
      return UserObjectModel.fromFireBaseUser(user);
    } on FirebaseAuthException catch (error) {
      throw RegisterException(error.code);
    } catch (error) {
      throw ServerException(error.toString());
    }
  }*/
}
