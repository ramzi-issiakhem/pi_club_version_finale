import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

Widget carouselWidget(List<String> imagesPath, double screenH, double screenW) {
  return CarouselSlider(
    items: imagesPath
        .map((path) => Container(
                child: Container(
              margin: EdgeInsets.all(5.0),
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                child: Image.asset(path, fit: BoxFit.fill),
              ),
            )))
        .toList(),
    options: CarouselOptions(
      autoPlay: true,
      aspectRatio: 4 / 3,
      enlargeCenterPage: true,
    ),
  );
}
