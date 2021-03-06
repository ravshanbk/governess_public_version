import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:governess/consts/size_config.dart';
import 'package:governess/consts/strings.dart';
import 'package:governess/models/cooker/to_accept_product_model.dart';
import 'package:governess/models/other/date_time_from_milliseconds_model.dart';
import 'package:governess/providers/cooker/accept_product_provider.dart';
import 'package:governess/services/cooker_service.dart';
import 'package:governess/services/network.dart';
import 'package:governess/ui/widgets/cooker_show_product_expansion_tile_widget.dart';
import 'package:governess/ui/widgets/date_time_show_button_widget.dart';
import 'package:provider/provider.dart';

class CookerAcceptProductArxivPage extends StatefulWidget {
  const CookerAcceptProductArxivPage({Key? key}) : super(key: key);

  @override
  State<CookerAcceptProductArxivPage> createState() =>
      _CookerAcceptProductArxivPageState();
}

class _CookerAcceptProductArxivPageState
    extends State<CookerAcceptProductArxivPage> {
  DateTime start = DateTime.now();
  DateTime end = DateTime.now();

  showDataPicker(BuildContext context, bool isStart) {
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
        if (isStart) {
          start = date;
        } else {
          end = date;
        }
        setState(() {});
      },
      locale: LocaleType.uz,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        slivers: [
          _sliverAppBAr(context),
          SliverToBoxAdapter(
            child: FutureBuilder<List<CookerProduct>>(
              future: CookerService().getInOutByDate(
                startt: start,
                endd: end,
              ),
              builder: (context, AsyncSnapshot<List<CookerProduct>> snap) {
                if (snap.connectionState == ConnectionState.done) {
                  if (snap.data!.isEmpty) {
                    return Center(
                      child: Column(
                        children: [
                          SizedBox(
                            height: gH(200.0),
                          ),
                          IconButton(
                              onPressed: () {
                                setState(
                                  () {},
                                );
                              },
                              icon: const Icon(Icons.refresh)),
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
                    return SizedBox(
                        height: 590, width: 335, child: _body(snap, context));
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
                      children: [
                        SizedBox(
                          height: gH(200.0),
                        ),
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
          ),
        ],
      ),
    );
  }

  SliverAppBar _sliverAppBAr(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      automaticallyImplyLeading: false,
      backgroundColor: Colors.white,
      elevation: 0,
      shadowColor: whiteColor,
      leadingWidth: 0.0,
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              gW(15.0),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              DateTimeShowButton(
                DTFM.maker(start.millisecondsSinceEpoch),
                () async {
                  bool isNet = await checkConnectivity();
                  if (isNet) {
                    showDataPicker(context, true);
                  } else {
                    showNoNetToast(false);
                  }
                },
              ),
              DateTimeShowButton(
                DTFM.maker(end.millisecondsSinceEpoch),
                () async {
                  bool isNet = await checkConnectivity();
                  if (isNet) {
                    showDataPicker(
                      context,
                      false,
                    );
                  } else {
                    showNoNetToast(false);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  ListView _body(
      AsyncSnapshot<List<CookerProduct>> snap, BuildContext context) {
    List<CookerProduct> data = snap.data!;
    data.sort(
      (a, b) => a.productName!.compareTo(b.productName!),
    );
    return ListView.separated(
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
    
      itemBuilder: (_, __) {
        return CookerShowProductExpansionTileWidget(
          key: Key("$__ CookerAcceptProductPage"),
          isExpanded:
              context.watch<CookerAcceptProductProvider>().current == __,
          children: _children(data[__], context),
          onChanged: (bool v) {
            if (v) {
              Provider.of<CookerAcceptProductProvider>(context, listen: false)
                  .changeCurrent(__);
            } else {
              Provider.of<CookerAcceptProductProvider>(context, listen: false)
                  .changeCurrent(-1);
            }
          },
          data: data[__],
        );
      },
      separatorBuilder: (context, index) {
        return SizedBox(
          height: gH(20.0),
        );
      },
      itemCount: data.length,
    );
  }

  List<Widget> _children(CookerProduct data, BuildContext context) {
    return <Widget>[
      Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: gH(10.0)),
          _divider(),
          _textInRow(
              "Jo'natuvchi",
              data.theSender!.length > 16
                  ? data.theSender!.toString().substring(0, 15)
                  : data.theSender!.toString()),
          _divider(),
          _textInRow("Buyurtma raqami", data.orderNumber!),
          _divider(),
          _textInRow("So'rov sanasi", DTFM.makerFromStr(data.timeOfShipment!)),
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
