import 'package:flutter/material.dart';
import 'package:governess/consts/colors.dart';
import 'package:governess/consts/size_config.dart';
import 'package:governess/ui/manager/show_daily_menu_page.dart';
import 'package:governess/ui/manager/show_daily_number_of_children_page.dart';
import 'package:governess/ui/widgets/big_elevate_button_home_page.dart';
import 'package:governess/ui/widgets/drawer_widget_my.dart';

class ManagerHomePage extends StatelessWidget {
  const ManagerHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    List<String> doings = [
      "Kunlik menyuni ko'rish",
      "Bolalar Soni",
    ];

    return Scaffold(
      drawer: const DrawerWidgetMy(),
      appBar: _appBar(),
      body: _body(doings, context),
    );
  }

  Center _body(List<String> doings, BuildContext context) {
    return Center(
      child: ListView.separated(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: gW(30.0), vertical: gH(30.0)),
        separatorBuilder: (context, index) {
          return SizedBox(height: gH(30.0));
        },
        itemCount: doings.length,
        itemBuilder: (_, __) {
          return BigElevatedButtonHomePage(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    switch (__) {
                      case 0:
                        return const ManagerShowDailyMenuPage();
                      case 1:
                        return const ManagerShowNumberOfChildrenPage();

                      default:
                        return const ManagerHomePage();
                    }
                  },
                ),
              );
            },
            title: doings[__],
          );
        },
      ),
    );
  }

  AppBar _appBar() {
    return AppBar(
      centerTitle: true,
      backgroundColor: mainColor,
      elevation: 0,
      title: const Text(
        "Mudira home page",
        style: TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }
}
