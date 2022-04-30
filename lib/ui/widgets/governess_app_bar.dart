import 'package:flutter/material.dart';
import 'package:governess/consts/size_config.dart';

PreferredSizeWidget get governessAppBar => AppBar(
      leadingWidth: gW(80.0),
      leading: Padding(
        padding: EdgeInsets.only(left: gW(20.0)),
        child: Image(
          image: const AssetImage("assets/images/governessLogo.png"),
          height: gH(80.0),
        ),
      ),
      backgroundColor: mainColor,
      elevation: 0,
      title: const Text("Governess Business"),
    );
