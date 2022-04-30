import 'package:flutter/material.dart';
import 'package:governess/consts/colors.dart';
import 'package:governess/consts/size_config.dart';
import 'package:governess/models/nurse_models/daily_menu_model.dart';
import 'package:governess/providers/nurse/daily_menu_page_provider.dart';
import 'package:governess/ui/widgets/meal_widget.dart';
import 'package:provider/provider.dart';

class DailyMenuWidget extends StatelessWidget {
  final DailyMenu data;
  final BuildContext con;
  final Function(int,int) onTap;
const DailyMenuWidget({required this.data, required this.con,required this.onTap, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: gW(10.0),vertical: gH(20.0)),
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
            Container(
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
            ),
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
                return InkWell(
                  onTap:(){
                    onTap(__,n);
                  },
                  child: MealWidget(
                      data: data!.mealTimeStandardResponseSaveDtoList![__]
                          .mealAgeStandardResponseSaveDtoList![n]),
                );
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
}
