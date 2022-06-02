import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:governess/consts/size_config.dart';
import 'package:governess/models/cooker/to_accept_product_model.dart';
import 'package:governess/models/other/date_time_from_milliseconds_model.dart';
import 'package:governess/services/cooker_service.dart';
import 'package:governess/consts/decorations.dart';
import 'package:governess/consts/strings.dart';
import 'package:governess/models/cooker/receive_product_model.dart';
import 'package:governess/providers/cooker/accept_product_provider.dart';
import 'package:governess/services/network.dart';
import 'package:governess/ui/widgets/cooker_show_product_expansion_tile_widget.dart';
import 'package:governess/ui/widgets/send_button_widger.dart.dart';
import 'package:provider/provider.dart';

class CookerAcceptProductDefaultPage extends StatefulWidget {
  const CookerAcceptProductDefaultPage({Key? key}) : super(key: key);

  @override
  State<CookerAcceptProductDefaultPage> createState() =>
      _CookerAcceptProductDefaultPageState();
}

class _CookerAcceptProductDefaultPageState
    extends State<CookerAcceptProductDefaultPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<CookerProduct>>(
        future: CookerService().getInOutDefault(),
        builder: (context, AsyncSnapshot<List<CookerProduct>> snap) {
          if (snap.connectionState == ConnectionState.done) {
            if (snap.data!.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                        onPressed: () {
                          setState(() {});
                        },
                        icon: const Icon(Icons.refresh_outlined)),
                    Text(
                      "Hozircha Mahsulotlar Mavjud Emas",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: mainColor,
                        fontSize: gW(20.0),
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return _body(context: context, dataa: snap.data!);
            }
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
                    radius: gW(20.0),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }


  


  _body({required BuildContext context, required List<CookerProduct> dataa}) {
    dataa.sort(
      (a, b) => a.productName!.compareTo(b.productName!),
    );

    if (dataa.isNotEmpty) {
      return ListView.separated(
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(
          vertical: gH(20.0),
        ),
        itemBuilder: (_, __) {
          return CookerShowProductExpansionTileWidget(
            key: Key("$__ CookerAcceptProductPage"),
            isExpanded:
                context.watch<CookerAcceptProductProvider>().current == __,
            children: _children(
              context: context,
              data: dataa[__],
              index: __,
            ),
            onChanged: (bool v) {
              if (v) {
                Provider.of<CookerAcceptProductProvider>(context, listen: false)
                    .changeCurrent(__);
              } else {
                Provider.of<CookerAcceptProductProvider>(context, listen: false)
                    .changeCurrent(-1);
              }
            },
            data: dataa[__],
          );
        },
        separatorBuilder: (context, index) {
          return SizedBox(
            height: gH(20.0),
         
          );
        },
        itemCount: dataa.length,
      );
    }
    return Center(
      child: Column(
        children: [
          IconButton(
            onPressed: () {
              setState(() {});
            },
            icon: const Icon(Icons.refresh),
          ),
          const Text("Topilmadi")
        ],
      ),
    );
  }

  List<Widget> _children(
      {required CookerProduct data,
      required BuildContext context,
      required int index}) {
    return <Widget>[
      Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: gW(20.0)),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: mainColor,
                elevation: 0,
                shadowColor: Colors.transparent,
              ),
              onPressed: () async {
                bool isNet = await checkConnectivity();
                if (isNet) {
                  Provider.of<CookerAcceptProductProvider>(context,
                          listen: false)
                      .clear();
                  Provider.of<CookerAcceptProductProvider>(context,
                          listen: false)
                      .initNumberController(data.sendNumberPack!);
                  _shownputDialog(context, product: data, index: index);
                } else {
                  showNoNetToast(false);
                }
              },
              child: const Text("Qabul qilish"),
            ),
          ),
          SizedBox(height: gH(10.0)),
          _textInRow("Buyurtma raqami", data.orderNumber!),
          _divider(),
          _textInRow("So'rov sanasi", DTFM.makerFromStr(data.timeOfShipment)),
          _divider(),
          _textInRow("O'lchov birligi", data.measurementType!),
          _divider(),
          _textInRow("Qadoq miqdori", data.pack!),
          _divider(),
          _textInRow("Qabul qilinadigan miqdori", data.sendWeight!),
          _divider(),
          _textInRow("Qabul qilinadigan qadoqlar soni", data.sendNumberPack!),
          _divider(),
          _textInRow("Qabul qilingan miqdori", data.successWeight!),
          _divider(),
          _textInRow("Qabul qilingan qadoqlar soni", data.successNumberPack!),
          _divider(),
          _textInRow("Holati", data.status!),
          SizedBox(
            height: gH(10.0),
          ),
        ],
      )
    ];
  }

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

  _shownputDialog(BuildContext context,
      {required CookerProduct product, required int index}) {
    return showDialog(
      context: context,
      builder: (context) {
        return _AcceptProductDialogContentWidget(
          data: product,
          toSetState: () {
            setState(() {});
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
}

class _AcceptProductDialogContentWidget extends StatelessWidget {
  final CookerProduct data;
  final VoidCallback toSetState;
  const _AcceptProductDialogContentWidget(
      {required this.toSetState, required this.data, Key? key})
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
          bottom: gH(340.0),
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
            _richTextInRow(["Nechta:  ", data.sendWeight.toString()]),
            _richTextInRow(["Umumiy:  ", data.sendNumberPack.toString()]),
            const Spacer(),
            _numberInputField(context, data),
            const Spacer(),
            _commentInputField(context),
            const Spacer(),
            _acceptButtonInShowDialog(context, data),
            const Spacer(),
          ],
        ),
      ),
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

  SendButtonWidget _acceptButtonInShowDialog(
      BuildContext con, CookerProduct data) {
    return SendButtonWidget(
      width: gW(200.0),
      onPressed: () async {
        bool isNet = await checkConnectivity();
        if (isNet) {
          if (Provider.of<CookerAcceptProductProvider>(con, listen: false)
              .numberController
              .text
              .isNotEmpty) {
            double number = (double.parse(
                        Provider.of<CookerAcceptProductProvider>(con,
                                listen: false)
                            .numberController
                            .text) *
                    (double.parse(data.pack!) > 0 ? double.parse(data.pack!) : 1))
                .toDouble();
            CookerService()
                .acceptProduct(
              id: data.id!,
              data: ReceiveProductModel(
                comment:
                    Provider.of<CookerAcceptProductProvider>(con, listen: false)
                        .commentController
                        .text,
                numberPack: double.parse(
                    Provider.of<CookerAcceptProductProvider>(con, listen: false)
                        .numberController
                        .text),
                weight: number,
              ),
            )
                .then((value) {
              if (value.success!) {
                showToast(value.text!.toString(), value.success!, false);
                toSetState();

                Provider.of<CookerAcceptProductProvider>(con, listen: false)
                    .changeCurrent(-1);
                Navigator.pop(con);
              } else {
                toSetState();

                showToast(value.text!.toString(), value.success!, false);
                Navigator.pop(con);
              }
            });
          } else {
            toSetState();

            showToast("Miqdorni kiriting, nol bolmasin", false, false);
          }
        } else {
          showNoNetToast(false);
        }
      },
      titleOfButton: "Qabul Qilish",
    );
  }

  _numberInputField(BuildContext context, CookerProduct data) {
    return TextFormField(
      onChanged: (v) {
        if (double.parse(v) > double.parse(data.sendNumberPack!)) {
          showToast(
              "Kiritilgan miqdor keraklisidan oshmasligi kerak", false, false);
          Provider.of<CookerAcceptProductProvider>(context, listen: false)
              .clearNumberController();
        }
      },
      keyboardType: TextInputType.number,
      controller: context.read<CookerAcceptProductProvider>().numberController,
      decoration: DecorationMy.inputDecoration(
        "Miqdor...",
        null,
      ),
    );
  }

  TextField _commentInputField(BuildContext context) {
    return TextField(
      onChanged: (v) {},
      keyboardType: TextInputType.text,
      controller: context.read<CookerAcceptProductProvider>().commentController,
      decoration: DecorationMy.inputDecoration(
        "Izoh...",
        null,
      ),
    );
  }
}
