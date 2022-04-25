import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:governess/consts/colors.dart';
import 'package:governess/consts/decorations.dart';
import 'package:governess/consts/size_config.dart';
import 'package:governess/providers/auth/auth_page_provider.dart';
import 'package:governess/services/auth_service.dart';
import 'package:governess/ui/apply_application_page.dart';
import 'package:governess/ui/cooker/home_cooker_page.dart';
import 'package:governess/ui/manager/home_manager_page.dart';
import 'package:governess/ui/nurse/nurse_home_page.dart';
import 'package:governess/ui/pin_code_page.dart';
import 'package:governess/ui/supplier/home_supplier_page.dart';
import 'package:governess/ui/widgets/governess_app_bar.dart';
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
                    _textButton(context),
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

  TextButton _textButton(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const ApplyAplicationPage(),
          ),
        );
      },
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          style: TextStyle(color: greyColor, fontSize: gW(20.0)),
          children: const [
            TextSpan(text: "Ta'minotchi bo'lib ro'yxatdan o'tish\n uchun "),
            TextSpan(text: "bu yerga ", style: TextStyle(color: Colors.red)),
            TextSpan(text: " bosing"),
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
              // Navigator.pushAndRemoveUntil(
              //     context,
              //     MaterialPageRoute(builder: (context) => const FakePage()
              //         //  const NurseHomePage(),
              //         // const ManagerHomePage()
              //         // const SupplierHomePage()
              //         //  const CookerHomePage()
              //         ),
              //     (route) => false);
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
                    Provider.of<AuthPageProvider>(context, listen: false)
                        .changeIsInProgress(false);
  Provider.of<AuthPageProvider>(context, listen: false)
                        .clear();
                    switch (value.role) {
                      case "ROLE_HAMSHIRA":
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const NurseHomePage(),
                            ),
                            (route) => false);
                        break;
                      case "ROLE_MUDIRA":
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ManagerHomePage(),
                            ),
                            (route) => false);
                        break;
                      case "ROLE_TAMINOT":
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>const  SupplierHomePage(),
                            ),
                            (route) => false);
                        break;
                      case "ROLE_OSHPAZ":
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const CookerHomePage(),
                            ),
                            (route) => false);
                        break;
                      default:
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
      validator: (v) {
        if (v!.isEmpty) return "Parolni kiriting !!!";
      },
      controller: context.read<AuthPageProvider>().passwordController,
      decoration: DecorationMy.inputDecoration("Parol...", null),
    );
  }

  TextFormField _loginInput(BuildContext context) {
    return TextFormField(
      validator: (v) {
        if (v!.isEmpty) return "Loginni kiriting !!!";
      },
      controller: context.read<AuthPageProvider>().loginController,
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

class FakePage extends StatelessWidget {
  const FakePage({Key? key}) : super(key: key);
  final List<String> roles = const [
    "TAMINOTCHI",
    "HAMSHIRA",
    "OSHPAZ",
    "MUDIR",
  ];
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.symmetric(horizontal: gW(20.0), vertical: gW(100.0)),
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      itemBuilder: (_, __) {
        return ElevatedButton(
          style: ElevatedButton.styleFrom(
              primary: mainColor,
              elevation: 0,
              fixedSize: Size(gW(335.0), gH(62.0))),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PinCodePage(__),
              ),
            );
          },
          child: Text(
            roles[__],
          ),
        );
      },
      separatorBuilder: (context, index) {
        return SizedBox(
          height: gH(30.0),
        );
      },
      itemCount: roles.length,
    );
  }
}
