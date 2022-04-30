import 'package:flutter/material.dart';
import 'package:governess/consts/size_config.dart';
import 'package:governess/consts/strings.dart';
import 'package:governess/models/other/date_time_from_milliseconds_model.dart';
import 'package:governess/services/network.dart';
import 'package:governess/ui/cooker/sub_pages/products_page.dart';
import 'package:governess/ui/cooker/sub_pages/show_daily_menu_page.dart';
import 'package:governess/ui/cooker/sub_pages/show_number_of_children_page.dart';
import 'package:governess/ui/widgets/big_elevate_button_home_page.dart';
import 'package:governess/ui/widgets/drawer_widget_my.dart';

class CookerHomePage extends StatelessWidget {
  const CookerHomePage({Key? key}) : super(key: key);
  final List<String> items = const [
    "Bolalar Soni",
    "Kunlik Menyu",
    "Mahsulotlar"
  ];
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      drawer: const DrawerWidgetMy(),

      //  _drawer(),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: mainColor,
        elevation: 0,
        title: Text(
          DTFM.maker(DateTime.now().millisecondsSinceEpoch),
        ),
      ),
      body: Center(
        child: ListView.separated(
          padding:
              EdgeInsets.symmetric(horizontal: gW(20.0), vertical: gW(30.0)),
          itemBuilder: (_, __) {
            return BigElevatedButtonHomePage(
              title: items[__],
              onPressed: () async {
                bool isNet = await checkConnectivity();
                if (isNet) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        switch (__) {
                          case 0:
                            return const CookerShowNumberOfChildrenPage();
                          case 1:
                            return const CookerShowDailyMenuPage();
                          case 2:
                            return const CookerProductsPage();

                          default:
                            return const CookerHomePage();
                        }
                      },
                    ),
                  );
                } else {
                  showNoNetToast(false);
                }
              },
            );
          },
          separatorBuilder: (context, index) {
            return SizedBox(
              height: gH(30.0),
            );
          },
          itemCount: items.length,
        ),
      ),
    );
  }
}
