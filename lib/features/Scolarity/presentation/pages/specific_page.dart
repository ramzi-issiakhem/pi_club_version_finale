import 'package:flutter/material.dart';
import 'package:project_initiative_club_app/ressources/globals.dart';

@override
// ignore: non_constant_identifier_names
Widget SpecificScolarityPage(
    {required String value, required double screenH, required double screenW}) {
  List<String> listData = [];

  void getListData() {
    List<String> list = [];
    scolarityData.forEach((element) {
      if (element[0] == value) {
        list = element;
      }
    });
    listData = list;
  }

  getListData();

  return Column(
    children: [
      Text(listData[1]),
      SizedBox(
        height: 50,
      ),
      Row(
        children: [Text("Specialités de la branche : "), Text(listData[2])],
      ),
      SizedBox(
        height: 50,
      ),
      Row(
        children: [Text("Facultés : "), Text(listData[3])],
      )
    ],
  );
}
