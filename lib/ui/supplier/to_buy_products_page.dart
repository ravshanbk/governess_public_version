import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:governess/consts/strings.dart';
import 'package:governess/services/network.dart';
import 'package:governess/ui/supplier/home_supplier_page.dart';
import 'package:governess/ui/widgets/future_builder_of_no_data_widget.dart';
import 'package:governess/ui/widgets/indicator_widget.dart';
import 'package:provider/provider.dart';
import 'package:governess/consts/decorations.dart';
import 'package:governess/consts/size_config.dart';
import 'package:governess/models/other/date_time_from_milliseconds_model.dart';
import 'package:governess/models/supplier/product_model.dart';
import 'package:governess/models/supplier/product_with_available_company_names_model.dart';
import 'package:governess/models/supplier/send_product_model.dart';
import 'package:governess/providers/supplier/filter_to_buy_page_provider.dart';
import 'package:governess/providers/supplier/to_buy_products_page_provider.dart.dart';
import 'package:governess/services/supplier_service.dart';
import 'package:governess/ui/widgets/expansion_tile_to_show_product_widget.dart';
import 'package:governess/ui/widgets/send_button_widger.dart.dart';

class ToBuyProductsPage extends StatefulWidget {
  ToBuyProductsPage({Key? key}) : super(key: key);

  List<Product>? dataw;

  @override
  State<ToBuyProductsPage> createState() => _ToBuyProductsPageState();
}

