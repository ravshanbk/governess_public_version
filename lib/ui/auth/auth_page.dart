import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:governess/consts/decorations.dart';
import 'package:governess/consts/size_config.dart';
import 'package:governess/consts/strings.dart';
import 'package:governess/local_storage/user_storage.dart';
import 'package:governess/providers/auth/pin_code_page_provider.dart';
import 'package:governess/services/auth_service.dart';
import 'package:governess/services/network.dart';
import 'package:governess/ui/auth/pin_code_page.dart';
import 'package:governess/ui/widgets/governess_app_bar.dart';
import 'package:provider/provider.dart';


class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool isInProgress = false;

  final GlobalKey<FormState> formKey = GlobalKey();

  final TextEditingController loginController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {



    SizeConfig().init(context);
    return Scaffold(
      appBar: governessAppBar,
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Column(
          children: [
            Form(
              key: formKey,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: gW(20.0),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                  SizedBox(
                          height: gH(50.0),
                          child: isInProgress
                              ?   Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        CupertinoActivityIndicator(
                                  radius: gW(20.0),
                                ),
                              
                       
                     ElevatedButton(
                       style: ElevatedButton.styleFrom(primary: mainColor,side: BorderSide(color: mainColor)),
                       onPressed:  () {
                          isInProgress = false;
                        setState(() {
                          
                        },);}, child:  Text("Bekor qilish",style: TextStyle(color: whiteColor),))
                      ],
                    ):const SizedBox(),),
                    _loginInput(context),
                    SizedBox(height: gH(20.0)),
                    _passwordInput(context),
                    SizedBox(height: gH(20.0)),
                    _submitButton(context),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  ElevatedButton _submitButton(BuildContext context) {
    return ElevatedButton(
      onPressed: isInProgress
          ? null
          : () async {
              bool isInternet = await checkConnectivity();
              if (isInternet) {
                setState(() {
                  isInProgress = true;
                });
                if (loginController.text.isNotEmpty &&
                    passwordController.text.isNotEmpty) {
                  AuthService()
                      .getUser(loginController.text.trim(), passwordController.text.trim())
                      .then(
                    (value) async {
                      if (value.success) {
                        await UserHive().addUser(
                          id: value.user.id,
                          fatherName: value.user.fatherName,
                          name: value.user.name,
                          role: value.user.role,
                          success: value.user.success,
                          surname: value.user.surname,
                          token: value.user.token,
                          username: value.user.username,
                        );

                        
                        showToast("Muvaffaqiyat !!!", true, false);

                        isInProgress = false;
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const PinCodePage(),
                            ),
                            (route) => false);
                      } else {
                        isInProgress = false;
                        showToast(value.text!, false, false);
                        setState(() {});
                      }
                    },
                  );
                }
              } else {
                showNoNetToast(false);
              }
            },
      style: _elevatedButtonStyle(),
      child: const Text("Kirish"),
    );
  }

  TextFormField _passwordInput(BuildContext context) {
    return TextFormField(
      onChanged: (v) {
        if (v.isEmpty && isInProgress) {
          isInProgress = false;
        }
      },
      validator: (v) {
        if (v!.isEmpty) return "Parolni kiriting !!!";
        return null;
      },
      controller: passwordController,
      decoration: DecorationMy.inputDecoration("Parol...", null),
    );
  }

  TextFormField _loginInput(BuildContext context) {
    return TextFormField(
      onChanged: (v) {
        if (v.isEmpty && isInProgress) {
          isInProgress = false;
        }
      },
      validator: (v) {
        if (v!.isEmpty) return "Loginni kiriting !!!";
        return null;
      },
      controller: loginController,
      decoration: DecorationMy.inputDecoration("Login...", null),
    );
  }

  _elevatedButtonStyle() {
    return ElevatedButton.styleFrom(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          gW(20.0),
        ),
      ),
      primary: mainColor,
      elevation: 0,
      fixedSize: Size(
        gW(200.0),
        gH(50.0),
      ),
    );
  }
}
