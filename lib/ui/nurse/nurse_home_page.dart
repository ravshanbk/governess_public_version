import 'package:flutter/material.dart';
import 'package:governess/consts/size_config.dart';
import 'package:governess/consts/strings.dart';
import 'package:governess/providers/nurse/enter_daily_children_page_provider.dart';
import 'package:governess/services/network.dart';
import 'package:governess/ui/nurse/sub_pages/show_menu_daily_page.dart';
import 'package:governess/ui/nurse/sub_pages/show_number_of_children_nurse_page.dart';
import 'package:governess/ui/widgets/big_elevate_button_home_page.dart';
import 'package:governess/ui/widgets/drawer_widget_my.dart';
import 'package:governess/ui/widgets/mtt_info_drawer_widget.dart';
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
      resizeToAvoidBottomInset: false,
      endDrawer: const MttInfoEndDrawer(),
      drawer: const DrawerWidgetMy(),
      appBar: _appBar(),
      body: _body(doings, context),
    );
  }

  Center _body(List<String> doings, BuildContext context) {
    return Center(
      child: ListView.separated(
        padding: EdgeInsets.symmetric(horizontal: gW(20.0), vertical: gH(30.0)),
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

  AppBar _appBar() {
    return AppBar(
      centerTitle: true,
      backgroundColor: mainColor,
      elevation: 0,
      actions: [
        Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.info_outline),
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
