import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:governess/consts/colors.dart';
import 'package:governess/consts/size_config.dart';
import 'package:governess/consts/strings.dart';
import 'package:governess/models/nurse_models/daily_menu_model.dart';
import 'package:governess/models/other/date_time_from_milliseconds_model.dart';
import 'package:governess/services/manager_service.dart';
import 'package:governess/services/network.dart';
import 'package:governess/services/nurse_service.dart';
import 'package:governess/ui/widgets/daily_menu_widget.dart';
import 'package:governess/ui/widgets/date_time_show_button_widget.dart';
import 'package:governess/ui/widgets/future_builder_of_no_data_widget.dart';
import 'package:governess/ui/widgets/indicator_widget.dart';
import 'package:governess/ui/widgets/show_toast_function.dart';

class ManagerShowDailyMenuPage extends StatefulWidget {
  const ManagerShowDailyMenuPage({Key? key}) : super(key: key);

  @override
  State<ManagerShowDailyMenuPage> createState() =>
      _ManagerShowDailyMenuPageState();
}

class _ManagerShowDailyMenuPageState extends State<ManagerShowDailyMenuPage> {
  DateTime when = DateTime.now();
  bool idf = false;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: _appBar(),
      body: FutureBuilder(
        future: NurseService().getDailyMenu(when),
        builder: (BuildContext context, AsyncSnapshot<DailyMenu> snap) {
          if (snap.connectionState == ConnectionState.done && snap.hasData) {
            return _body(snap.data!, context);
          } else if (snap.connectionState == ConnectionState.done &&
              !snap.hasData) {
            return const NoDataWidgetForFutureBuilder(
                "Hozircha Bu Kunga Hech Qanday Menyu Biriktirilmagan");
          } else {
            return IndicatorWidget(snap);
          }
        },
      ),
    );
  }

  _body(DailyMenu? data, BuildContext context) {
    idf = data!.confirmation!;

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _submitUnsubmitButton(data),
          _status(data),
          DailyMenuWidget(data: data, con: context, onTap: (int __, int n) {}),
        ],
      ),
    );
  }

  Padding _status(DailyMenu data) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: gW(20.0)),
      child: Row(
        children: [
          Text(
            "Holati: ",
            style: TextStyle(color: Colors.grey, fontSize: gW(18.0)),
          ),
          Text(
            data.status!.toString(),
            style: TextStyle(
              fontSize: gW(20.0),
            ),
          ),
        ],
      ),
    );
  }

  Padding _submitUnsubmitButton(DailyMenu? data) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: gW(20.0),
        vertical: gH(20.0),
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              gW(10.0),
            ),
          ),
          primary: idf ? mainColor : Colors.red,
          elevation: 0,
          shadowColor: Colors.transparent,
        ),
        onPressed: data!.confirmation!
            ? null
            : () async {
                bool isNet = await checkConnectivity();
                if (isNet) {
                  try {
                    ManagerService().submitDailyMenu(data.id!).then((value) {
                      if (value.success!) {
                        showToast(value.text!, value.success!, true);
                      } else {
                        showToast(value.text!, value.success!, true);
                      }
                    });
                  } catch (e) {
                    throw Exception(
                        "Manager / show_daily_menu_page/ submitbutton: " +
                            e.toString());
                  }
                } else {
                  showNoNetToast(false);
                }
              },
        child: Text(
          idf ? "Tasdiqlangan" : 'Tasdiqlash',
          style: TextStyle(
            fontSize: gW(20.0),
            letterSpacing: gW(2.0),
          ),
        ),
      ),
    );
  }

  AppBar _appBar() {
    return AppBar(
      backgroundColor: mainColor,
      elevation: 0,
      title: Text(
        DTFM.maker(DateTime.now().millisecondsSinceEpoch),
        textAlign: TextAlign.center,
      ),
      actions: [
        DateTimeShowButton(DTFM.maker(when.millisecondsSinceEpoch), () {
          _showDataPicker(context);
        })
      ],
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
