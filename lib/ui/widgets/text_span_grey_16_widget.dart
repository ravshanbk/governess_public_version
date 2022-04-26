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

TextSpan textSpan22Maincolor(String text) {
  return TextSpan(
    text: text,
    style: TextStyle(
      fontWeight: FontWeight.bold,
      color: mainColor,
      fontSize: gW(22.0),
    ),
  );
}
