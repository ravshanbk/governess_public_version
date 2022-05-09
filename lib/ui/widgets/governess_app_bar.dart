import 'package:flutter/material.dart';
import 'package:governess/consts/size_config.dart';

PreferredSizeWidget get governessAppBar => AppBar(
      shape: UnderlineInputBorder(
        borderRadius: BorderRadius.circular(gW(10.0)),
        borderSide: BorderSide(
          color: mainColor,
          width: gW(3.5),
        ),
      ),
      toolbarHeight: 80.0,
      leadingWidth: gW(80.0),
      leading: Padding(
        padding: EdgeInsets.only(left: gW(20.0)),
        child: Image(
          image: const AssetImage("assets/images/governessLogo.png"),
          height: gH(80.0),
        ),
      ),
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: Text(
        "Governess Business",
        style: TextStyle(color: mainColor),
      ),
    );
