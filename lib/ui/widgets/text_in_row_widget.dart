import 'package:flutter/material.dart';
import 'package:governess/consts/size_config.dart';

class TextInRowWidget extends StatelessWidget {
  final String title;
  final String text;
  const TextInRowWidget( this.title,this.text, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
