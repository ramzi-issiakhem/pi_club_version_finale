import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firestore_cache/firestore_cache.dart';
import 'package:path/path.dart';
import 'package:project_initiative_club_app/features/News/data/model/news_model.dart';
import 'package:project_initiative_club_app/features/News/domain/entities/newsEntity.dart';
import 'package:project_initiative_club_app/features/News/domain/usecases/add_news_usecase.dart';
import 'package:project_initiative_club_app/features/News/domain/usecases/edit_news_usecase.dart';
import 'package:project_initiative_club_app/ressources/errors/exceptions.dart';
import 'package:uuid/uuid.dart';

abstract class NewsRemoteDataSource {
  Future<List<NewsEntity>> getUsthbNews();

  Future<List<NewsEntity>> getClubNews();

  Future<bool> manageLikes(NewsEntity news, int type, bool isAnAdd);

  Future<bool> addNews(AddNewsParam param);

  Future<bool> removeNews(int type, String uid);

  Future<bool> updateNews(EditNewsParam params);
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

      param.images.forEach((element) async {
        if (element != null) {
          String path = await uploadFile(
              element, param.type, basename(element.path), param.title);

          imagesPath.add(path);
        }
      });

      String id = Uuid().v4();
      NewsModel newsEnity =
          NewsModel.fromParams(param, coverImagePath, imagesPath, id);

      String collection = "";
      switch (param.type) {
        case 0:
          collection = "pi_news";
          break;
        default:
          collection = "usthb_news";
          break;
      }

      CollectionReference news = firestore.collection(collection);

      await news.doc(id).set((newsEnity.toJson()));
      return true;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  Future<bool> updateNews(EditNewsParam params) async {
    List<String> imagesPath = [];
    try {
      String coverImagePath = await uploadFile(params.coverImage, params.type,
          basename(params.coverImage.path), params.title);

      params.images.forEach((element) async {
        String path = await uploadFile(
            element, params.type, basename(element.path), params.title);

        imagesPath.add(path);
      });

      String collection;
      switch (params.type) {
        case 0:
          collection = "pi_news";
          break;
        default:
          collection = "usthb_news";
          break;
      }

      NewsModel news = NewsModel(
        lastModification: DateTime.now(),
        uid: params.uid,
        images: imagesPath,
        coverImage: coverImagePath,
        description: params.description,
        title: params.title,
        likes: params.likes,
      );

      await firestore
          .collection(collection)
          .doc(params.uid)
          .update(news.toJson());
      return true;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<bool> manageLikes(NewsEntity news, int type, bool isAnAdd) async {
    try {
      String collection;
      switch (type) {
        case 0:
          collection = "pi_news";
          break;
        default:
          collection = "usthb_news";
          break;
      }
      int number = 0;

      if (isAnAdd) {
        number = news.likes + 1;
        await firestore
            .collection(collection)
            .doc(news.uid)
            .update({'lastModification': DateTime.now(), 'likes': number});
      } else {
        number = news.likes > 0 ? news.likes - 1 : 0;
        await firestore
            .collection(collection)
            .doc(news.uid)
            .update({'lastModification': DateTime.now(), 'likes': number});
      }
      return true;
    } catch (e) {
      throw ServerException(e.toString());
    }
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
            firestore.collection('pi_news').doc('news_standard'));

    QuerySnapshot<Map<String, dynamic>> snapshot =
        await FirestoreCache.getDocuments(
            query: queryCasted,
            cacheDocRef: cacheDocRef,
            firestoreCacheField: cacheField);

    snapshot.docs.forEach((element) {
      NewsEntity newEntity =
          NewsModel.fromFirestore(element, element.reference.id);
      if (newEntity.title != "standard_test") {
        news.add(newEntity);
      }
    });

    return news;
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

  @override
  Future<bool> removeNews(int type, String uid) async {
    String collection = "";
    switch (type) {
      case 0:
        collection = "pi_news";
        break;
      default:
        collection = "usthb_news";
        break;
    }

    try {
      await firestore
          .collection(collection)
          .doc(uid)
          .update({"lastModification": DateTime.now()});

      await firestore.collection(collection).doc(uid).delete();
      return true;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
