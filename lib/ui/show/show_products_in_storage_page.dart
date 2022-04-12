import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:governess/consts/colors.dart';
import 'package:governess/consts/size_config.dart';
import 'package:governess/models/in_out_list_product_model.dart';
import 'package:governess/providers/show_in_out_list_product_provider.dart';
import 'package:governess/services/in_out_list_product_service.dart';
import 'package:governess/ui/widgets/show_in_out_list_product_widget.dart';
import 'package:governess/ui/widgets/text_in_row_widget.dart';
import 'package:provider/provider.dart';

class ShowProductsInStoragePage extends StatelessWidget {
  const ShowProductsInStoragePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: FutureBuilder(
        future: InOutListProductService().getAvailableProductsInStorage(),
        builder: (context, AsyncSnapshot<List<InoutListProduct>> snap) {
          List<InoutListProduct> data = snap.data!;
          return !snap.hasData
              ? CupertinoActivityIndicator(
                  radius: gW(50.0),
                )
              : SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.symmetric(horizontal: gW(20.0)),
                        itemBuilder: (_, __) {
                          int current =
                              Provider.of<ShowInOutListProductProvider>(context,
                                      listen: false)
                                  .current;

                          return ShowInOutListProductWidget(
                              isExpanded: current == __,
                              children: List.generate(
                                data[__].inOutList!.length,
                                (index) => Column(
                                  children: [
                                    _divider(),
                                    TextInRowWidget(
                                        "O'lchov birligi",
                                        data[__]
                                            .inOutList![index]
                                            .measurementType
                                            .toString()),_divider(),
                                    TextInRowWidget(
                                        "EnterDate",
                                        data[__]
                                            .inOutList![index]
                                            .enterDate
                                            .toString()),_divider(),
                                    TextInRowWidget(
                                        "Mahsulot Id",
                                        data[__]
                                            .inOutList![index]
                                            .id
                                            .toString()),_divider(),
                                    TextInRowWidget(
                                        "Nechta",
                                        data[__]
                                            .inOutList![index]
                                            .numberPack
                                            .toString()),_divider(),
                                    TextInRowWidget(
                                        "Qadoq hajmi",
                                        data[__]
                                            .inOutList![index]
                                            .pack
                                            .toString()),_divider(),
                                    TextInRowWidget(
                                        "Narxi",
                                        data[__]
                                            .inOutList![index]
                                            .price
                                            .toString()),_divider(),
                                    TextInRowWidget(
                                        "Umumiy miqdor",
                                        data[__]
                                            .inOutList![index]
                                            .weightPack
                                            .toString()),_divider(),
                                  ],
                                ),
                              ),
                              onChanged: (v) {},
                              data: data[__]);
                        },
                        separatorBuilder: (context, index) {
                          return SizedBox(height: gH(20.0));
                        },
                        itemCount: data.length,
                      ),
                      ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (_, __) {
                            return Column(
                              children: List.generate(
                                data[__].inOutList!.length,
                                (index) => Column(children: [
                                  TextInRowWidget(
                                      "O'lchov birligi",
                                      data[__]
                                          .inOutList![index]
                                          .measurementType
                                          .toString()),
                                  TextInRowWidget(
                                      "EnterDate",
                                      data[__]
                                          .inOutList![index]
                                          .enterDate
                                          .toString()),
                                  TextInRowWidget(
                                      "Mahsulot Id",
                                      data[__].inOutList![index].id.toString()),
                                  TextInRowWidget(
                                      "Nechta",
                                      data[__]
                                          .inOutList![index]
                                          .numberPack
                                          .toString()),
                                  TextInRowWidget(
                                      "Qadoq hajmi",
                                      data[__]
                                          .inOutList![index]
                                          .pack
                                          .toString()),
                                  TextInRowWidget(
                                      "Narxi",
                                      data[__]
                                          .inOutList![index]
                                          .price
                                          .toString()),
                                  TextInRowWidget(
                                      "Umumiy miqdor",
                                      data[__]
                                          .inOutList![index]
                                          .weightPack
                                          .toString()),
                                ]),
                              ),
                            );
                          },
                          separatorBuilder: (context, index) {
                            return Container(
                              color: Colors.cyan.withOpacity(.5),
                              child: Column(
                                children: [
                                  TextInRowWidget("data[index].weight",
                                      data[index].weight.toString()),
                                  TextInRowWidget("data[index].productName",
                                      data[index].productName.toString())
                                ],
                              ),
                            );
                          },
                          itemCount: data.length),
                    ],
                  ),
                );
        },
      ),
    );
  }
  Divider _divider() => Divider(
        color: mainColor,
        indent: gW(15.0),
        endIndent: gW(15.0),
      );
}
