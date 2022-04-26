import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:governess/consts/colors.dart';
import 'package:governess/consts/decorations.dart';
import 'package:governess/consts/print_my.dart';
import 'package:governess/consts/size_config.dart';
import 'package:governess/providers/auth/auth_page_provider.dart';
import 'package:governess/services/auth_service.dart';
import 'package:governess/ui/auth/pin_code_page.dart';
import 'package:governess/ui/widgets/governess_app_bar.dart';
import 'package:governess/ui/widgets/show_toast_function.dart';
import 'package:provider/provider.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({Key? key}) : super(key: key);

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
              key: context.read<AuthPageProvider>().formKey,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: gW(20.0),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: gH(50.0),
                      child: context.watch<AuthPageProvider>().isInProgress
                          ? CupertinoActivityIndicator(
                              radius: gW(20.0),
                            )
                          : const Text(""),
                    ),
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
      onPressed: context.watch<AuthPageProvider>().isInProgress
          ? null
          : () async {
              if (Provider.of<AuthPageProvider>(context, listen: false)
                  .formKey
                  .currentState!
                  .validate()) {
                Provider.of<AuthPageProvider>(context, listen: false)
                    .changeIsInProgress(true);

                AuthService()
                    .getUser(
                        Provider.of<AuthPageProvider>(context, listen: false)
                            .loginController
                            .text,
                        Provider.of<AuthPageProvider>(context, listen: false)
                            .passwordController
                            .text)
                    .then(
                  (value) {
                    if (value) {
                      showToast("Muvaffaqiyat !!!", true, false);

                      Provider.of<AuthPageProvider>(context, listen: false)
                          .changeIsInProgress(false);
                      Provider.of<AuthPageProvider>(context, listen: false)
                          .clear();
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const PinCodePage(),
                          ),
                          (route) => false);
                    } else {
                      showToast("Nimadir hato bo'ldi", false, false);
                    }
                  },
                );
              }
            },
      style: _elevatedButtonStyle(),
      child: const Text("Kirish"),
    );
  }

  TextFormField _passwordInput(BuildContext context) {
    return TextFormField(
      onChanged: (v) {
        p(v);
        if (v.isEmpty &&
            Provider.of<AuthPageProvider>(context, listen: false)
                .isInProgress) {
          Provider.of<AuthPageProvider>(context, listen: false).clear();
          Provider.of<AuthPageProvider>(context, listen: false).changeIsInProgress(false);
        }
      },
      validator: (v) {
        if (v!.isEmpty) return "Parolni kiriting !!!";
      },
      controller: Provider.of<AuthPageProvider>(context, listen: false)
          .passwordController,
      decoration: DecorationMy.inputDecoration("Parol...", null),
    );
  }

  TextFormField _loginInput(BuildContext context) {
    return TextFormField(
      onChanged: (v) {
        p(v);
        if (v.isEmpty &&
            Provider.of<AuthPageProvider>(context, listen: false)
                .isInProgress) {
          Provider.of<AuthPageProvider>(context, listen: false).clear();
          Provider.of<AuthPageProvider>(context, listen: false).changeIsInProgress(false);

        }
      },
      validator: (v) {
        if (v!.isEmpty) return "Loginni kiriting !!!";
      },
      controller:
          Provider.of<AuthPageProvider>(context, listen: false).loginController,
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
