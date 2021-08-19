import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/rendering.dart';

// ignore: must_be_immutable
class DescriptionWindow extends StatelessWidget {
  String title;
  String description;
  List<String> images;

  List<String> imagesPath = ["images/pi/slide_1.png", "images/pi/slide_2.png"];

  DescriptionWindow(
      {Key? key,
      required this.title,
      required this.description,
      required this.images})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenW = MediaQuery.of(context).size.width;
    double screenH = MediaQuery.of(context).size.height;
    Map<int, Color> colorCodes = {
      50: Color.fromRGBO(255, 90, 34, .1),
      100: Color.fromRGBO(255, 90, 34, .2),
      200: Color.fromRGBO(255, 90, 34, .3),
      300: Color.fromRGBO(255, 90, 34, .4),
      400: Color.fromRGBO(255, 90, 34, .5),
      500: Color.fromRGBO(255, 90, 34, .6),
      600: Color.fromRGBO(255, 90, 34, .7),
      700: Color.fromRGBO(255, 90, 34, .8),
      800: Color.fromRGBO(255, 90, 34, .9),
      900: Color.fromRGBO(255, 90, 34, 1),
    };

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
              "Project Initiative",
              style: TextStyle(
                  fontSize: 30, color: MaterialColor(0xFFF15A22, colorCodes)),
            ),
          ),
          body: Column(
            children: [
              CarouselSlider(
                options: CarouselOptions(height: 400.0),
                items: imagesPath.map((path) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Image(
                        image: AssetImage(path),
                        width: screenW,
                        height: screenH / 3,
                      );
                    },
                  );
                }).toList(),
              ),
              ConstrainedBox(
                  constraints: BoxConstraints.tightFor(width: screenW / 1.5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 10),
                      Center(child: Text(this.title)),
                      SizedBox(
                        height: 20,
                      ),
                      Text(this.description)
                    ],
                  ))
            ],
          ),
        ));
  }
}
