import 'package:flutter/material.dart';
import 'package:governess/consts/size_config.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class PinCodeWidget extends StatelessWidget {
  final TextEditingController controller;
  final Function(String) onComplete;
  const PinCodeWidget(
      {required this.controller, required this.onComplete, Key? key})
      : super(key: key);



  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: gW(80.0)),
      child: PinCodeTextField(
        
      keyboardType: TextInputType.datetime,
        onChanged:( onComplete){},
        appContext: context,
        length: 4,
        obscureText:true,
        animationType: AnimationType.fade,
        pinTheme: PinTheme(
          selectedFillColor: whiteColor,
          selectedColor: mainColor,
          // activeColor: whiteColor,
          inactiveColor: mainColor_02,
          inactiveFillColor: whiteColor,
          shape: PinCodeFieldShape.box,
          borderRadius: BorderRadius.circular(5),
          fieldHeight: 50,
          fieldWidth: 40,
          activeFillColor: Colors.white,
        ),
        animationDuration: const Duration(milliseconds: 200),
        backgroundColor: Colors.transparent,
        enableActiveFill: true,
        controller: controller,
        onCompleted:onComplete,
      ),
    );
  }
}
