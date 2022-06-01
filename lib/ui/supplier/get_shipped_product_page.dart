import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:governess/consts/size_config.dart';
import 'package:governess/consts/strings.dart';
import 'package:governess/models/other/date_time_from_milliseconds_model.dart';
import 'package:governess/models/supplier/shipped_product_model.dart';
import 'package:governess/providers/supplier/date_time_sepplier_provider.dart';
// import 'package:governess/providers/supplier/filter_to_buy_page_provider.dart';
import 'package:governess/providers/supplier/get_shipped_products_provider.dart';
import 'package:governess/services/network.dart';
import 'package:governess/services/supplier_service.dart';
import 'package:governess/ui/widgets/date_time_show_button_widget.dart';
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
        Provider.of<GetShippedDateTimeProvider>(context, listen: false)
            .clearFromTo();

        return Future.value(true);
      },
      child: Scaffold(
        appBar: _appBar(context),
        body: CustomScrollView(
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          slivers: [
            _sliverAppBar(context),
            SliverToBoxAdapter(
              child: FutureBuilder<List<ShippedProduct>>(
                future: SupplierService().getShippedProduct(
                    end: context.watch<GetShippedDateTimeProvider>().to,
                    start: context.watch<GetShippedDateTimeProvider>().from),
                builder: (context, AsyncSnapshot<List<ShippedProduct>> snap) {
                  if (snap.connectionState == ConnectionState.done) {
                    if (snap.data!.isEmpty) {
                      return Center(
                        child: Text(
                          "Hozircha Yetkazilgan Mahsulotlar Mavjud Emas!",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: mainColor,
                            fontSize: gW(20.0),
                          ),
                        ),
                      );
                    } else {}
                    return _body(context, snap.data!);
                  } else {
                       String text;
                    switch (snap.connectionState) {
                      case ConnectionState.none:

                      case ConnectionState.waiting:

                      case ConnectionState.active:
                        text = "Kuting...";
                        break;
                      case ConnectionState.done:
                        text = "Bajarildi...";
                        break;
                    }

                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(text),
                          CupertinoActivityIndicator(
                            radius: gW(50.0),
                          ),
                        ],
                      ),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  SliverAppBar _sliverAppBar(
    BuildContext context,
  ) {
    return SliverAppBar(
      automaticallyImplyLeading: false,
      elevation: 0,
      backgroundColor: Colors.white,
      floating: true,
      flexibleSpace: _flecibleSpaceBAr(context),
    );
  }

  Container _flecibleSpaceBAr(BuildContext context) {
    return Container(
      color: Colors.transparent,
      alignment: Alignment.bottomCenter,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          DateTimeShowButton(
            DTFM.maker(
              context
                  .watch<GetShippedDateTimeProvider>()
                  .from
                  ?.millisecondsSinceEpoch,
            ),
            () {
              _showDialogDate(context);
            },
          ),
          DateTimeShowButton(
            DTFM.maker(context
                .watch<GetShippedDateTimeProvider>()
                .to
                ?.millisecondsSinceEpoch),
            () {
              _showDialogDate(context);
            },
          ),
        ],
      ),
    );
  }

  _body(BuildContext context, List<ShippedProduct> data) {
    data.sort(
      (a, b) => a.productName!.compareTo(b.productName!),
    );
    return ListView.separated(
      padding: EdgeInsets.only(left: gW(20.0), right: gW(20.0), top: gW(20.0)),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (_, __) {
        return ShippedProductExpansionTile(
            key: Key(__.toString()),
            isExpanded:
                context.watch<GetShippedProductsProvider>().current == __,
            children: _children(data[__]),
            onChanged: (bool v) {
              if (v) {
                context.read<GetShippedProductsProvider>().changeCurrent(__);
              } else {
                context.read<GetShippedProductsProvider>().changeCurrent(-1);
              }
            },
            data: data[__]);
      },
      separatorBuilder: (context, index) {
        return SizedBox(
          height: gH(14.0),
        );
      },
      itemCount: data.length,
    );
  }

  AppBar _appBar(BuildContext context) {
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

  List<Widget> _children(ShippedProduct data) {
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
                "Yuborilgan vaqti", DTFM.makerFromStr(data.timeOfShipment!)),
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

  Future<dynamic> _showDialogDate(BuildContext context) {
    return showDialog(
      useSafeArea: true,
      context: context,
      builder: (BuildContext alertContext) {
        return _ShowDialogDateContent(
          toSetState: () => setState(() {}),
        );
      },
    );
  }
}

// ignore: must_be_immutable
class _ShowDialogDateContent extends StatefulWidget {
  VoidCallback toSetState;
  _ShowDialogDateContent({
    required this.toSetState,
    Key? key,
  }) : super(key: key);

  @override
  State<_ShowDialogDateContent> createState() => _ShowDialogDateContentState();
}

class _ShowDialogDateContentState extends State<_ShowDialogDateContent> {
  DateTime? start;
  DateTime? end;
  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Container(
        padding: EdgeInsets.all(gW(20.0)),
        margin: EdgeInsets.only(
          top: gH(250.0),
          left: gW(10.0),
          right: gW(10.0),
          bottom: gH(350.0),
        ),
        decoration: BoxDecoration(
          color: whiteColor,
          border: Border.all(color: greyColor),
          borderRadius: BorderRadius.circular(
            gW(10.0),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ElevatedButton(
              onPressed: () {
                if (end == null || start == null) {
                  context.read<GetShippedProductsProvider>().changeCurrent(-1);

                  Navigator.pop(context);
                }
                Provider.of<GetShippedDateTimeProvider>(context, listen: false)
                    .initTo(end!);
                Provider.of<GetShippedDateTimeProvider>(context, listen: false)
                    .initFrom(start!);
                context.read<GetShippedProductsProvider>().changeCurrent(-1);

                widget.toSetState();
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                primary: mainColor_02,
                elevation: 0,
                shadowColor: Colors.transparent,
                shape: RoundedRectangleBorder(
                  side: BorderSide(color: mainColor),
                  borderRadius: BorderRadius.circular(
                    gW(7.0),
                  ),
                ),
              ),
              child: Text(
                "Ko'rish",
                style: TextStyle(color: mainColor),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  DTFM.maker(start?.millisecondsSinceEpoch),
                  style: TextStyle(
                    fontSize: gW(20.0),
                    letterSpacing: gW(1.0),
                  ),
                ),
                Text(
                  DTFM.maker(end?.millisecondsSinceEpoch),
                  style: TextStyle(
                    fontSize: gW(20.0),
                    letterSpacing: gW(1.0),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  height: gH(40.0),
                  width: gW(150.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: mainColor,
                      elevation: 0,
                      shadowColor: Colors.transparent,
                    ),
                    child: const Text("dan..."),
                    onPressed: () {
                      showDataPicker(context, true);
                    },
                  ),
                ),
                SizedBox(
                  height: gH(40.0),
                  width: gW(150.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: mainColor,
                      elevation: 0,
                      shadowColor: Colors.transparent,
                    ),
                    child: const Text("gacha..."),
                    onPressed: () {
                      showDataPicker(context, false);
                    },
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  showDataPicker(BuildContext context, bool isFrom) {
    DatePicker.showPicker(
      context,
      showTitleActions: true,
      theme: DatePickerTheme(
        backgroundColor: lightGreyColor,
        containerHeight: gH(200.0),
        headerColor: mainColor,
        itemStyle: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
        doneStyle: TextStyle(
          color: whiteColor,
          fontSize: 18,
          fontWeight: FontWeight.bold,
          letterSpacing: gW(1.5),
          decoration: TextDecoration.underline,
        ),
      ),
      onConfirm: (date) {
        if (isFrom) {
          // Provider.of<GetShippedDateTimeProvider>(context, listen: false)
          //     .initFrom(date);
          // Provider.of<GetShippedDateTimeProvider>(context, listen: false)
          //     .initTo(date);
          start = date;
          end = date;
          setState(() {});
        } else {
          end = date;
          setState(() {});
        }
      },
      locale: LocaleType.uz,
    );
  }
}
