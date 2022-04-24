import 'package:flutter/material.dart';
import 'package:governess/consts/colors.dart';
import 'package:governess/consts/print_my.dart';
import 'package:governess/consts/size_config.dart';
import 'package:governess/models/supplier/product_model.dart';
import 'package:governess/providers/cooker/accept_product_provider.dart';
import 'package:governess/services/cooker_service.dart';
import 'package:governess/ui/widgets/expansion_tile_to_show_product_widget.dart';
import 'package:governess/ui/widgets/future_builder_of_no_data_widget.dart';
import 'package:governess/ui/widgets/indicator_widget.dart';
import 'package:provider/provider.dart';

class CookerAcceptProductPage extends StatelessWidget {
  const CookerAcceptProductPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: mainColor,
        elevation: 0,
        title: const Text("Mahsulotlarni qabul qilish"),
      ),
      body: FutureBuilder<List<Product>>(
        future: CookerService().getSentProductFromWarehouse(),
        builder: (context, AsyncSnapshot<List<Product>> snap) {
          if (snap.connectionState == ConnectionState.done && snap.hasData) {
            return _body(snap, context);
          } else if (snap.connectionState == ConnectionState.done &&
              !snap.hasData) {
            return const NoDataWidgetForFutureBuilder(
                "Hozircha Yuborilgan Mahsulotlar Mavjud Emas");
          } else {
            return IndicatorWidget(snap);
          }
        },
      ),
    );
  }

  ListView _body(AsyncSnapshot<List<Product>> snap, BuildContext context) {
    p(snap.data!.length.toString());
    return ListView.separated(
      padding: EdgeInsets.all(gW(20.0)),
      itemBuilder: (_, __) {
        return ExpansionTileToShowProductWidget(
          // children: [Text("data")],
          key: Key("$__ CookerAcceptProductPage"),
          isExpanded:
              context.watch<CookerAcceptProductProvider>().current == __,
          children: _children(snap.data![__], context),
          onChanged: (bool v) {
            if (v) {
              Provider.of<CookerAcceptProductProvider>(context, listen: false)
                  .changeCurren(__);
            } else {
              Provider.of<CookerAcceptProductProvider>(context, listen: false)
                  .changeCurren(-1);
            }
          },
          data: snap.data![__],
        );
      },
      separatorBuilder: (context, index) {
        return SizedBox(
          height: gH(20.0),
        );
      },
      itemCount: snap.data!.length,
    );
  }

  List<Widget> _children(Product data, BuildContext context) {
    // p(DTFM.maker(data.sendDate!));
    return <Widget>[
      Ink(
        decoration: BoxDecoration(
          border: Border.all(color: mainColor),
          borderRadius: BorderRadius.circular(
            gW(10.0),
          ),
        ),
        child: Column(children: [
          SizedBox(height: gH(10.0)),
          _textInRow("Korxona nomi", data.companyName.toString()),
          _divider(),
          _textInRow("Zayavka nomi", data.orderNumber.toString()),
          _divider(),
          _textInRow("Yuborilgan Sana", "DTFM.maker(data.sendDate!)"),
          _divider(),
          _textInRow("O'lchov birligi", data.measurementType.toString()),
          _divider(),
          _textInRow("Holati", data.status.toString()),
          _divider(),
          _textInRow("Yaxlitlash miqdori", data.pack.toString()),
          _divider(),
          _textInRow("Qadoqlar soni", data.numberPack.toString()),
          _divider(),
          _textInRow("Qadoqlangandan so'ng (miq)", data.weightPack.toString()),
          _divider(),
          SizedBox(
            height: gH(10.0),
          ),
        ]),
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
