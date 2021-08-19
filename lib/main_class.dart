import 'package:flutter/material.dart';
import 'package:project_initiative_club_app/ressources/globals.dart';

import 'features/News/presentation/pages/news_page.dart';

class MainClass with ChangeNotifier {
  Widget widget = NewsPage();

  void rebuild(String type) {
    var _widget = mapRoutes[type];
    print("test " + _widget.toString());
    _widget != null ? this.widget = _widget : this.widget = Container();

    notifyListeners();
  }
}
