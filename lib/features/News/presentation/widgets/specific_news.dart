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
    String editedString = DateFormat('dd-MM-yyyy').format(news.lastModification);
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
              child: ListView(children: [
                carouselWidget(
                    <String>[widget.news.coverImage] + widget.news.images,
                    screenH,
                    screenW),
                Container(
                  padding: EdgeInsets.only(left: 20,right: 10),
                  height: MediaQuery.of(context).size.height*0.53,
                  decoration: BoxDecoration(
                    color: mainColor,
                    borderRadius:BorderRadius.circular(30),
                  ),
                  child: Column(
                    children: [

                      SizedBox(height: screenH * 0.02),

                      Container(
                          alignment: Alignment.topLeft,
                          child: Text(news.title,style: TextStyle(color: Colors.white,fontSize: 20),)),
                      SizedBox(height: 10,),
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

                      SizedBox(height: MediaQuery.of(context).size.height*0.34,
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
                        Text(editedString,style: TextStyle(color: Colors.white,fontSize: 15),),
                        TextButton(
                            onPressed: () {
                              setState(() {
                                isLiked = !isLiked;
                              });
                            },
                            child: Row(children: [
                              Icon(isLiked
                                  ? Icons.favorite
                                  : Icons.favorite_outline_outlined,color: Colors.white,),
                              Text(news.likes.toString() + " J'aime",style: TextStyle(color: Colors.white),)
                            ])),
                      ]),
                    ],
                  ),
                ),

              ]),
            )));
  }
}
