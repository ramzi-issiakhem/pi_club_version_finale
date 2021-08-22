import 'package:flutter/material.dart';

class NewsEntity {
  final String coverImage;
  final List<String> images;
  final String title;
  final String description;
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
