import 'package:dartz/dartz.dart';
import 'package:project_initiative_club_app/features/News/domain/entities/newsEntity.dart';
import 'package:project_initiative_club_app/features/News/domain/repository/news_repository.dart';
import 'package:project_initiative_club_app/ressources/errors/failures.dart';
import 'package:project_initiative_club_app/ressources/usecases/usecase.dart';

class UsthbNewsCase implements UseCase<List<NewsEntity>, NoParams> {
  final NewsRepository newsRepository;

  UsthbNewsCase({required this.newsRepository});

  @override
  Future<Either<Failure, List<NewsEntity>>> call(NoParams noParams) async {
    return await newsRepository.getUsthbNews();
  }
}

class NoParams {}
