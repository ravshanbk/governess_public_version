import 'package:flutter/material.dart';
import 'package:governess/consts/size_config.dart';

class NoDataWidgetForFutureBuilder extends StatelessWidget {
  final String message;
  const NoDataWidgetForFutureBuilder(
    this.message, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     body:  Center(
        child: Text(
          message,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: mainColor,
            fontSize: gW(20.0),
          ),
        ),
      ),
    );
  }
}
