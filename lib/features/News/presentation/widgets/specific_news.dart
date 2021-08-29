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
import 'package:project_initiative_club_app/features/News/presentation/pages/edit_page.dart';
import 'package:project_initiative_club_app/features/News/presentation/widgets/likes_title.dart';
import 'package:project_initiative_club_app/injections.dart';
import 'package:project_initiative_club_app/main.dart';
import 'package:project_initiative_club_app/ressources/globals.dart';
import 'package:project_initiative_club_app/ressources/widgets/error.dart';
import 'package:project_initiative_club_app/ressources/widgets/loading.dart';
import 'package:tap_debouncer/tap_debouncer.dart';

// ignore: must_be_immutable
class SpecificNewsPage extends StatefulWidget {
  NewsEntity news;

  final int type;
  bool isLiked = false;
  SpecificNewsPage({Key? key, required this.news, required this.type})
      : super(key: key);

  @override
  _SpecificNewsPageState createState() => _SpecificNewsPageState();
}

class _SpecificNewsPageState extends State<SpecificNewsPage> {
  int likes = 0;

  @override
  void initState() {
    likes = widget.news.likes;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                            .add(IsLiked(news: widget.news));
                      } else if (state is Loading) {
                      } else if (state is Error) {
                        return ErrorPage(message: state.message);
                      } else if (state is LoadedIsLiked) {
                        widget.isLiked = state.isLiked;
                      } else if (state is LoadedLike) {
                        widget.isLiked = !widget.isLiked;
                        if (widget.isLiked) {
                          likes = likes + 1;
                        } else {
                          likes = likes > 0 ? likes - 1 : 0;
                        }

                        return _body(
                          screenW,
                          screenH,
                          context,
                        );
                      } else if (state is LoadedRemove) {
                        return Center(
                          child: Text("Element supprimé"),
                        );
                      }

                      return _body(
                        screenW,
                        screenH,
                        context,
                      );
                    })))));
  }

  Widget _body(double screenW, double screenH, BuildContext context) {
    String editedString =
        DateFormat('dd-MM-yyyy').format(widget.news.lastModification);
    print("data :" + widget.news.images.toString());
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
                  widget.news.title,
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
                    widget.news.description + "\n Test",
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
              TapDebouncer(
                cooldown: const Duration(milliseconds: 800),
                onTap: () async {
                  if (widget.isLiked) {
                    BlocProvider.of<NewsblocBloc>(context).add(LikeClick(
                        param: LikesParams(
                            isAnAdd: false,
                            type: widget.type,
                            news: widget.news)));
                  } else {
                    BlocProvider.of<NewsblocBloc>(context).add(LikeClick(
                        param: LikesParams(
                            isAnAdd: true,
                            type: widget.type,
                            news: widget.news)));
                  }
                },
                builder: (_, onTap) => TextButton(
                    onPressed: onTap,
                    child: Row(children: [
                      Icon(
                        widget.isLiked
                            ? Icons.favorite
                            : Icons.favorite_outline_outlined,
                        color: Colors.white,
                      ),
                      Text(
                        likes.toString() + " J'aime",
                        style: TextStyle(color: Colors.white),
                      )
                    ])),
              ),
              TextButton(
                  onPressed: () async {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) =>
                            EditPage(news: widget.news, type: widget.type)));
                  },
                  child: Text('Edit')),
              TextButton(
                  onPressed: () async {
                    BlocProvider.of<NewsblocBloc>(context).add(RemoveNews(
                        param: RemoveNewsParam(
                            newsEntity: widget.news, type: widget.type)));
                  },
                  child: Text('Remove'))
            ]),
          ],
        ),
      ),
    ]);
  }
}
