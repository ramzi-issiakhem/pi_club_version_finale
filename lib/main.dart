//import 'dart:html';
import 'package:project_initiative_club_app/features/About%20Us/presentation/pages/about_us_page.dart';
import 'package:project_initiative_club_app/main_class.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:project_initiative_club_app/main_class.dart';
import 'package:project_initiative_club_app/ressources/globals.dart';
import 'package:project_initiative_club_app/ressources/widgets/main_menu.dart';
import 'package:provider/provider.dart';
import 'package:flutter/foundation.dart';
import 'injections.dart' as serviceLocator;
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:project_initiative_club_app/features/About%20Us/presentation/pages/about_us_page_1.dart';
import 'package:project_initiative_club_app/features/Maps/domain/entities/maps_data.dart';
import 'package:project_initiative_club_app/features/Maps/presentation/pages/page_maps.dart';
import 'package:project_initiative_club_app/features/News/presentation/pages/add_news_page.dart';
import 'package:project_initiative_club_app/features/News/presentation/pages/news_page.dart';
import 'package:project_initiative_club_app/features/News/presentation/widgets/pi_news.dart';
import 'package:project_initiative_club_app/features/News/presentation/widgets/usthb_news.dart';
import 'package:project_initiative_club_app/features/Scolarity/presentation/pages/scolarity_page.dart';
import 'package:project_initiative_club_app/main_class.dart';

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
  int currentab=0;
  Widget currentscreen=ScolarityPage();
 final PageStorageBucket bucket = PageStorageBucket();
  String text="News";
  String gettext(){
    switch(currentab){
      case 0: return"News";
      break;
      case 1: return"Scolarité";
        break;
      case 2: return"Map";
        break;
      case 3: return"Contact";
        break;
      default: return "";
    }
  }
  List<Widget> screens=[
    NewsPage(),
    ScolarityPage(),
    MapsPage(),
    Container(),
  ];
  @override
  Widget build(BuildContext context) {
    double screenW = MediaQuery.of(context).size.width;
    double screenH = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: mainColor,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(gettext(),style: TextStyle(fontSize: 35),textAlign: TextAlign.center,),
          ],
        ),
      ),
      body: PageStorage(bucket: bucket, child: screens[currentab]),
      floatingActionButton: FloatingActionButton(
        backgroundColor: mainColor,
        child: Container(decoration: BoxDecoration(image: DecorationImage(image: AssetImage("images/logowhite.png"))),),
        onPressed: (){
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
            children: <Widget> [
              Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MaterialButton(
                      minWidth: 20,
                      onPressed:(){
                        setState(() {
                          mainClass.rebuild("news");
                          currentab=0;
                        });
                      } ,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.article,color: currentab==0 ? mainColor:Colors.grey,),
                        Text("News",style: TextStyle(color:  currentab==0 ? mainColor:Colors.grey,),)

                      ],
                    ),
                  ),
                  MaterialButton(
                    minWidth: 20,
                    onPressed:(){
                      setState(() {
                        mainClass.rebuild("scolarity");
                        currentab=1;
                      });
                    } ,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.school_outlined,color: currentab==1 ? mainColor:Colors.grey,),
                        Text("Scolarité",style: TextStyle(color:  currentab==1 ? mainColor:Colors.grey,),)

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
                    onPressed:(){
                      setState(() {
                        mainClass.rebuild("map");
                        currentab=2;
                      });
                    } ,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.map_outlined,color: currentab==2 ? mainColor:Colors.grey,),
                        Text("maps",style: TextStyle(color:  currentab==2 ? mainColor:Colors.grey,),)

                      ],
                    ),
                  ),
                  MaterialButton(
                    minWidth: 20,
                    onPressed:(){
                      setState(() {
                        currentscreen=MapsPage();
                        currentab=3;
                      });
                    } ,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.contact_support_outlined,color: currentab==3 ? mainColor:Colors.grey,),
                        Text("Contact",style: TextStyle(color:  currentab==3 ? mainColor:Colors.grey,),)

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



// @override
//Widget build(BuildContext context) {
//  double screenW = MediaQuery.of(context).size.width;
 // double screenH = MediaQuery.of(context).size.height;
 // return Container(
  //  child: Column(
    //  children: [
  //      MainMenu(
 //         screenH: screenH,
 //         screenW: screenW,
  //      ),
  //      BottomNavigationBar(items: )
  //    ],
  //  ),
 // );
//}
//}