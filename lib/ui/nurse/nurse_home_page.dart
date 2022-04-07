import 'package:flutter/material.dart';
import 'package:governess/consts/colors.dart';
import 'package:governess/consts/size_config.dart';
import 'package:governess/local_storage/boxes.dart';
import 'package:governess/models/hive_models/user_h_model.dart';
import 'package:governess/ui/nurse/sub_pages/daiyly_menyu_page.dart';
import 'package:governess/ui/nurse/sub_pages/number_of_children_page.dart';
import 'package:governess/ui/widgets/unicorn_outline_button_widget.dart';
import 'package:hive_flutter/hive_flutter.dart';

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
      drawer: _drawer(),
      appBar: _appBar(),
      body: _body(doings, context),
    );
  }

  _drawer() {
    return ValueListenableBuilder<Box<UserH>>(
        valueListenable: Boxes.getUser().listenable(),
        builder: (context, box, __) {
          final UserH data = box.values.toList().cast<UserH>()[0];

          return data.box!.isEmpty
              ? const Text("Malumotlar mavjud emas")
              : Drawer(
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
          _textSpan16grey(text1),
          _textSpan18black(text2),
        ],
      ),
    );
  }

  TextSpan _textSpan16grey(text) {
    return TextSpan(
      text: text,
      style: TextStyle(
        color: greyColor,
        fontSize: gW(16.0),
      ),
    );
  }

  TextSpan _textSpan18black(text) {
    return TextSpan(
      text: text,
      style: TextStyle(
        color: Colors.black,
        fontSize: gW(18.0),
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
          return UnicornOutlineButton(
            strokeWidth: 10,
            radius: 100.0,
            gradient: LinearGradient(colors: [
              mainColor,
              mainColor,
              mainColor,
              whiteColor,
              mainColor,
              mainColor,
              mainColor,
              mainColor,
              mainColor,
              mainColor,
              mainColor,
              mainColor,
              mainColor,
              mainColor,
              mainColor,
              mainColor,
              mainColor,
              mainColor,
              mainColor,
              mainColor,
              mainColor,
              mainColor,
              mainColor,
              mainColor,
              mainColor,
              mainColor,
              mainColor,
              mainColor,
              mainColor,
              mainColor,
              mainColor,
              mainColor,
              mainColor,
              mainColor,
              mainColor,
              mainColor,
              mainColor,
              mainColor,
              mainColor,
              mainColor,
              mainColor,
              mainColor,
              mainColor,
              mainColor,
              whiteColor,
              mainColor,
              mainColor,
              mainColor,
            ]),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    switch (__) {
                      case 0:
                        return const DailyMenuPage();
                      case 1:
                        return const NumberOfChildrenPage();

                      default:
                        return const NurseHomePage();
                    }
                  },
                ),
              );
            },
            child: Text(
              doings[__],
              textAlign: TextAlign.center,
              style: TextStyle(
                color: mainColor,
                fontSize: gW(22.0),
              ),
            ),
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
        "Hamshira Ismi",
        style: TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }
}
