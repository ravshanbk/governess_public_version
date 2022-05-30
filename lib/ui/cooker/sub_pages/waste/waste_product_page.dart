import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:governess/consts/decorations.dart';
import 'package:governess/consts/size_config.dart';
import 'package:governess/consts/strings.dart';
import 'package:governess/models/cooker/garbage_model.dart';
import 'package:governess/models/cooker/receive_product_model.dart';
import 'package:governess/models/cooker/to_accept_product_model.dart';
import 'package:governess/models/other/date_time_from_milliseconds_model.dart';
import 'package:governess/models/supplier/product_model.dart';
import 'package:governess/providers/cooker/accept_product_provider.dart';
import 'package:governess/providers/cooker/garbage_provider.dart';
import 'package:governess/providers/cooker/show_in_out_list_product_provider.dart';
// import 'package:governess/providers/supplier/filter_to_buy_page_provider.dart';
import 'package:governess/services/cooker_service.dart';
import 'package:governess/services/network.dart';
import 'package:governess/ui/cooker/sub_pages/waste/waste_page.dart';
import 'package:governess/ui/widgets/date_time_show_button_widget.dart';
import 'package:governess/ui/widgets/send_button_widger.dart.dart';
import 'package:governess/ui/widgets/text_in_row_widget.dart';
import 'package:provider/provider.dart';

class CookerWastProductPage extends StatefulWidget {
  const CookerWastProductPage({Key? key}) : super(key: key);

  @override
  State<CookerWastProductPage> createState() => _CookerWastProductPageState();
}

class _CookerWastProductPageState extends State<CookerWastProductPage> {
  DateTime start = DateTime.now();
  bool isDefault = true;
  DateTime end = DateTime.now();

  @override
  Widget build(BuildContext context) {
  
    SizeConfig().init(context);
    return WillPopScope(
      onWillPop: () {
        Provider.of<ShowInOutListProductProvider>(context, listen: false)
            .changeCurrent(-1);
        return Future.value(true);
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: mainColor,
          elevation: 0,
          title: const Text("Chiqitlar"),
          actions: [
            IconButton(
                onPressed: () {
                  setState(() {
                    isDefault = true;
                  });
                },
                icon: Padding(
                  padding: EdgeInsets.only(right: gW(20.0)),
                  child: const Icon(Icons.refresh),
                ))
          ],
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
                DateTimeShowButton(DTFM.maker(start.millisecondsSinceEpoch),
                    () {
                  showDataPicker(context, true);
                }),
                SizedBox(width: gW(50.0)),
                DateTimeShowButton(DTFM.maker(end.millisecondsSinceEpoch), () {
                  showDataPicker(context, false);
                }),
                SizedBox(width: gW(23.0)),
              ],
            ),
            SliverToBoxAdapter(
              child: FutureBuilder<List<Garbage>>(
                future: CookerService()
                    .getGarbage(start: start, end: end, isDefault: isDefault),
                builder: (context, AsyncSnapshot<List<Garbage>> snap) {
                  if (snap.connectionState == ConnectionState.done) {
                    if (snap.data!.isEmpty) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            SizedBox(height: gH(200.0)),
                            Text(
                              "Hozircha Chiqitga Chiqarilgan Mahsulotlar Mavjud Emas",
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
                      return _body(context, snap.data!);
                    }
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
        floatingActionButton: FloatingActionButton(
          backgroundColor: mainColor,
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) =>const  WastePage()));
          },
          child: Icon(
            Icons.add,
            size: gW(50.0),
          ),
        ),
      ),
    );
  }

  _body(BuildContext context, List<Garbage> data) {
    data.sort(
      (a, b) => a.productName!.compareTo(b.productName!),
    );
    return ListView.separated(
      key: Key(DateTime.now().toString()),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.all(
        gW(20.0),
      ),
      itemBuilder: (_, __) {
        return ExpansionTile(
            collapsedBackgroundColor: mainColor_02,
            iconColor: Colors.grey,
            textColor: mainColor,
            collapsedTextColor: Colors.black,
            key: Key(DateTime.now().toString()),
            initiallyExpanded: context.watch<GarbageProvider>().current == __,
            title: Text(data[__].productName!),
            children: [
              _divider(),
              TextInRowWidget("Miqdori", data[__].weight.toString()),
              _divider(),
              TextInRowWidget("Qabul qiluvchi", data[__].acceptByName.toString()),
              _divider(),
              TextInRowWidget(
                  "Tasdiqlangan san", DTFM.maker(data[__].acceptDate)),
              _divider(),
              TextInRowWidget("Oshpaz Ismi", data[__].createdByName.toString()),
              _divider(),
              TextInRowWidget(
                  "Chiqarilgan sana", DTFM.maker(data[__].createDate)),
              _divider(),
              TextInRowWidget("MTT nomi", data[__].kindergartenName.toString()),
              _divider(),
              TextInRowWidget("Holati", data[__].status.toString()),
              _divider(),
              TextInRowWidget(
                  "O'zgartirilgan sana", DTFM.maker(data[__].updateDate)),
              _divider(),
              const TextInRowWidget("Izoh", ""),
              Text(data[__].comment!.toString()),
              _divider(),
            ],
            onExpansionChanged: (v) {
              if (context.watch<GarbageProvider>().current == __) {
                Provider.of<GarbageProvider>(context, listen: false)
                    .changeCurrent(-1);
              } else {
                Provider.of<GarbageProvider>(context, listen: false)
                    .changeCurrent(__);
              }
            });
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
          isDefault = false;
          setState(() {});
        } else {
          end = date;
          isDefault = false;
          setState(() {});
        }
      },
      locale: LocaleType.en,
    );
  }

 }
