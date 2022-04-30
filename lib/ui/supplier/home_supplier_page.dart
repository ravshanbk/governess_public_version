
import 'package:flutter/material.dart';
import 'package:governess/consts/size_config.dart';
import 'package:governess/consts/strings.dart';
import 'package:governess/services/network.dart';
import 'package:governess/ui/supplier/get_shipped_product_page.dart';
import 'package:governess/ui/supplier/to_buy_products_page.dart';
import 'package:governess/ui/widgets/big_elevate_button_home_page.dart';
import 'package:governess/ui/widgets/drawer_widget_my.dart';

class SupplierHomePage extends StatelessWidget {
  const SupplierHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    List<String> doings = [
      "Harid Qilinadigan Mahsulotlar",
      "Yetkazilgan Mahsulotlar",
    ];

    return Scaffold(
      drawer: const DrawerWidgetMy(),
      //  _drawer(),
      appBar: _appBar(),
      body: _body(doings, context),
    );
  }

  Center _body(List<String> doings, BuildContext context) {
    return Center(
      child: ListView.separated(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: gW(30.0), vertical: gH(30.0)),
        separatorBuilder: (context, index) {
          return SizedBox(height: gH(30.0));
        },
        itemCount: doings.length,
        itemBuilder: (_, __) {
          return BigElevatedButtonHomePage(
            title: doings[__],
            onPressed: () async {
              bool therIsInternet = await checkConnectivity();
              if (therIsInternet) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      switch (__) {
                        case 0:
                          return ToBuyProductsPage();
                        case 1:
                          return const GetShippedProductPage();

                        default:
                          return const SupplierHomePage();
                      }
                    },
                  ),
                );
              } else {
                showNoNetToast(false);
              }
            },
          );
        },
      ),
    );
  }

  AppBar _appBar() {
    return AppBar(
      centerTitle: true,
      backgroundColor: mainColor,
      elevation: 0,
      title: const Text(
        "Supplier home page",
        style: TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }
}
