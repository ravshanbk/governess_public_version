import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:governess/consts/size_config.dart';

class IndicatorWidget extends StatelessWidget {
 final  AsyncSnapshot snap;
  const IndicatorWidget(this.snap,{Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(snap.connectionState.name),
            CupertinoActivityIndicator(
              radius: gW(50.0),
            ),
          ],
        ),
      ),
    );
  }
}
