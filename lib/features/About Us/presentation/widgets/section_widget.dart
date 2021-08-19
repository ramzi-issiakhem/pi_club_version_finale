import 'package:flutter/material.dart';

Widget sectionWidget(
    {required String title,
    required String description,
    required String image,
    required double screenH,
    required double screenW,
    required bool right}) {
  double heightImage = screenH / 3.2;
  double widthImage = screenW / 2.5;
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 8.0),
    child: right
        ? Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(mainAxisAlignment: MainAxisAlignment.start, children: [
                Text(title),
                Text(
                  description,
                  textAlign: TextAlign.center,
                ),
              ]),
              Image(
                image: AssetImage(image),
                width: widthImage,
                height: heightImage,
              )
            ],
          )
        : Row(children: [
            Image(
              image: AssetImage(image),
              width: widthImage,
              height: heightImage,
            ),
            Column(mainAxisAlignment: MainAxisAlignment.start, children: [
              Text(title),
              Text(
                description,
                textAlign: TextAlign.center,
              ),
            ]),
          ]),
  );
}
