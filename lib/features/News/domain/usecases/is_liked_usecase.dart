import 'package:dartz/dartz.dart';
import 'package:project_initiative_club_app/features/News/domain/entities/newsEntity.dart';
import 'package:project_initiative_club_app/features/News/domain/repository/news_repository.dart';
import 'package:project_initiative_club_app/ressources/errors/failures.dart';
import 'package:project_initiative_club_app/ressources/usecases/usecase.dart';

enum NewsTypes { club, usthb }

class IsLikedUseCase implements UseCase<bool, NewsEntity> {
  final NewsRepository newsRepository;

  IsLikedUseCase({required this.newsRepository});

  @override
  Future<Either<Failure, bool>> call(NewsEntity news) async {
    return await newsRepository.isLiked(news: news);
  }
}
