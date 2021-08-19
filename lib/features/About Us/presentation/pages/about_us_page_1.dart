import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:path/path.dart';
import 'package:project_initiative_club_app/features/About%20Us/presentation/widgets/box_info.dart';
import 'package:project_initiative_club_app/features/About%20Us/presentation/widgets/carousel_widget.dart';
import 'package:project_initiative_club_app/ressources/globals.dart';

class AboutUsPageSecondary extends StatelessWidget {
  AboutUsPageSecondary({Key? key}) : super(key: key) {
    currentTitle = "Qui Sommes-Nous";
  }

  @override
  Widget build(BuildContext context) {
    double screenW = MediaQuery.of(context).size.width;
    double screenH = MediaQuery.of(context).size.height;

    return ListView(children: [
      Center(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: Image.asset(
            'images/pi/logo.png',
            height: 150.0,
            width: 100.0,
          ),
        ),
      ),
      SizedBox(
        height: 5,
      ),
      Center(
        child: Text(
          "Project Initiative Club",
          style: TextStyle(color: mainColor),
        ),
      ),
      SizedBox(
        height: 10,
      ),
      Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Text(
            "Project Initiative est une famille universitaire à caractère entrepreneurial fondé en 2014 par des étudiants ambitieux, volontaires, visant à la promotion de l’esprit d’engagement, d’initiative et de leadership au sein de la communauté universitaire.",
          ),
        ),
      ),
      SizedBox(
        height: 15,
      ),
      Center(
        child: Text(
          "PI en Chiffres",
          style: TextStyle(color: mainColor),
        ),
      ),
      SizedBox(
        height: 7,
      ),
      Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          column("140", "Membres"),
          VerticalDivider(
            width: 5,
            thickness: 5,
            color: Colors.blueAccent,
          ),
          column("25k", "Abonnés"),
          VerticalDivider(
            width: 5,
            thickness: 5,
            color: Colors.blueAccent,
          ),
          column("60", "Evenements")
        ],
      ),
      SizedBox(
        height: 25,
      ),
      Center(
        child: Text(
          "PI History",
          style: TextStyle(color: mainColor),
        ),
      ),
      SizedBox(
        height: 15,
      ),
      carouselWidget([
        'images/pi/image_2.png',
        'images/pi/image_2.png',
        'images/pi/image_2.png',
        'images/pi/image_2.png'
      ], screenH, screenW)
      /*imageWidget('images/pi/image_2.png', screenW),
      SizedBox(
        height: 5,
      ),
      imageWidget('images/pi/image_2.png', screenW),
      SizedBox(
        height: 5,
      ),
      imageWidget('images/pi/image_2.png', screenW),
      SizedBox(
        height: 5,
      )*/
    ]);

    /* SingleChildScrollView(
      child: Column(
        children: [
          Center(
              child: Column(children: [
            SizedBox(height: 10),
            carouselWidget(imagesPath, screenH, screenW),
            ConstrainedBox(
              constraints: BoxConstraints.tightFor(width: screenW),
              child: Column(
                children: [
                  SizedBox(height: 60),
                  Column(
                    children: [
                      Text(
                        "PI en Chiffres",
                        style: TextStyle(color: Color.fromRGBO(255, 90, 34, 1)),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          boxInfo("185", "Evenement Actuels"),
                          VerticalDivider(
                            width: 10,
                            thickness: 3,
                          ),
                          boxInfo("65", "Workshops Actuels"),
                          VerticalDivider(
                            width: 10,
                            thickness: 3,
                          ),
                          boxInfo("6", "Ans d'activité"),
                        ],
                      ),
                      SizedBox(height: 75),
                      Text("Qui Sommes-Nous",
                          style:
                              TextStyle(color: Color.fromRGBO(255, 90, 34, 1))),
                      SizedBox(height: 15),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: Text(
                            "Project Initiative est une famille universitaire à caractère entrepreneurial fondé en 2014 par des étudiants ambitieux, volontaires, visant à la promotion de l’esprit d’engagement, d’initiative et de leadership au sein de la communauté universitaire."),
                      ),
                      SizedBox(
                        height: 35,
                      ),
                      Text("Notre Vision",
                          textAlign: TextAlign.start,
                          style:
                              TextStyle(color: Color.fromRGBO(255, 90, 34, 1))),
                      SizedBox(height: 15),
                      Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 75.0),
                          child: Text(
                              "Alors Que les clubs universitaires Forment l’étudiant dans le domaine technique, Project initiative permet d’ouvrir un nouveau champ de vision aux étudiants et propose une approche d’un domaine nouveau «  l’entreprenariat », et ceci en leur offrant divers opportunités, formations et événements dans le but de faciliter la communication entre les entreprises et porteurs de projets")),
                      SizedBox(
                        height: 35,
                      ),
                      Text("Notre Vision",
                          style:
                              TextStyle(color: Color.fromRGBO(255, 90, 34, 1))),
                      SizedBox(height: 15),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: Text(
                            "Project initiative vise à former ses éléments pour le monde de demain. pas seulement pour en faire partie mais pour en être un acteur actif et leader du changement"),
                      ),
                      SizedBox(height: 50),
                    ],
                  )
                ],
              ),
            ),
          ]))
        ],
      ),
    );*/
  }
}

Widget imageWidget(String path, double screenW) {
  return Image.asset(
    path,
    width: screenW * 0.8,
    height: screenW * 0.65,
    fit: BoxFit.fill,
  );
}

Widget column(String numbers, String type) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text(
        numbers,
        style: TextStyle(fontSize: 22.5),
      ),
      Text(
        type,
        style: TextStyle(fontSize: 13),
      )
    ],
  );
}
