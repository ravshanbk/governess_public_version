import 'package:flutter/material.dart';
import 'package:governess/consts/colors.dart';
import 'package:governess/consts/size_config.dart';

class DateTimeShowButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;
  const DateTimeShowButton(this.title, this.onPressed, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Ink(
        padding: EdgeInsets.all(gW(2.0)),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              gW(8.0),
            ),
            color: whiteColor),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: mainColor_02,
            elevation: 0,
            shadowColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                gW(7.0),
              ),
            ),
          ),
          onPressed: onPressed,
          child: Text(
            title,
            style: const TextStyle(
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
