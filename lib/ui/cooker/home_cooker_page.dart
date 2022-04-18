import 'package:flutter/material.dart';
import 'package:governess/consts/colors.dart';
import 'package:governess/consts/size_config.dart';
import 'package:governess/local_storage/boxes.dart';
import 'package:governess/models/hive_models/user_h_model.dart';
import 'package:governess/models/other/date_time_from_milliseconds_model.dart';
import 'package:governess/ui/cooker/sub_pages/products_page.dart';
import 'package:governess/ui/show_menu_daily_page.dart';
import 'package:governess/ui/show_number_of_children_nurse_page.dart';
import 'package:governess/ui/widgets/big_elevate_button_home_page.dart';
import 'package:governess/ui/widgets/fake_drawer_widget.dart';
import 'package:governess/ui/widgets/text_span_grey_16_widget.dart';
import 'package:hive_flutter/adapters.dart';

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
      drawer:const FakeDrawerWidget(),
      
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
              BigElevatedButtonHomePage(title:items[0], onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            const ShowNumberOfChildrenPage()));
              }),
              SizedBox(height: gH(20.0)),

              BigElevatedButtonHomePage(title:items[1], onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ShowDailyMenuPage()));
              }),
              SizedBox(height: gH(20.0)),

              // "Mahsulotlar"
              BigElevatedButtonHomePage(title:items[2], onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            const CookerProductsPage()));
              }),
            ],
          ),
        ),
      ),
    );
  }

  _drawer() {
    return ValueListenableBuilder<Box<UserH>>(
        valueListenable: Boxes.getUser().listenable(),
        builder: (context, box, __) {
          return box.isEmpty
              ? const Drawer(
                  child: Center(
                    child: Text("Malumotlar mavjud emas"),
                  ),
                )
              : _drawerrrrrr(box);
        });
  }

  Drawer _drawerrrrrr(Box<UserH> box) {
    final UserH data = box.values.toList().cast<UserH>()[0];

    return Drawer(
      child: Padding(
        padding: EdgeInsets.only(top: gH(50.0), left: gW(20.0)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Shaxsiy Malumotlar",
              style: TextStyle(
                fontSize: gW(20.0),
              ),
            ),
            Divider(thickness: gW(2.0)),
            SizedBox(height: gH(20.0)),
            _richText("Tahallus: ", data.username),
            SizedBox(height: gH(20.0)),
            _richText("Ism: ", data.name),
            SizedBox(height: gH(20.0)),
            _richText("Familya: ", data.surname),
            SizedBox(height: gH(20.0)),
            _richText("Lavozimi: ", data.role),
          ],
        ),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.horizontal(
          right: Radius.circular(
            gW(20.0),
          ),
        ),
      ),
    );
  }

  RichText _richText(String text1, String text2) {
    return RichText(
      textAlign: TextAlign.start,
      text: TextSpan(
        children: [
          textSpanGrey16Widget(text1),
          textSpan18black(text2),
        ],
      ),
    );
  }
}
