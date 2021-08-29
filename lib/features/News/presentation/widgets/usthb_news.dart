import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_initiative_club_app/features/News/domain/entities/newsEntity.dart';
import 'package:project_initiative_club_app/features/News/presentation/blocs/news/newsbloc_bloc.dart';
import 'package:project_initiative_club_app/features/News/presentation/pages/add_news_page.dart';
import 'package:project_initiative_club_app/features/News/presentation/widgets/news_card.dart';
import 'package:project_initiative_club_app/injections.dart';
import 'package:project_initiative_club_app/ressources/globals.dart';
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
            return UsthbNewsWidget(
              entries: state.lists[0],
              isLikedTab: state.lists[1],
            );
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
  List<bool> isLikedTab = [];
  UsthbNewsWidget({Key? key, required this.entries, required this.isLikedTab})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: entries.length,
        itemBuilder: (BuildContext context, int index) {
          return Center(
              child: NewsCard(
            isLiked: isLikedTab[index],
            color: mainColor,
            news: entries[index],
            type: 1,
          ));
        });
    //FloatingActionButton(child: Icon(Icons.add),onPressed: (){
    // Navigator.of(context).push(MaterialPageRoute(
    //    builder: (BuildContext context) => AddNewsPage()));
    // }),
  }
}
