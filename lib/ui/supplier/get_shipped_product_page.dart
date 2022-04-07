import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:governess/consts/colors.dart';
import 'package:governess/consts/decorations.dart';
import 'package:governess/consts/size_config.dart';
import 'package:governess/models/other/date_time_from_milliseconds_model.dart';
import 'package:governess/models/supplier/product_model.dart';
import 'package:governess/providers/get_shipped_products_provider.dart';
import 'package:governess/providers/to_buy_products_page_provider.dart.dart';
import 'package:governess/services/supplier_service.dart';
import 'package:governess/ui/widgets/expansion_tile_to_show_product_widget.dart';
import 'package:provider/provider.dart';

class GetShippedProductPage extends StatefulWidget {
  const GetShippedProductPage({Key? key}) : super(key: key);

  @override
  State<GetShippedProductPage> createState() => _GetShippedProductPageState();
}

class _GetShippedProductPageState extends State<GetShippedProductPage> {
  Future<List<Product>>? products;

  @override
  void initState() {
    products = SupplierService().getShippedProduct();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: _appBar(),
      body: FutureBuilder(
          future: products,
          builder: (context, AsyncSnapshot<List<Product>> snap) {
            List<Product> data = snap.data!;

            return !snap.hasData
                ? _indicator()
                : Column(
                    children: [
                      ListView.separated(
                          padding: EdgeInsets.only(
                              left: gW(20.0), right: gW(20.0), top: gW(20.0)),
                          shrinkWrap: true,
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (_, __) {
                            int current = context
                                .watch<GetShippedProductsProvider>()
                                .current;
                            return Column(
                              children: [
                                ExpansionTileToShowProductWidget(
                                    isExpanded: current == __,
                                    children: _children(data[__], context),
                                    onChanged: (bool newState) {
                                      debugPrint(newState.toString());
                                      if (newState) {
                                        Provider.of<ToBuyProductPageProvider>(
                                                context,
                                                listen: false)
                                            .changeCurrent(__);
                                      } else {
                                        Provider.of<ToBuyProductPageProvider>(
                                                context,
                                                listen: false)
                                            .changeCurrent(-1);
                                      }
                                    },
                                    data: data[__]),
                              ],
                            );
                          },
                          separatorBuilder: (context, index) {
                            return SizedBox(
                              height: gH(4.0),
                            );
                          },
                          itemCount: data.length)
                    ],
                  );
          }),
    );
  }

  AppBar _appBar() {
    return AppBar(
      title: const Text("Omborga Yuborilgan Mahs..."),
      backgroundColor: mainColor,
      elevation: 0,
      centerTitle: true,
      actions: [
        IconButton(
            onPressed: () {
              context.read<GetShippedProductsProvider>().changeCurrent(-1);
              initState();
            },
            icon: const Icon(Icons.filter_list))
      ],
    );
  }

  List<Widget> _children(Product data, BuildContext context) {
    return <Widget>[
      Ink(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            gW(10.0),
          ),
        ),
        child: Column(children: [
          _textInRow("Korxona nomi", data.companyName.toString()),
          _divider(),
          _textInRow("Zayavka nomi", data.orderNumber.toString()),
          _divider(),
          _textInRow("Yuborilgan Sana", DTFM.maker(data.sendDate!).toString()),
          _divider(),
          _textInRow("O'lchov birligi", data.measurementType.toString()),
          _divider(),
          _textInRow("Holati", data.status.toString()),
          _divider(),
          _textInRow("Yaxlitlash miqdori", data.pack.toString()),
          _divider(),
          _textInRow("Qadoqlar soni", data.numberPack.toString()),
          _divider(),
          _textInRow("Qadoqlangandan so'ng (miq)", data.weightPack.toString()),
          _divider(),
          SizedBox(
            height: gH(10.0),
          ),
        ]),
      )
    ];
  }

  Divider _divider() => Divider(
        color: mainColor,
        indent: gW(15.0),
        endIndent: gW(15.0),
      );

  _textInRow(String title, String text) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: gW(10.0)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "$title:",
            style: TextStyle(
              color: greyColor,
              fontSize: gW(14.0),
            ),
          ),
          Text(
            text.length > 18 ? text.substring(0, 17) : text,
            style: TextStyle(
              color: Colors.black,
              fontSize: gW(18.0),
            ),
          ),
        ],
      ),
    );
  }

  Scaffold _indicator() {
    return Scaffold(
      body: Center(
        child: CupertinoActivityIndicator(
          radius: gW(50.0),
        ),
      ),
    );
  }
}
