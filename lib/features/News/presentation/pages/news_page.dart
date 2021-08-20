import 'package:flutter/cupertino.dart';
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

List<bool> clickedBtns = [false, false];

class _NewsPageState extends State<NewsPage> {
  double elevationValue = 5;
  @override
  Widget build(BuildContext context) {
    double screenW = MediaQuery.of(context).size.width;
    return  Column(
        children: [
          Container(
            width: screenW,
            height: 40,
            child: DecoratedBox(
              decoration: BoxDecoration(color: mainColor,borderRadius: BorderRadius.only(bottomLeft: Radius.circular(15) ,bottomRight:Radius.circular(15))),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _container(0, "PI News"),
                  _container(1, "Usthb News"),
                ],
              ),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height*0.76,
            child: Stack(
              children: [
                _widget(),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: FloatingActionButton(child: Icon(Icons.add),backgroundColor: mainColor,onPressed: (){
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

  void onClickeBtn(int index) {
    setState(() {
      clickedBtns = [false, false];
      clickedBtns[index] = true;
    });
  }

  Widget _widget() {
    if (clickedBtns[0]) {
      return PiNews();
    } else{
      return UsthbNews();
    }
  }

  Widget _container(int index, String text) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Container(
          child: TextButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(mainColor),
            ),
            onPressed: () {
              onClickeBtn(index);
            },
            child: Text(text, style: TextStyle(color: Colors.white,fontSize: 16 )),
          ),
          decoration: BoxDecoration(
            border: Border(
                bottom: clickedBtns[index]
                    ? BorderSide(color: Colors.white, width: 1)
                    : BorderSide(width: 0, color: mainColor)

            ),

          )),
    );
  }
}
