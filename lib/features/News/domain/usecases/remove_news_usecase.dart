import 'package:dartz/dartz.dart';
import 'package:project_initiative_club_app/features/News/domain/entities/newsEntity.dart';
import 'package:project_initiative_club_app/features/News/domain/repository/news_repository.dart';
import 'package:project_initiative_club_app/ressources/errors/failures.dart';
import 'package:project_initiative_club_app/ressources/usecases/usecase.dart';

enum NewsTypes { club, usthb }

class RemoveNewsUseCase implements UseCase<bool, RemoveNewsParam> {
  final NewsRepository newsRepository;

  RemoveNewsUseCase({required this.newsRepository});

  @override
  Future<Either<Failure, bool>> call(RemoveNewsParam newsParam) async {
    return await newsRepository.removeNews(newsParam);
  }
}

class RemoveNewsParam {
  final NewsEntity newsEntity;
  final int type;

  RemoveNewsParam({required this.newsEntity, required this.type});
}
