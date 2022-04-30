import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:governess/consts/colors.dart';
import 'package:governess/consts/size_config.dart';
import 'package:governess/models/nurse_models/number_of_children_model.dart';
import 'package:governess/models/other/date_time_from_milliseconds_model.dart';
import 'package:governess/services/cooker_service.dart';
import 'package:governess/services/nurse_service.dart';
import 'package:governess/ui/widgets/date_time_show_button_widget.dart';
import 'package:governess/ui/widgets/future_builder_of_no_data_widget.dart';
import 'package:governess/ui/widgets/indicator_widget.dart';
import 'package:governess/ui/widgets/number_of_children_widget.dart';

class CookerShowNumberOfChildrenPage extends StatefulWidget {
  const CookerShowNumberOfChildrenPage({Key? key}) : super(key: key);

  @override
  State<CookerShowNumberOfChildrenPage> createState() =>
      _CookerShowNumberOfChildrenPageState();
}

class _CookerShowNumberOfChildrenPageState
    extends State<CookerShowNumberOfChildrenPage> {
  DateTime when = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
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

  AppBar _appBar(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: mainColor,
      actions: [
        DateTimeShowButton(
          DTFM.maker(when.millisecondsSinceEpoch),
          () {
            _showDataPicker(context);
          },
        ),
      ],
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
        children: [
          NumberOfChildrenWidget(data: data),
        ],
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
