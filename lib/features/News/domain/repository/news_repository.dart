import 'package:dartz/dartz.dart';
import 'package:project_initiative_club_app/features/News/domain/entities/newsEntity.dart';
import 'package:project_initiative_club_app/features/News/domain/usecases/add_news_usecase.dart';
import 'package:project_initiative_club_app/ressources/errors/failures.dart';

abstract class NewsRepository {
  /// Return Either the like for the news has been registered
  ///
  /// Return a [Failure] in case of any error .
  Future<Either<Failure, bool>> addLike({required NewsEntity news});

  /// Return Either the like for the news has been registered
  ///
  /// Return a [Failure] in case of any error .
  ///
  Future<Either<Failure, bool>> removeLike({required NewsEntity news});

  /// Return A List of the USTHB News
  ///
  /// Return a [Failure] in case of any error .
  Future<Either<Failure, List<NewsEntity>>> getUsthbNews();

  /// Return A List of the Club News
  ///
  /// Return a [Failure] in case of any error .
  Future<Either<Failure, List<NewsEntity>>> getClubNews();

  /// Return Either the news is added or not
  ///
  /// Return a [Failure] in case of any error .
  Future<Either<Failure, bool>> addNews(AddNewsParam param);
}
