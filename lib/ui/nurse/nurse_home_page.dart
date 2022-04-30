import 'package:flutter/material.dart';
import 'package:governess/consts/colors.dart';
import 'package:governess/consts/size_config.dart';
import 'package:governess/consts/strings.dart';
import 'package:governess/providers/nurse/enter_daily_children_page_provider.dart';
import 'package:governess/services/network.dart';
import 'package:governess/ui/nurse/sub_pages/show_menu_daily_page.dart';
import 'package:governess/ui/nurse/sub_pages/show_number_of_children_nurse_page.dart';
import 'package:governess/ui/widgets/big_elevate_button_home_page.dart';
import 'package:governess/ui/widgets/drawer_widget_my.dart';
import 'package:governess/ui/widgets/show_toast_function.dart';
import 'package:provider/provider.dart';

class NurseHomePage extends StatelessWidget {
  const NurseHomePage({Key? key}) : super(key: key);

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
        itemBuilder: (_, __) {
          return BigElevatedButtonHomePage(
              onPressed: () async {
                bool isEnabledInternet = await checkConnectivity();
                if (isEnabledInternet) {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    switch (__) {
                      case 0:
                        return const NurseShowDailyMenuPage();
                      case 1:
                        return const NurseShowNumberOfChildrenPage();

                      default:
                        return const NurseHomePage();
                    }
                  })).then((value) {
                    Provider.of<NurseEnterChildrenNumberPageProvider>(context,
                            listen: false)
                        .changeWhen(DateTime.now());
                  });
                } else {
                  showNoNetToast(false);
                }
              },
              title: doings[__]);
        },
        separatorBuilder: (context, index) {
          return SizedBox(
            height: gH(30.0),
          );
        },
        itemCount: doings.length,
      ),
    );
  }

  Ink _button(bool isLeft, VoidCallback onPressed) {
    //!
    return Ink(
      height: gW(60.0),
      width: gW(128.0),
      decoration: BoxDecoration(
        color: mainColor,
        borderRadius: BorderRadius.only(
          bottomLeft: isLeft
              ? Radius.circular(
                  gW(60.0),
                )
              : _miniRadius(),
          bottomRight: !isLeft
              ? Radius.circular(
                  gW(60.0),
                )
              : _miniRadius(),
          topLeft: _miniRadius(),
          topRight: _miniRadius(),
        ),
      ),
      child: TextButton(
        onPressed: onPressed,
        child: Text(
          isLeft ? "Ko'rish" : "Kirish",
          style: TextStyle(color: whiteColor, fontSize: gW(20.0)),
        ),
      ),
    );
  }

  Radius _miniRadius() => Radius.circular(
        gW(4.0),
      );

  AppBar _appBar() {
    return AppBar(
      centerTitle: true,
      backgroundColor: mainColor,
      elevation: 0,
      // title: const Text(
      //   "Hamshira Ismi",
      //   style: TextStyle(
      //     color: Colors.white,
      //   ),
      // ),
    );
  }
}
