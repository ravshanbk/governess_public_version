import 'package:flutter/material.dart';
import 'package:governess/consts/size_config.dart';
import 'package:governess/models/cooker/product_cooker_product.dart';
import 'package:governess/models/other/date_time_from_milliseconds_model.dart';
import 'package:governess/providers/cooker/waste_product_cooker_page_provider.dart';
import 'package:governess/services/cooker_service.dart';
import 'package:governess/ui/widgets/future_builder_of_no_data_widget.dart';
import 'package:governess/ui/widgets/indicator_widget.dart';
import 'package:governess/ui/widgets/show_in_out_list_product_widget.dart';
import 'package:provider/provider.dart';

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
          future: CookerService().getExistingProduct(),
          builder: (context, AsyncSnapshot<List<Balancer>> snap) {
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

  

  ListView _body(BuildContext context, List<Balancer> data) {
    data.sort(
      (a, b) => a.productName!.compareTo(b.productName!),
    );
    return ListView.separated(
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: gH(20.0)),
      itemBuilder: (_, __) {
        return ShowInOutListProductWidget(
          data: data[__],
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
         title: data[__].productName!,
          isExpanded:
              context.watch<WasteProductCookerPageProvider>().current == __,
         
        );
      },
      separatorBuilder: (context, index) {
        return SizedBox(height: gH(20.0));
      },
      itemCount: data.length,
    );
  }


 

 
}

