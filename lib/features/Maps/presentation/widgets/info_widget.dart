import 'package:flutter/material.dart';
import 'package:project_initiative_club_app/features/Maps/domain/entities/maps_data.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:project_initiative_club_app/ressources/globals.dart';

class InfoWidget extends StatelessWidget {
  final MapsDataEntity entity;
  InfoWidget({Key? key, required this.entity}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: mainColor,
      ),
      body: Container(
        color: mainColor,
        child: Column(
          children: [
            Text(entity.title,style: TextStyle(fontSize: 20,color: Colors.white,fontFamily: 'Roboto Slab'),),
            SizedBox(height: 5,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 3,
                  width: 40,
                  decoration: BoxDecoration(
                    color: Colors.white
                  ),
                ),
              ],
            ),
            SizedBox(height: 20,),
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
            Container(
              height: MediaQuery.of(context).size.height*0.565,
              margin: EdgeInsets.only(right: 20,left: 20,top: 20),
              padding: EdgeInsets.only(right: 20,left: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Colors.white
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Text(entity.description,style: TextStyle(fontFamily: 'Roboto Slab',height: 2),textAlign: TextAlign.center,)
                  ],
                ),
              ),
            ),
          ],
        ),
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
