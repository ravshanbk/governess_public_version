import 'package:flutter/material.dart';
import 'package:governess/consts/date_time_picker_function.dart';
import 'package:governess/consts/size_config.dart';
import 'package:governess/models/nurse_models/number_of_children_model.dart';
import 'package:governess/models/other/date_time_from_milliseconds_model.dart';
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
        future: NurseService().getDailyChildrenNumber(when),
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
            showDataPicker(context, onDone: (date) {
              when = date;
              setState(() {});
            });
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
}
