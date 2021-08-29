import 'package:flutter/material.dart';

import '../globals.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
      width: MediaQuery.of(context).size.width,
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 30,
            backgroundImage: AssetImage("images/orange_logo.png"),
          ),
          SizedBox(
            height: 10,
          ),
          SizedBox(
              width: 20,
              height: 20,
              child: Center(
                  child: CircularProgressIndicator(
                backgroundColor: mainColor,
              )))
        ],
      ),
    ));
  }
}
