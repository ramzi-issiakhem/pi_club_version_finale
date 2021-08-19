import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_initiative_club_app/features/News/domain/entities/newsEntity.dart';
import 'package:project_initiative_club_app/features/News/presentation/blocs/news/newsbloc_bloc.dart';
import 'package:project_initiative_club_app/features/News/presentation/widgets/news_card.dart';
import 'package:project_initiative_club_app/injections.dart';
import 'package:project_initiative_club_app/ressources/widgets/loading.dart';

class UsthbNews extends StatelessWidget {
  const UsthbNews({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<NewsblocBloc>(
        create: (_context) => sl<NewsblocBloc>(),
        child:
            BlocBuilder<NewsblocBloc, NewsblocState>(builder: (context, state) {
          if (state is EmptyUsthb) {
            BlocProvider.of<NewsblocBloc>(context).add(UsthbNewsEvent());
          } else if (state is Loading) {
            return Center(child: LoadingWidget());
          } else if (state is LoadedUsthbNews) {
            return UsthbNewsWidget(entries: state.list);
          } else if (state is Error) {
            return Center(
              child: Container(
                child: Text("error"),
              ),
            );
          }
          return Container();
        }));
  }
}

// ignore: must_be_immutable
class UsthbNewsWidget extends StatelessWidget {
  List<NewsEntity> entries;
  UsthbNewsWidget({Key? key, required this.entries}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
          itemCount: entries.length,
          itemBuilder: (BuildContext context, int index) {
            return Center(
                child: NewsCard(
                    color: Colors.blue.shade600, news: entries[index]));
          }),
    );
  }
}
