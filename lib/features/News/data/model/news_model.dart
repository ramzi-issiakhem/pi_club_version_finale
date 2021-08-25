import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project_initiative_club_app/features/News/domain/entities/newsEntity.dart';
import 'package:project_initiative_club_app/features/News/domain/usecases/add_news_usecase.dart';
import 'package:project_initiative_club_app/features/News/domain/usecases/edit_news_usecase.dart';

class NewsModel extends NewsEntity {
  final String coverImage;
  final List<String> images;
  final String title;
  final String description;
  final int likes;
  final DateTime lastModification;
  final String uid;
  NewsModel({
    required this.uid,
    required this.coverImage,
    required this.lastModification,
    required this.images,
    required this.title,
    required this.description,
    required this.likes,
  }) : super(
          uid: uid,
          title: title,
          coverImage: coverImage,
          lastModification: lastModification,
          images: images,
          description: description,
          likes: likes,
        );

  factory NewsModel.fromFirestore(dynamic data, String id) {
    Timestamp t = data["lastModification"];
    DateTime dateTime = t.toDate();
    List<String> list = [];

    list = data['images'] != null ? List.from(data['images']) : [];
    return NewsModel(
      uid: id,
      coverImage: data["coverImage"],
      lastModification: dateTime,
      images: list,
      title: data["title"],
      description: data["description"],
      likes: data["likes"],
    );
  }

  factory NewsModel.fromParams(AddNewsParam param, String coverImagePath,
      List<String> imagesPath, String id) {
    print("PATH " + imagesPath.toString());
    return NewsModel(
      uid: id,
      coverImage: coverImagePath,
      lastModification: param.lastModification,
      images: List.from(imagesPath),
      title: param.title,
      description: param.description,
      likes: param.likes,
    );
  }

  Map<String, dynamic> toJson() {
    List<String> imagesArray = List.from(images);
    
    return {
      'id': uid,
      'coverImage': coverImage,
      'title': title,
      'likes': likes,
      'description': description,
      'lastModification': lastModification,
      'images': imagesArray,
    };
  }
}
