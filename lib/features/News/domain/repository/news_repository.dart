import 'package:dartz/dartz.dart';
import 'package:project_initiative_club_app/features/News/domain/entities/newsEntity.dart';
import 'package:project_initiative_club_app/features/News/domain/usecases/add_news_usecase.dart';
import 'package:project_initiative_club_app/features/News/domain/usecases/edit_news_usecase.dart';
import 'package:project_initiative_club_app/features/News/domain/usecases/remove_news_usecase.dart';
import 'package:project_initiative_club_app/ressources/errors/failures.dart';

abstract class NewsRepository {
  /// Return Either the like for the news has been registered
  ///
  /// Return a [Failure] in case of any error .
  Future<Either<Failure, NewsEntity>> manageLikes(
      {required NewsEntity news, required int type, required bool isAnAdd});

  Future<Either<Failure, bool>> isLiked({required NewsEntity news});

  /// Return A List of the USTHB News
  ///
  /// Return a [Failure] in case of any error .
  Future<Either<Failure, List<dynamic>>> getUsthbNews();

  /// Return A List of the Club News
  ///
  /// Return a [Failure] in case of any error .
  Future<Either<Failure, List<dynamic>>> getClubNews();

  /// Return Either the news is added or not
  ///
  /// Return a [Failure] in case of any error .
  Future<Either<Failure, int>> addNews(AddNewsParam param);

  Future<Either<Failure, int>> removeNews(RemoveNewsParam param);

  Future<Either<Failure, int>> updateNews(EditNewsParam newsParam);
}
