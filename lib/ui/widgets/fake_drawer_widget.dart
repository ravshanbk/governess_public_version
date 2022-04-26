import 'package:flutter/material.dart';
import 'package:governess/consts/colors.dart';
import 'package:governess/consts/size_config.dart';
import 'package:governess/local_storage/boxes.dart';
import 'package:governess/local_storage/user_storage.dart';
import 'package:governess/models/hive_models/user_h_model.dart';
import 'package:governess/ui/auth/auth_page.dart';
import 'package:governess/ui/auth/change_password_page.dart';
import 'package:governess/ui/widgets/text_span_grey_16_widget.dart';
import 'package:hive_flutter/hive_flutter.dart';

class FakeDrawerWidget extends StatelessWidget {
  const FakeDrawerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Box<UserH>>(
        valueListenable: Boxes.getUser().listenable(),
        builder: (context, box, __) {
          return box.isEmpty
              ? const Drawer(
                  child: Center(
                    child: Text("Malumotlar mavjud emas"),
                  ),
                )
              : _drawerrrrrr(box, context);
        });
  }

  Drawer _drawerrrrrr(Box<UserH> box, BuildContext context) {
    final UserH data = box.values.toList().cast<UserH>()[0];

    return Drawer(
      child: Padding(
        padding:
            EdgeInsets.only(top: gH(50.0), left: gW(20.0), right: gW(20.0)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Shaxsiy Malumotlar",
              style: TextStyle(
                color: mainColor,
                fontSize: gW(20.0),
              ),
            ),
            Divider(
              thickness: gW(2.0),
              color: mainColor,
            ),
            SizedBox(height: gH(20.0)),
            _richText("Tahallus: ", data.username),
            SizedBox(height: gH(20.0)),
            _richText("Ism: ", data.name),
            SizedBox(height: gH(20.0)),
            _richText("Familya: ", data.surname),
            SizedBox(height: gH(20.0)),
            _richText("Lavozimi: ", data.role),
            SizedBox(height: gH(50.0)),
            _exitButton(
              title: "Tizimdan Chiqish",
              context: context,
              icon: Icons.logout_outlined,
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return const _ShowDialogDateContent(false);
                    });
              },
            ),
            SizedBox(height: gH(20.0)),
            _exitButton(
                title: "Pinkodni O'zgartirish",
                context: context,
                icon: Icons.replay_outlined,
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return const _ShowDialogDateContent(true);
                      });
                }),
            SizedBox(height: gH(20.0)),
            _exitButton(
                title: "Pinkod O'zgartirish",
                context: context,
                icon: Icons.change_circle_outlined,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ChangePasswordPage(),
                    ),
                  );
                }),
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

  ElevatedButton _exitButton(
      {required String title,
      required BuildContext context,
      required IconData icon,
      required VoidCallback onPressed}) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          side: BorderSide(color: mainColor),
          borderRadius: BorderRadius.circular(
            gW(
              25.0,
            ),
          ),
        ),
        primary: mainColor_02,
        elevation: 0,
        shadowColor: whiteColor,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(color: mainColor),
          ),
          Icon(
            icon,
            color: mainColor,
          )
        ],
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

class _ShowDialogDateContent extends StatelessWidget {
  final bool isPin;
  const _ShowDialogDateContent(this.isPin,{
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Container(
        padding: EdgeInsets.all(gW(20.0)),
        margin: EdgeInsets.only(
          top: gH(50.0),
          left: gW(10.0),
          right: gW(10.0),
          bottom: gH(350.0),
        ),
        decoration: BoxDecoration(
          color: whiteColor,
          border: Border.all(color: greyColor),
          borderRadius: BorderRadius.circular(
            gW(10.0),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              isPin? "Pinkodingizni o'zgartirmoqchimisiz?":"Rostdan ham chiqishni  xohlaysizmi?",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: mainColor,
                fontSize: gW(25.0),
              ),
            ),
            Text(
             isPin?"Pinkodni o'zgartirish uchun tizimga qaytadan kirishingizga to'gri keladi": "Chiqqaningizdan keyin qayta ro'yxatdan o'tishingiz kerak bo'ladi",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.red,
                fontSize: gW(25.0),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  height: gH(40.0),
                  width: gW(150.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          color: mainColor,
                        ),
                        borderRadius: BorderRadius.circular(
                          gW(15.0),
                        ),
                      ),
                      primary: mainColor_02,
                      elevation: 0,
                      shadowColor: Colors.transparent,
                    ),
                    child: Text("Yo'q...", style: TextStyle(color: mainColor)),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                SizedBox(
                  height: gH(40.0),
                  width: gW(150.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          color: mainColor,
                        ),
                        borderRadius: BorderRadius.circular(
                          gW(15.0),
                        ),
                      ),
                      primary: Colors.red.withOpacity(.15),
                      elevation: 0,
                      shadowColor: Colors.transparent,
                    ),
                    child: Text(
                      "Ha...",
                      style: TextStyle(color: mainColor),
                    ),
                    onPressed: () {
                      UserHive().logOutUser();
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const AuthPage()),
                          (route) => false);
                    },
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
