import 'package:flutter/material.dart';
import 'package:governess/consts/colors.dart';
import 'package:governess/consts/decorations.dart';
import 'package:governess/consts/size_config.dart';
import 'package:governess/providers/auth_page_provider.dart';
import 'package:governess/ui/nurse/nurse_home_page.dart';
import 'package:provider/provider.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Center(
        child: Form(
          key: context.read<AuthPageProvider>().formKey,
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: gW(20.0),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _loginInput(context),
                SizedBox(height: gH(20.0)),
                _passwordInput(context),
                SizedBox(height: gH(20.0)),
                _submitButton(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  ElevatedButton _submitButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => const NurseHomePage(),
            ),
            (route) => false);
        // if (Provider.of<AuthPageProvider>(context, listen: false)
        //     .formKey
        //     .currentState!
        //     .validate()) {
        //        await AuthService()
        //         .getUser(
        //             Provider.of<AuthPageProvider>(context, listen: false)
        //                 .loginController
        //                 .text,
        //             Provider.of<AuthPageProvider>(context, listen: false)
        //                 .passwordController
        //                 .text)
        //         .then(
        //       (value) {
        //         switch (value.role) {
        //           case "ROLE_HAMSHIRA":
        //             Navigator.pushAndRemoveUntil(
        //                 context,
        //                 MaterialPageRoute(
        //                   builder: (context) => const HamshiraHomePage(),
        //                 ),
        //                 (route) => false);
        //             break;
        //           default:
        //         }
        //       },
        //     );
        // }
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
      decoration: DecorationMy.inputDecoration("Parol...",null),
    );
  }

  TextFormField _loginInput(BuildContext context) {
    return TextFormField(
      validator: (v) {
        if (v!.isEmpty) return "Loginni kiriting !!!";
      },
      controller: context.read<AuthPageProvider>().loginController,
      decoration:DecorationMy.inputDecoration("Login...",null),
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
