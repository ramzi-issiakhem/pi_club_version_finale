import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:project_initiative_club_app/features/News/domain/entities/newsEntity.dart';
import 'package:project_initiative_club_app/ressources/globals.dart';
// ignore: non_constant_identifier_names
Widget LikesAndModificationWidget(NewsEntity news) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(onTap: () {
            if()
            news.isClicked=!news.isClicked;
          }, child: Icon(Icons.favorite,color: Colors.white,)),
          SizedBox(width: 5,),
          Text(news.likes.toString(),style: TextStyle(fontSize: 15,color: Colors.white),)
        ],
      ),
      Text(DateFormat('dd-MM-yyyy').format(news.lastModification),style: TextStyle(fontSize: 15,color: Colors.white),)
    ],
  );
}
