import 'package:flutter/material.dart';
import 'package:governess/consts/size_config.dart';
import 'package:governess/ui/auth/check_pincode_page.dart';
import 'package:governess/ui/cooker/home_cooker_page.dart';
import 'package:governess/ui/manager/home_manager_page.dart';
import 'package:governess/ui/nurse/nurse_home_page.dart';
import 'package:governess/ui/supplier/home_supplier_page.dart';
import 'package:governess/ui/widgets/send_button_widger.dart.dart';

class SelectPage extends StatelessWidget {
  const SelectPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> users = [
      "Taminotchi",
      "Hamshira",
      "Mudira",
      "Oshpaz",
    ];

    return Scaffold(
      backgroundColor: mainColor,
      appBar: AppBar(
          backgroundColor: Colors.red, title: const Text("User tanlang")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(
            users.length,
            (index) => ElevatedButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                  builder: (context) {
                    switch (index) {
                      case 0:
                        return const SupplierHomePage();
                      case 1:
                        return const NurseHomePage();
                      case 2:
                        return const ManagerHomePage();
                      case 3:
                        return const CookerHomePage();

                      default:
                        return CheckingPinCodePage();
                    }
                  },
                ), (route) => false);
              },
              child: Text(
                users[index],
                style: TextStyle(color: mainColor,fontSize: gW(22.0)),
              ),
              style: ElevatedButton.styleFrom(
                  fixedSize: Size(
                    gW(335),
                    gH(62.0),
                  ),
                  primary: whiteColor,
                  elevation: 0,
                  shadowColor: null),
            ),
          ),
        ),
      ),
    );
  }
}
