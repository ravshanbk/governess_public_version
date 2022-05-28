import 'package:flutter/material.dart';
import 'package:governess/consts/size_config.dart';
import 'package:governess/models/cooker/product_cooker_product.dart';
import 'package:governess/models/other/date_time_from_milliseconds_model.dart';
import 'package:governess/providers/cooker/show_in_out_list_product_provider.dart';
import 'package:governess/services/cooker_service.dart';
import 'package:governess/ui/widgets/indicator_widget.dart';
import 'package:governess/ui/widgets/show_in_out_list_product_widget.dart';
import 'package:governess/ui/widgets/text_in_row_widget.dart';
import 'package:provider/provider.dart';

class CookerShowProductsInStoragePage extends StatelessWidget {
  const CookerShowProductsInStoragePage({Key? key}) : super(key: key);
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
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: mainColor,
          elevation: 0,
          title: Text(DTFM.maker(DateTime.now().millisecondsSinceEpoch)),
        ),
        body: FutureBuilder<List<CookerInOutListProduct>>(
          future: CookerService().getAvailbleProductsInStorage(),
          builder: (context, AsyncSnapshot<List<CookerInOutListProduct>> snap) {
            if (snap.connectionState == ConnectionState.done) {
              // ignore: prefer_is_empty
              if (snap.data!.length < 1) {
                return const Center(child: Text("Mahsulotlar mavjud emas"));
              }
              return _body(context: context, data: snap.data!);
              //  CookerInStorageSearchPage(data: snap.data!);
            } else {
              return IndicatorWidget(snap);
            }
          },
        ),
      ),
    );
  }

  ListView _body(
      {required BuildContext context,
      required List<CookerInOutListProduct> data}) {
         data.sort(
      (a, b) => a.productName!.compareTo(b.productName!),
    );

    return ListView.separated(
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.only(top: gH(20.0), left: gW(20.0), right: gW(20.0)),
      itemBuilder: (_, __) {
        return ShowInOutListProductWidget(
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
            (index) => Card(
              child: ExpansionTile(
                key: Key("key $index"),
                collapsedIconColor: Colors.transparent,
                iconColor: Colors.transparent,
                textColor: Colors.black,
                collapsedBackgroundColor: mainColor_02,
                title: Text(
                  DTFM.maker(data[__].inOutList![index].enterDate),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: gW(20.0), fontStyle: FontStyle.italic),
                ),
                children: [
                  _divider(),
                  TextInRowWidget(
                      "O'lchov birligi", data[__].inOutList![0].measurementType!),
                  _divider(),
                  TextInRowWidget("EnterDate",
                      DTFM.maker(data[__].inOutList![index].enterDate!)),
                 _divider(),
                  TextInRowWidget("Nechta",
                      data[__].inOutList![index].numberPack.toString()),
                  _divider(),
                  TextInRowWidget("Yaxlitlash miqdori",
                      data[__].inOutList![index].pack.toString()),
                  _divider(),
                  TextInRowWidget(
                      "Narxi", data[__].inOutList![index].price.toString()),
                  _divider(),
                  TextInRowWidget("Umumiy miqdor",
                      data[__].inOutList![index].weightPack.toString()),
                  _divider(),
                ],
              ),
            ),
          ),
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
}
