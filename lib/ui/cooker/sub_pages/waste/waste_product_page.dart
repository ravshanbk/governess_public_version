import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:governess/consts/size_config.dart';
import 'package:governess/models/cooker/product_cooker_product.dart';
import 'package:governess/models/other/date_time_from_milliseconds_model.dart';
import 'package:governess/providers/cooker/show_in_out_list_product_provider.dart';
import 'package:governess/services/cooker_service.dart';
import 'package:governess/ui/widgets/date_time_show_button_widget.dart';
import 'package:governess/ui/widgets/show_in_out_list_product_widget.dart';
import 'package:governess/ui/widgets/text_in_row_widget.dart';
import 'package:provider/provider.dart';

class CookerWastProductPage extends StatefulWidget {
  const CookerWastProductPage({Key? key}) : super(key: key);

  @override
  State<CookerWastProductPage> createState() => _CookerWastProductPageState();
}

class _CookerWastProductPageState extends State<CookerWastProductPage> {
  DateTime start = DateTime.now();

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
              child: FutureBuilder<List<CookerInOutListProduct>>(
                future: CookerService().getGarbage(start, end),
                builder: (context,
                    AsyncSnapshot<List<CookerInOutListProduct>> snap) {
                  if (snap.connectionState == ConnectionState.done &&
                      snap.data!.isNotEmpty) {
                    return _body(context, snap.data!);
                  } else if (snap.connectionState == ConnectionState.done &&
                      snap.data!.isEmpty) {
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
      ),
    );
  }

  _body(BuildContext context, List<CookerInOutListProduct> data) {
    return ListView.separated(
      key: Key(DateTime.now().toString()),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.all(
        gW(20.0),
      ),
      itemBuilder: (_, __) {
        return ShowInOutListProductWidget(
          key: Key(DateTime.now().toString()),
          onChanged: (bool v) {
            if (v) {
              Provider.of<ShowInOutListProductProvider>(context, listen: false)
                  .changeCurrent(__);
            } else {
              Provider.of<ShowInOutListProductProvider>(context, listen: false)
                  .changeCurrent(-1);
            }
          },
          data: data[__],
          isExpanded:
              context.watch<ShowInOutListProductProvider>().current == __,
          children: List.generate(
            data[__].inOutList!.length,
            (index) => _inOutListProductChild(data, __, index, context),
          ),
        );
      },
      separatorBuilder: (context, index) {
        return SizedBox(height: gH(20.0));
      },
      itemCount: data.length,
    );
  }

  _inOutListProductChild(List<CookerInOutListProduct> data, int __, int index,
      BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 10.0,
        vertical: gH(5.0),
      ),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(
          gW(7.0),
        ),
      ),
      child: ExpansionTile(
        textColor: Colors.black,
        iconColor: Colors.grey,
        controlAffinity: ListTileControlAffinity.platform,
        onExpansionChanged: (v) {},
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              DTFM.maker(data[__].inOutList![index].enterDate!),
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: gW(18.0)),
            ),
            Container(
              margin: EdgeInsets.only(bottom: gW(10.0)),
              height: gH(40.0),
              width: gW(130.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: mainColor,
                  elevation: 0,
                ),
                onPressed: () {},
                child: const Text("Bekor qilish"),
              ),
            ),
          ],
        ),
        subtitle: SizedBox(
          height: gH(40.0),
          width: gW(150.0),
          child: ElevatedButton(
            key: UniqueKey(),
            style: ElevatedButton.styleFrom(
              primary: mainColor,
              elevation: 0,
              shape: RoundedRectangleBorder(
                side: BorderSide(color: whiteColor),
                borderRadius: BorderRadius.circular(
                  gW(7.0),
                ),
              ),
            ),
            child: Text(
              "Chiqarish",
              style: TextStyle(
                  color: whiteColor,
                  letterSpacing: gW(2.0),
                  fontSize: gW(18.0)),
            ),
            onPressed: () {},
          ),
        ),
        children: [
          // TextInRowWidget(
          //     "O'lchov birligi", data[__].inOutList![index].measurementType!),
          _divider(),
          TextInRowWidget(
              "Yaxlitlashi", data[__].inOutList![index].pack.toString()),
          _divider(),
          TextInRowWidget("Yaxlitlangan qiymati",
              data[__].inOutList![index].weightPack.toString()),
          _divider(),
          TextInRowWidget(
              "Soni", data[__].inOutList![index].numberPack.toString()),
          _divider(),
          SizedBox(height: gH(10.0)),
        ],
      ),
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
