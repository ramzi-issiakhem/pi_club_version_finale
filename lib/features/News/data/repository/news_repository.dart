import 'package:dartz/dartz.dart';
import 'package:project_initiative_club_app/features/News/data/datasources/news_local_data_source.dart';
import 'package:project_initiative_club_app/features/News/data/datasources/news_remote_data_source.dart';
import 'package:project_initiative_club_app/features/News/data/model/news_model.dart';
import 'package:project_initiative_club_app/features/News/domain/entities/newsEntity.dart';
import 'package:project_initiative_club_app/features/News/domain/repository/news_repository.dart';
import 'package:project_initiative_club_app/features/News/domain/usecases/add_news_usecase.dart';
import 'package:project_initiative_club_app/features/News/domain/usecases/edit_news_usecase.dart';
import 'package:project_initiative_club_app/features/News/domain/usecases/remove_news_usecase.dart';
import 'package:project_initiative_club_app/ressources/errors/exceptions.dart';
import 'package:project_initiative_club_app/ressources/errors/failures.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NewsRepositoryImpl implements NewsRepository {
  final NewsRemoteDataSource remoteDataSource;
  final NewsLocalDataSource localDataSource;

  NewsRepositoryImpl(
      {required this.remoteDataSource, required this.localDataSource});
  // TODO Remove picture from storage
  @override
  Future<Either<Failure, NewsEntity>> manageLikes(
      {required NewsEntity news,
      required int type,
      required bool isAnAdd}) async {
    try {
      bool isLiked = await localDataSource.isLiked(news: news);
      late NewsEntity newsEntity;
      if (isLiked && !isAnAdd) {
        newsEntity = await remoteDataSource.manageLikes(news, type, isAnAdd);
        await localDataSource.like(isAnAdd, news);
        return Right(newsEntity);
      } else {
        newsEntity = await remoteDataSource.manageLikes(news, type, isAnAdd);
        await localDataSource.like(isAnAdd, news);
        return Right(newsEntity);
      }
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, List<dynamic>>> getClubNews() async {
    List<bool> likedTab = [];
    try {
      List<NewsEntity> news = await remoteDataSource.getClubNews();
      for (int i = 0; i < news.length; i++) {
        bool isLiked = await localDataSource.isLiked(news: news[i]);
        likedTab.add(isLiked);
      }

      return Right([news, likedTab]);
    } on ServerException catch (exception) {
      return Left(ServerFailure(message: exception.message));
    }
  }

  @override
  Future<Either<Failure, List<dynamic>>> getUsthbNews() async {
    List<bool> likedTab = [];
    try {
      List<NewsEntity> news = await remoteDataSource.getUsthbNews();
      for (int i = 0; i < news.length; i++) {
        bool isLiked = await localDataSource.isLiked(news: news[i]);
        likedTab.add(isLiked);
      }

      return Right([news, likedTab]);
    } on ServerException catch (exception) {
      return Left(ServerFailure(message: exception.message));
    }
  }

  @override
  Future<Either<Failure, int>> addNews(AddNewsParam param) async {
    try {
      bool state = await remoteDataSource.addNews(param);
      return Right(param.type);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, bool>> isLiked({required NewsEntity news}) async {
    try {
      bool state = await localDataSource.isLiked(news: news);
      return Right(state);
    } on ClientException catch (e) {
      return Left(ClientFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, int>> removeNews(RemoveNewsParam param) async {
    int type = param.type;

    NewsEntity news = param.newsEntity;

    try {
      bool state = await remoteDataSource.removeNews(news, type);
      return Right(type);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, int>> updateNews(EditNewsParam params) async {
    try {
      await remoteDataSource.updateNews(params);
      return Right(params.type);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }
}
