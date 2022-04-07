import 'package:flutter/material.dart';
import 'package:governess/consts/colors.dart';
import 'package:governess/consts/size_config.dart';

class CancelButtonWidget extends StatelessWidget {
  final VoidCallback callBack;
  const CancelButtonWidget({required this.callBack, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          side: BorderSide(color: mainColor),
          borderRadius: BorderRadius.circular(
            gW(15.0),
          ),
        ),
        primary: Colors.transparent,
        elevation: 0,
        fixedSize: Size(
          gW(150.0),
          gH(62.0),
        ),
      ),
      onPressed: callBack,
      child: Text(
        "Cancel",
        style: TextStyle(
          color: mainColor,
          letterSpacing: gW(3.0),
          fontSize: gW(20.0),
        ),
      ),
    );
  }
}
