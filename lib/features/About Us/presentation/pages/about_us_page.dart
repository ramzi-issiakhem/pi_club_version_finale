import 'package:flutter/material.dart';
import 'package:project_initiative_club_app/features/About%20Us/presentation/widgets/carousel_widget.dart';
import 'package:project_initiative_club_app/features/About%20Us/presentation/widgets/section_widget.dart';

// ignore: must_be_immutable
class AboutUsPage extends StatelessWidget {
  AboutUsPage({Key? key}) : super(key: key);
  List<String> imagesPath = ["images/pi/slide_1.png", "images/pi/slide_2.png"];

  @override
  Widget build(BuildContext context) {
    double screenW = MediaQuery.of(context).size.width;
    double screenH = MediaQuery.of(context).size.height;

    return SingleChildScrollView(
      child: Column(
        children: [
          carouselWidget(imagesPath, screenH, screenW),
          sectionWidget(
              title: "Qui Sommes-Nous",
              screenH: screenH,
              screenW: screenW,
              description:
                  "Project Initiative est une famille universitaire à caractère entrepreneurial fondé en 2014 par des étudiants ambitieux, volontaires, visant à la promotion de l’esprit d’engagement, d’initiative et de leadership au sein de la communauté universitaire",
              image: "images/pi/image_1.png",
              right: true),
          sectionWidget(
              title: "Nos Activités",
              screenH: screenH,
              screenW: screenW,
              description: "Description des Activites",
              image: "images/pi/image_2.png",
              right: false),
          sectionWidget(
              title: "Notre Vision",
              screenH: screenH,
              screenW: screenW,
              right: true,
              description:
                  "Alors Que les clubs universitaires Forment l’étudiant dans le domaine technique, Project initiative permet d’ouvrir un nouveau champ de vision aux étudiants et propose une approche d’un domaine nouveau «  l’entreprenariat », et ceci en leur offrant divers opportunités, formations et événements dans le but de faciliter la communication entre les entreprises et porteurs de projets",
              image: "images/pi/image_3.png")
        ],
      ),
    );
  }
}
