import 'package:flutter/material.dart';
import 'package:governess/consts/colors.dart';
import 'package:governess/consts/decorations.dart';
import 'package:governess/consts/print_my.dart';
import 'package:governess/consts/size_config.dart';
import 'package:governess/models/cooker/receive_product_model.dart';
import 'package:governess/models/supplier/product_model.dart';
import 'package:governess/providers/cooker/accept_product_provider.dart';
import 'package:governess/services/cooker_service.dart';
import 'package:governess/ui/widgets/expansion_tile_to_show_product_widget.dart';
import 'package:governess/ui/widgets/future_builder_of_no_data_widget.dart';
import 'package:governess/ui/widgets/indicator_widget.dart';
import 'package:governess/ui/widgets/show_toast_function.dart';
import 'package:governess/ui/widgets/submit_button_widger.dart.dart';
import 'package:provider/provider.dart';

class CookerAcceptProductPage extends StatelessWidget {
  const CookerAcceptProductPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: mainColor,
        elevation: 0,
        title: const Text("Mahsulotlarni qabul qilish"),
      ),
      body: FutureBuilder<List<Product>>(
        future: CookerService().getSentProductFromWarehouse(),
        builder: (context, AsyncSnapshot<List<Product>> snap) {
          if (snap.connectionState == ConnectionState.done && snap.hasData) {
            return _body(snap, context);
          } else if (snap.connectionState == ConnectionState.done &&
              !snap.hasData) {
            return const NoDataWidgetForFutureBuilder(
                "Hozircha Yuborilgan Mahsulotlar Mavjud Emas");
          } else {
            return IndicatorWidget(snap);
          }
        },
      ),
    );
  }

  ListView _body(AsyncSnapshot<List<Product>> snap, BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.all(gW(20.0)),
      itemBuilder: (_, __) {
        return ExpansionTileToShowProductWidget(
          // children: [Text("data")],
          key: Key("$__ CookerAcceptProductPage"),
          isExpanded:
              context.watch<CookerAcceptProductProvider>().current == __,
          children: _children(snap.data![__], context),
          onChanged: (bool v) {
            if (v) {
              Provider.of<CookerAcceptProductProvider>(context, listen: false)
                  .changeCurrent(__);
            } else {
              Provider.of<CookerAcceptProductProvider>(context, listen: false)
                  .changeCurrent(-1);
            }
          },
          data: snap.data![__],
        );
      },
      separatorBuilder: (context, index) {
        return SizedBox(
          height: gH(20.0),
        );
      },
      itemCount: snap.data!.length,
    );
  }

  List<Widget> _children(Product data, BuildContext context) {
    // p(DTFM.maker(data.sendDate!));
    return <Widget>[
      Ink(
        decoration: BoxDecoration(
          border: Border.all(color: mainColor),
          borderRadius: BorderRadius.circular(
            gW(10.0),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: mainColor,
                elevation: 0,
                shadowColor: Colors.transparent,
              ),
              onPressed: () {
                _shownputDialog(context, data);
              },
              child: const Text("Qabul qilish"),
            ),
            SizedBox(height: gH(10.0)),
            _textInRow("Korxona nomi", data.companyName.toString()),
            _divider(),
            _textInRow("Zayavka nomi", data.orderNumber.toString()),
            _divider(),
            _textInRow("Yuborilgan Sana", "DTFM.maker(data.sendDate!)"),
            _divider(),
            _textInRow("O'lchov birligi", data.measurementType.toString()),
            _divider(),
            _textInRow("Holati", data.status.toString()),
            _divider(),
            _textInRow("Yaxlitlash miqdori", data.pack.toString()),
            _divider(),
            _textInRow("Qadoqlar soni", data.numberPack.toString()),
            _divider(),
            _textInRow(
                "Qadoqlangandan so'ng (miq)", data.weightPack.toString()),
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

  _shownputDialog(BuildContext context, Product product) {
    return showDialog(
      context: context,
      builder: (context) {
        return _SendProductShowDialogContentWidget(product);
      },
    );
  }
}

class _SendProductShowDialogContentWidget extends StatelessWidget {
  final Product data;
  const _SendProductShowDialogContentWidget(this.data, {Key? key})
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
            _richTextInRow(["Nechta:  ", data.numberPack.toString()]),
            _richTextInRow(["Umumiy:  ", data.weightPack.toString()]),
            const Spacer(),
            _numberInputField(context, data),
            const Spacer(),
            _priceInputField(context),
            const Spacer(),
            _commentInputField(context),
            const Spacer(),
            _sendButtonInShowDialog(context, data),
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

  SendButtonWidget _sendButtonInShowDialog(BuildContext con, Product data) {
    return SendButtonWidget(
      () async {
        if ((Provider.of<CookerAcceptProductProvider>(con, listen: false)
                .numberController
                .text
                .isNotEmpty) &&
            (int.parse(
                    Provider.of<CookerAcceptProductProvider>(con, listen: false)
                        .numberController
                        .text) >
                0)) {
          int number = (int.parse(Provider.of<CookerAcceptProductProvider>(con,
                          listen: false)
                      .numberController
                      .text) *
                  (data.pack! > 0 ? data.pack! : 1))
              .toInt();
          await CookerService()
              .acceptProduct(
            ReceiveProductModel(
              comment:
                  Provider.of<CookerAcceptProductProvider>(con, listen: false)
                      .commentController
                      .text,
              numberPack: int.parse(
                  Provider.of<CookerAcceptProductProvider>(con, listen: false)
                      .numberController
                      .text),
              weightPack: number,
            ),
            id: data.id!,
          )
              .then((value) {
            if (value.success!) {
              showToast(value.text!.toString(), value.success!, false);

              Provider.of<CookerAcceptProductProvider>(con, listen: false)
                  .clear();
              Provider.of<CookerAcceptProductProvider>(con, listen: false)
                  .changeCurrent(-1);
              Navigator.pop(con);
            } else {
              showToast(value.text!.toString(), value.success!, false);
            }
          });
        } else {
          showToast("Miqdorni kiriting, nol bolmasin", false, false);
        }
      },
      titleOfButton: "Qabul Qilish",
    );
  }

  _numberInputField(BuildContext context, Product data) {
    return TextFormField(
      onChanged: (v) {
        if (double.parse(v) > data.numberPack!) {
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

  TextField _priceInputField(BuildContext context) {
    return TextField(
      onChanged: (v) {},
      keyboardType: TextInputType.number,
      controller: context.read<CookerAcceptProductProvider>().priceController,
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
      controller: context.read<CookerAcceptProductProvider>().commentController,
      decoration: DecorationMy.inputDecoration(
        "Comment...",
        null,
      ),
    );
  }
}
