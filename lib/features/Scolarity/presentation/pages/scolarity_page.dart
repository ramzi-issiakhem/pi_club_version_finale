import 'package:flutter/material.dart';
import 'package:project_initiative_club_app/features/Scolarity/presentation/pages/specific_page.dart';
import 'package:project_initiative_club_app/features/Scolarity/presentation/widgets/choice_widgets.dart';

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
  String _chosenValue = "Biologie";

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

    return Column(children: [
      DropDownMenu(),
      Divider(
        height: 50,
        thickness: 10,
      ),
      SpecificScolarityPage(
          value: _chosenValue, screenH: screenH, screenW: screenW)
    ]);
  }
}