class _ToBuyProductsPageState extends State<ToBuyProductsPage> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return WillPopScope(
      onWillPop: () {
        Provider.of<ToBuyProductPageProvider>(context, listen: false)
            .changeCurrent(-1);
        Provider.of<FilterToBuyPageProvider>(context, listen: false)
            .changeCurrentFilterIndex(0);
        Provider.of<FilterToBuyPageProvider>(context, listen: false)
            .clearFromTo();
        return Future.value(true);
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: _appBar(context),
        body: FutureBuilder<ProductWithAvailableCompnayNames>(
          future: SupplierService().getToBuyProducts(
            start: context.watch<FilterToBuyPageProvider>().from,
            end: context.watch<FilterToBuyPageProvider>().to,
          ),
          builder:
              (context, AsyncSnapshot<ProductWithAvailableCompnayNames> snap) {
            if (snap.connectionState == ConnectionState.done) {
              if (snap.data!.product.isNotEmpty) {
                return _body(snap.data!, context);
              } else {
                return const NoDataWidgetForFutureBuilder(
                    "Hozirda Mahsulotlar Mavjud Emas");
              }
            } else {
              return IndicatorWidget(snap);
            }
          },
        ),
      ),
    );
  }

  _body(ProductWithAvailableCompnayNames datas, BuildContext context) {
    List<Product> data = datas.product;
    widget.dataw = datas.product;
    int current = Provider.of<FilterToBuyPageProvider>(context, listen: false)
        .currentFilterIndex;
    List<Widget> widgetsDate = List.generate(
      Provider.of<FilterToBuyPageProvider>(context, listen: false)
          .dataByDate
          .length,
      (__) {
        List<Product> dataByDate =
            Provider.of<FilterToBuyPageProvider>(context, listen: false)
                .dataByDate;
        return ExpansionTileToShowProductWidget(
          isExpanded: context.watch<ToBuyProductPageProvider>().current == __,
          children: _children(dataByDate[__], context),
          onChanged: (bool newState) {
            if (newState) {
              context.read<ToBuyProductPageProvider>().changeCurrent(__);
            } else {
              context.read<ToBuyProductPageProvider>().changeCurrent(-1);
            }
          },
          data: dataByDate[__],
        );
      },
    );

    List<Widget> widgetsByCompanyName = List.generate(
      Provider.of<FilterToBuyPageProvider>(context, listen: false)
          .dataByCompanyName
          .length,
      (n) {
        List<Product> dataByCompName =
            Provider.of<FilterToBuyPageProvider>(context, listen: false)
                .dataByCompanyName;
        return ExpansionTileToShowProductWidget(
          isExpanded: context.watch<ToBuyProductPageProvider>().current == n,
          children: _children(dataByCompName[n], context),
          onChanged: (bool newState) {
            if (newState) {
              context.read<ToBuyProductPageProvider>().changeCurrent(n);
            } else {
              context.read<ToBuyProductPageProvider>().changeCurrent(-1);
            }
          },
          data: dataByCompName[n],
        );
      },
    );

    List<Widget> widgetsAll = List.generate(
      data.length,
      (__) {
        return ExpansionTileToShowProductWidget(
          isExpanded: context.watch<ToBuyProductPageProvider>().current == __,
          children: _children(data[__], context),
          onChanged: (bool newState) {
            if (newState) {
              context.read<ToBuyProductPageProvider>().changeCurrent(__);
            } else {
              context.read<ToBuyProductPageProvider>().changeCurrent(-1);
            }
          },
          data: data[__],
        );
      },
    );
    return Center(
        child: (current == 0
            ? _allBody(
                widgetsAll,
                datas,
                context,
              )
            : current == 1
                ? _allBody(
                    widgetsDate,
                    datas,
                    context,
                  )
                : (current == 2
                    ? _allBody(
                        widgetsByCompanyName,
                        datas,
                        context,
                      )
                    : _allBody(
                        widgetsDate,
                        datas,
                        context,
                      ))));
  }

  _noDataBody(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
                style: TextStyle(color: Colors.black, fontSize: gW(18.0)),
                children: context
                            .watch<FilterToBuyPageProvider>()
                            .currentFilterIndex ==
                        0
                    ? [const TextSpan(text: "Hozirda malumotlar mavjud emas")]
                    : [
                        TextSpan(
                            text: "Tanlangan " +
                                (context
                                            .watch<FilterToBuyPageProvider>()
                                            .currentFilterIndex ==
                                        1
                                    ? "sana \n"
                                    : "korxona nomi ")),
                        TextSpan(
                          text: context
                                      .watch<FilterToBuyPageProvider>()
                                      .currentFilterIndex ==
                                  1
                              ? DTFM.maker(Provider.of<FilterToBuyPageProvider>(
                                      context,
                                      listen: false)
                                  .from!
                                  .millisecondsSinceEpoch)
                              : Provider.of<FilterToBuyPageProvider>(context,
                                      listen: false)
                                  .currentCompName,
                          style:
                              TextStyle(color: Colors.red, fontSize: gW(22.0)),
                        ),
                        TextSpan(
                            text: " / ", style: TextStyle(fontSize: gW(22.0))),
                        TextSpan(
                          text: context
                                      .watch<FilterToBuyPageProvider>()
                                      .currentFilterIndex ==
                                  1
                              ? DTFM.maker(
                                  Provider.of<FilterToBuyPageProvider>(context)
                                      .to!
                                      .millisecondsSinceEpoch)
                              : Provider.of<FilterToBuyPageProvider>(context,
                                      listen: false)
                                  .currentCompName,
                          style:
                              TextStyle(color: Colors.red, fontSize: gW(22.0)),
                        ),
                        const TextSpan(text: " bo'yicha ma'lumot topilmadi"),
                      ]),
          ),
          SizedBox(height: gH(30.0)),
          SendButtonWidget(
            width: gW(335),
            onPressed: () async {
              bool isThereInternet = await checkConnectivity();
              if (isThereInternet) {
                Provider.of<FilterToBuyPageProvider>(context, listen: false)
                    .changeCurrentFilterIndex(0);
                Provider.of<ToBuyProductPageProvider>(context, listen: false)
                    .changeCurrent(-1);
                setState(() {});
              } else {
                Provider.of<FilterToBuyPageProvider>(context, listen: false)
                    .changeCurrentFilterIndex(0);

                Provider.of<ToBuyProductPageProvider>(context, listen: false)
                    .changeCurrent(-1);

                showNoNetToast(false);
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SupplierHomePage()),
                    (route) => false);
              }
            },
            titleOfButton: "Hammasi",
          ),
        ],
      ),
    );
  }

  _allBody(List<Widget>? data, ProductWithAvailableCompnayNames datas,
      BuildContext context) {
    return data!.isNotEmpty
        ? CustomScrollView(
            slivers: [
              _sliverAppBar(context, datas),
              SliverToBoxAdapter(
                child: ListView.separated(
                  separatorBuilder: (context, index) {
                    return SizedBox(
                      height: gH(14.0),
                      // child: Text(text),
                    );
                  },
                  key: Key(DateTime.now().toString()),
                  padding:
                      const EdgeInsets.only(left: 20.0, right: 20.0, top: 25.0),
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: data.length,
                  itemBuilder: (_, __) {
                    return data[__];
                  },
                ),
              ),
            ],
          )
        : _noDataBody(context);
  }

  SliverAppBar _sliverAppBar(
      BuildContext context, ProductWithAvailableCompnayNames data) {
    return SliverAppBar(
      automaticallyImplyLeading: false,
      elevation: 0,
      backgroundColor: Colors.white,
      floating: true,
      flexibleSpace: Container(
        color: greyColor,
        child: ListView.separated(
          separatorBuilder: (index, context) {
            return SizedBox(width: gW(15.0));
          },
          padding:
              EdgeInsets.symmetric(horizontal: gW(20.0), vertical: gH(10.0)),
          itemCount: context.watch<FilterToBuyPageProvider>().filters.length,
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          itemBuilder: (_, __) {
            return __ == 2
                ? _popUpMenuButton(context, __, data)
                : _elevatedButton(__, context);
          },
        ),
      ),
    );
  }

  ElevatedButton _elevatedButton(int __, BuildContext context) {
    return ElevatedButton(
      focusNode: FocusNode(canRequestFocus: true),
      onPressed: () async {
        bool isNet = await checkConnectivity();
        if (isNet) {
          if (__ == 0) {
            Provider.of<FilterToBuyPageProvider>(context, listen: false)
                .clearFromTo();
            Provider.of<FilterToBuyPageProvider>(context, listen: false)
                .changeCurrentFilterIndex(0);
            setState(() {});
          } else if (__ == 1) {
            _showDialogDate(context);
          }
        } else {
          showNoNetToast(false);
        }
      },
      style: ElevatedButton.styleFrom(
          minimumSize: const Size(0, 0),
          fixedSize: Size(double.infinity, gH(40.0)),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(gW(20.0)),
            side: BorderSide(color: whiteColor),
          ),
          visualDensity: const VisualDensity(horizontal: 0.0, vertical: 0.0),
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          primary:
              context.watch<FilterToBuyPageProvider>().currentFilterIndex != __
                  ? greyColor
                  : whiteColor,
          elevation: 0),
      child: Text(
        context.watch<FilterToBuyPageProvider>().filters[__],
        style: TextStyle(
          fontWeight:
              context.watch<FilterToBuyPageProvider>().currentFilterIndex != __
                  ? FontWeight.w300
                  : FontWeight.bold,
          color:
              context.watch<FilterToBuyPageProvider>().currentFilterIndex == __
                  ? mainColor
                  : whiteColor,
        ),
      ),
    );
  }

  PopupMenuButton<String> _popUpMenuButton(
      BuildContext context, int __, ProductWithAvailableCompnayNames data) {
    return PopupMenuButton(
      onSelected: (String v) {
        Provider.of<FilterToBuyPageProvider>(context, listen: false)
            .initCurrentCompanyname(v);
        Provider.of<FilterToBuyPageProvider>(context, listen: false)
            .generateByCompanyNameData(widget.dataw!, v);
        Provider.of<FilterToBuyPageProvider>(context, listen: false)
            .changeCurrentFilterIndex(2);
      },
      iconSize: 200,
      child: Container(
        alignment: Alignment.center,
        width: gW(200),
        height: gH(40.0),
        decoration: BoxDecoration(
          color:
              context.watch<FilterToBuyPageProvider>().currentFilterIndex == 2
                  ? whiteColor
                  : greyColor,
          border: Border.all(
            color: whiteColor,
          ),
          borderRadius: BorderRadius.circular(gW(20.0)),
        ),
        child: Text(
          context.watch<FilterToBuyPageProvider>().filters[__],
          style: TextStyle(
            fontWeight:
                context.watch<FilterToBuyPageProvider>().currentFilterIndex !=
                        __
                    ? FontWeight.w300
                    : FontWeight.bold,
            color:
                context.watch<FilterToBuyPageProvider>().currentFilterIndex ==
                        __
                    ? mainColor
                    : whiteColor,
          ),
        ),
      ),
      elevation: 0,
      color: whiteColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(gW(20.0)),
        side: BorderSide(color: whiteColor),
      ),
      initialValue: data.availables[0],
      itemBuilder: (context) {
        return List.generate(
          data.availables.length,
          (index) {
            return PopupMenuItem(
              key: Key("$index"),
              value: data.availables[index],
              child: Container(
                padding: EdgeInsets.symmetric(
                    horizontal: gW(15.0), vertical: gH(5.0)),
                decoration: BoxDecoration(
                  border: Border.all(color: mainColor_02),
                  color: mainColor_02,
                  borderRadius: BorderRadius.circular(
                    gW(7.0),
                  ),
                ),
                child: Text(
                  data.availables[index],
                  style: const TextStyle(color: Colors.black),
                ),
              ),
            );
          },
        );
      },
    );
  }

  AppBar _appBar(BuildContext context) {
    return AppBar(
      centerTitle: true,
      backgroundColor: mainColor,
      elevation: 0,
      title: context.watch<FilterToBuyPageProvider>().currentFilterIndex == 1
          ? Text(
              """${DTFM.maker(
                context
                    .watch<FilterToBuyPageProvider>()
                    .from
                    ?.millisecondsSinceEpoch,
              )} - ${DTFM.maker(
                context
                    .watch<FilterToBuyPageProvider>()
                    .from
                    ?.millisecondsSinceEpoch,
              )}""",
              style: TextStyle(fontSize: gW(18.0)),
            )
          : Text(
              context.watch<FilterToBuyPageProvider>().filters[
                  context.watch<FilterToBuyPageProvider>().currentFilterIndex],
            ),
      actions: [
        IconButton(
          onPressed: () {
            Provider.of<ToBuyProductPageProvider>(context, listen: false)
                .changeCurrent(-1);
            setState(() {});
          },
          icon: const Icon(
            Icons.refresh,
          ),
        )
      ],
    );
  }

  List<Widget> _children(Product data, BuildContext context) {
    return <Widget>[
      Ink(
        decoration: BoxDecoration(
          border: Border.all(color: mainColor),
          borderRadius: BorderRadius.circular(
            gW(10.0),
          ),
        ),
        child: Column(
          children: [
            SizedBox(height: gH(10.0)),
            _textInRow("Korxona nomi", data.companyName.toString()),
            _divider(),
            _textInRow("Zayavka raqami", data.orderNumber.toString()),
            _divider(),
            _textInRow("O'lchov birligi", data.measurementType.toString()),
            _divider(),
            _textInRow("Holati", data.status.toString()),
            _divider(),
            _textInRow("Qadoq miqdori", data.pack.toString()),
            _divider(),
            _textInRow("Qadoqlar soni", data.numberPack.toString()),
            _divider(),
            _textInRow("Miqdori", data.weight.toString()),
            _divider(),
            _textInRow("Yuborilgan miqdor", data.successWeight.toString()),
            _divider(),
            _textInRow(
                "Yuborilgan qadoqlar soni:", data.successNumberPack.toString()),
            _divider(),
            SendButtonWidget(
              width: gW(200.0),
              onPressed: (data.status! == "TO'LIQ TUGALLANGAN")
                  ? null
                  : () {
                      Provider.of<ToBuyProductPageProvider>(context,
                              listen: false)
                          .clear();
                      _showDialogSend(data, context);
                    },
              titleOfButton: "YUBORISH",
            ),
            SizedBox(
              height: gH(10.0),
            ),
          ],
        ),
      )
    ];
  }

  Future<dynamic> _showDialogSend(Product data, BuildContext context) {
    Provider.of<ToBuyProductPageProvider>(context, listen: false).initNumber(data.numberPack!);
    return showDialog(
      useSafeArea: true,
      context: context,
      builder: (BuildContext alertContext) {
        return _SendProductShowDialogContentWidget(
          data,
          callback: () {
            setState(() {});
          },
        );
      },
    );
  }

  Future<dynamic> _showDialogDate(BuildContext context) {
    return showDialog(
      useSafeArea: true,
      context: context,
      builder: (BuildContext alertContext) {
        return _ShowDialogDateContent(
          widget.dataw,
          toSetState: () {
            setState(
              () {},
            );
          },
        );
      },
    );
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
}

