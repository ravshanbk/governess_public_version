import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

showToast(String text, bool success, {bool? isCentr}) {
  Fluttertoast.showToast(
    msg: text,
    toastLength: isCentr! ? Toast.LENGTH_LONG : Toast.LENGTH_SHORT,
    gravity: isCentr ? ToastGravity.CENTER : ToastGravity.TOP,
    timeInSecForIosWeb: 1,
    backgroundColor: success ? Colors.green : Colors.red,
    textColor: Colors.white,
    fontSize: isCentr?25.0:16.0,
  );
}
