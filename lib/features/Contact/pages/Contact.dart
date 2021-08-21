import 'package:flutter/material.dart';
import 'package:project_initiative_club_app/ressources/globals.dart';

class Contact_page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: 20,
              child: DecoratedBox(
              decoration: BoxDecoration(color: mainColor,borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20) ,bottomRight:Radius.circular(20))),
              ),

            ),
          Container(
              child: Column(
                children: [

                ],
              )),
        ],
    ),
    );
  }
}
