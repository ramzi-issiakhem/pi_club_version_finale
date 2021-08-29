import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:project_initiative_club_app/features/News/domain/entities/newsEntity.dart';
import 'package:project_initiative_club_app/features/News/domain/repository/news_repository.dart';
import 'package:project_initiative_club_app/ressources/errors/failures.dart';
import 'package:project_initiative_club_app/ressources/usecases/usecase.dart';

enum NewsTypes { club, usthb }

class LikesUseCase implements UseCase<NewsEntity, LikesParams> {
  final NewsRepository newsRepository;

  LikesUseCase({required this.newsRepository});

  @override
  Future<Either<Failure, NewsEntity>> call(LikesParams params) async {
    return await newsRepository.manageLikes(
        news: params.news, type: params.type, isAnAdd: params.isAnAdd);
  }
}

class LikesParams {
  final NewsEntity news;
  final int type;
  final bool isAnAdd;

  LikesParams({
    required this.type,
    required this.isAnAdd,
    required this.news,
  });
}
