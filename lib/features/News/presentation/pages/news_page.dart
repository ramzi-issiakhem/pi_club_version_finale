import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_initiative_club_app/features/News/presentation/pages/add_news_page.dart';
import 'package:project_initiative_club_app/features/News/presentation/widgets/pi_news.dart';
import 'package:project_initiative_club_app/features/News/presentation/widgets/usthb_news.dart';
import 'package:project_initiative_club_app/main.dart';
import 'package:project_initiative_club_app/ressources/globals.dart';

class NewsPage extends StatefulWidget {
  bool isPiNews = true;
  NewsPage({Key? key, this.isPiNews = true}) : super(key: key) {
    currentTitle = "News Feed";
  }

  @override
  _NewsPageState createState() => _NewsPageState(isPiNews);
}

class _NewsPageState extends State<NewsPage> {
  bool isPiNews = true;
  _NewsPageState(this.isPiNews);

  double elevationValue = 5;

  @override
  Widget build(BuildContext context) {
    double screenW = MediaQuery.of(context).size.width;
    return Column(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.03,
        ),
        Container(
          width: screenW,
          height: 30,
          child: DecoratedBox(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(15),
                    bottomRight: Radius.circular(15))),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Padding(
                  padding: const EdgeInsets.all(0),
                  child: GestureDetector(
                    onTap: () {
                      onClickedBtn(0);
                    },
                    child: Container(
                      child: Text("PI News",
                          style: TextStyle(
                              color: isPiNews ? mainColor : Colors.grey,
                              fontSize: 16,
                              fontWeight: FontWeight.bold)),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(0),
                  child: GestureDetector(
                    onTap: () {
                      onClickedBtn(1);
                    },
                    child: Container(
                      child: Text("Usthb News",
                          style: TextStyle(
                              color: isPiNews ? Colors.grey : mainColor,
                              fontSize: 16,
                              fontWeight: FontWeight.bold)),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        Container(
          height: MediaQuery.of(context).size.height * 0.76,
          child: Stack(
            children: [
              _widget(),
              Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FloatingActionButton(
                      child: Icon(Icons.add),
                      backgroundColor: mainColor,
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (BuildContext context) => AddNewsPage()));
                      }),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  void onClickedBtn(int index) {
    setState(() {
      if (index == 0) {
        isPiNews = true;
      } else {
        isPiNews = false;
      }
    });
  }

  Widget _widget() {
    if (isPiNews) {
      return PiNews();
    } else {
      return UsthbNews();
    }
  }
}
