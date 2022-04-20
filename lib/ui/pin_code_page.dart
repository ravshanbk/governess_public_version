import 'package:flutter/material.dart';
import 'package:governess/consts/colors.dart';
import 'package:governess/consts/size_config.dart';
import 'package:governess/ui/auth_page.dart';
import 'package:governess/ui/cooker/home_cooker_page.dart';
import 'package:governess/ui/manager/home_manager_page.dart';
import 'package:governess/ui/nurse/nurse_home_page.dart';
import 'package:governess/ui/supplier/home_supplier_page.dart';

class PinCodePage extends StatelessWidget {
  final int index;
  PinCodePage(this.index, {Key? key}) : super(key: key);
  final List<FocusNode> nodes = List.generate(4, (index) => FocusNode());
  List<TextEditingController> controllers =
      List.generate(4, (index) => TextEditingController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mainColor,
        elevation: 0,
      ),
      body: Center(
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                4,
                (n) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      height: gH(50.0),
                      width: gW(40.0),
                      child: TextFormField(
                        onTap: () {
                          if (controllers[0].text.isEmpty) {
                            FocusScope.of(context).requestFocus(nodes[0]);
                          }
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(gW(8.0))),
                          contentPadding: EdgeInsets.only(left: gW(14.0)),
                          focusColor: Colors.black,
                        ),
                        controller: controllers[n],
                        cursorWidth: 0.0,
                        cursorHeight: 0.0,
                        obscuringCharacter: "*",
                        cursorColor: Colors.transparent,
                        style: TextStyle(
                          fontSize: gW(
                            30.0,
                          ),
                        ),
                        obscureText: true,
                        autofocus: true,
                        keyboardType: TextInputType.number,
                        focusNode: nodes[n],
                        onChanged: (v) {
                          if (v.length == 1) {
                            if (n == 3) {
                              clearControllers();
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    switch (index) {
                                      case 0:
                                        return const SupplierHomePage();

                                      case 1:
                                        return const NurseHomePage();

                                      case 2:
                                        return const CookerHomePage();

                                      case 3:
                                        return const ManagerHomePage();

                                      default:
                                        return const FakePage();
                                    }
                                  },
                                ),
                              );
                            } else {
                              nodes[n].unfocus();
                              FocusScope.of(context).requestFocus(nodes[n + 1]);
                            }
                          } else {
                            clearControllers();
                          }
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
            Divider(color: mainColor,indent: gW(50.0),endIndent: gW(50.0),)
          ],
        ),
      ),
    );
  }

  clearControllers() async {
    controllers.map((e) => e.clear());
  }
}
