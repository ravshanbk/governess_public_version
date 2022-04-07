import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:governess/consts/colors.dart';
import 'package:governess/consts/size_config.dart';
import 'package:governess/models/hamshira_models/daily_menu_model.dart';

class MealWidget extends StatelessWidget {
  MealAgeStandardResponseSaveDtoList? data;
  MealWidget({required this.data, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      minVerticalPadding: 0.0,
      contentPadding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: mainColor),
        borderRadius: BorderRadius.circular(
          gW(10.0),
        ),
      ),
      title: _mealImage(data),
      subtitle: Column(
        children: [
          SizedBox(
            height: gH(5.0),
          ),
          _textCyan(data!.name),
          Divider(
            color: mainColor,
            height: gH(5.0),
          ),
          _ageGroupAndWeightRow(),
          Divider(
            color: mainColor,
            height: gH(5.0),
          ),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (_, __) {
              return _rowData(
                  data!.ageStandardResponseSaveDtoList![__].ageGroupName
                      .toString(),
                  data!.ageStandardResponseSaveDtoList![__].weight.toString());
            },
            separatorBuilder: (context, index) {
              return SizedBox(
                height: gH(5.0),
                child: Divider(
                  color: mainColor,
                  endIndent: gW(15.0),
                  indent: gW(15.0),
                ),
              );
            },
            itemCount: data!.ageStandardResponseSaveDtoList!.length,
          ),
        ],
      ),
    );
    ;
  }

  Text _text18grey(String text) {
    return Text(
      text,
      style: TextStyle(fontSize: gW(18.0), color: greyColor),
    );
  }

  Ink _mealImage(data) {
    return Ink(
      height: gH(280.0),
      decoration: BoxDecoration(
        border:data.image != null?null: Border.fromBorderSide(BorderSide(color: mainColor)),
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(gW(10.0)),
        ),
        image: data.image != null
            ? DecorationImage(
                image: MemoryImage(
                  base64.decode(data.image!),
                ),
                fit: BoxFit.cover,
              )
            : const DecorationImage(
                image: AssetImage("assets/images/placeholder.jpeg"),
                fit: BoxFit.cover,
              ),
      ),
    );
  }

  Row _ageGroupAndWeightRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _text18grey("Yosh toifa"),
        SizedBox(
          height: gH(40.0),
          width: 3.0,
          child: VerticalDivider(
            color: mainColor,
          ),
        ),
        _text18grey("Miqdor  gr")
      ],
    );
  }

  _rowData(String text1, String text2) {
    return Padding(
      padding: EdgeInsets.only(left: gW(30.0), right: gW(50.0)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _text18grey(text1),
          const Spacer(),
          _text18grey(text2),
        ],
      ),
    );
  }

  Text _textCyan(text) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(
          fontStyle: FontStyle.italic,
          fontSize: gW(20.0),
          fontWeight: FontWeight.w500,
          color: mainColor,
          letterSpacing: gW(2.0)),
    );
  }
}
