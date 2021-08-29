import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_initiative_club_app/features/Scolarity/presentation/pages/specific_page.dart';
import 'package:project_initiative_club_app/features/Scolarity/presentation/widgets/choice_widgets.dart';
import 'package:project_initiative_club_app/ressources/globals.dart';

/*class ScolarityPage extends StatefulWidget {
  const ScolarityPage({Key? key}) : super(key: key);

  @override
  _ScolarityPageState createState() => _ScolarityPageState();
}

class _ScolarityPageState extends State<ScolarityPage> {
  @override
  Widget build(BuildContext context) {
    return ScolarityChoiceWidget();
  }
}*/

class ScolarityPage extends StatefulWidget {
  ScolarityPage({Key? key}) : super(key: key);
  @override
  _ScolarityPageState createState() => _ScolarityPageState();
}

class _ScolarityPageState extends State<ScolarityPage> {
  String _chosenValue = "Math&Info";

  List<String> items = [
    "Math&Info",
    "ST",
    "Biologie",
    "SM",
  ];

  // ignore: non_constant_identifier_names
  Widget DropDownMenu() {
    return DropdownButton(
      focusColor: Colors.white,
      value: _chosenValue,
      //elevation: 5,
      style: TextStyle(color: Colors.white),
      iconEnabledColor: Colors.black,
      items: items.map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(
            value,
            style: TextStyle(color: Colors.black),
          ),
        );
      }).toList(),
      hint: Text(
        "Please choose a langauage",
        style: TextStyle(
            color: Colors.black, fontSize: 14, fontWeight: FontWeight.w500),
      ),
      onChanged: (String? value) {
        setState(() {
          if (value != null) {
            _chosenValue = value;
          }
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenW = MediaQuery.of(context).size.width;
    double screenH = MediaQuery.of(context).size.height;

    return  Column(children: [
      /*Container(
        width: screenW,
        height: 20,
          child: DecoratedBox(
          decoration: BoxDecoration(color: mainColor,borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20) ,bottomRight:Radius.circular(20))),
        ),
      ),*/
      SizedBox(height: MediaQuery.of(context).size.height*0.04,),
        Container(
          padding: EdgeInsets.all(8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GestureDetector(
                onTap: (){
                  setState(() {
                    _chosenValue="Math&Info";
                  });
                },
                child: Column(
                  children: [
                    CircleAvatar(
                      child: CircleAvatar(
                        radius: 30,
                        backgroundColor: mainColor,
                        backgroundImage: AssetImage("images/mi.jpg"),
                      ),
                      backgroundColor: mainColor,
                      radius:  _chosenValue=="Math&Info" ? 33:30,
                    ),
                    SizedBox(height: 5,),
                    Text("MI",style: TextStyle(fontSize: 15),),
                  ],
                ),
              ),
              GestureDetector(
                onTap: (){
                  setState(() {
                    _chosenValue="ST";
                  });
                },
                child: Column(
                  children: [
                    CircleAvatar(
                      child: CircleAvatar(
                        radius: 30,
                        backgroundColor: mainColor,
                        backgroundImage: AssetImage("images/st.jpg"),
                      ),
                      radius:  _chosenValue=="ST" ? 33:30,
                      backgroundColor: mainColor,
                    ),
                    SizedBox(height: 5,),
                    Text("ST",style: TextStyle(fontSize: 15),),
                  ],
                ),
              ),
              GestureDetector(
                onTap: (){
                  setState(() {
                    _chosenValue="Biologie";
                  });

                },
                child: Column(
                  children: [
                    CircleAvatar(
                      child: CircleAvatar(
                        radius: 30,
                        backgroundColor: mainColor,
                        backgroundImage: AssetImage("images/bio.jpg"),
                      ),
                      radius:  _chosenValue=="Biologie" ? 33:30,
                      backgroundColor: mainColor,
                    ),
                    SizedBox(height: 5,),
                    Text("BIO",style: TextStyle(fontSize: 15),),
                  ],
                ),
              ),
              GestureDetector(
                onTap: (){
                  setState(() {
                    _chosenValue="SM";
                  });
                },
                child: Column(
                  children: [
                    CircleAvatar(
                      child: CircleAvatar(
                        radius: 30,
                        backgroundColor: mainColor,
                        backgroundImage: AssetImage("images/sm.jpg"),
                      ),
                      radius: _chosenValue=="SM" ? 33:30,
                      backgroundColor: mainColor,
                    ),
                    SizedBox(height: 5,),
                    Text("SM",style: TextStyle(fontSize: 15),),
                  ],
                ),
              ),
            ],
          ),
        ),
        //DropDownMenu(),
        /*Divider(
          height: 50,
          thickness: 10,
        ),*/
      SizedBox(height: 0,),

        Container(
          padding: EdgeInsets.all(0),
          child: SpecificScolarityPage(
              value: _chosenValue, screenH: screenH, screenW: screenW),
        )
      ]);
  }
}
