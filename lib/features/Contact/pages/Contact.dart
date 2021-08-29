//import 'dart:html';

import 'package:flutter/material.dart';
import 'package:project_initiative_club_app/ressources/globals.dart';

class Contact_page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
            SizedBox(height: 100,),
          Container(
            width: 350,
            height: 500,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("images/social.png"),
              ),
            ),
          ),
        /*  Container(
              child: Column(
                children: [
                  SizedBox(height: 30,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                          width: 50,
                          height: 50,
                          child: Image.asset("images/face.png")),
                    ],
                  ),
                  SizedBox(height: 30,),
                  Text("project initiative club",style: TextStyle(color: mainColor,fontSize: 20,fontFamily: 'Roboto Slab'),),
                  SizedBox(height: 30,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                          width: 50,
                          height: 50,
                          child: Image.asset("images/insta.png")),
                    ],
                  ),
                  SizedBox(height: 30,),
                  Text("project.initiative.club",style: TextStyle(color: mainColor,fontSize: 20,fontFamily: 'Roboto Slab'),),
                  SizedBox(height: 30,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                          width: 50,
                          height: 50,
                          child: Image.asset("images/link.png")),
                    ],
                  ),
                  SizedBox(height: 30,),
                  Text("project initiative club",style: TextStyle(color: mainColor,fontSize: 20,fontFamily: 'Roboto Slab'),),
                  SizedBox(height: 30,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                          width: 50,
                          height: 50,
                          child: Image.asset("images/mail.png")),
                    ],
                  ),
                  SizedBox(height: 30,),
                  Text("projectinitiative@gmail.com",style: TextStyle(color: mainColor,fontSize: 20,fontFamily: 'Roboto Slab'),),
                ],
              )),*/
        ],
    ),
    );
  }
}
