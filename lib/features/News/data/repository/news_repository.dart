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
  Future<Either<Failure, bool>> manageLikes(
      {required NewsEntity news,
      required int type,
      required bool isAnAdd}) async {
    try {
      bool isLiked = await localDataSource.isLiked(news: news);

      if (isLiked && !isAnAdd) {
        bool state = await remoteDataSource.manageLikes(news, type, isAnAdd);
        await localDataSource.like(isAnAdd, news);
      } else if (isAnAdd && !isLiked) {
        bool state = await remoteDataSource.manageLikes(news, type, isAnAdd);
        await localDataSource.like(isAnAdd, news);
      }

      return Right(true);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, List<NewsEntity>>> getClubNews() async {
    List<NewsEntity> list;
    try {
      list = await remoteDataSource.getClubNews();
      return Right(list);
    } on ServerException catch (exception) {
      return Left(ServerFailure(message: exception.message));
    }
  }

  @override
  Future<Either<Failure, List<NewsEntity>>> getUsthbNews() async {
    List<NewsEntity> list;
    try {
      list = await remoteDataSource.getUsthbNews();
      return Right(list);
    } on ServerException catch (exception) {
      return Left(ServerFailure(message: exception.message));
    }
  }

  @override
  Future<Either<Failure, bool>> addNews(AddNewsParam param) async {
    try {
      bool state = await remoteDataSource.addNews(param);
      return Right(state);
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
  Future<Either<Failure, bool>> removeNews(RemoveNewsParam param) async {
    int type = param.type;

    NewsEntity news = param.newsEntity;

    try {
      bool state = await remoteDataSource.removeNews(news, type);
      return Right(state);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, bool>> updateNews(EditNewsParam params) async {
    try {
      bool state = await remoteDataSource.updateNews(params);
      return Right(state);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }
}
