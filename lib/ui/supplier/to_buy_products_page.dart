import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:governess/consts/colors.dart';
import 'package:governess/consts/decorations.dart';
import 'package:governess/consts/size_config.dart';
import 'package:governess/models/other/date_time_from_milliseconds_model.dart';
import 'package:governess/models/supplier/send_product_model.dart';
import 'package:governess/models/supplier/product_model.dart';
import 'package:governess/providers/filter_to_buy_page_provider.dart';
import 'package:governess/providers/to_buy_products_page_provider.dart.dart';
import 'package:governess/services/supplier_service.dart';
import 'package:governess/ui/widgets/expansion_tile_to_show_product_widget.dart';
import 'package:governess/ui/widgets/submit_button_widger.dart.dart';
import 'package:provider/provider.dart';

class ToBuyProductsPage extends StatefulWidget {
  ToBuyProductsPage({Key? key}) : super(key: key);

  @override
  State<ToBuyProductsPage> createState() => _ToBuyProductsPageState();
}

class _ToBuyProductsPageState extends State<ToBuyProductsPage> {
  Future<List<Product>>? toBuyProducts;

  @override
  void initState() {
    toBuyProducts = SupplierService().getToBuyProducts();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: _appBar(context),
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          _sliverAppBar(),
          SliverToBoxAdapter(
            child: FutureBuilder<List<Product>>(
              future: toBuyProducts,
              builder: (context, AsyncSnapshot<List<Product>> snap) {
                List<Product> data = snap.data!;
                Provider.of<FilterToBuyPageProvider>(context, listen: false)
                    .initN(data.length);

               
                return snap.hasData ? _body(data, context) : _indicator();
              },
            ),
          ),
        ],
      ),
    );
  }

  _body(List<Product>? data, BuildContext context) {
    return Center(
      child: (Provider.of<FilterToBuyPageProvider>(context, listen: false)
                      .currentFilterIndex ==
                  0 &&
              Provider.of<FilterToBuyPageProvider>(context, listen: false).n! >
                  0)
          ? ListView.separated(
              separatorBuilder: (context, index) {
                return SizedBox(
                  height: gH(14.0),
                );
              },
              key: Key('builder ${data![0].productId}'),
              padding:
                  const EdgeInsets.only(left: 20.0, right: 20.0, top: 25.0),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: data.length,
              itemBuilder: (_, __) {
                return Column(
                  children: [
                    Text(__.toString()),
                    ExpansionTileToShowProductWidget(
                      isExpanded:
                          context.watch<ToBuyProductPageProvider>().current ==
                              __,
                      children: _children(data[__], context),
                      onChanged: (bool newState) {
                        if (newState) {
                          context
                              .read<ToBuyProductPageProvider>()
                              .changeCurrent(__);
                        } else {
                          context
                              .read<ToBuyProductPageProvider>()
                              .changeCurrent(-1);
                        }
                      },
                      data: data[__],
                    ),
                  ],
                );
              },
            )
          : Container(
              alignment: Alignment.center,
              height: gH(400.0),
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                    style: TextStyle(color: Colors.black, fontSize: gW(18.0)),
                    children: context
                                .watch<FilterToBuyPageProvider>()
                                .currentFilterIndex ==
                            0
                        ? [
                            const TextSpan(
                                text: "Hozirda malumotlar mavjud emas")
                          ]
                        : [
                            const TextSpan(text: "Tanlangan "),
                            TextSpan(
                                text: context
                                            .watch<FilterToBuyPageProvider>()
                                            .currentFilterIndex ==
                                        1
                                    ? "sana "
                                    : "korxona nomi "),
                            TextSpan(
                              text: context
                                          .watch<FilterToBuyPageProvider>()
                                          .currentFilterIndex ==
                                      1
                                  ? "${DTFM.maker(Provider.of<FilterToBuyPageProvider>(context, listen: false).from!.millisecondsSinceEpoch)} ${DTFM.maker(Provider.of<FilterToBuyPageProvider>(context).to!.millisecondsSinceEpoch)} "
                                  : Provider.of<FilterToBuyPageProvider>(
                                          context,
                                          listen: false)
                                      .currentCompName,
                              style: TextStyle(
                                  color: Colors.red, fontSize: gW(22.0)),
                            ),
                            const TextSpan(text: "bo'yicha ma'lumot topilmadi"),
                          ]),
              ),
            ),
    );
  }

  SliverAppBar _sliverAppBar() {
    return SliverAppBar(
      elevation: 0,
      backgroundColor: Colors.white,
      floating: true,
      flexibleSpace: Container(
        color: greyColor,
        child: ListView.separated(
          padding: EdgeInsets.symmetric(
            horizontal: gW(20.0),
          ),
          separatorBuilder: (context, index) {
            return SizedBox(width: gW(15.0));
          },
          itemCount: context.watch<FilterToBuyPageProvider>().filters.length,
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          itemBuilder: (_, __) {
            return Chip(
              shape: RoundedRectangleBorder(
                side: BorderSide(color: whiteColor),
                borderRadius: BorderRadius.circular(
                  gW(20.0),
                ),
              ),
              backgroundColor:
                  context.watch<FilterToBuyPageProvider>().currentFilterIndex !=
                          __
                      ? greyColor
                      : whiteColor,
              label: __ == 2
                  ? PopupMenuButton(
                      child: Text(
                        Provider.of<FilterToBuyPageProvider>(context,
                                listen: false)
                            .filters[2],
                        style: TextStyle(
                            color: Provider.of<FilterToBuyPageProvider>(context,
                                            listen: false)
                                        .currentFilterIndex ==
                                    2
                                ? mainColor
                                : whiteColor),
                      ),
                      padding: EdgeInsets.zero,
                      itemBuilder: (context) {
                        debugPrint(Provider.of<FilterToBuyPageProvider>(context,
                                listen: false)
                            .companyNamesPopUpMenuItems!
                            .elementAt(0)
                            .toString());
                        return Provider.of<FilterToBuyPageProvider>(context,listen: false).companyNamesPopUpMenuItems!.toList();
                      })
                  : _filterOnPressed(__),
            );
          },
        ),
      ),
    );
  }

  GestureDetector _filterOnPressed(int __) {
    return GestureDetector(
      onTap: () {
        if (__ == 0 &&
            0 !=
                Provider.of<FilterToBuyPageProvider>(context, listen: false)
                    .currentFilterIndex) {
          Provider.of<FilterToBuyPageProvider>(context, listen: false)
              .changeCurrentFilterIndex(0);
          setState(() {});
        } else if (__ == 1) {
          _showDataPicker(true);
        } else if (__ == 2) {
          // showCupertinoModalPopup(
          //     context: context,
          //     builder: (context) {
          //       return ListView.builder(
          //           physics: const NeverScrollableScrollPhysics(),
          //           shrinkWrap: true,
          //           itemBuilder: (_, __) {
          //             return PopupMenuItem(
          //                 value: " $__", child: Text(__.toString()));
          //           });
          //     });
        } else {
          debugPrint("Out of range:::");
        }
      },
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

  AppBar _appBar(BuildContext context) {
    return AppBar(
      centerTitle: true,
      backgroundColor: mainColor,
      elevation: 0,
      title: Text(
        context.watch<FilterToBuyPageProvider>().filters[
            context.watch<FilterToBuyPageProvider>().currentFilterIndex],
      ),
      actions: [
        IconButton(
          onPressed: () {
            debugPrint("");

            context.read<ToBuyProductPageProvider>().changeCurrent(-1);
            initState();
          },
          icon: const Icon(
            Icons.filter_list,
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
        child: Column(children: [
          SizedBox(height: gH(10.0)),
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
          SendButtonWidget((data.status! == "TO'LIQ TUGALLANGAN")
              ? null
              : () {
                  Provider.of<ToBuyProductPageProvider>(context, listen: false)
                      .clear();
                  _showDialog(data, context);
                }),
          SizedBox(
            height: gH(10.0),
          ),
        ]),
      )
    ];
  }

  Future<dynamic> _showDialog(Product data, BuildContext context) {
    return showDialog(
      useSafeArea: true,
      context: context,
      builder: (BuildContext alertContext) {
        return Material(
          type: MaterialType.transparency,
          child: Container(
            padding:
                EdgeInsets.symmetric(horizontal: gW(20.0), vertical: gH(15)),
            margin: EdgeInsets.only(
              top: gH(20.0),
              left: gW(10.0),
              right: gW(10.0),
              bottom: gH(380.0),
            ),
            decoration: BoxDecoration(
              color: whiteColor,
              border: Border.all(color: greyColor),
              borderRadius: BorderRadius.circular(
                gW(10.0),
              ),
            ),
            child: Column(
              children: [
                _richTextInRow(["Nomi:  ", data.productName!.toString()]),
                _richTextInRow(
                    ["Yaxlitlash miqdaori:  ", data.pack.toString()]),
                _richTextInRow(["Nechta:  ", data.numberPack.toString()]),
                _richTextInRow(["Umumiy:  ", data.weightPack.toString()]),
                SizedBox(height: gH(20.0)),
                _numberInputField(context),
                SizedBox(height: gH(20.0)),
                _commentInputField(context),
                SizedBox(height: gH(20.0)),
                _sendButtonInShowDialog(alertContext, data),
              ],
            ),
          ),
        );
      },
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
    return SendButtonWidget(() async {
      if ((Provider.of<ToBuyProductPageProvider>(con, listen: false)
              .numberController
              .text
              .isNotEmpty) &&
          (int.parse(Provider.of<ToBuyProductPageProvider>(con, listen: false)
                  .numberController
                  .text) >
              0)) {
        num number = int.parse(
                Provider.of<ToBuyProductPageProvider>(con, listen: false)
                    .numberController
                    .text) *
            (data.pack! > 0 ? data.pack! : 1);
        debugPrint("show dialog if ga kirdi ");

        await SupplierService()
            .sendProduct(
          SendProduct(
            comment: Provider.of<ToBuyProductPageProvider>(con, listen: false)
                .commentController
                .text,
            companyId: data.companyId,
            measurementType: data.measurementType,
            orderNumber: data.orderNumber,
            price: data.price,
            productId: data.productId,
            weightPack: number,
            pack: data.pack,
            numberPack: int.parse(
              Provider.of<ToBuyProductPageProvider>(con, listen: false)
                  .numberController
                  .text,
            ),
          ),
        )
            .then((value) {
          debugPrint("show dialog then ga kirdi ");

          if (value.success!) {
            debugPrint("if if ga kirdi ");

            _showToast(value.text!.toString(), value.success!);

            Provider.of<ToBuyProductPageProvider>(con, listen: false).clear();
            Provider.of<ToBuyProductPageProvider>(con, listen: false)
                .changeCurrent(-1);
            Navigator.pop(con);
          } else {
            debugPrint("if else ga kirdi ");
            _showToast(value.text!.toString(), value.success!);
          }
        });
      } else {
        debugPrint("show dialog else ga kirdi ");
        _showToast("Miqdorni kiriting, nol bolmasin", false);
      }
    });
  }

  TextField _numberInputField(BuildContext context) {
    return TextField(
      onChanged: (v) {},
      keyboardType: TextInputType.number,
      controller: context.read<ToBuyProductPageProvider>().numberController,
      decoration: DecorationMy.inputDecoration(
        "Qancha...",
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
        "Comment...",
        null,
      ),
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

  _fakeBody(List<Product>? data) {
    return ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (_, __) {
          return Column(
            children: [
              Text("companyId: " + data![__].companyId!.toString()),
              Text("id: " + data[__].id.toString()),
              Text("numberPack: " + data[__].numberPack.toString()),
              Text("createDate: " + data[__].createDate.toString()),
              Text("pack: " + data[__].pack.toString()),
              Text("productId: " + data[__].productId.toString()),
              Text("sendDate: " + data[__].sendDate.toString()),
              Text("updateDate: " + data[__].updateDate.toString()),
              Text("weightPack: " + data[__].weightPack.toString()),
              Text("comment: " + data[__].comment.toString()),
              Text("companyName: " + data[__].companyName.toString()),
              Text("measurementType: " + data[__].measurementType.toString()),
              Text("orderNumber: " + data[__].orderNumber.toString()),
              Text("price: " + data[__].price.toString()),
              Text("productName: " + data[__].productName.toString()),
              Text("status: " + data[__].status.toString()),
            ],
          );
        },
        separatorBuilder: (context, index) {
          return SizedBox(
            height: gH(20.0),
            child: const Divider(
              color: Colors.red,
            ),
          );
        },
        itemCount: 1);
  }

  _indicator() {
    return Center(
      child: CupertinoActivityIndicator(
        radius: gW(50.0),
      ),
    );
  }

  _showToast(String text, bool success) {
    Fluttertoast.showToast(
        msg: text,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 1,
        backgroundColor: success ? Colors.green : Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  _getDataByDateTime(List<Product> data) async {
    debugPrint("GEt by id ga kirdi");
    int n = 0;
    for (int i = 0; i < data.length; i++) {
      debugPrint("for $i");

      if (data[i].sendDate! <=
              Provider.of<FilterToBuyPageProvider>(context, listen: false)
                  .to!
                  .millisecondsSinceEpoch &&
          data[i].sendDate! >=
              Provider.of<FilterToBuyPageProvider>(context, listen: false)
                  .from!
                  .millisecondsSinceEpoch) {
        debugPrint("if ichi $i");
        n++;
      }
    }
    Provider.of<FilterToBuyPageProvider>(context, listen: false).initN(n);

    return n > 0;
  }

  _showDataPicker(bool isFrom) {
    DatePicker.showPicker(
      context,
      showTitleActions: true,
      theme: DatePickerTheme(
        backgroundColor: mainColor,
        containerHeight: gH(100.0),
        headerColor: whiteColor,
        itemStyle: const TextStyle(
            color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
        doneStyle: TextStyle(
            color: greyColor,
            fontSize: 16,
            fontWeight: FontWeight.bold,
            letterSpacing: gW(1.5),
            decoration: TextDecoration.underline),
      ),

      onConfirm: (date) {
        print('confirm $date');
        if (isFrom) {
          Provider.of<FilterToBuyPageProvider>(context, listen: false)
              .initFrom(date);
          _showDataPicker(false);
        } else {
          Provider.of<FilterToBuyPageProvider>(context, listen: false)
              .initTo(date);
          Provider.of<FilterToBuyPageProvider>(context, listen: false)
              .changeCurrentFilterIndex(1);

          setState(() {});
        }
      },
      // currentTime: DateTime.now(),
      locale: LocaleType.en,
    );
  }
}
