//import 'dart:html';
import 'package:project_initiative_club_app/features/Contact/pages/Contact.dart';
import 'package:project_initiative_club_app/main_class.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:project_initiative_club_app/ressources/globals.dart';
import 'package:provider/provider.dart';
import 'package:flutter/foundation.dart';
import 'injections.dart' as serviceLocator;
import 'package:project_initiative_club_app/features/About%20Us/presentation/pages/about_us_page_1.dart';
import 'package:project_initiative_club_app/features/Maps/presentation/pages/page_maps.dart';
import 'package:project_initiative_club_app/features/News/presentation/pages/news_page.dart';
import 'package:project_initiative_club_app/features/Scolarity/presentation/pages/scolarity_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await serviceLocator.init();

  runApp(HomePage());
}

// TODO optimize the upload and the download
// TODO optimize tracing database
class HomePage extends StatelessWidget {
  String type = "null";
  HomePage({this.type = "null"});
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
          child: MyHomePage(type: this.type),
        ));
  }
}

class MyHomePage extends StatefulWidget {
  String type = "null";
  MyHomePage({Key? key, this.type = "null"}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

@override
class _MyHomePageState extends State<MyHomePage> {
  bool error = false;
  bool initialized = false;
  int currentab = 0;
  final PageStorageBucket bucket = PageStorageBucket();
  String text = "News";

  String gettext() {
    switch (currentab) {
      case 0:
        return "News";
        break;
      case 1:
        return "Scolarité";
        break;
      case 2:
        return "Map";
        break;
      case 3:
        return "Contact";
        break;
      default:
        return "";
    }
  }

  List<Widget> screens = [
    NewsPage(),
    ScolarityPage(),
    MapsPage(fromHome: true),
    Contact_page(),
  ];

  @override
  Widget build(BuildContext context) {
    print("type2 " + widget.type);

    currentab = mainClass.currentTab();

    Widget returnedWidget = Container(
      child: Text("center"),
    );
    if (widget.type == "usthbnews") {
      returnedWidget = NewsPage(isPiNews: false);
    } else if (widget.type == "pinews") {
      returnedWidget = NewsPage(isPiNews: true);
    } else if (currentab == 10) {
      returnedWidget = NewsPage(
        isPiNews: false,
      );
    } else if (currentab == 11) {
      returnedWidget = NewsPage(
        isPiNews: true,
      );
    } else {
      returnedWidget = screens[currentab];
    }
    print("widget1 " + returnedWidget.toString());
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(currentab == 2 ? 50 : 40.0),
        child: AppBar(
          elevation: 0,
          backgroundColor: currentab == 2 ? mainColor : Colors.white12,
          title: Column(
            children: [
              SizedBox(
                height: currentab == 2 ? 0 : 15,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    gettext(),
                    style: TextStyle(
                        fontSize: 35,
                        color: currentab == 2 ? Colors.white : mainColor),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      body: PageStorage(bucket: bucket, child: returnedWidget),
      floatingActionButton: FloatingActionButton(
        backgroundColor: mainColor,
        child: Container(
          decoration: BoxDecoration(
              image:
                  DecorationImage(image: AssetImage("images/logowhite.png"))),
        ),
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (BuildContext context) => AboutUsPageSecondary()));
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 10,
        child: Container(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MaterialButton(
                    minWidth: 20,
                    onPressed: () {
                      setState(() {
                        mainClass.rebuild("news");
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.article,
                          color: currentab == 0 ? mainColor : Colors.grey,
                        ),
                        Text(
                          "News",
                          style: TextStyle(
                            color: currentab == 0 ? mainColor : Colors.grey,
                          ),
                        )
                      ],
                    ),
                  ),
                  MaterialButton(
                    minWidth: 20,
                    onPressed: () {
                      setState(() {
                        mainClass.rebuild("scolarity");
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.school_outlined,
                          color: currentab == 1 ? mainColor : Colors.grey,
                        ),
                        Text(
                          "Scolarité",
                          style: TextStyle(
                            color: currentab == 1 ? mainColor : Colors.grey,
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(width: 10),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MaterialButton(
                    minWidth: 20,
                    onPressed: () {
                      setState(() {
                        mainClass.rebuild("map");
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.map_outlined,
                          color: currentab == 2 ? mainColor : Colors.grey,
                        ),
                        Text(
                          "maps",
                          style: TextStyle(
                            color: currentab == 2 ? mainColor : Colors.grey,
                          ),
                        )
                      ],
                    ),
                  ),
                  MaterialButton(
                    minWidth: 20,
                    onPressed: () {
                      setState(() {
                        mainClass.rebuild("contact");
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.contact_support_outlined,
                          color: currentab == 3 ? mainColor : Colors.grey,
                        ),
                        Text(
                          "Contact",
                          style: TextStyle(
                            color: currentab == 3 ? mainColor : Colors.grey,
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
