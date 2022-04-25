import 'package:flutter/material.dart';
import 'package:governess/consts/colors.dart';
import 'package:governess/consts/size_config.dart';

class SendButtonWidget extends StatelessWidget {
  final String titleOfButton;
  final VoidCallback? onPressed;
  const SendButtonWidget(this.onPressed, {required this.titleOfButton,Key? key}) : super(key: key);

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
        fixedSize: Size(gW(200.0), gH(40.0)),
        elevation: 0,
        primary: Colors.green,
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
