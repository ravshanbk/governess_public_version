import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:governess/consts/colors.dart';
import 'package:governess/consts/size_config.dart';
import 'package:governess/models/other/date_time_from_milliseconds_model.dart';
import 'package:governess/models/hamshira_models/daily_menu_model.dart';
import 'package:governess/providers/nurse/daily_menu_page_provider.dart';
import 'package:governess/services/nurse_service.dart';
import 'package:governess/ui/widgets/meal_widget.dart';
import 'package:provider/provider.dart';

class NurseShowDailyMenuPage extends StatelessWidget {
  const NurseShowDailyMenuPage({Key? key}) : super(key: key);

  // DateTime dateTime =  DateTime(2022, 4, 18);
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: _appBar(),
      body: FutureBuilder(
        future: NurseService().getDailyMenu(DateTime(2022, 4, 18,7,45,00)),
        builder: (BuildContext context, AsyncSnapshot<DailyMenu> snap) {
          if (snap.connectionState == ConnectionState.active) {
            return _indicator(snap);
          } else if (snap.connectionState == ConnectionState.done) {
            return _body(snap.data!, context);
          } else{
            return _indicator(snap);
          }
        },
      ),
    );
  }

  Center _indicator(AsyncSnapshot<DailyMenu> snap) {
    return Center(
        child: Column(
      children: [
        Text(snap.connectionState.name),
        CupertinoActivityIndicator(radius: gW(70.0)),
      ],
    ));
  }

  ListView _body(DailyMenu data, BuildContext context) {
    return ListView.separated(
        padding: EdgeInsets.symmetric(vertical: gH(20.0), horizontal: gW(20.0)),
        physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (_, __) {
          return _expansionTile(context, __, data);
        },
        separatorBuilder: (context, index) {
          return SizedBox(height: gH(20.0));
        },
        itemCount: data.mealTimeStandardResponseSaveDtoList!.length);
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

  AppBar _appBar() {
    return AppBar(
      backgroundColor: mainColor,
      elevation: 0,
      centerTitle: true,
      title: Text(
        DTFM.maker(DateTime.now().millisecondsSinceEpoch),
        textAlign: TextAlign.center,
      ),
    );
  }
}
