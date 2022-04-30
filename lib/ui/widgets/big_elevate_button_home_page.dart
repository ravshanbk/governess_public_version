import 'package:flutter/material.dart';
import 'package:governess/consts/colors.dart';
import 'package:governess/consts/size_config.dart';

class BigElevatedButtonHomePage extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;
  const BigElevatedButtonHomePage({required this.onPressed,
    required this.title,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        
        shadowColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            gW(80.0),
          ),
        ),
        primary: mainColor_02,
        elevation: 0,
        
        fixedSize: Size(
          gW(335.0),
          gW(160.0),
        ),
      ),
      onPressed:onPressed,
      child: Text(
        title,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: mainColor,
          fontSize: gW(22.0),
        ),
      ),
    );
  }
}
