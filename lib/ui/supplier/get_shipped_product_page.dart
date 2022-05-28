import 'package:flutter/material.dart';
import 'package:governess/consts/size_config.dart';
import 'package:governess/consts/strings.dart';
import 'package:governess/models/other/date_time_from_milliseconds_model.dart';
import 'package:governess/models/supplier/shipped_product_model.dart';
import 'package:governess/providers/supplier/get_shipped_products_provider.dart';
import 'package:governess/services/network.dart';
import 'package:governess/services/supplier_service.dart';
import 'package:governess/ui/widgets/future_builder_of_no_data_widget.dart';
import 'package:governess/ui/widgets/indicator_widget.dart';
import 'package:governess/ui/widgets/send_button_widger.dart.dart';
import 'package:governess/ui/widgets/shipped_product_expansion_tile_widget.dart';
import 'package:governess/ui/widgets/text_in_row_widget.dart';
import 'package:provider/provider.dart';

class GetShippedProductPage extends StatefulWidget {
  const GetShippedProductPage({Key? key}) : super(key: key);

  @override
  State<GetShippedProductPage> createState() => _GetShippedProductPageState();
}

class _GetShippedProductPageState extends State<GetShippedProductPage> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return WillPopScope(
      onWillPop: () {
        Provider.of<GetShippedProductsProvider>(context, listen: false)
            .changeCurrent(-1);
        return Future.value(true);
      },
      child: Scaffold(
        appBar: _appBar(),
        body: FutureBuilder<List<ShippedProduct>>(
          future: SupplierService().getShippedProduct(),
          builder: (context, AsyncSnapshot<List<ShippedProduct>> snap) {
            if (snap.connectionState == ConnectionState.done) {
              if (!snap.hasData) {
                return const NoDataWidgetForFutureBuilder(
                    "Hozircha Yetkazilgan Mahsulotlar Mavjud Emas!");
              } else {}
              return _body(context, snap.data!);
            } else {
              return IndicatorWidget(snap);
            }
          },
        ),
      ),
    );
  }

  _body(BuildContext context, List<ShippedProduct> data) {
    data.sort(
      (a, b) => a.productName!.compareTo(b.productName!),
    );
    return data.isEmpty ?_noDataBody(context):ListView.separated(
      padding: EdgeInsets.only(left: gW(20.0), right: gW(20.0), top: gW(20.0)),
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      itemBuilder: (_, __) {
        int current = context.watch<GetShippedProductsProvider>().current;
        return Column(
          children: [
            ShippedProductExpansionTile(
                isExpanded: current == __,
                children: _children(data[__], context),
                onChanged: (bool newState) {
                  if (newState) {
                    Provider.of<GetShippedProductsProvider>(context,
                            listen: false)
                        .changeCurrent(__);
                  } else {
                    Provider.of<GetShippedProductsProvider>(context,
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
          height: gH(14.0),
        );
      },
      itemCount: data.length,
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
              setState(() {});
            },
            icon: const Icon(Icons.refresh_rounded))
      ],
    );
  }

  List<Widget> _children(ShippedProduct data, BuildContext context) {
    return <Widget>[
      Ink(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            gW(10.0),
          ),
        ),
        child: Column(
          children: [
            TextInRowWidget("Korxona nomi", data.companyName.toString()),
            _divider(),
            TextInRowWidget("Zayavka raqami", data.orderNumber.toString()),
            _divider(),
            TextInRowWidget("Ta'minotchi", data.supplier.toString()),
            _divider(),
            TextInRowWidget("O'lchov birligi", data.measurementType.toString()),
            _divider(),
            TextInRowWidget("Qadoq miqdori", data.pack.toString()),
            _divider(),
            TextInRowWidget(
                "Yuborilgan miqdor", data.sendNumberPack.toString()),
            _divider(),
            TextInRowWidget(
                "Yuborilgan qadoqlar soni", data.sendWeight.toString()),
            _divider(),
            TextInRowWidget(
                "Qabul qilingan miqdor", data.successWeight.toString()),
            _divider(),
            TextInRowWidget("Qabul qilingan qadoqlar soni",
                data.successNumberPack.toString()),
            _divider(),
            TextInRowWidget("Narxi", data.price.toString()),
            _divider(),
            TextInRowWidget(
                "Yuborilgan vaqti",
                data.timeOfShipment != null
                    ? DTFM.makerFromStr(data.timeOfShipment!)
                    : "--,--,----"),
            _divider(),
            TextInRowWidget(
                "Qabul qilingan sana", DTFM.makerFromStr(data.timeTaken)),
            _divider(),
            TextInRowWidget("Yuboruvchi", data.theSender.toString()),
            _divider(),
            TextInRowWidget("Qabul qiluvchi", data.receiver.toString()),
            _divider(),
            TextInRowWidget("To'lov holati", data.paymentStatus.toString()),
            _divider(),
            TextInRowWidget("To'lov turi", data.typeOfPayment.toString()),
            _divider(),
            SizedBox(
              height: gH(10.0),
            ),
          ],
        ),
      )
    ];
  }

  Divider _divider() => Divider(
        color: mainColor,
        indent: gW(15.0),
        endIndent: gW(15.0),
      );

  _noDataBody(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Hozirda mahsulotlar mavjud emas",
            style: TextStyle(color: mainColor, fontSize: gW(18.0)),
          ),
          SizedBox(height: gH(30.0)),
          SendButtonWidget(
            width: gW(335),
            onPressed: () async {
              bool isThereInternet = await checkConnectivity();
              if (isThereInternet) {
                setState(() {});
              } else {
                showNoNetToast(false);
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const GetShippedProductPage()),
                    (route) => false);
              }
            },
            titleOfButton: "Qayta yuklash",
          ),
        ],
      ),
    );
  }
}
