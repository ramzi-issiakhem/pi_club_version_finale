import 'package:dartz/dartz.dart';
import 'package:project_initiative_club_app/features/News/data/datasources/news_local_data_source.dart';
import 'package:project_initiative_club_app/features/News/data/datasources/news_remote_data_source.dart';
import 'package:project_initiative_club_app/features/News/domain/entities/newsEntity.dart';
import 'package:project_initiative_club_app/features/News/domain/repository/news_repository.dart';
import 'package:project_initiative_club_app/features/News/domain/usecases/add_news_usecase.dart';
import 'package:project_initiative_club_app/ressources/errors/exceptions.dart';
import 'package:project_initiative_club_app/ressources/errors/failures.dart';

class NewsRepositoryImpl implements NewsRepository {
  final NewsRemoteDataSource remoteDataSource;
  final NewsLocalDataSource localDataSource;

  NewsRepositoryImpl(
      {required this.remoteDataSource, required this.localDataSource});

  @override
  Future<Either<Failure, bool>> addLike({required NewsEntity news}) async {
    return Right(true);
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
  Future<Either<Failure, bool>> removeLike({required NewsEntity news}) async {
    return Right(true);
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
}
