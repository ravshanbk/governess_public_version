import 'package:flutter/material.dart';
import 'package:governess/consts/size_config.dart';
import 'package:governess/consts/strings.dart';
import 'package:governess/models/cooker/product_cooker_product.dart';
import 'package:governess/models/other/date_time_from_milliseconds_model.dart';
import 'package:governess/providers/cooker/waste_product_cooker_page_provider.dart';
import 'package:governess/services/cooker_service.dart';
import 'package:governess/ui/widgets/future_builder_of_no_data_widget.dart';
import 'package:governess/ui/widgets/indicator_widget.dart';
import 'package:governess/ui/widgets/send_button_widger.dart.dart';
import 'package:governess/ui/widgets/show_in_out_list_product_widget.dart';
import 'package:governess/ui/widgets/text_in_row_widget.dart';
import 'package:provider/provider.dart';
import 'package:governess/models/cooker/waste_product_model.dart';

class CookerShowExistingProductPage extends StatelessWidget {
  const CookerShowExistingProductPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return WillPopScope(
      onWillPop: () {
        Provider.of<WasteProductCookerPageProvider>(context, listen: false)
            .changeCurrent(-1);

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
          future: future(),
          builder: (context, AsyncSnapshot<List<CookerInOutListProduct>> snap) {
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

  Future<List<CookerInOutListProduct>> future() async {
    DateTime keyOf = DateTime(DateTime.now().year, DateTime.now().month,
        DateTime.now().day, DateTime.now().hour, DateTime.now().minute);
    Map<String, List<CookerInOutListProduct>> _cache = {};
    if (_cache.containsKey(keyOf.millisecondsSinceEpoch.toString())) {
      return Future.value(_cache[keyOf.millisecondsSinceEpoch.toString()]);
    } else {
      return await CookerService().getExistingProduct();
    }
  }

  ListView _body(BuildContext context, List<CookerInOutListProduct> data) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: gH(20.0)),
      itemBuilder: (_, __) {
        return ShowInOutListProductWidget(
          key: Key("$__ StarageProducts"),
          onChanged: (bool v) {
            if (v) {
              Provider.of<WasteProductCookerPageProvider>(context,
                      listen: false)
                  .changeCurrent(__);
            } else {
              Provider.of<WasteProductCookerPageProvider>(context,
                      listen: false)
                  .changeCurrent(-1);
            }
          },
          data: data[__],
          isExpanded:
              context.watch<WasteProductCookerPageProvider>().current == __,
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
    return Card(
      elevation: 0,
      color: mainColor_02,
      margin: EdgeInsets.symmetric(
        horizontal: 10.0,
        vertical: gH(5.0),
      ),
      child: ExpansionTile(
        collapsedIconColor: Colors.transparent,
        collapsedBackgroundColor: mainColor_02,
        textColor: Colors.black,
        iconColor: Colors.transparent,
        controlAffinity: ListTileControlAffinity.platform,
        onExpansionChanged: (v) {},
        title: Text(
          DTFM.maker(data[__].inOutList![index].enterDate!),
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: gW(18.0)),
        ),
        expandedAlignment: Alignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SendButtonWidget(
                width: gW(160.0),
                onPressed: () {
                  // p(data[__].productId.toString());
                  // p(data[__].inOutList![index].id!.toString());
                  Provider.of<WasteProductCookerPageProvider>(context,
                          listen: false)
                      .clear();
                  _showWasteDialog(context, data, __, index);
                },
                titleOfButton: "Chiqarish",
              ),
              SizedBox(
                height: gH(10.0),
              ),
              SendButtonWidget(
                width: gW(130.0),
                onPressed: () {
                  CookerService().deleteGarbage(data[0].productId!).then(
                    (value) {
                      if (value) {
                        showToast("Muvaffaqiyat", true, false);
                      } else {
                        showToast("Chiqarilmadi", false, false);
                      }
                    },
                  );
                },
                titleOfButton: "Bekor qilish",
              ),
            ],
          ),
          SizedBox(height: gH(10.0)),
          _divider(),
          TextInRowWidget(
              "O'lchov birligi", data[__].inOutList![index].measurementType!),
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

  Future<dynamic> _showWasteDialog(BuildContext context,
      List<CookerInOutListProduct> data, int __, int index) {
    return showDialog(
      context: context,
      builder: (context) {
        return _ShowDialogDateContent(
            data[__].productId, data[__].inOutList![index].id!);
      },
    );
  }

  Divider _divider() => Divider(
        color: mainColor,
        indent: gW(15.0),
        endIndent: gW(15.0),
      );
}

class _ShowDialogDateContent extends StatelessWidget {
  final dynamic productId;
  final String id;

  const _ShowDialogDateContent(
    this.productId,
    this.id, {
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Container(
        padding: EdgeInsets.all(gW(20.0)),
        margin: EdgeInsets.only(
          bottom: gH(500.0),
          left: gW(10.0),
          right: gW(10.0),
          top: gH(100.0),
        ),
        decoration: BoxDecoration(
          color: whiteColor,
          borderRadius: BorderRadius.circular(
            gW(10.0),
          ),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _numberInputFieldInDialog(context),
                _wasteButtonInDialog(context, productId, id)
              ],
            ),
            SizedBox(height: gH(10.0)),
            _commentInputFieldInDialog(context),
          ],
        ),
      ),
    );
  }

