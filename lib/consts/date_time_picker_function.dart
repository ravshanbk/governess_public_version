
  import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:governess/consts/size_config.dart';

showDataPicker(BuildContext context,{required Function(DateTime) onDone}) {
    DatePicker.showPicker(
      context,
      showTitleActions: true,
      theme: DatePickerTheme(
        backgroundColor: lightGreyColor,
        containerHeight: gH(200.0),
        headerColor: mainColor,
        itemStyle: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
        doneStyle: TextStyle(
          color: whiteColor,
          fontSize: 18,
          fontWeight: FontWeight.bold,
          letterSpacing: gW(1.5),
          decoration: TextDecoration.underline,
        ),
      ),
      onConfirm:onDone,
      locale: LocaleType.en,
    );
  }