import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ErrorPage extends StatelessWidget {
  String message;
  ErrorPage({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: Text(message),
        ),
      ),
    );
  }
}
