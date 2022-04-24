import 'package:flutter/material.dart';
import 'package:governess/consts/colors.dart';
import 'package:governess/consts/size_config.dart';
import 'package:governess/models/in_out_list_product_model.dart';
import 'package:governess/models/other/date_time_from_milliseconds_model.dart';
import 'package:governess/providers/cooker/show_in_out_list_product_provider.dart';
import 'package:governess/services/cooker_service.dart';
import 'package:governess/ui/widgets/future_builder_of_no_data_widget.dart';
import 'package:governess/ui/widgets/indicator_widget.dart';
import 'package:governess/ui/widgets/show_in_out_list_product_widget.dart';
import 'package:governess/ui/widgets/text_in_row_widget.dart';
import 'package:provider/provider.dart';

class CookerShowProductsInStoragePage extends StatelessWidget {
  const CookerShowProductsInStoragePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: mainColor,
        elevation: 0,
        title: Text(DTFM.maker(DateTime.now().millisecondsSinceEpoch)),
      ),
      body: FutureBuilder(
        future: CookerService().getExistingProduct(),
        builder: (context, AsyncSnapshot<List<InoutListProduct>> snap) {
          if (snap.connectionState == ConnectionState.done && snap.data!.isNotEmpty) {
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

  ListView _body(BuildContext context, List<InoutListProduct> data) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.all(
        gW(20.0),
      ),
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
            (index) => Column(
              children: [
                _divider(),
                TextInRowWidget(
                    "O'lchov birligi", data[__].inOutList!.length.toString()),
                _divider(),
                TextInRowWidget("EnterDate",
                    DTFM.maker(data[__].inOutList![index].enterDate!)),
                _divider(),
                TextInRowWidget(
                    "Mahsulot Id", data[__].inOutList![index].id.toString()),
                _divider(),
                TextInRowWidget(
                    "Nechta", data[__].inOutList![index].numberPack.toString()),
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
