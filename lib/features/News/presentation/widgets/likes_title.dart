import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:project_initiative_club_app/features/News/domain/entities/newsEntity.dart';

// ignore: non_constant_identifier_names
Widget LikesAndModificationWidget(NewsEntity news) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(onTap: () {}, child: Icon(Icons.favorite)),
          Text(news.likes.toString())
        ],
      ),
      Text(DateFormat('dd-MM-yyyy').format(news.lastModification))
    ],
  );
}
