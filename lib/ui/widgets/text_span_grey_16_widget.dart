import 'package:flutter/material.dart';
import 'package:governess/consts/colors.dart';
import 'package:governess/consts/size_config.dart';

TextSpan textSpanGrey16Widget(String text) {
  return TextSpan(
    text: text,
    style: TextStyle(
      color: greyColor,
      fontSize: gW(16.0),
    ),
  );
}

TextSpan textSpan18black(String text) {
  return TextSpan(
    text: text,
    style: TextStyle(
      color: Colors.black,
      fontSize: gW(18.0),
    ),
  );
}
