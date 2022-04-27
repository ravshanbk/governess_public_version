import 'package:flutter/material.dart';
import 'package:governess/consts/colors.dart';
import 'package:governess/consts/size_config.dart';
import 'package:governess/local_storage/user_storage.dart';
import 'package:governess/providers/auth/pin_code_page_provider.dart';
import 'package:governess/ui/auth/check_pincode_page.dart';
import 'package:governess/ui/widgets/governess_app_bar.dart';
import 'package:governess/ui/widgets/pincode_widget.dart';
import 'package:governess/ui/widgets/send_button_widger.dart.dart';
import 'package:governess/ui/widgets/show_toast_function.dart';
import 'package:provider/provider.dart';

class PinCodePage extends StatefulWidget {
  const PinCodePage({Key? key}) : super(key: key);

  @override
  State<PinCodePage> createState() => _PinCodePageState();
}

class _PinCodePageState extends State<PinCodePage> {
  final TextEditingController savePinCodeController = TextEditingController();

  final TextEditingController repeatePinCodeController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: governessAppBar,
      body: _savePinCodeBody(context),
    );
  }

  Center _savePinCodeBody(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Pinkod O'rnatish",
            style: TextStyle(
              fontSize: gW(25.0),
              color: Colors.red,
            ),
          ),
          _divider(),
          _textGreen("Pin kodingizni kiriting!"),
          SizedBox(height: gH(10.0)),
          _newPincodeField(context),
          _textGreen("Pin kodingizni takror kiriting"),
          SizedBox(height: gH(10.0)),
          _repeatPincodeField(context),
          _submitButton(context),
          _divider()
        ],
      ),
    );
  }

  SendButtonWidget _submitButton(BuildContext context) {
    return SendButtonWidget(
        onPressed: context.watch<PinCodePageProvider>().idf
            ? () async {
                await UserHive().pinSave(
                  savePinCodeController.text,
                );

                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CheckingPinCodePage(),
                    ),
                    (route) => false);
              }
            : null,
        titleOfButton: "Tasdiqlash");
  }

  Text _textGreen(String text) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(
        color: mainColor,
      ),
    );
  }

  PinCodeWidget _repeatPincodeField(BuildContext context) {
    return PinCodeWidget(
      controller: repeatePinCodeController,
      onComplete: (v) {
        if (savePinCodeController.text == repeatePinCodeController.text &&
            repeatePinCodeController.text.length == 4) {
          Provider.of<PinCodePageProvider>(context, listen: false)
              .changeIdf(true);
        } else {
          showToast(
            "Takror pinkodingiz pinkodingiz bilan bir hil emas.\n Qaytadan kiriting!",
            false,
            false,
          );
          setState(() {
            repeatePinCodeController.clear();
          });
        }
      },
    );
  }

  PinCodeWidget _newPincodeField(BuildContext context) {
    return PinCodeWidget(
      controller: savePinCodeController,
      onComplete: (v) {
        if (savePinCodeController.text == repeatePinCodeController.text &&
            repeatePinCodeController.text.length == 4) {
          Provider.of<PinCodePageProvider>(context, listen: false)
              .changeIdf(true);
        }
      },
    );
  }

  Divider _divider() {
    return Divider(
      color: mainColor,
      indent: gW(50.0),
      endIndent: gW(50.0),
    );
  }
}
