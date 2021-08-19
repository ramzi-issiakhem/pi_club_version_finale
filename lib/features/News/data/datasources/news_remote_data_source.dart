import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firestore_cache/firestore_cache.dart';
import 'package:path/path.dart';
import 'package:project_initiative_club_app/features/News/data/model/news_model.dart';
import 'package:project_initiative_club_app/features/News/domain/entities/newsEntity.dart';
import 'package:project_initiative_club_app/features/News/domain/usecases/add_news_usecase.dart';
import 'package:project_initiative_club_app/ressources/errors/exceptions.dart';

abstract class NewsRemoteDataSource {
  Future<List<NewsEntity>> getUsthbNews();

  Future<List<NewsEntity>> getClubNews();

  Future<bool> addLikes();

  Future<bool> addNews(AddNewsParam param);
}

class NewsRemoteDataSourceImpl implements NewsRemoteDataSource {
  final FirebaseFirestore firestore;
  final FirebaseStorage storage;

  NewsRemoteDataSourceImpl({required this.firestore, required this.storage});

  Future<bool> addNews(AddNewsParam param) async {
    List<String> imagesPath = [];

    try {
      String coverImagePath = await uploadFile(param.coverImage, param.type,
          basename(param.coverImage.path), param.title);

      for (var i = 0; i < param.images.length; i++) {
        String path = await uploadFile(param.coverImage, param.type,
            basename(param.coverImage.path), param.title);
        imagesPath.add(path);
      }

      NewsModel newsEnity =
          NewsModel.fromParams(param, coverImagePath, imagesPath);

      String collection = "";
      switch (param.type) {
        case 0:
          collection = "pi_news";
          break;
        default:
          collection = "usthb_news";
          break;
      }

      CollectionReference news =
          FirebaseFirestore.instance.collection(collection);

      await news.add((newsEnity.toJson()));
      return true;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<bool> addLikes() async {
    return true;
  }

  @override
  Future<List<NewsEntity>> getClubNews() async {
    try {
      final Query query = firestore.collection('pi_news');
      return getNews(query);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<List<NewsEntity>> getUsthbNews() {
    try {
      final Query query = firestore.collection('usthb_news');
      return getNews(query);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  Future<List<NewsEntity>> getNews(Query query) async {
    List<NewsEntity> news = [];

    final Query<Map<String, dynamic>> queryCasted =
        cast<Query<Map<String, dynamic>>>(query);
    final String cacheField = 'lastModification';

    final DocumentReference<Map<String, dynamic>> cacheDocRef =
        cast<DocumentReference<Map<String, dynamic>>>(
            firestore.doc('pi_news/news_standard'));

    QuerySnapshot<Map<String, dynamic>> snapshot =
        await FirestoreCache.getDocuments(
            query: queryCasted,
            cacheDocRef: cacheDocRef,
            firestoreCacheField: cacheField);

    snapshot.docs.forEach((element) {
      NewsEntity newEntity = NewsModel.fromFirestore(element);
      if (newEntity.title != "standard_test") {
        news.add(newEntity);
      }
    });

    return news;
  }

  Future<QuerySnapshot<Object?>> getDocs(Query query) {
    try {
      return query.get(GetOptions(source: Source.cache));
    } catch (e) {
      throw Exception();
    }
  }

  Future<String> uploadFile(
      File file, int type, String fileName, String title) async {
    String typeString = "";
    if (type == 0) {
      typeString = "pi";
    } else if (type == 1) {
      typeString = "club";
    }
    String name =
        title + '_' + DateTime.now().millisecondsSinceEpoch.toString();
    String fullPath = 'uploads/news/$typeString/images/$name/$fileName';

    try {
      TaskSnapshot task = await storage.ref().child(fullPath).putFile(file);
      return task.ref.getDownloadURL();
    } on FirebaseException catch (e) {
      return e.toString();
    }
  }
}
