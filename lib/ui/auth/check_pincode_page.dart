import 'package:flutter/material.dart';
import 'package:governess/consts/colors.dart';
import 'package:governess/consts/size_config.dart';
import 'package:governess/local_storage/boxes.dart';
import 'package:governess/models/hive_models/pin_hive_model.dart';
import 'package:governess/providers/auth/pin_code_page_provider.dart';
import 'package:governess/ui/cooker/home_cooker_page.dart';
import 'package:governess/ui/manager/home_manager_page.dart';
import 'package:governess/ui/nurse/nurse_home_page.dart';
import 'package:governess/ui/supplier/home_supplier_page.dart';
import 'package:governess/ui/widgets/governess_app_bar.dart';
import 'package:governess/ui/widgets/pincode_widget.dart';
import 'package:governess/ui/widgets/show_toast_function.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

class CheckingPinCodePage extends StatelessWidget {
  const CheckingPinCodePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: governessAppBar,
      body: _checkPinCodeBody(context),
    );
  }

  Center _checkPinCodeBody(BuildContext context) {
    Box box = Boxes.getPinUser();
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Pin kodingizni kiriting!",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: mainColor,
              fontSize: gW(20.0),
            ),
          ),
          PinCodeWidget(
              controller:
                  Provider.of<PinCodePageProvider>(context, listen: false)
                      .pinCodeController,
              onComplete: (String v) {
                if (box.values.toList().cast<PinHive>()[0].pinUser == v) {
                  showToast("Muvaffaqiyat !!!", true, true);
                  Provider.of<PinCodePageProvider>(context, listen: false)
                      .clear();
                  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                    builder: (context) {
                      switch (Boxes.getUser().values.first.role) {
                        case "ROLE_HAMSHIRA":
                          return const NurseHomePage();
                        case "ROLE_BOG`CHA MUDIRASI":
                          return const ManagerHomePage();
                        case "ROLE_TA`MINOTCHI":
                          return const SupplierHomePage();
                        case "ROLE_OSHPAZ":
                          return const CookerHomePage();
                        default:
                          return const CheckingPinCodePage();
                      }
                    },
                  ), (route) => false);
                } else {
                    Provider.of<PinCodePageProvider>(context, listen: false)
                      .clear();
                  showToast(
                      "Pinkodni notog'ri kiritdingiz, Qaytadan urinib ko'ring!!!",
                      false,
                      true);
                  Provider.of<PinCodePageProvider>(context, listen: false)
                      .clear();
                }
              }),
          Divider(
            color: mainColor,
            indent: gW(50.0),
            endIndent: gW(50.0),
          )
        ],
      ),
    );
  }
}
