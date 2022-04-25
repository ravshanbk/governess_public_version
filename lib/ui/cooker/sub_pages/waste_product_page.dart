import 'package:flutter/material.dart';
import 'package:governess/consts/colors.dart';
import 'package:governess/consts/print_my.dart';
import 'package:governess/consts/size_config.dart';
import 'package:governess/models/cooker/product_cooker_product.dart';
import 'package:governess/models/other/date_time_from_milliseconds_model.dart';
import 'package:governess/providers/cooker/show_in_out_list_product_provider.dart';
import 'package:governess/providers/cooker/waste_product_cooker_page_provider.dart';
import 'package:governess/services/cooker_service.dart';
import 'package:governess/ui/widgets/future_builder_of_no_data_widget.dart';
import 'package:governess/ui/widgets/indicator_widget.dart';
import 'package:governess/ui/widgets/show_in_out_list_product_widget.dart';
import 'package:governess/ui/widgets/text_in_row_widget.dart';
import 'package:provider/provider.dart';

class CookerWastProductPage extends StatelessWidget {
  const CookerWastProductPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: mainColor,
        elevation: 0,
        title: const Text("Wast Product Page"),
      ),
      body: FutureBuilder<List<CookerProduct>>(
        future: CookerService().getAvailbleProductsInStorage(),
        builder: (context, AsyncSnapshot<List<CookerProduct>> snap) {
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
    );
  }

  ListView _body(BuildContext context, List<CookerProduct> data) {
    return ListView.separated(
      key: Key(DateTime.now().toString()),
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
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

  _inOutListProductChild(
      List<CookerProduct> data, int __, int index, BuildContext context) {
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
            onPressed: () {
              context.read<WasteProductCookerPageProvider>().clear();
              _showInputDialog(context, data[__].inOutList![index].id);
            },
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

  _showInputDialog(BuildContext context, dynamic productId) {
    return showDialog(
      context: context,
      builder: (context) {
        return Material(
          type: MaterialType.transparency,
          child: Container(
            padding: EdgeInsets.all(gW(20.0)),
            margin: EdgeInsets.only(
                bottom: gH(500.0),
                left: gW(10.0),
                right: gW(10.0),
                top: gH(100.0)),
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
                    SizedBox(
                      width: gW(150.0),
                      height: gH(60.0),
                      child: TextField(
                        onChanged: (v) {
                          if (v.isNotEmpty) {
                            Provider.of<WasteProductCookerPageProvider>(context,
                                    listen: false)
                                .notify();
                          }
                        },
                        keyboardType: TextInputType.number,
                        controller: context
                            .watch<WasteProductCookerPageProvider>()
                            .numberOfController,
                        decoration: InputDecoration(
                          label: const Text("Miqdor..."),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(
                              gW(7.0),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
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
                        onPressed: context
                                    .watch<WasteProductCookerPageProvider>()
                                    .commentController
                                    .text
                                    .isEmpty ||
                                context
                                    .watch<WasteProductCookerPageProvider>()
                                    .commentController
                                    .text
                                    .isEmpty
                            ? null
                            : () {
                               
                              },
                      ),
                    )
                  ],
                ),
                SizedBox(height: gH(10.0)),
                SizedBox(
                  height: 60.0,
                  child: TextField(
                    onChanged: (v) {
                      if (v.isNotEmpty) {
                        Provider.of<WasteProductCookerPageProvider>(context,
                                listen: false)
                            .notify();
                      }
                    },
                    maxLines: null,
                    expands: true,
                    keyboardType: TextInputType.name,
                    controller: context
                        .watch<WasteProductCookerPageProvider>()
                        .commentController,
                    decoration: InputDecoration(
                      label: const Text("Izoh..."),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                          gW(7.0),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
