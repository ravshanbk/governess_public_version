import 'package:flutter/material.dart';
import 'package:governess/consts/size_config.dart';
import 'package:governess/models/cooker/product_cooker_product.dart';
import 'package:governess/models/other/date_time_from_milliseconds_model.dart';
import 'package:governess/providers/cooker/show_in_out_list_product_provider.dart';
import 'package:governess/services/cooker_service.dart';
import 'package:governess/ui/widgets/indicator_widget.dart';
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
        body: FutureBuilder<List<Balancer>>(
          future: CookerService().getAvailbleProductsInStorage(),
          builder: (context, AsyncSnapshot<List<Balancer>> snap) {
            if (snap.connectionState == ConnectionState.done) {
              if (snap.data!.isEmpty) {
                return const Center(child: Text("Mahsulotlar mavjud emas"));
              }
              return _body(context: context, data: snap.data!);
            } else {
              return IndicatorWidget(snap);
            }
          },
        ),
      ),
    );
  }

  ListView _body(
      {required BuildContext context, required List<Balancer> data}) {
    data.sort(
      (a, b) => a.productName!.compareTo(b.productName!),
    );

    return ListView.separated(
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.only(top: gH(20.0), left: gW(20.0), right: gW(20.0)),
      itemBuilder: (_, __) {
        return ExpansionTile(
          collapsedBackgroundColor: mainColor_02,
          iconColor: Colors.grey,
          textColor: mainColor,
          collapsedTextColor: Colors.black,
          key: Key(DateTime.now().toString()),
          initiallyExpanded:
              context.watch<ShowInOutListProductProvider>().current == __,
          title: Text(
            data[__].productName.toString().length > 40
                ? data[__].productName.toString().substring(0, 39)
                : data[__].productName.toString(),
            textAlign: TextAlign.center,
            style: TextStyle(
              letterSpacing: gW(2.0),
              decoration: TextDecoration.underline,
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Row(
            children: [
              Text(
                "Miqdori:",
                style: TextStyle(color: greyColor, fontSize: gW(14.0)),
              ),
              SizedBox(
                width: gW(5.0),
              ),
              Text(
                data[__].numberPack!.toString(),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: gW(14.0),
                  color: mainColor,
                ),
              ),
            ],
          ),
          children: [
            _divider(),
            TextInRowWidget("Qadoq miqdori", data[__].pack!.toString()),
            _divider(),
            TextInRowWidget("Miqdori", data[__].weight!.toString()),
            _divider(),
            TextInRowWidget("Qadoqlar soni", data[__].numberPack!.toString()),
            _divider(),
          ],
          onExpansionChanged: (bool v) {
            if (v) {
              Provider.of<ShowInOutListProductProvider>(context, listen: false)
                  .changeCurrent(__);
            } else {
              Provider.of<ShowInOutListProductProvider>(context, listen: false)
                  .changeCurrent(-1);
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
}
