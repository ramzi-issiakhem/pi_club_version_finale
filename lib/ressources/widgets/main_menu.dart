import 'package:flutter/material.dart';
import 'package:project_initiative_club_app/main_class.dart';
import 'package:project_initiative_club_app/ressources/globals.dart' as globals;
import 'package:provider/provider.dart';
import 'dart:math' as math;

// ignore: must_be_immutable
class MainMenu extends StatefulWidget {
  double screenW;
  double screenH;

  MainMenu({Key? key, required this.screenH, required this.screenW})
      : super(key: key);

  @override
  _MainMenuState createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu>
    with SingleTickerProviderStateMixin {
  late AnimationController mainAnimController;
  bool reverseAnimation = false;
  late Animation _animScale;
  late Animation _animPosH;
  late Animation _animPosW;

  @override
  void initState() {
    mainAnimController =
        AnimationController(duration: Duration(milliseconds: 200), vsync: this);

    _animScale = Tween<double>(begin: 1, end: 0.5).animate(mainAnimController);
    _animPosW = Tween<double>(begin: 0, end: widget.screenW * 0.2)
        .animate(mainAnimController);
    _animPosH = Tween<double>(begin: 0, end: widget.screenH * 0.1)
        .animate(mainAnimController);

    mainAnimController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          reverseAnimation = true;
        });
      } else if (status == AnimationStatus.dismissed) {
        setState(() {
          reverseAnimation = false;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext x) {
    return Consumer<MainClass>(builder: (context, mainClass, _) {
      globals.mainClass = mainClass;
      return AnimatedBuilder(
          animation: mainAnimController,
          builder: (BuildContext y, _) {
            return Scaffold(
              appBar: AppBar(
                backgroundColor: globals.mainColor,
                title: Row(
                  children: [
                    Transform.rotate(
                        angle: mainAnimController.value * math.pi * 2,
                        child: IconButton(
                            onPressed: () {
                              reverseAnimation
                                  ? mainAnimController.reverse()
                                  : mainAnimController.forward();
                            },
                            icon: Icon(Icons.reorder))),
                    Text("Project Initiative Club")
                  ],
                ),
              ),
              body: Stack(
                children: [
                  Positioned(
                    child: Transform.scale(
                      alignment: Alignment.topRight,
                      scale: _animScale.value,
                      child: Container(
                        color: Colors.white,
                        width: widget.screenH,
                        height: widget.screenH - globals.barHeight,
                        child: mainClass.widget,
                      ),
                    ),
                  )

                  //MenuContainer
                  ,

                  Positioned(
                    top: 0,
                    left: 0,
                    child: Padding(
                      padding: EdgeInsets.only(left: 35),
                      child: Opacity(
                        opacity: mainAnimController.value,
                        child: Container(
                          margin:
                              EdgeInsets.only(left: reverseAnimation ? 0 : 500),
                          width: widget.screenW,
                          height: widget.screenH - globals.barHeight,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextButton(
                                  onPressed: reverseAnimation
                                      ? () {
                                          mainAnimController.reverse();
                                          mainClass.rebuild("news");
                                        }
                                      : null,
                                  child: Text("News")),
                              TextButton(
                                  onPressed: reverseAnimation
                                      ? () {
                                          if (reverseAnimation) {
                                            mainAnimController.reverse();
                                            mainClass.rebuild("scolarity");
                                          }
                                        }
                                      : null,
                                  child: Text("Scolarity")),
                              TextButton(
                                  onPressed: reverseAnimation
                                      ? () {
                                          mainAnimController.reverse();
                                          mainClass.rebuild("map");
                                        }
                                      : null,
                                  child: Text("Maps")),
                              TextButton(
                                  onPressed: reverseAnimation
                                      ? () {
                                          mainAnimController.reverse();
                                          mainClass.rebuild("about");
                                        }
                                      : null,
                                  child: Text("About Us")),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),

                  //MainContainer
                ],
              ),
            );
          });
    });
  }
}
