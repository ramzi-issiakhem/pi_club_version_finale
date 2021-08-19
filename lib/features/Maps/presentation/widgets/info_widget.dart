import 'package:flutter/material.dart';
import 'package:project_initiative_club_app/features/Maps/domain/entities/maps_data.dart';
import 'package:carousel_slider/carousel_slider.dart';

class InfoWidget extends StatelessWidget {
  final MapsDataEntity entity;
  InfoWidget({Key? key, required this.entity}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("test"),
      ),
      body: Column(
        children: [
          CarouselSlider(
            items: entity.images
                .map((e) => Container(
                        child: Container(
                      margin: EdgeInsets.all(5.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        child: Image.asset(e, fit: BoxFit.cover, width: 1000.0),
                      ),
                    )))
                .toList(),
            options: CarouselOptions(
              autoPlay: true,
              aspectRatio: 2.0,
              enlargeCenterPage: true,
            ),
          ),
          Text(entity.title),
          Text(entity.description)
        ],
      ),
    );
  }
}

/*import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:project_initiative_club_app/features/Maps/domain/entities/maps_data.dart';
import 'package:project_initiative_club_app/features/Maps/presentation/widgets/description_window.dart';

Widget InfoListWidget(
    {required BuildContext context,
    required double screenH,
    required double screenW,
    required List<MapsDataEntity> list}) {
  return Container(
    child: ListView.separated(
      separatorBuilder: (BuildContext context, int index) => const Divider(),
      padding: const EdgeInsets.all(8),
      itemCount: list.length,
      itemBuilder: (BuildContext context, int index) {
        MapsDataEntity currentClass = list[index];

        return ConstrainedBox(
          constraints: BoxConstraints.tightFor(width: screenW / 5),
          child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => DescriptionWindow(
                          title: currentClass.title,
                          description: currentClass.description,
                          images: currentClass.images)),
                );
              },
              child: Text(currentClass.title)),
        );
      },
    ),
  );
}

/*ConstrainedBox(
      constraints:
          BoxConstraints.tightFor(width: screenW, height: screenH / 10),
      child: Column(
        children: [
          TextButton(
            child: Text('Faculté Informatique'),
            onPressed: () {
              //Navigator.of(context).push(route);
            },
          )
        ],
      ));

showAlertDialog(BuildContext context, String title, String description,
    List<String> images) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Column(
            children: [
              Text(description),
              Row(
                children: [
                  Image(
                    image: AssetImage(images[0]),
                  )
                ],
              )
            ],
          ),
        );
      });
}*/*/
