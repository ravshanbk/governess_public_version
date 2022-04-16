import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:governess/consts/colors.dart';
import 'package:governess/consts/decorations.dart';
import 'package:governess/consts/size_config.dart';
import 'package:governess/models/other/date_time_from_milliseconds_model.dart';
import 'package:governess/models/supplier/product_with_available_company_names_model.dart';
import 'package:governess/models/supplier/send_product_model.dart';
import 'package:governess/models/supplier/product_model.dart';
import 'package:governess/providers/supplier/filter_to_buy_page_provider.dart';
import 'package:governess/providers/supplier/to_buy_products_page_provider.dart.dart';
import 'package:governess/services/supplier_service.dart';
import 'package:governess/ui/widgets/expansion_tile_to_show_product_widget.dart';
import 'package:governess/ui/widgets/show_toast_function.dart';
import 'package:governess/ui/widgets/submit_button_widger.dart.dart';
import 'package:provider/provider.dart';

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

    return Scaffold(
      appBar: _appBar(context),
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          _sliverAppBar(context),
          SliverToBoxAdapter(
            child: FutureBuilder<ProductWithAvailableCompnayNames>(
              future: SupplierService().getToBuyProducts(),
              builder: (context,
                  AsyncSnapshot<ProductWithAvailableCompnayNames> snap) {
                //////////////////////////////////////////////////////////

                /////////////////////////////////////////////////////////////////////////

                return snap.hasData ? _body(snap.data!, context) : _indicator();
              },
            ),
          ),
        ],
      ),
    );
  }

  _body(ProductWithAvailableCompnayNames datas, BuildContext context) {
    List<Product> data = datas.product;
    widget.dataw = datas.product;
    Provider.of<FilterToBuyPageProvider>(context, listen: false)
        .generateAvailableCompanyNames(data);
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
                context,
              )
            : current == 1
                ? _allBody(
                    widgetsDate,
                    context,
                  )
                : (current == 2
                    ? _allBody(
                        widgetsByCompanyName,
                        context,
                      )
                    : _allBody(
                        widgetsDate,
                        context,
                      ))));
  }

  Container _noDataBody(BuildContext context) {
    return Container(
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
                      style: TextStyle(color: Colors.red, fontSize: gW(22.0)),
                    ),
                    TextSpan(text: " / ", style: TextStyle(fontSize: gW(22.0))),
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
                      style: TextStyle(color: Colors.red, fontSize: gW(22.0)),
                    ),
                    const TextSpan(text: " bo'yicha ma'lumot topilmadi"),
                  ]),
      ),
    );
  }

  _allBody(List<Widget>? data, BuildContext context) {
    return data!.isNotEmpty
        ? ListView.separated(
            separatorBuilder: (context, index) {
              return SizedBox(
                height: gH(14.0),
                // child: Text(text),
              );
            },
            key: Key(DateTime.now().toString()),
            padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 25.0),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: data.length,
            itemBuilder: (_, __) {
              return data[__];
            },
          )
        : _noDataBody(context);
  }

  SliverAppBar _sliverAppBar(
    BuildContext context,
  ) {
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
                ? _popUpMenuButton(context, __)
                : _elevatedButton(__, context);
          },
        ),
      ),
    );
  }

  ElevatedButton _elevatedButton(int __, BuildContext context) {
    return ElevatedButton(
      focusNode: FocusNode(canRequestFocus: true),
      onPressed: () {
        debugPrint("Filter OnPressed $__");
        if (__ == 0) {
          Provider.of<FilterToBuyPageProvider>(context, listen: false)
              .changeCurrentFilterIndex(0);
          setState(() {
            Provider.of<FilterToBuyPageProvider>(context, listen: false)
                .changeCurrentFilterIndex(0);
          });
        } else if (__ == 1) {
          _showDataPicker(true);
          showToast("Qachondan ?", false, isCentr: true);
        } else {
          debugPrint("Out of range:::");
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

  PopupMenuButton<String> _popUpMenuButton(BuildContext context, int __) {
    return PopupMenuButton(
      onSelected: (String v) {
        debugPrint("men on selectedning valuesiman: $v");
        Provider.of<FilterToBuyPageProvider>(context, listen: false)
            .initCurrentCompanyname(v);
        _getDataByCompanyName(widget.dataw!, v);
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
      initialValue: Provider.of<FilterToBuyPageProvider>(context, listen: false)
          .availableCompanyNames[0],
      itemBuilder: (context) {
        return List.generate(
            Provider.of<FilterToBuyPageProvider>(context, listen: false)
                .availableCompanyNames
                .length, (index) {
          return PopupMenuItem(
            key: Key("$index"),
            value: Provider.of<FilterToBuyPageProvider>(context, listen: false)
                .availableCompanyNames[index],
            child: Container(
              padding:
                  EdgeInsets.symmetric(horizontal: gW(15.0), vertical: gH(5.0)),
              decoration: BoxDecoration(
                border: Border.all(color: mainColor_02),
                color: mainColor_02,
                borderRadius: BorderRadius.circular(
                  gW(7.0),
                ),
              ),
              child: Text(
                Provider.of<FilterToBuyPageProvider>(context, listen: false)
                    .availableCompanyNames[index],
                style: const TextStyle(color: Colors.black),
              ),
            ),
          );
        });
      },
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
            context.read<ToBuyProductPageProvider>().changeCurrent(-1);
            initState();
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

            showToast(value.text!.toString(), value.success!);

            Provider.of<ToBuyProductPageProvider>(con, listen: false).clear();
            Provider.of<ToBuyProductPageProvider>(con, listen: false)
                .changeCurrent(-1);
            Navigator.pop(con);
          } else {
            debugPrint("if else ga kirdi ");
            showToast(value.text!.toString(), value.success!);
          }
        });
      } else {
        debugPrint("show dialog else ga kirdi ");
        showToast("Miqdorni kiriting, nol bolmasin", false);
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

  _indicator() {
    return Center(
      child: CupertinoActivityIndicator(
        radius: gW(50.0),
      ),
    );
  }

  int _getDataByDateTime(List<Product> data) {
    List<Product> list = [];
    int m = 0;
    for (int i = 0; i < data.length; i++) {
      if (data[i].sendDate! <=
              Provider.of<FilterToBuyPageProvider>(context, listen: false)
                  .to!
                  .millisecondsSinceEpoch &&
          data[i].sendDate! >=
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

  int _getDataByCompanyName(List<Product> data, String name) {
    List<Product> list = [];
    int m = 0;

    for (int i = 0; i < data.length; i++) {
      debugPrint(data[i].companyName.toString() + " " + name);
      if (data[i].companyName! == name) {
        list.add(data[i]);
        m++;
      }
    }
    debugPrint("Length of comp name list: " + list.length.toString());
    Provider.of<FilterToBuyPageProvider>(context, listen: false)
        .generateByCompanyNameData(list);
    return m;
  }

  _showDataPicker(bool isFrom) {
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
            decoration: TextDecoration.underline),
      ),
      onConfirm: (date) {
        if (isFrom) {
          Provider.of<FilterToBuyPageProvider>(context, listen: false)
              .initFrom(date);
          _showDataPicker(false);
          showToast("Qachongacha ?", true, isCentr: true);
        } else {
          Provider.of<FilterToBuyPageProvider>(context, listen: false)
              .initTo(date);
          Provider.of<FilterToBuyPageProvider>(context, listen: false)
              .changeCurrentFilterIndex(1);
          _getDataByDateTime(widget.dataw!);
        }
      },
      locale: LocaleType.en,
    );
  }
}
