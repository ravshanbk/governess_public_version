import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:governess/consts/size_config.dart';
import 'package:governess/consts/strings.dart';
import 'package:governess/models/nurse_models/daily_menu_model.dart';
import 'package:governess/models/other/date_time_from_milliseconds_model.dart';
import 'package:governess/services/network.dart';
import 'package:governess/services/nurse_service.dart';
import 'package:governess/ui/cooker/sub_pages/menu/meal_info_page.dart';
import 'package:governess/ui/widgets/daily_menu_widget.dart';
import 'package:governess/ui/widgets/date_time_show_button_widget.dart';
import 'package:governess/ui/widgets/future_builder_of_no_data_widget.dart';
import 'package:governess/ui/widgets/indicator_widget.dart';

class CookerShowDailyMenuPage extends StatefulWidget {
  const CookerShowDailyMenuPage({Key? key}) : super(key: key);

  @override
  State<CookerShowDailyMenuPage> createState() =>
      _CookerShowDailyMenuPageState();
}

class _CookerShowDailyMenuPageState extends State<CookerShowDailyMenuPage> {
  DateTime when = DateTime.now();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: _appBar(),
      body: FutureBuilder<MenuInfo>(
        future: NurseService().getDailyMenu(when),
        builder: (BuildContext context, AsyncSnapshot<MenuInfo> snap) {
          if (snap.connectionState == ConnectionState.done) {
            if (snap.hasData) {
              return DailyMenuWidget(
                data: snap.data!,
                con: context,
                onTap: (int __, int n) async {
                  bool isNet = await checkConnectivity();
                  if (isNet) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CookerMealInfoPage(
                          mealAgeStandartId: snap
                              .data!
                              .mealTimeStandardResponseSaveDtoList![__]
                              .mealAgeStandardResponseSaveDtoList![n]
                              .id!,
                          menuId: snap.data!.id,
                          mealName: snap.data!.name,
                        ),
                      ),
                    );
                  } else {
                    showNoNetToast(false);
                  }
                },
              );
            } else {
              return NoDataWidgetForFutureBuilder(
                  "${DTFM.maker(when.millisecondsSinceEpoch)}\n Menyu Mavjud Emas!");
            }
          } else {
            return IndicatorWidget(snap);
          }
        },
      ),
    );
  }

  AppBar _appBar() {
    return AppBar(
      backgroundColor: mainColor,
      elevation: 0,
      centerTitle: true,
      actions: [
        DateTimeShowButton(
          DTFM.maker(when.millisecondsSinceEpoch),
          () {
            showDataPicker(context);
          },
        ),
      ],
    );
  }

  showDataPicker(BuildContext context) {
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
