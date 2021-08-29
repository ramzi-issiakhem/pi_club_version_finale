import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:project_initiative_club_app/features/News/domain/entities/newsEntity.dart';
import 'package:project_initiative_club_app/features/News/domain/usecases/likes_usecase.dart';
import 'package:project_initiative_club_app/features/News/presentation/blocs/news/newsbloc_bloc.dart';
import 'package:project_initiative_club_app/ressources/globals.dart';

// ignore: non_constant_identifier_names
Widget LikesAndModificationWidget(
    NewsEntity news, bool isLiked, int type, BuildContext context) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
              onTap: () {
                BlocProvider.of<NewsblocBloc>(context).add(LikeClick(
                    param:
                        LikesParams(isAnAdd: false, type: type, news: news)));
              },
              child: Icon(
                isLiked ? Icons.favorite : Icons.favorite_outline,
                color: Colors.white,
              )),
          SizedBox(
            width: 5,
          ),
          Text(
            news.likes.toString(),
            style: TextStyle(
              fontSize: 15,
              color: Colors.white,
            ),
          )
        ],
      ),
      SizedBox(
        width: 10,
      ),
      Text(
        news.title,
        textAlign: TextAlign.left,
        overflow: TextOverflow.fade,
        style: TextStyle(
            fontWeight: FontWeight.bold,
            decoration: TextDecoration.none,
            color: Colors.white,
            fontSize: 15),
      ),
      //Text(DateFormat('dd-MM-yyyy').format(news.lastModification),style: TextStyle(fontSize: 15,color: Colors.white),)
    ],
  );
}
