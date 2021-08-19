import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_initiative_club_app/features/News/domain/entities/newsEntity.dart';
import 'package:project_initiative_club_app/features/News/presentation/blocs/news/newsbloc_bloc.dart';
import 'package:project_initiative_club_app/features/News/presentation/widgets/news_card.dart';
import 'package:project_initiative_club_app/injections.dart';
import 'package:project_initiative_club_app/ressources/widgets/loading.dart';

class PiNews extends StatelessWidget {
  const PiNews({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<NewsblocBloc>(
        create: (_context) => sl<NewsblocBloc>(),
        child:
            BlocBuilder<NewsblocBloc, NewsblocState>(builder: (context, state) {
          if (state is EmptyUsthb) {
            BlocProvider.of<NewsblocBloc>(context).add(ClubNewsEvent());
          } else if (state is Loading) {
            return LoadingWidget();
          } else if (state is LoadedClubNews) {
            return ClubNewsWidget(entries: state.list);
          } else if (state is Error) {}
          return Container();
        }));
  }
}

// ignore: must_be_immutable
class ClubNewsWidget extends StatelessWidget {
  List<NewsEntity> entries;
  ClubNewsWidget({Key? key, required this.entries}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
          itemCount: entries.length,
          itemBuilder: (BuildContext context, int index) {
            return Center(
                child: NewsCard(
                    color: Colors.orange.shade800, news: entries[index]));
          }),
    );
  }
}
