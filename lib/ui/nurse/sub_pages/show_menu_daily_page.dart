import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:governess/consts/colors.dart';
import 'package:governess/consts/size_config.dart';
import 'package:governess/models/nurse_models/daily_menu_model.dart';
import 'package:governess/models/other/date_time_from_milliseconds_model.dart';
import 'package:governess/providers/nurse/daily_menu_page_provider.dart';
import 'package:governess/services/nurse_service.dart';
import 'package:governess/ui/widgets/daily_menu_widget.dart';
import 'package:governess/ui/widgets/date_time_show_button_widget.dart';
import 'package:governess/ui/widgets/future_builder_of_no_data_widget.dart';
import 'package:governess/ui/widgets/indicator_widget.dart';
import 'package:governess/ui/widgets/meal_widget.dart';
import 'package:provider/provider.dart';

class NurseShowDailyMenuPage extends StatefulWidget {
  NurseShowDailyMenuPage({Key? key}) : super(key: key);

  @override
  State<NurseShowDailyMenuPage> createState() => _NurseShowDailyMenuPageState();
}

class _NurseShowDailyMenuPageState extends State<NurseShowDailyMenuPage> {
  DateTime when = DateTime.now();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: _appBar(context),
      body: FutureBuilder<DailyMenu>(
        future: NurseService().getDailyMenu(when),
        builder: (BuildContext context, AsyncSnapshot<DailyMenu> snap) {
          if (snap.connectionState == ConnectionState.done && snap.hasData) {
            return Padding(
              padding:  EdgeInsets.only(top: gH(20.0)),
              child: DailyMenuWidget(con: context,data: snap.data!,onTap: (int __,int n){},),
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

  _body(DailyMenu data, BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.only(top: gH(20.0)),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: gW(10.0),vertical: gH(20.0),
        ),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(
            gW(
              10.0,
            ),
          ),
        ),
        child: Column(
          children: [
            _menuNameAndStatus(data),
            ListView.separated(
              padding: EdgeInsets.symmetric(
                  vertical: gH(20.0), horizontal: gW(10.0)),
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (_, __) {
                return _expansionTile(context, __, data);
              },
              separatorBuilder: (context, index) {
                return SizedBox(height: gH(20.0));
              },
              itemCount: data.mealTimeStandardResponseSaveDtoList!.length,
            ),
          ],
        ),
      ),
    );
  }

  Container _menuNameAndStatus(DailyMenu data) {
    return Container(
            padding: EdgeInsets.symmetric(
              vertical: gH(10.0),
            ),
            decoration: BoxDecoration(
              border: Border.all(color: mainColor, width: gW(2.0)),
              borderRadius:
                  BorderRadius.vertical(top: Radius.circular(gW(10.0))),
              color: mainColor,
            ),
            child: Column(
              children: [
                // MENYU NOMI
                Text(
                  data.name!,
                  style: TextStyle(
                    decorationThickness: gW(.5),
                    decorationStyle: TextDecorationStyle.solid,
                    decoration: TextDecoration.underline,
                    decorationColor: lightGreyColor,
                    fontWeight: FontWeight.bold,
                    color: whiteColor,
                    fontStyle: FontStyle.italic,
                    fontSize: gW(
                      25.0,
                    ),
                  ),
                ),
                SizedBox(
                  height: gW(5.0),
                ),
                //MENYU HOLATI
                Row(
                  children: [
                    SizedBox(
                      width: gW(20.0),
                    ),
                    Text(
                      "Holati: ",
                      style: TextStyle(
                        color: lightGreyColor,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    Text(
                      data.status!,
                      style: TextStyle(
                        color: whiteColor,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
  }

  _expansionTile(BuildContext context, int __, DailyMenu? data) {
    return Ink(
      decoration: BoxDecoration(
        border: Border.all(color: mainColor),
        borderRadius: BorderRadius.circular(gW(10.0)),
        color: context.watch<DailyMenuPageProvider>().current != __
            ? mainColor_02
            : mainColor,
      ),
      child: ExpansionTile(
        key: Key(DateTime.now().toString()),
        onExpansionChanged: (v) {
          if (v) {
            Provider.of<DailyMenuPageProvider>(context, listen: false)
                .changeCurrent(__);
          } else {
            Provider.of<DailyMenuPageProvider>(context, listen: false)
                .changeCurrent(-1);
          }
        },
        initiallyExpanded: context.watch<DailyMenuPageProvider>().current == __,
        collapsedIconColor: Colors.white,
        iconColor: mainColor,
        collapsedTextColor: mainColor,
        textColor: whiteColor,
        collapsedBackgroundColor: Colors.transparent,
        title: _expansionTileTitle(data, __),
        children: [
          ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (_, n) {
                return MealWidget(
                    data: data!.mealTimeStandardResponseSaveDtoList![__]
                        .mealAgeStandardResponseSaveDtoList![n]);
              },
              itemCount: data!.mealTimeStandardResponseSaveDtoList![__]
                  .mealAgeStandardResponseSaveDtoList!.length),
        ],
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

  AppBar _appBar(BuildContext context) {
    return AppBar(
      backgroundColor: mainColor,
      elevation: 0,
      centerTitle: true,
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
