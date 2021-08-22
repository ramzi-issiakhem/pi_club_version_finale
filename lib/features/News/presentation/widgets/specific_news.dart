import 'package:confirm_dialog/confirm_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:project_initiative_club_app/features/About%20Us/presentation/widgets/carousel_widget.dart';
import 'package:project_initiative_club_app/features/News/domain/entities/newsEntity.dart';
import 'package:project_initiative_club_app/features/News/domain/usecases/likes_usecase.dart';
import 'package:project_initiative_club_app/features/News/domain/usecases/remove_news_usecase.dart';
import 'package:project_initiative_club_app/features/News/presentation/blocs/news/newsbloc_bloc.dart';
import 'package:project_initiative_club_app/features/News/presentation/widgets/likes_title.dart';
import 'package:project_initiative_club_app/injections.dart';
import 'package:project_initiative_club_app/ressources/globals.dart';
import 'package:project_initiative_club_app/ressources/widgets/error.dart';
import 'package:project_initiative_club_app/ressources/widgets/loading.dart';

// ignore: must_be_immutable
class SpecificNewsPage extends StatefulWidget {
  NewsEntity news;
  final int type;
  SpecificNewsPage({Key? key, required this.news, required this.type})
      : super(key: key);

  @override
  _SpecificNewsPageState createState() => _SpecificNewsPageState();
}

class _SpecificNewsPageState extends State<SpecificNewsPage> {
  bool isLiked = false;

  @override
  Widget build(BuildContext context) {
    NewsEntity news = widget.news;
    double screenH = MediaQuery.of(context).size.height;
    double screenW = MediaQuery.of(context).size.width;

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              toolbarHeight: 60,
              centerTitle: true,
              title: Text(
                "News",
                style: TextStyle(fontSize: 30, color: mainColor),
              ),
            ),
            body: Container(
                padding: EdgeInsets.all(10),
                child: BlocProvider<NewsblocBloc>(
                    create: (_context) => sl<NewsblocBloc>(),
                    child: BlocBuilder<NewsblocBloc, NewsblocState>(
                        builder: (context, state) {
                      if (state is EmptyUsthb) {
                        BlocProvider.of<NewsblocBloc>(context)
                            .add(IsLiked(news: news));
                        return _body(screenW, screenH, news, context);
                      } else if (state is Loading) {
                        return LoadingWidget();
                      } else if (state is Error) {
                        return ErrorPage(message: state.message);
                      } else if (state is LoadedIsLiked) {
                        isLiked = state.isLiked;
                      } else if (state is LoadedRemove) {
                        Navigator.pop(context);
                        return Container();
                      }

                      return _body(screenW, screenH, news, context);
                    })))));
  }

  Widget _body(
      double screenW, double screenH, NewsEntity news, BuildContext context) {
    String editedString =
        DateFormat('dd-MM-yyyy').format(news.lastModification);

    return ListView(children: [
      carouselWidget(<String>[widget.news.coverImage] + widget.news.images,
          screenH, screenW, true),
      Container(
        padding: EdgeInsets.only(left: 20, right: 10),
        height: MediaQuery.of(context).size.height * 0.53,
        decoration: BoxDecoration(
          color: mainColor,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Column(
          children: [
            SizedBox(height: screenH * 0.02),
            Container(
                alignment: Alignment.topLeft,
                child: Text(
                  news.title,
                  style: TextStyle(color: Colors.white, fontSize: 20),
                )),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  height: 3,
                  width: 50,
                  color: Colors.white,
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.34,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    news.description + "\n Test",
                    textAlign: TextAlign.start,
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  height: 2,
                  width: 200,
                  color: Colors.white,
                ),
              ],
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text(
                editedString,
                style: TextStyle(color: Colors.white, fontSize: 15),
              ),
              TextButton(
                  onPressed: () {
                    if (isLiked) {
                      isLiked = false;
                      BlocProvider.of<NewsblocBloc>(context).add(LikeClick(
                          param: LikesParams(
                              isAnAdd: false, type: widget.type, news: news)));
                    } else {
                      isLiked = true;
                      BlocProvider.of<NewsblocBloc>(context).add(LikeClick(
                          param: LikesParams(
                              isAnAdd: true, type: widget.type, news: news)));
                    }
                  },
                  child: Row(children: [
                    Icon(
                      isLiked
                          ? Icons.favorite
                          : Icons.favorite_outline_outlined,
                      color: Colors.white,
                    ),
                    Text(
                      news.likes.toString() + " J'aime",
                      style: TextStyle(color: Colors.white),
                    )
                  ])),
              TextButton(onPressed: () async {}, child: Text('Edit')),
              TextButton(
                  onPressed: () async {
                    BlocProvider.of<NewsblocBloc>(context).add(RemoveNews(
                        param: RemoveNewsParam(
                            newsEntity: news, type: widget.type)));
                  },
                  child: Text('Remove'))
            ]),
          ],
        ),
      ),
    ]);
  }
}
