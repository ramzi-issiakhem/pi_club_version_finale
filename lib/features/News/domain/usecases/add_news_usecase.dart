import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:project_initiative_club_app/features/News/domain/repository/news_repository.dart';
import 'package:project_initiative_club_app/ressources/errors/failures.dart';
import 'package:project_initiative_club_app/ressources/usecases/usecase.dart';

enum NewsTypes { club, usthb }

class AddNewsUseCase implements UseCase<bool, AddNewsParam> {
  final NewsRepository newsRepository;

  AddNewsUseCase({required this.newsRepository});

  @override
  Future<Either<Failure, bool>> call(AddNewsParam newsParam) async {
    return await newsRepository.addNews(newsParam);
  }
}

class AddNewsParam {
  final File coverImage;
  final List<File> images;
  final String title;
  final String description;
  final int likes;
  final DateTime lastModification;
  final int type;
  AddNewsParam(
      {required this.type,
      required this.coverImage,
      required this.lastModification,
      required this.images,
      required this.title,
      required this.description,
      required this.likes});
}
