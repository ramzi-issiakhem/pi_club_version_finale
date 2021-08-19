import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:project_initiative_club_app/features/About%20Us/presentation/widgets/carousel_widget.dart';
import 'package:project_initiative_club_app/features/News/domain/entities/newsEntity.dart';
import 'package:project_initiative_club_app/features/News/presentation/widgets/likes_title.dart';
import 'package:project_initiative_club_app/ressources/globals.dart';

// ignore: must_be_immutable
class SpecificNewsPage extends StatefulWidget {
  NewsEntity news;
  SpecificNewsPage({Key? key, required this.news}) : super(key: key);

  @override
  _SpecificNewsPageState createState() => _SpecificNewsPageState();
}

class _SpecificNewsPageState extends State<SpecificNewsPage> {
  bool isLiked = true;

  @override
  Widget build(BuildContext context) {
    NewsEntity news = widget.news;
    double screenH = MediaQuery.of(context).size.height;
    double screenW = MediaQuery.of(context).size.width;
    String editedString =
        "Edité le : " + DateFormat('dd-MM-yyyy').format(news.lastModification);
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
            body: ListView(children: [
              carouselWidget(
                  <String>[widget.news.coverImage] + widget.news.images,
                  screenH,
                  screenW),
              SizedBox(height: screenH * 0.05),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Text(editedString),
                TextButton(
                    onPressed: () {
                      setState(() {
                        isLiked = !isLiked;
                      });
                    },
                    child: Row(children: [
                      Icon(isLiked
                          ? Icons.favorite
                          : Icons.favorite_outline_outlined),
                      Text(news.likes.toString() + " J'aime")
                    ])),
              ]),
              Text("Article par : "),
              SizedBox(
                height: 50,
              ),
              Text(news.description + "\n Test"),
            ])));
  }
}
