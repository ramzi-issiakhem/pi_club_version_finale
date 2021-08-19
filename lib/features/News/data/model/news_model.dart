import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:project_initiative_club_app/features/News/domain/entities/newsEntity.dart';
import 'package:project_initiative_club_app/features/News/domain/usecases/add_news_usecase.dart';

class NewsModel extends NewsEntity {
  final String coverImage;
  final List<String> images;
  final String title;
  final String description;
  final int likes;
  final DateTime lastModification;

  NewsModel(
      {required this.coverImage,
      required this.lastModification,
      required this.images,
      required this.title,
      required this.description,
      required this.likes})
      : super(
            title: title,
            coverImage: coverImage,
            lastModification: lastModification,
            images: images,
            description: description,
            likes: likes);

  factory NewsModel.fromFirestore(dynamic data) {
    Timestamp t = data["lastModification"];
    DateTime dateTime = t.toDate();
    List<String> list = [];

    list = []; //data["images"] == null ? [] : data['images'];
    return NewsModel(
        coverImage: data["coverImage"],
        lastModification: dateTime,
        images: list,
        title: data["title"],
        description: data["description"],
        likes: data["likes"]);
  }

  factory NewsModel.fromParams(
      AddNewsParam param, String coverImagePath, List<String> images) {
    return NewsModel(
        coverImage: coverImagePath,
        lastModification: param.lastModification,
        images: images,
        title: param.title,
        description: param.description,
        likes: param.likes);
  }

  Map<String, dynamic> toJson() {
    return {
      'coverImage': coverImage,
      'title': title,
      'likes': likes,
      'description': description,
      'lastModification': lastModification,
      'images': List<String>.of(images)
    };
  }
}
