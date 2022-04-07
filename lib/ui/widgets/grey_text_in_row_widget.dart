import 'package:flutter/material.dart';
import 'package:governess/consts/colors.dart';
import 'package:governess/consts/size_config.dart';

class GreyTextInRowWidget extends StatelessWidget {
  final String text1, text2;
  const GreyTextInRowWidget(this.text1,this.text2,{Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: gW(30.0), right: gW(50.0)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text1,
            style: TextStyle(fontSize: gW(18.0), color: greyColor),
          ),
          const Spacer(),
          Text(
            text2,
            style: TextStyle(fontSize: gW(18.0), color: greyColor),
          ),
        ],
      ),
    );
  }
}
