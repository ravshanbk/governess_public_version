import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:governess/consts/colors.dart';
import 'package:governess/consts/print_my.dart';
import 'package:governess/consts/size_config.dart';
import 'package:governess/models/nurse_models/daily_menu_model.dart';
import 'package:governess/models/other/date_time_from_milliseconds_model.dart';
import 'package:governess/providers/nurse/daily_menu_page_provider.dart';
import 'package:governess/services/manager_service.dart';
import 'package:governess/services/nurse_service.dart';
import 'package:governess/ui/widgets/date_time_show_button_widget.dart';
import 'package:governess/ui/widgets/future_builder_of_no_data_widget.dart';
import 'package:governess/ui/widgets/indicator_widget.dart';
import 'package:governess/ui/widgets/meal_widget.dart';
import 'package:provider/provider.dart';

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
        future: NurseService().getDailyMenu(DateTime.now()),
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
    idf = data!.status == "TASDIQLANGAN";

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _submitUnsubmitButton(data),
          _status(),
          _menus(context, data),
        ],
      ),
    );
  }

  ListView _menus(BuildContext context, DailyMenu data) {
    return ListView.separated(
      padding: EdgeInsets.symmetric(
        vertical: gH(20.0),
        horizontal: gW(20.0),
      ),
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (_, __) {
        return Ink(
          decoration: BoxDecoration(
            border: Border.all(color: mainColor),
            borderRadius: BorderRadius.circular(gW(10.0)),
            color: context.watch<DailyMenuPageProvider>().current != __
                ? Colors.white
                : mainColor,
          ),
          child: ExpansionTile(
            key: Key(DateTime.now().toString()),
            onExpansionChanged: (v) {
              p(v.toString());
              debugPrint("CURRENT: " +
                  Provider.of<DailyMenuPageProvider>(context, listen: false)
                      .current
                      .toString());
              if (v) {
                Provider.of<DailyMenuPageProvider>(context, listen: false)
                    .changeCurrent(__);
              } else {
                Provider.of<DailyMenuPageProvider>(context, listen: false)
                    .changeCurrent(-1);
              }
              debugPrint("CURRENT: " +
                  Provider.of<DailyMenuPageProvider>(context, listen: false)
                      .current
                      .toString());
            },
            initiallyExpanded:
                context.watch<DailyMenuPageProvider>().current == __,
            collapsedIconColor: Colors.white,
            iconColor: mainColor,
            collapsedTextColor: mainColor,
            textColor: whiteColor,
            collapsedBackgroundColor: Colors.transparent,
            title: _expansionTileTitle(data, __),
            children: [
              Text("fsdfasf"),
              ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (_, n) {
                    return MealWidget(
                        data: data.mealTimeStandardResponseSaveDtoList![__]
                            .mealAgeStandardResponseSaveDtoList![n]);
                  },
                  itemCount: data.mealTimeStandardResponseSaveDtoList![__]
                      .mealAgeStandardResponseSaveDtoList!.length),
            ],
          ),
        );
      },
      separatorBuilder: (context, index) {
        return SizedBox(height: gH(20.0));
      },
      itemCount: data.mealTimeStandardResponseSaveDtoList!.length,
    );
  }

  Padding _status() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: gW(20.0)),
      child: Row(
        children: [
          Text(
            "Holati: ",
            style: TextStyle(color: Colors.grey, fontSize: gW(18.0)),
          ),
          Text(
            idf ? "Tasdiqlangan" : 'Tasdiqlanmagan',
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
          primary: idf ? Colors.green : Colors.red,
          elevation: 0,
          shadowColor: Colors.transparent,
        ),
        onPressed: data!.status == "TASDIQLANGAN"
            ? null
            : () {
                try {
                  ManagerService().submitDailyMenu(data.id!);
                } catch (e) {
                  throw Exception(
                      "Manager / show_daily_menu_page/ submitbutton: " +
                          e.toString());
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

  _expansionTileTitle(DailyMenu? data, int __) {
    return Text(
      data!.mealTimeStandardResponseSaveDtoList![__].mealTimeName!,
      textAlign: TextAlign.center,
      style: TextStyle(
          letterSpacing: gW(2),
          fontWeight: FontWeight.w500,
          fontSize: gW(20.0)),
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
