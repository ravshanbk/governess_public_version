import 'package:flutter/material.dart';
import 'package:governess/consts/colors.dart';
import 'package:governess/consts/size_config.dart';
import 'package:governess/local_storage/boxes.dart';
import 'package:governess/models/hive_models/pin_hive_model.dart';
import 'package:governess/ui/cooker/home_cooker_page.dart';
import 'package:governess/ui/manager/home_manager_page.dart';
import 'package:governess/ui/nurse/nurse_home_page.dart';
import 'package:governess/ui/supplier/home_supplier_page.dart';
import 'package:governess/ui/widgets/governess_app_bar.dart';
import 'package:governess/ui/widgets/pincode_widget.dart';
import 'package:governess/ui/widgets/show_toast_function.dart';
import 'package:hive_flutter/hive_flutter.dart';

class CheckingPinCodePage extends StatelessWidget {
  CheckingPinCodePage({Key? key}) : super(key: key);
   TextEditingController controller = TextEditingController();

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
          SizedBox(height: gH(10.0)),
          PinCodeWidget(
              controller:
               controller,
              onComplete: (String v) {
                if (box.values.toList().cast<PinHive>()[0].pinUser == v) {
                  showToast("Muvaffaqiyat !!!", true, true);

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
                          return CheckingPinCodePage();
                      }
                    },
                  ), (route) => false);
                } else {
                  showToast(
                      "Pinkodni notog'ri kiritdingiz, Qaytadan urinib ko'ring!!!",
                      false,
                      true);
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
