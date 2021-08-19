import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:project_initiative_club_app/main_class.dart';
import 'package:project_initiative_club_app/ressources/widgets/main_menu.dart';
import 'package:provider/provider.dart';
import 'package:flutter/foundation.dart';
import 'injections.dart' as serviceLocator;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await serviceLocator.init();

  runApp(HomePage());
}

// TODO optimize the upload and the download
// TODO optimize tracing database
class HomePage extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: ChangeNotifierProvider(
          create: (_) => MainClass(),
          child: MyHomePage(),
        ));
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool error = false;
  bool initialized = false;

  @override
  Widget build(BuildContext context) {
    double screenW = MediaQuery.of(context).size.width;
    double screenH = MediaQuery.of(context).size.height;
    return MainMenu(
      screenH: screenH,
      screenW: screenW,
    );
  }
}