// ignore: unused_element
class _SendProductShowDialogContentWidget extends StatelessWidget {
  final Product data;
  final VoidCallback callback;
  const _SendProductShowDialogContentWidget(this.data,
      {required this.callback, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: gW(20.0), vertical: gH(15)),
        margin: EdgeInsets.only(
          top: gH(0.0),
          left: gW(10.0),
          right: gW(10.0),
          bottom: gH(280.0),
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
          children: [
            _richTextInRow(["Nomi:  ", data.productName!.toString()]),
            _richTextInRow(["Yaxlitlash miqdaori:  ", data.pack.toString()]),
            _richTextInRow(["Nechta:  ", data.numberPack.toString()]),
            _richTextInRow(["Umumiy:  ", data.weight.toString()]),
            const Spacer(),
            _numberInputField(context, data),
            const Spacer(),
            _priceInputField(context),
            const Spacer(),
            _commentInputField(context),
            const Spacer(),
            _paymentStatusSwitch(context),
            const Spacer(),
            _paymentType(context),
            const Spacer(),
            _sendButtonInShowDialog(context, data),
          ],
        ),
      ),
    );
  }

  _paymentStatusSwitch(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text(
          context.watch<ToBuyProductPageProvider>().statusOfPayment
              ? "To'landi"
              : "To'lanmadi",
          style: TextStyle(
            fontSize: gW(22.0),
            fontWeight: FontWeight.bold,
            color: context.watch<ToBuyProductPageProvider>().statusOfPayment
                ? mainColor
                : Colors.red,
          ),
        ),
        CupertinoSwitch(
            value: context.watch<ToBuyProductPageProvider>().statusOfPayment,
            onChanged: (bool v) {
              if (v) {
                Provider.of<ToBuyProductPageProvider>(context, listen: false)
                    .changeStatusOfPayment(v);
              } else {
                Provider.of<ToBuyProductPageProvider>(context, listen: false)
                    .changeStatusOfPayment(v);
                Provider.of<ToBuyProductPageProvider>(context, listen: false)
                    .changeIsCashOnPayment(v);
              }
            }),
      ],
    );
  }

  _paymentType(BuildContext context) {
    return context.watch<ToBuyProductPageProvider>().statusOfPayment
        ? Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                context.watch<ToBuyProductPageProvider>().isCashOnPayment
                    ? "Naqd"
                    : "Naqdsiz",
                style: TextStyle(
                  fontSize: gW(22.0),
                  fontWeight: FontWeight.bold,
                  color:
                      context.watch<ToBuyProductPageProvider>().isCashOnPayment
                          ? mainColor
                          : Colors.red,
                ),
              ),
              CupertinoSwitch(
                  value:
                      context.watch<ToBuyProductPageProvider>().isCashOnPayment,
                  onChanged: (bool v) {
                    Provider.of<ToBuyProductPageProvider>(context,
                            listen: false)
                        .changeIsCashOnPayment(v);
                  }),
            ],
          )
        : const SizedBox(
            height: 0.1,
            width: 0.1,
          );
  }

  RichText _richTextInRow(List<String> text) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: text[0],
            style: TextStyle(color: greyColor, fontSize: gW(14.0)),
          ),
          TextSpan(
            text: text[1].length > 17 ? text[1].substring(0, 16) : text[1],
            style: TextStyle(color: Colors.black, fontSize: gW(18.0)),
          ),
        ],
      ),
    );
  }

  SendButtonWidget _sendButtonInShowDialog(BuildContext con, Product data) {
    return SendButtonWidget(
      width: gW(200.0),
      onPressed: () async {
        bool isNet = await checkConnectivity();
        if (isNet) {
          if ((Provider.of<ToBuyProductPageProvider>(con, listen: false)
                  .numberController
                  .text
                  .isNotEmpty) &&
              (double.parse(
                      Provider.of<ToBuyProductPageProvider>(con, listen: false)
                          .numberController
                          .text) >
                  0)) {
            double number = (double.parse(
                    Provider.of<ToBuyProductPageProvider>(con, listen: false)
                        .numberController
                        .text) *
                (double.parse(data.pack!) > 0 ? double.parse(data.pack!) : 1));
            await SupplierService()
                .sendProduct(
              v: SendProduct(
                  paymentStatus:
                      Provider.of<ToBuyProductPageProvider>(con, listen: false)
                          .statusOfPayment,
                  typeOfPayment:
                      Provider.of<ToBuyProductPageProvider>(con, listen: false)
                          .isCashOnPayment,
                  comment:
                      Provider.of<ToBuyProductPageProvider>(con, listen: false)
                          .commentController
                          .text,
                  numberPack: double.parse(
                    Provider.of<ToBuyProductPageProvider>(con, listen: false)
                        .numberController
                        .text,
                  ),
                  weight: number,
                  price: double.parse(
                      Provider.of<ToBuyProductPageProvider>(con, listen: false)
                          .priceController
                          .text)),
              id: data.id!,
            )
                .then((value) {
              if (value.success!) {
                showToast(value.text!, value.success!, false);

                Provider.of<ToBuyProductPageProvider>(con, listen: false)
                    .clear();
                Provider.of<ToBuyProductPageProvider>(con, listen: false)
                    .changeCurrent(-1);
                callback();
                Navigator.pop(con);
              } else {
                showToast(value.text!, value.success!, false);
                callback();
                Navigator.pop(con);
              }
            });
          } else {
            showToast("Miqdorni kiriting, nol bolmasin", false, false);
          }
        } else {
          callback();
          showNoNetToast(false);
        }
      },
      titleOfButton: "YUBORISH",
    );
  }

  _numberInputField(BuildContext context, Product data) {
    return TextFormField(
      onChanged: (v) {
        if (double.parse(v) > double.parse(data.numberPack!)) {
          showToast(
              "Kiritilgan miqdor keraklisidan oshmasligi kerak", false, false);
          Provider.of<ToBuyProductPageProvider>(context, listen: false)
              .clearNumberController();
        }
      },
      keyboardType: TextInputType.number,
      controller: context.read<ToBuyProductPageProvider>().numberController,
      decoration: DecorationMy.inputDecoration(
        "Miqdor...",
        null,
      ),
    );
  }

  TextField _priceInputField(BuildContext context) {
    return TextField(
      onChanged: (v) {},
      keyboardType: TextInputType.number,
      controller: context.read<ToBuyProductPageProvider>().priceController,
      decoration: DecorationMy.inputDecoration(
        "Narxi...",
        null,
      ),
    );
  }

  TextField _commentInputField(BuildContext context) {
    return TextField(
      onChanged: (v) {},
      keyboardType: TextInputType.text,
      controller: context.read<ToBuyProductPageProvider>().commentController,
      decoration: DecorationMy.inputDecoration(
        "Izoh...",
        null,
      ),
    );
  }
}

