import 'package:flutter/material.dart';
import 'package:governess/consts/decorations.dart';
import 'package:governess/consts/size_config.dart';
import 'package:governess/consts/strings.dart';
import 'package:governess/local_storage/boxes.dart';
import 'package:governess/local_storage/user_storage.dart';
import 'package:governess/models/user/change_user_info.dart';
import 'package:governess/services/auth_service.dart';
import 'package:governess/ui/auth/auth_page.dart';
import 'package:governess/ui/widgets/send_button_widger.dart.dart';

class ChangePasswordPage extends StatelessWidget {
  ChangePasswordPage({Key? key}) : super(key: key);

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController loginController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController retwritePasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: mainColor,
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Ink(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  gW(5.0),
                ),
                color: Colors.white,
              ),
              padding: const EdgeInsets.all(5.0),
              child: SendButtonWidget(
                width: gW(200.0),
                onPressed: () {
                  AuthService()
                      .changeLoginPassword(
                    info: ChangUserInfo(
                      newPassword: retwritePasswordController.text,
                      oldPassword: passwordController.text,
                      username: loginController.text,
                    ),
                  )
                      .then(
                    (value) async {
                      if (value.success!) {
                        await UserHive().logOutUser();
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const AuthPage(),
                            ),
                            (route) => false);

                        showToast(value.text!, value.success!, false);
                      } else {
                        Navigator.pop(context);
                        showToast(value.text!, value.success!, false);
                      }
                    },
                  );
                },
                titleOfButton: "O'zgartirish",
              ),
            ),
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(gW(20.0)),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Loginingizni Kiriting",
                style: TextStyle(
                  color: mainColor,
                  fontSize: gW(18.0),
                ),
              ),
              SizedBox(
                height: gH(10.0),
              ),
              TextFormField(
                validator: (v) {
                  if (v!.isEmpty) return "Login kiriting";
                  return null;
                },
                controller: loginController,
                decoration: DecorationMy.inputDecoration("Login...", null),
              ),
              SizedBox(
                height: gH(10.0),
              ),
              Text(
                "Joriy parolingizni kiriting",
                style: TextStyle(
                  color: mainColor,
                  fontSize: gW(18.0),
                ),
              ),
              SizedBox(
                height: gH(10.0),
              ),
              TextFormField(
                validator: (v) {
                  if (v!.isEmpty) return "Parol kiriting";
                  return null;
                },
                controller: passwordController,
                decoration:
                    DecorationMy.inputDecoration("Joriy Parolingiz", null),
              ),
              SizedBox(
                height: gH(10.0),
              ),
              Text(
                "Yangi parolingizni kiriting",
                style: TextStyle(
                  color: mainColor,
                  fontSize: gW(18.0),
                ),
              ),
              SizedBox(
                height: gH(10.0),
              ),
              TextFormField(
                validator: (v) {
                  if (v!.isEmpty) return "Parol kiriting";
                  return null;
                },
                controller: retwritePasswordController,
                decoration:
                    DecorationMy.inputDecoration("Yangi Parolingiz", null),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
