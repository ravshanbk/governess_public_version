import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:governess/consts/colors.dart';
import 'package:governess/consts/size_config.dart';
import 'package:governess/models/hamshira_models/number_of_children_model.dart';
import 'package:governess/models/other/date_time_from_milliseconds_model.dart';
import 'package:governess/services/cooker_service.dart';
import 'package:governess/ui/widgets/date_time_show_button_widget.dart';
import 'package:governess/ui/widgets/number_of_children_widget.dart';

class CookerShowNumberOfChildrenPage extends StatefulWidget {
  CookerShowNumberOfChildrenPage({Key? key}) : super(key: key);

  @override
  State<CookerShowNumberOfChildrenPage> createState() =>
      _CookerShowNumberOfChildrenPageState();
}

class _CookerShowNumberOfChildrenPageState
    extends State<CookerShowNumberOfChildrenPage> {
  DateTime when = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<NumberOfChildren>(
      future: CookerService().getChildrenNumberByData(when),
      builder: (context, AsyncSnapshot<NumberOfChildren> snap) {
        if (snap.connectionState == ConnectionState.waiting) {
          return _indicator();
        } else {
          NumberOfChildren data = snap.data!;

          return Scaffold(
            appBar: AppBar(
              elevation: 0,
              backgroundColor: mainColor,
              title: Text(data.perDayList![0].kindergartenName!),
              actions: [
                DateTimeShowButton(
                  DTFM.maker(when.millisecondsSinceEpoch),
                  () {
                    _showDataPicker(context);
                  },
                ),
              ],
            ),
            body: Padding(
              padding: EdgeInsets.only(
                left: gW(20.0),
                right: gW(20.0),
                top: gH(20.0),
              ),
              child: Column(
                children: [
                  NumberOfChildrenWidget(data: data),
                ],
              ),
            ),
          );
        }
      },
    );
  }

  Scaffold _indicator() {
    return Scaffold(
      body: Center(
        child: CupertinoActivityIndicator(
          radius: gW(50.0),
        ),
      ),
    );
  }

  _showDataPicker(BuildContext context) {
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
      onConfirm: (date) {
        when = date;
        setState(() {});
      },
      locale: LocaleType.en,
    );
  }
}
