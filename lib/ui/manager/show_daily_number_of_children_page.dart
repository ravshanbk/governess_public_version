import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:governess/consts/size_config.dart';
import 'package:governess/consts/strings.dart';
import 'package:governess/models/nurse_models/number_of_children_model.dart';
import 'package:governess/models/other/date_time_from_milliseconds_model.dart';
import 'package:governess/services/manager_service.dart';
import 'package:governess/ui/widgets/date_time_show_button_widget.dart';
import 'package:governess/ui/widgets/future_builder_of_no_data_widget.dart';
import 'package:governess/ui/widgets/indicator_widget.dart';
import 'package:governess/ui/widgets/number_of_children_widget.dart';
import 'package:governess/services/nurse_service.dart';

class ManagerShowNumberOfChildrenPage extends StatefulWidget {
  const ManagerShowNumberOfChildrenPage({Key? key}) : super(key: key);

  @override
  State<ManagerShowNumberOfChildrenPage> createState() =>
      _ManagerShowNumberOfChildrenPageState();
}



DateTime when = DateTime.now();

class _ManagerShowNumberOfChildrenPageState
    extends State<ManagerShowNumberOfChildrenPage> {
 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: mainColor,
        actions: [
          DateTimeShowButton(DTFM.maker(when.millisecondsSinceEpoch), () {
            showDataPicker(context);
          })
        ],
      ),
      body: FutureBuilder<NumberOfChildren>(
        future:NurseService().getDailyChildrenNumber(when),
        builder: (context, AsyncSnapshot<NumberOfChildren> snap) {
          if (snap.connectionState == ConnectionState.done && snap.hasData) {
            return _body(snap.data!, context);
          } else if (snap.connectionState == ConnectionState.done &&
              !snap.hasData) {
            return const NoDataWidgetForFutureBuilder(
                "Bu Kunga Hali Bolalar Soni Kiritilmagan!");
          } else {
            return IndicatorWidget(snap);
          }
        },
      ),
    );
  }

  _body(NumberOfChildren data, BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: gW(20.0),
        right: gW(20.0),
        top: gH(20.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          NumberOfChildrenWidget(data: data),
          SizedBox(height: gH(20.0)),
          _submitButton(context, data),
        ],
      ),
    );
  }

  _submitButton(BuildContext context, NumberOfChildren data) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            gW(10.0),
          ),
        ),
        primary: mainColor,
        elevation: 0,
        fixedSize: Size(
          gW(180.0),
          gH(52.0),
        ),
      ),
      onPressed: data.perDayList![0].status == "TASDIQLANDI" ||
              data.perDayList![0].status == "NOANIQ"
          ? null
          : () async {
              ManagerService()
                  .submitDailyNumberOfChildren(data.perDayList![0].id!)
                  .then((value) {
                if (value.success!) {
                  showToast(value.text!, value.success!, value.success!);
                  setState(() {});
                } else {
                  showToast(value.text!, value.success!, value.success!);
                  setState(() {});
                }
              });
            },
      child: Text(
        "Tasdiqlash",
        style: TextStyle(
          letterSpacing: gW(2.0),
          fontSize: gW(20.0),
        ),
      ),
    );
  }

  showDataPicker(
    BuildContext context,
  ) {
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
