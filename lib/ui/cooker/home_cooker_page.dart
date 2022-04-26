import 'package:flutter/material.dart';
import 'package:governess/consts/colors.dart';
import 'package:governess/consts/size_config.dart';
import 'package:governess/models/other/date_time_from_milliseconds_model.dart';
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
        child: Padding(
          padding: EdgeInsets.all(gW(20.0)),
          child: Column(
            children: [
              // "Bolalar Soni",
              BigElevatedButtonHomePage(
                  title: items[0],
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const CookerShowNumberOfChildrenPage()));
                  }),
              SizedBox(height: gH(20.0)),

              //Kunlik Menu
              BigElevatedButtonHomePage(
                  title: items[1],
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>const  CookerShowDailyMenuPage(),
                      ),
                    );
                  }),
              SizedBox(height: gH(20.0)),

              // "Mahsulotlar"
              BigElevatedButtonHomePage(
                  title: items[2],
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const CookerProductsPage()));
                  }),
            ],
          ),
        ),
      ),
    );
  }

  
   
}
