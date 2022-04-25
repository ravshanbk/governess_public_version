import 'package:flutter/material.dart';
import 'package:governess/consts/colors.dart';

PreferredSizeWidget get governessAppBar => AppBar(
      leading: const Image(
        image: AssetImage("assets/images/governessLogo.png"),
      ),
      backgroundColor: mainColor,
      elevation: 0,
      title: const Text("Governess Business"),
    );
