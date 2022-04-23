import 'package:flutter/material.dart';
import 'package:governess/consts/colors.dart';
import 'package:governess/consts/size_config.dart';
import 'package:governess/local_storage/boxes.dart';
import 'package:governess/models/hive_models/user_h_model.dart';
import 'package:governess/ui/manager/show_daily_menu_page.dart';
import 'package:governess/ui/manager/show_daily_number_of_children_page.dart';
import 'package:governess/ui/widgets/big_elevate_button_home_page.dart';
import 'package:governess/ui/widgets/fake_drawer_widget.dart';
import 'package:governess/ui/widgets/text_span_grey_16_widget.dart';
import 'package:hive_flutter/hive_flutter.dart';

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
      drawer:
   const    FakeDrawerWidget(),
      //  _drawer(),
      appBar: _appBar(),
      body: _body(doings, context),
    );
  }

  _drawer() {
    return ValueListenableBuilder<Box<UserH>>(
        valueListenable: Boxes.getUser().listenable(),
        builder: (context, box, __) {
          // final UserH data = box.getAt(0)!;
          final UserH data = UserH()..fatherName="familya"..id=09..name="Ism"..role="ROLE_OF_USER"..surname="surname"..username="userName"..success=true;

          return  Drawer(
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
        });
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
        style:  TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }
}
