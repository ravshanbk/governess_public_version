import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:governess/consts/colors.dart';
import 'package:governess/consts/print_my.dart';
import 'package:governess/consts/size_config.dart';
import 'package:governess/models/other/date_time_from_milliseconds_model.dart';
import 'package:governess/models/supplier/product_model.dart';
import 'package:governess/providers/supplier/get_shipped_products_provider.dart';
import 'package:governess/providers/supplier/to_buy_products_page_provider.dart.dart';
import 'package:governess/ui/widgets/expansion_tile_to_show_product_widget.dart';
import 'package:governess/ui/widgets/text_in_row_widget.dart';
import 'package:provider/provider.dart';

class GetShippedProductPage extends StatefulWidget {
  const GetShippedProductPage({Key? key}) : super(key: key);

  @override
  State<GetShippedProductPage> createState() => _GetShippedProductPageState();
}

class _GetShippedProductPageState extends State<GetShippedProductPage> {
  Future<List<Product>>? products;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: _appBar(),
      body: FutureBuilder<List<Product>>(
        future: products,
        builder: (context, AsyncSnapshot<List<Product>> snap) {
          if (snap.connectionState == ConnectionState.done) {
            return _body(context, snap.data!);
          } else if (snap.connectionState == ConnectionState.active) {
            return _indicator(snap.connectionState.name);
          } else {
            return _indicator(snap.connectionState.name);
          }
        },
      ),
    );
  }

  Column _body(BuildContext context, List<Product> data) {
    return Column(
      children: [
        ListView.separated(
          padding:
              EdgeInsets.only(left: gW(20.0), right: gW(20.0), top: gW(20.0)),
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          itemBuilder: (_, __) {
            int current = context.watch<GetShippedProductsProvider>().current;
            return Column(
              children: [
                ExpansionTileToShowProductWidget(
                    isExpanded: current == __,
                    children: _children(data[__], context),
                    onChanged: (bool newState) {
                      if (newState) {
                        Provider.of<ToBuyProductPageProvider>(context,
                                listen: false)
                            .changeCurrent(__);
                      } else {
                        Provider.of<ToBuyProductPageProvider>(context,
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
          itemCount: data.length,
        ),
      ],
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
              p("v");
              context.read<GetShippedProductsProvider>().changeCurrent(-1);
              setState(() {});
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
          TextInRowWidget("Korxona nomi", data.companyName.toString()),
          _divider(),
          TextInRowWidget("Zayavka nomi", data.orderNumber.toString()),
          _divider(),
          TextInRowWidget(
              "Yuborilgan Sana", DTFM.maker(data.sendDate!).toString()),
          _divider(),
          TextInRowWidget("O'lchov birligi", data.measurementType.toString()),
          _divider(),
          TextInRowWidget("Holati", data.status.toString()),
          _divider(),
          TextInRowWidget("Yaxlitlash miqdori", data.pack.toString()),
          _divider(),
          TextInRowWidget("Qadoqlar soni", data.numberPack.toString()),
          _divider(),
          TextInRowWidget(
              "Qadoqlangandan so'ng (miq)", data.weightPack.toString()),
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

  Scaffold _indicator(String idf) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Text(idf),
            CupertinoActivityIndicator(
              radius: gW(50.0),
            ),
          ],
        ),
      ),
    );
  }
}