  SizedBox _numberInputFieldInDialog(BuildContext context) {
    return SizedBox(
      width: gW(150.0),
      height: gH(60.0),
      child: TextField(
        onChanged: (v) {
          if (v.isNotEmpty) {
            Provider.of<WasteProductCookerPageProvider>(context, listen: false)
                .notify();
          }
        },
        keyboardType: TextInputType.number,
        controller:
            context.watch<WasteProductCookerPageProvider>().numberOfController,
        decoration: InputDecoration(
          label: const Text("Miqdor..."),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
              gW(7.0),
            ),
          ),
        ),
      ),
    );
  }

  _commentInputFieldInDialog(BuildContext context) {
    return SizedBox(
      height: 60.0,
      child: TextField(
        onChanged: (v) {
          if (v.isNotEmpty) {
            Provider.of<WasteProductCookerPageProvider>(context, listen: false)
                .notify();
          }
        },
        maxLines: null,
        expands: true,
        keyboardType: TextInputType.name,
        controller:
            context.watch<WasteProductCookerPageProvider>().commentController,
        decoration: InputDecoration(
          label: const Text("Izoh..."),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
              gW(7.0),
            ),
          ),
        ),
      ),
    );
  }

  _wasteButtonInDialog(BuildContext context, dynamic productId, String id) {
    return SizedBox(
      height: gH(40.0),
      width: gW(120.0),
      child: ElevatedButton(
        key: UniqueKey(),
        style: ElevatedButton.styleFrom(
          shadowColor: Colors.transparent,
          primary: mainColor_02,
          elevation: 0,
          shape: RoundedRectangleBorder(
            side: BorderSide(color: mainColor),
            borderRadius: BorderRadius.circular(
              gW(7.0),
            ),
          ),
        ),
        child: Text(
          "Chiqarish",
          style: TextStyle(color: mainColor),
        ),
        onPressed:
            Provider.of<WasteProductCookerPageProvider>(context, listen: false)
                        .commentController
                        .text
                        .isEmpty ||
                    Provider.of<WasteProductCookerPageProvider>(context,
                            listen: false)
                        .numberOfController
                        .text
                        .isEmpty
                ? null
                : () {
                    CookerService().postGarbage(
                      WasteProduct(
                        comment: Provider.of<WasteProductCookerPageProvider>(
                                context,
                                listen: false)
                            .commentController
                            .text,
                        productId: productId,
                        weight: int.parse(
                          Provider.of<WasteProductCookerPageProvider>(context,
                                  listen: false)
                              .numberOfController
                              .text,
                        ),
                      ),
                      id,
                    );
                  },
      ),
    );
  }
}