// ignore: must_be_immutable
class _ShowDialogDateContent extends StatefulWidget {
  VoidCallback toSetState;
  List<Product>? dataw;
  _ShowDialogDateContent(
    this.dataw, {
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
          bottom: gH(320.0),
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
                  Navigator.pop(context);
                  return;
                }
                Provider.of<FilterToBuyPageProvider>(context, listen: false)
                    .initFrom(start!);
                Provider.of<FilterToBuyPageProvider>(context, listen: false)
                    .initTo(end!);
                Provider.of<FilterToBuyPageProvider>(context, listen: false)
                    .changeCurrentFilterIndex(1);
                _getDataByDateTime(widget.dataw!, context);
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

  int _getDataByDateTime(List<Product> data, BuildContext context) {
    List<Product> list = [];
    int m = 0;
    for (int i = 0; i < data.length; i++) {
      if (int.parse(data[i].requestDate!) <=
              Provider.of<FilterToBuyPageProvider>(context, listen: false)
                  .to!
                  .millisecondsSinceEpoch &&
          int.parse(data[i].requestDate!) >=
              Provider.of<FilterToBuyPageProvider>(context, listen: false)
                  .from!
                  .millisecondsSinceEpoch) {
        list.add(data[i]);
        m++;
      }
    }

    Provider.of<FilterToBuyPageProvider>(context, listen: false)
        .generateByTimeData(list);
    return m;
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
