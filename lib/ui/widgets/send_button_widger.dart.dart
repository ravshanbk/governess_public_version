import 'package:flutter/material.dart';
import 'package:governess/consts/size_config.dart';

class SendButtonWidget extends StatelessWidget {
 final double width;
  final String titleOfButton;
  final VoidCallback? onPressed;
  const SendButtonWidget(
      {required this.width,
      required this.onPressed,
      required this.titleOfButton,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(
        titleOfButton,
        style: TextStyle(color: whiteColor),
      ),
      style: ElevatedButton.styleFrom(
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        fixedSize: Size(width, gH(40.0)),
        // minimumSize: Size(gW(130.0), gH(40.0)),
        elevation: 0,
        primary: mainColor,
        shape: RoundedRectangleBorder(
          side: const BorderSide(color: Colors.green),
          borderRadius: BorderRadius.circular(
            gW(5.0),
          ),
        ),
      ),
    );
  }
}
