import 'package:flutter/material.dart';
import 'package:governess/consts/colors.dart';
import 'package:governess/consts/size_config.dart';

abstract class DecorationMy {
  static inputDecoration(String text1, String? text2) {
    return InputDecoration(
      floatingLabelStyle: TextStyle(
        color: greyColor,
      ),
      border: _inputBorder(),
      focusedBorder: _inputBorder(),
      enabledBorder: _inputBorder(),
      label: text2 != null
          ? RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                      text: text1,
                      style: TextStyle(color: mainColor, fontSize: gW(20.0))),
                  TextSpan(
                      text: text2,
                      style: TextStyle(color: Colors.black, fontSize: gW(20.0)))
                ],
              ),
            )
          : Text(
              text1,
              style: TextStyle(fontSize: gW(20.0)),
            ),
    );
  }

  static _inputBorder() {
    return OutlineInputBorder(
      borderSide: BorderSide(color: mainColor),
      borderRadius: BorderRadius.circular(
        gW(20.0),
      ),
    );
  }
}
