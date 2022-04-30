import 'package:flutter/material.dart';

class SizeConfig {
  static late MediaQueryData _mediaQueryData;
  static late double screenWidth;
  static late double screenHeight;
  static late double defaultSize;
  static late Orientation orientation;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    orientation = _mediaQueryData.orientation;
  }
}

double gH(double inputHeight) {
  double screenHeight = SizeConfig.screenHeight;
  return (inputHeight / 812.0) * screenHeight;
}

double gW(double inputWidth) {
  double screenWidth = SizeConfig.screenWidth;
  return (inputWidth / 375.0) * screenWidth;
}

Color get mainColor => const  
// Color(0xff00B0FF);
Color(0xff00a859);

Color get greyColor =>const Color(0xff8c8181);
Color get lightGreyColor =>const Color(0xfff2f2f2);
Color get mainColor_02 =>const
Color(0xff00a859).withOpacity(.15);

//  Color(0xff00B0FF).withOpacity(.15);
Color get sliverColor =>const Color(0xffB5CCE6).withOpacity(.15);

Color get whiteColor =>const Color(0xffFFFFFF);
