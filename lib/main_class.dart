import 'package:flutter/material.dart';
import 'package:project_initiative_club_app/features/About%20Us/presentation/pages/about_us_page_1.dart';
import 'package:project_initiative_club_app/features/Contact/pages/Contact.dart';
import 'package:project_initiative_club_app/features/Maps/presentation/pages/page_maps.dart';
import 'package:project_initiative_club_app/features/News/presentation/widgets/pi_news.dart';
import 'package:project_initiative_club_app/features/News/presentation/widgets/usthb_news.dart';
import 'package:project_initiative_club_app/features/Scolarity/presentation/pages/scolarity_page.dart';
import 'package:project_initiative_club_app/ressources/globals.dart';

import 'features/News/presentation/pages/news_page.dart';

class MainClass with ChangeNotifier {
  Widget widget = NewsPage();

  void rebuild(String type) {
    var _widget = mapRoutes[type];
    _widget != null ? this.widget = _widget : this.widget = Container();

    notifyListeners();
  }

  int currentTab() {
    if (this.widget is NewsPage) {
      return 0;
    } else if (this.widget is ScolarityPage) {
      return 1;
    } else if (this.widget is MapsPage) {
      return 2;
    } else if (this.widget is Contact_page) {
      return 3;
    } else if (this.widget is AboutUsPageSecondary) {
      return 4;
    } else if (this.widget is UsthbNews) {
      return 10;
    } else if (this.widget is PiNews) {
      return 11;
    }

    return 0;
  }
}
