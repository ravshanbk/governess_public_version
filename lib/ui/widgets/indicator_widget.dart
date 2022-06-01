import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:governess/consts/size_config.dart';

class IndicatorWidget extends StatelessWidget {
 final  AsyncSnapshot snap;
  const IndicatorWidget(this.snap,{Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
       String text;
    switch (snap.connectionState) {
      case ConnectionState.none:

      case ConnectionState.waiting:

      case ConnectionState.active:
        text = "Kuting...";
        break;
      case ConnectionState.done:
        text = "Bajarildi...";
        break;
    }

    return Scaffold(
    body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(text),
            CupertinoActivityIndicator(
              radius: gW(50.0),
            ),
          ],
        ),
      ),
    );
  }
}
