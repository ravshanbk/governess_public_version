import 'package:flutter/material.dart';
import 'package:governess/consts/size_config.dart';
import 'package:governess/models/supplier/product_model.dart';
import 'package:governess/services/chef_service.dart';
import 'package:governess/ui/widgets/expansion_tile_to_show_product_widget.dart';

class AcceptProductPage extends StatelessWidget {
  const AcceptProductPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: ChefService().acceptProduct(),
          builder: (context, AsyncSnapshot<List<Product>> snap) {
            List<Product> data = snap.data!;

            return ListView.separated(
              itemBuilder: (_, __) {
                return ExpansionTileToShowProductWidget(
                    isExpanded: false,
                    children: const [Text("")],
                    onChanged: (v) {},
                    data: data[__]);
              },
              separatorBuilder: (context, index) {
                return SizedBox(
                  height: gH(20.0),
                );
              },
              itemCount: data.length,
            );
          }),
    );
  }
}
