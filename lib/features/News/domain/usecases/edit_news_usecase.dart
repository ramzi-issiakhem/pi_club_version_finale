import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:project_initiative_club_app/features/News/domain/entities/newsEntity.dart';
import 'package:project_initiative_club_app/features/News/domain/repository/news_repository.dart';
import 'package:project_initiative_club_app/ressources/errors/failures.dart';
import 'package:project_initiative_club_app/ressources/usecases/usecase.dart';

enum NewsTypes { club, usthb }

class EditNewsUseCase implements UseCase<bool, EditNewsParam> {
  final NewsRepository newsRepository;

  EditNewsUseCase({required this.newsRepository});

  @override
  Future<Either<Failure, bool>> call(EditNewsParam newsParam) async {
    return await newsRepository.updateNews(newsParam);
  }
}

class EditNewsParam {
  final int ancientType;
  final String title;
  final String description;
  final String uid;
  final File coverImage;
  final List<File> images;
  final int type;
  final int likes;
  EditNewsParam(
      {required this.type,
      required this.title,
      required this.ancientType,
      required this.uid,
      required this.likes,
      required this.description,
      required this.coverImage,
      required this.images});
}
