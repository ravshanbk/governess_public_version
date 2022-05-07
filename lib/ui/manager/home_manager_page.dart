import 'package:flutter/material.dart';
import 'package:governess/consts/size_config.dart';
import 'package:governess/consts/strings.dart';
import 'package:governess/services/network.dart';
import 'package:governess/ui/manager/show_daily_menu_page.dart';
import 'package:governess/ui/manager/show_daily_number_of_children_page.dart';
import 'package:governess/ui/widgets/big_elevate_button_home_page.dart';
import 'package:governess/ui/widgets/drawer_widget_my.dart';
import 'package:governess/ui/widgets/mtt_info_drawer_widget.dart';

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
            endDrawer: const MttInfoEndDrawer() ,
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
            onPressed: () async {
              bool isNet = await checkConnectivity();
              if (isNet) {
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
              } else {
                showNoNetToast(false);
              }
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
      actions: [
        Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () async {
                final isNet = await checkConnectivity();
                if (isNet) {
                  Scaffold.of(context).openEndDrawer();
                } else {
                  showNoNetToast(false);
                }
              },
            tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
          ),
        ),
      ],
    );
  }
}
