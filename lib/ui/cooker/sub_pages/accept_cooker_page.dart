import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:governess/consts/size_config.dart';
import 'package:governess/models/cooker/to_accept_product_model.dart';
import 'package:governess/services/cooker_service.dart';
import 'package:governess/ui/cooker/sub_pages/accept/accept_product_body_widget.dart';

class CookerAcceptProductDefaultPage extends StatefulWidget {
  const CookerAcceptProductDefaultPage({Key? key}) : super(key: key);

  @override
  State<CookerAcceptProductDefaultPage> createState() =>
      _CookerAcceptProductDefaultPageState();
}

class _CookerAcceptProductDefaultPageState
    extends State<CookerAcceptProductDefaultPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<CookerProduct>>(
        future: CookerService().getInOutDefault(),
        builder: (context, AsyncSnapshot<List<CookerProduct>> snap) {
          if (snap.connectionState == ConnectionState.done) {
            // ignore: prefer_is_empty
            if (snap.data!.length < 1) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                        onPressed: () {
                          setState(() {});
                        },
                        icon: const Icon(Icons.refresh_outlined)),
                    Text(
                      "Hozircha Mahsulotlar Mavjud Emas",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: mainColor,
                        fontSize: gW(20.0),
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return AcceptProductBodyWidget(data: snap.data!);
            }
          } else {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(snap.connectionState.name),
                  CupertinoActivityIndicator(
                    radius: gW(20.0),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
