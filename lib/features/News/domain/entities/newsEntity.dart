import 'package:flutter/material.dart';

class NewsEntity {
  String coverImage;
  List<String> images;
  String title;
  String description;
  int likes;
  final DateTime lastModification;
  final String uid;
  NewsEntity({
    required this.uid,
    required this.coverImage,
    required this.lastModification,
    required this.images,
    required this.title,
    required this.description,
    required this.likes,
  });
}
