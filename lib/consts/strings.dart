import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';


showNoNetToast(bool isCentr) {
  Fluttertoast.showToast(
    msg:"Qurilma Internet Tarmog'iga Ulanmagan",
    toastLength: isCentr ? Toast.LENGTH_LONG : Toast.LENGTH_SHORT,
    gravity: isCentr ? ToastGravity.CENTER : ToastGravity.TOP,
    timeInSecForIosWeb: 1,
    backgroundColor:  Colors.orange,
    textColor: Colors.white,
    fontSize: 25.0,
  );
}