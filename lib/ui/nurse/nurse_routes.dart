import 'package:flutter/material.dart';
import 'package:governess/models/nurse_models/number_of_children_model.dart';
import 'package:governess/providers/nurse/enter_daily_children_page_provider.dart';
import 'package:governess/ui/nurse/nurse_home_page.dart';
import 'package:governess/ui/nurse/sub_pages/camera_page.dart';
import 'package:governess/ui/nurse/sub_pages/edit_daily_childred_page.dart';
import 'package:governess/ui/nurse/sub_pages/enter_daily_children_page.dart';
import 'package:governess/ui/nurse/sub_pages/show_menu_daily_page.dart';
import 'package:governess/ui/nurse/sub_pages/show_number_of_children_nurse_page.dart';

class RouteManager {
  static generaRouter(RouteSettings settings) {
    // ignore: unused_local_variable
    var args = settings.arguments;
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const NurseHomePage());
      case "/children":
        return MaterialPageRoute(builder: (_) =>  NurseShowNumberOfChildrenPage());
      case "/menu":
        return MaterialPageRoute(builder: (_) => const NurseShowDailyMenuPage());

      case "/camera":
        return MaterialPageRoute(builder: (_) => const CameraPage());
      case "/edit":
        return MaterialPageRoute(builder: (_) => NurseEditDailyChildrenPage(NumberOfChildren()));

      case "/enter":
        return MaterialPageRoute(builder: (_) => NurseEnterDailyChildrenPage(kGId: 34,));
     
    }
  }
}
