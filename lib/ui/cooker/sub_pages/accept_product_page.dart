import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:governess/consts/colors.dart';
import 'package:governess/consts/decorations.dart';
import 'package:governess/consts/size_config.dart';
import 'package:governess/models/cooker/receive_product_model.dart';
import 'package:governess/models/cooker/to_accept_product_model.dart';
import 'package:governess/models/other/date_time_from_milliseconds_model.dart';
import 'package:governess/providers/cooker/accept_product_provider.dart';
import 'package:governess/services/cooker_service.dart';
import 'package:governess/ui/widgets/cooker_show_product_expansion_tile_widget.dart';
import 'package:governess/ui/widgets/date_time_show_button_widget.dart';
import 'package:governess/ui/widgets/show_toast_function.dart';
import 'package:governess/ui/widgets/send_button_widger.dart.dart';
import 'package:provider/provider.dart';

class CookerAcceptProductPage extends StatefulWidget {
  const CookerAcceptProductPage({Key? key}) : super(key: key);

  @override
  State<CookerAcceptProductPage> createState() =>
      _CookerAcceptProductPageState();
}

class _CookerAcceptProductPageState extends State<CookerAcceptProductPage> {
  DateTime start = DateTime(2022, 4, 28);

  DateTime end = DateTime(2022, 4, 30);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: mainColor,
        elevation: 0,
        title: const Text("Mahsulotlarni qabul qilish"),
      ),
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            floating: true,
            pinned: false,
            automaticallyImplyLeading: false,
            backgroundColor: greyColor,
            leadingWidth: 0.0,
            actions: [
              DateTimeShowButton(DTFM.maker(start.millisecondsSinceEpoch), () {
                _showDataPicker(
                  context,
                  true,
                );
              }),
              SizedBox(width: gW(50.0)),
              DateTimeShowButton(DTFM.maker(end.millisecondsSinceEpoch), () {
                _showDataPicker(
                  context,
                  false,
                );
              }),
              SizedBox(width: gW(23.0)),
            ],
          ),
          SliverToBoxAdapter(
            child: FutureBuilder<List<CookerProduct>>(
              future: CookerService().getInOut(start: start, end: end),
              builder: (context, AsyncSnapshot<List<CookerProduct>> snap) {
                if (snap.connectionState == ConnectionState.done &&
                    snap.hasData) {
                  return
                      //  const Text("Success");
                      _body(
                    snap,
                    context,
                  );
                } else if (snap.connectionState == ConnectionState.done &&
                    !snap.hasData) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SizedBox(height: gH(200.0)),
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
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(snap.connectionState.name),
                        CupertinoActivityIndicator(
                          radius: gW(20.0),
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
    );
  }

  ListView _body(
      AsyncSnapshot<List<CookerProduct>> snap, BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.all(gW(20.0)),
      itemBuilder: (_, __) {
        return CookerShowProductExpansionTileWidget(
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

  List<Widget> _children(CookerProduct data, BuildContext context) {
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
            Padding(
              padding: EdgeInsets.symmetric(horizontal: gW(20.0)),
              child: ElevatedButton(
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
            ),
            SizedBox(height: gH(10.0)),
            _textInRow("Korxona nomi", data.senderName.toString()),
            _divider(),
            // _textInRow("Zayavka nomi", data.orderNumber.toString()),
            _divider(),
            _textInRow("Yuborilgan Sana",
                data.enterDate == null ? "null" : DTFM.maker(data.enterDate!)),
            _divider(),
            _textInRow("O'lchov birligi", data.measurementType.toString()),
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

  _shownputDialog(BuildContext context, CookerProduct product) {
    return showDialog(
      context: context,
      builder: (context) {
        return _SendProductShowDialogContentWidget(product);
      },
    );
  }

  _showDataPicker(BuildContext context, bool idf) {
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
        if (idf) {
          start = date;
          setState(() {});
        } else {
          end = date;
          setState(() {});
        }
      },
      locale: LocaleType.en,
    );
  }
}

class _SendProductShowDialogContentWidget extends StatelessWidget {
  final CookerProduct data;
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
            // const Spacer(),
            // _priceInputField(context),
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
        if (Provider.of<CookerAcceptProductProvider>(con, listen: false)
                .numberController
                .text
                .isNotEmpty &&
            int.parse(
                    Provider.of<CookerAcceptProductProvider>(con, listen: false)
                        .numberController
                        .text) >
                0) {
          int number = (int.parse(Provider.of<CookerAcceptProductProvider>(con,
                          listen: false)
                      .numberController
                      .text) *
                  (data.pack! > 0 ? data.pack! : 1))
              .toInt();
          await CookerService()
              .acceptProduct(
            id: data.id!,
            data: ReceiveProductModel(
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

  _numberInputField(BuildContext context, CookerProduct data) {
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
