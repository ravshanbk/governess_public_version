import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:governess/consts/size_config.dart';
import 'package:governess/consts/strings.dart';
import 'package:governess/models/nurse_models/daily_menu_model.dart';
import 'package:governess/models/other/date_time_from_milliseconds_model.dart';
import 'package:governess/services/network.dart';
import 'package:governess/services/nurse_service.dart';
import 'package:governess/ui/widgets/daily_menu_widget.dart';
import 'package:governess/ui/widgets/date_time_show_button_widget.dart';
import 'package:governess/ui/widgets/future_builder_of_no_data_widget.dart';
import 'package:governess/ui/widgets/indicator_widget.dart';

class TAjribaPage extends StatefulWidget {
  const TAjribaPage({Key? key}) : super(key: key);

  @override
  State<TAjribaPage> createState() => _TAjribaPageState();
}

class _TAjribaPageState extends State<TAjribaPage> {
  DateTime when = DateTime.now();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: _appBar(context),
      body: FutureBuilder<MenuInfo>(
        future: NurseService().tajribaDailyMenu(when),
        builder:
            (BuildContext context, AsyncSnapshot<MenuInfo> snap) {
          if (snap.connectionState == ConnectionState.done && snap.hasData) {
            return Padding(
              padding: EdgeInsets.only(top: gH(20.0)),
              child: Center(child: SingleChildScrollView(child: Container(color: Colors.orange,child: Text(snap.data.toString()),)))
            );
          } else if (snap.connectionState == ConnectionState.done &&
              !snap.hasData) {
            return const NoDataWidgetForFutureBuilder(
                "Hozircha Menyu Mavjud Emas!");
          } else {
            return IndicatorWidget(snap);
          }
        },
      ),
    );
  }

  AppBar _appBar(BuildContext context) {
    return AppBar(
      backgroundColor: mainColor,
      elevation: 0,
      centerTitle: true,
      actions: [
        DateTimeShowButton(
          DTFM.maker(when.millisecondsSinceEpoch),
          () async {
            bool isTherInternet = await checkConnectivity();
            if (isTherInternet) {
              showDataPicker(
                context,
              );
            } else {
              showNoNetToast(false);
            }
          },
        ),
      ],
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
      onConfirm: (DateTime date) {
        when = date;
        setState(() {});
      },
      locale: LocaleType.en,
    );
  }
}
