import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:governess/consts/colors.dart';
import 'package:governess/consts/size_config.dart';
import 'package:governess/models/in_out_list_product_model.dart';
import 'package:governess/models/other/date_time_from_milliseconds_model.dart';
import 'package:governess/providers/cooker/show_in_out_list_product_provider.dart';
import 'package:governess/providers/cooker/waste_product_cooker_page_provider.dart';
import 'package:governess/services/in_out_list_product_service.dart';
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
      body: FutureBuilder(
        future: InOutListProductService().getAvailableProductsInStorage(),
        builder: (context, AsyncSnapshot<List<InoutListProduct>> snap) {
          return !snap.hasData
              ? CupertinoActivityIndicator(
                  radius: gW(50.0),
                )
              : _body(context, snap.data!);
        },
      ),
    );
  }

  ListView _body(BuildContext context, List<InoutListProduct> data) {
    return ListView.separated(
      key: UniqueKey(),
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.all(
        gW(20.0),
      ),
      itemBuilder: (_, __) {
        return ShowInOutListProductWidget(
          key: UniqueKey(),
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

  ExpansionTile _inOutListProductChild(List<InoutListProduct> data, int __, int index, BuildContext context) {
    return ExpansionTile(
            title: Text(
              DTFM.maker(data[__].inOutList![index].enterDate!),
              textAlign: TextAlign.center,
            ),
            children: [
              TextInRowWidget(
                  "Sana", DTFM.maker(data[__].inOutList![index].enterDate!)),
              _divider(),
              TextInRowWidget("O'lchov birligi",
                  data[__].inOutList![index].measurementType!),
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
              Padding(
                padding: EdgeInsets.symmetric(horizontal: gW(10.0)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(
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
                          style: TextStyle(color: whiteColor),
                        ),
                        onPressed: () {
                          context
                              .read<WasteProductCookerPageProvider>()
                              .clear();
                          _showInputDialog(context);
                        },
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: gH(10.0)),
            ],
          );
  }

  Divider _divider() => Divider(
        color: mainColor,
        indent: gW(15.0),
        endIndent: gW(15.0),
      );

  _showInputDialog(BuildContext context) {
    showDialog(
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
                              Provider.of<WasteProductCookerPageProvider>(
                                      context,
                                      listen: false)
                                  .notify();
                            }
                          },
                          key: UniqueKey(),
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
                        width: gW(150.0),
                        child: ElevatedButton(
                          key: UniqueKey(),
                          style: ElevatedButton.styleFrom(
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
                                      .isEmpty &&
                                  context
                                      .watch<WasteProductCookerPageProvider>()
                                      .commentController
                                      .text
                                      .isEmpty
                              ? null
                              : () {},
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
                      key: UniqueKey(),
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
        });
  }
}
