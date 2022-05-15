import 'package:flutter/material.dart';
import 'package:governess/consts/size_config.dart';
import 'package:governess/consts/strings.dart';
import 'package:governess/services/network.dart';
import 'package:governess/ui/cooker/sub_pages/cooker_show_products_in_storage_page.dart.dart';
import 'package:governess/ui/cooker/sub_pages/show_products_in_storage_page.dart';
import 'package:governess/ui/cooker/sub_pages/tab_accept_product_page.dart';
import 'package:governess/ui/cooker/sub_pages/waste_product_page.dart';

class CookerProductsPage extends StatelessWidget {
  const CookerProductsPage({Key? key}) : super(key: key);
  final List<String> toDoes = const [
    "Mahsulotlarni Qabul Qilish",
    "Ombordagi Mahsulotlar",
    "Zahiradagi Mahsulotlar",
    "Chiqindilar",
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mainColor,
        elevation: 0,
        centerTitle: true,
        title: const Text("Mahsulotlar"),
      ),
      body: ListView.separated(
        padding: EdgeInsets.all(
          gW(20.0),
        ),
        itemBuilder: (_, __) {
          return ElevatedButton(
            onPressed: () async {
              bool isNet = await checkConnectivity();
              if (isNet) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      switch (__) {
                        case 0:
                          return const CookerAcceptProductPageTab();
                        case 1:
                          return const CookerShowProductsInStoragePage();
                        case 2:
                          return const CookerShowExistingProductPage();
                        case 3:
                          return const CookerWastProductPage();
                        default:
                          return const CookerProductsPage();
                      }
                    },
                  ),
                );
              } else {
                showNoNetToast(false);
              }
            },
            style: ElevatedButton.styleFrom(
              fixedSize: Size(
                gW(335.0),
                gH(62.0),
              ),
              primary: mainColor_02,
              elevation: 0,
              shape: RoundedRectangleBorder(
                side: BorderSide(color: mainColor),
                borderRadius: BorderRadius.circular(
                  gW(15.0),
                ),
              ),
            ),
            child: Text(
              toDoes[__],
              style: TextStyle(
                color: mainColor,
                fontSize: gW(20.0),
              ),
            ),
          );
        },
        separatorBuilder: (context, index) {
          return SizedBox(height: gH(20.0));
        },
        itemCount: toDoes.length,
      ),
    );
  }
}
