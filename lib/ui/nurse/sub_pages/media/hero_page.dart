import 'package:flutter/material.dart';
import 'package:governess/consts/size_config.dart';

class HeroPage extends StatelessWidget {
  final Image image;
  const HeroPage({required this.image, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Navigator.pop(context);
        return Future.value(true);
      },
      child: Scaffold(
        body: Container(
          color: mainColor,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: gH(50.0)),
                child: image,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
