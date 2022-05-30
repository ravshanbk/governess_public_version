import 'package:flutter/material.dart';
import 'package:governess/consts/decorations.dart';
import 'package:governess/consts/size_config.dart';
import 'package:governess/consts/strings.dart';
import 'package:governess/models/cooker/product_cooker_product.dart';
import 'package:governess/models/cooker/waste_product_model.dart';
import 'package:governess/models/other/date_time_from_milliseconds_model.dart';
import 'package:governess/providers/cooker/garbage_provider.dart';
import 'package:governess/services/cooker_service.dart';
import 'package:governess/services/network.dart';
import 'package:governess/ui/widgets/future_builder_of_no_data_widget.dart';
import 'package:governess/ui/widgets/indicator_widget.dart';
import 'package:governess/ui/widgets/send_button_widger.dart.dart';
import 'package:governess/ui/widgets/text_in_row_widget.dart';
import 'package:provider/provider.dart';

class WastePage extends StatefulWidget {
  const WastePage({Key? key}) : super(key: key);

  @override
  State<WastePage> createState() => _WastePageState();
}

class _WastePageState extends State<WastePage> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return WillPopScope(
      onWillPop: () {
        Provider.of<GarbageProvider>(context, listen: false).changeCurrent(-1);

        return Future.value(true);
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: mainColor,
          elevation: 0,
          title: Text(
            DTFM.maker(DateTime.now().millisecondsSinceEpoch),
          ),
        ),
        body: FutureBuilder(
          future: CookerService().getExistingProduct(),
          builder: (context, AsyncSnapshot<List<Balancer>> snap) {
            if (snap.connectionState == ConnectionState.done &&
                snap.data!.isNotEmpty) {
              return _body(context, snap.data!);
            } else if (snap.connectionState == ConnectionState.done &&
                snap.data!.isEmpty) {
              return const NoDataWidgetForFutureBuilder(
                  "Hozircha Omborda Mahsulotlar Mavjud Emas");
            } else {
              return IndicatorWidget(snap);
            }
          },
        ),
      ),
    );
  }

  ListView _body(BuildContext context, List<Balancer> data) {
    data.sort(
      (a, b) => a.productName!.compareTo(b.productName!),
    );
    return ListView.separated(
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: gH(20.0)),
      itemBuilder: (_, __) {
        return ExpansionTile(
          collapsedBackgroundColor: mainColor_02,
          iconColor: Colors.grey,
          textColor: mainColor,
          collapsedTextColor: Colors.black,
          key: Key(DateTime.now().toString()),
          initiallyExpanded: __ == context.watch<GarbageProvider>().current,
          title: Text(
            data[__].productName!,
          ),
          children: [
            ElevatedButton(
                onPressed: () {
                  _shownputDialog(context, product: data[__], index: __);
                },
                child: const Text("Chiqarish")),
            _divider(),
            TextInRowWidget("Qadoq miqdori", data[__].pack!.toString()),
            _divider(),
            TextInRowWidget("Qadoqlar soni", data[__].numberPack!.toString()),
            _divider(),
            TextInRowWidget("Miqdori", data[__].weight!.toString()),
            _divider(),
          ],
          onExpansionChanged: (v) {
            if (__ ==
                Provider.of<GarbageProvider>(context, listen: false).current) {
              Provider.of<GarbageProvider>(context, listen: false)
                  .changeCurrent(-1);
            } else {
              Provider.of<GarbageProvider>(context, listen: false)
                  .changeCurrent(__);
            }
          },
        );
      },
      separatorBuilder: (context, index) {
        return SizedBox(height: gH(20.0));
      },
      itemCount: data.length,
    );
  }

  Divider _divider() => Divider(
        color: mainColor,
        indent: gW(15.0),
        endIndent: gW(15.0),
      );

  _shownputDialog(BuildContext context,
      {required Balancer product, required int index}) {
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
}

class _AcceptProductDialogContentWidget extends StatelessWidget {
  final Balancer data;
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
        child: Form(
          key: context.read<GarbageProvider>().formKey,
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
              _commentInputField(context),
              const Spacer(),
              _wasteButtonInShowDialog(context, data),
              const Spacer(),
            ],
          ),
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

  SendButtonWidget _wasteButtonInShowDialog(BuildContext con, Balancer data) {
    return SendButtonWidget(
      width: gW(200.0),
      onPressed: () async {
        bool isNet = await checkConnectivity();
        if (isNet) {
          if (Provider.of<GarbageProvider>(con, listen: false)
                  .numberController
                  .text
                  .isNotEmpty &&
              con.read<GarbageProvider>().commentController.text.isNotEmpty) {
            CookerService()
                .postGarbage(
              WasteProduct(
                comment: Provider.of<GarbageProvider>(con, listen: false)
                    .commentController
                    .text,
                numberPack: double.parse(
                    Provider.of<GarbageProvider>(con, listen: false)
                        .numberController
                        .text),
                productId: data.productId,
                weight: data.pack! > 0
                    ? double.parse(
                            Provider.of<GarbageProvider>(con, listen: false)
                                .numberController
                                .text) *
                        data.pack!
                    : double.parse(
                        Provider.of<GarbageProvider>(con, listen: false)
                            .numberController
                            .text,
                      ),
              ),
            )
                .then((value) {
              if (value.success!) {
                showToast(value.text!.toString(), value.success!, false);
                Provider.of<GarbageProvider>(con, listen: false)
                    .clearNumberController();
                Provider.of<GarbageProvider>(con, listen: false)
                    .changeCurrent(-1);
                toSetState();
                Navigator.pop(con);
              } else {
                Provider.of<GarbageProvider>(con, listen: false)
                    .clearNumberController();
                toSetState();

                showToast(value.text!.toString(), value.success!, false);
                toSetState();
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
      titleOfButton: "Chiqarish",
    );
  }

  _numberInputField(BuildContext context, Balancer data) {
    return TextFormField(
      validator: (v) {
        if (v!.isEmpty) return "Bo'sh bo'lmasligi kerak";
        return null;
      },
      onChanged: (v) {
        if (double.parse(v) > data.numberPack!) {
          showToast(
              "Kiritilgan miqdor keraklisidan oshmasligi kerak", false, false);
          Provider.of<GarbageProvider>(context, listen: false)
              .clearNumberController();
        }
      },
      keyboardType: TextInputType.number,
      controller: context.read<GarbageProvider>().numberController,
      decoration: DecorationMy.inputDecoration(
        "Miqdor...",
        null,
      ),
    );
  }

  _commentInputField(BuildContext context) {
    return TextFormField(
      validator: (v) {
        if (v!.isEmpty) {
          return "Bo'sh bo'lmasligi kerak";
        }
        return null;
      },
      onChanged: (v) {},
      keyboardType: TextInputType.text,
      controller: context.read<GarbageProvider>().commentController,
      decoration: DecorationMy.inputDecoration(
        "Izoh...",
        null,
      ),
    );
  }
}
