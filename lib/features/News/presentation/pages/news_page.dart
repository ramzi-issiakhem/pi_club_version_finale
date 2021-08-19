import 'package:flutter/material.dart';
import 'package:project_initiative_club_app/features/News/presentation/pages/add_news_page.dart';
import 'package:project_initiative_club_app/features/News/presentation/widgets/pi_news.dart';
import 'package:project_initiative_club_app/features/News/presentation/widgets/usthb_news.dart';
import 'package:project_initiative_club_app/main.dart';
import 'package:project_initiative_club_app/ressources/globals.dart';

class NewsPage extends StatefulWidget {
  NewsPage({Key? key}) : super(key: key) {
    currentTitle = "News Feed";
  }

  @override
  _NewsPageState createState() => _NewsPageState();
}

List<bool> clickedBtns = [false, false, false];

class _NewsPageState extends State<NewsPage> {
  double elevationValue = 5;
  @override
  Widget build(BuildContext context) {
    double screenW = MediaQuery.of(context).size.width;
    return Column(
      children: [
        SizedBox(
          width: screenW,
          height: 60,
          child: DecoratedBox(
            decoration: BoxDecoration(color: mainColor),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _container(0, "PI News"),
                _container(1, "Usthb News"),
                _container(2, "Add News")
              ],
            ),
          ),
        ),
        _widget()
      ],
    );
  }

  void onClickeBtn(int index) {
    setState(() {
      clickedBtns = [false, false, false];
      clickedBtns[index] = true;
    });
  }

  Widget _widget() {
    if (clickedBtns[0]) {
      return PiNews();
    } else if (clickedBtns[1]) {
      return UsthbNews();
    } else {
      return AddNewsPage();
    }
  }

  Widget _container(int index, String text) {
    return Container(
        child: TextButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(mainColor),
          ),
          onPressed: () {
            onClickeBtn(index);
          },
          child: Text(text, style: TextStyle(color: Colors.white)),
        ),
        decoration: BoxDecoration(
          border: Border(
              bottom: clickedBtns[index]
                  ? BorderSide(color: Colors.white, width: 4)
                  : BorderSide(width: 0, color: mainColor)),
        ));
  }
}
