import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:governess/consts/colors.dart';
import 'package:governess/consts/size_config.dart';
import 'package:governess/models/other/date_time_from_milliseconds_model.dart';
import 'package:governess/models/hamshira_models/daily_menu_model.dart';
import 'package:governess/providers/daily_menu_page_provider.dart';
import 'package:governess/services/nurse_service.dart';
import 'package:governess/ui/widgets/meal_widget.dart';
import 'package:provider/provider.dart';

class DailyMenuPage extends StatefulWidget {
  const DailyMenuPage({Key? key}) : super(key: key);

  @override
  State<DailyMenuPage> createState() => _DailyMenuPageState();
}

class _DailyMenuPageState extends State<DailyMenuPage> {
  Future<DailyMenu>? dailyMenu;

  @override
  void initState() {
    dailyMenu = NurseService().getDailyMenu();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("Data:" + DateTime.now().millisecondsSinceEpoch.toString());

    SizeConfig().init(context);
    return Scaffold(
      appBar: _appBar(),
      body: FutureBuilder(
        future: dailyMenu,
        builder: (BuildContext context, AsyncSnapshot<DailyMenu> snap) {
          DailyMenu? data = snap.data;

          return !snap.hasData
              ? Center(child: CupertinoActivityIndicator(radius: gW(70.0)))
              : _body(data, context);
        },
      ),
    );
  }

  ListView _body(DailyMenu? data, BuildContext context) {
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
        itemCount: data!.mealTimeStandardResponseSaveDtoList!.length);
  }

  _expansionTile(BuildContext context, int __, DailyMenu? data) {
    return Container(
      decoration: BoxDecoration(color: whiteColor,backgroundBlendMode: BlendMode.difference),
      child: Ink(
        decoration: BoxDecoration(
          
          borderRadius: BorderRadius.circular(gW(10.0)),
          color: context.watch<DailyMenuPageProvider>().current == __
              ? Colors.white
              : mainColor,
        ),
        child: ExpansionTile(key: Key(DateTime.now().toString()),
          onExpansionChanged: (v) {
            if (v) {
              Provider.of<DailyMenuPageProvider>(context, listen: false)
                  .changeCurrent(__);
            } else {
              Provider.of<DailyMenuPageProvider>(context, listen: false)
                  .changeCurrent(-1);
            }
            debugPrint(v.toString());
          },
          initiallyExpanded: context.watch<DailyMenuPageProvider>().current == __,
          collapsedIconColor: Colors.white,
          iconColor: mainColor,
          collapsedTextColor: Colors.white,
          textColor: mainColor,
          collapsedBackgroundColor: Colors.transparent,
          title: _expansionTileTitle(data, __),
          children: [
            ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (_, n) {
                  return MealWidget(
                      data: data!.mealTimeStandardResponseSaveDtoList![__]
                          .mealAgeStandardResponseSaveDtoList![n]);
                },
                separatorBuilder: (context, index) {
                  return SizedBox(
                    height: gH(20.0),
                  );
                },
                itemCount: data!.mealTimeStandardResponseSaveDtoList![__]
                    .mealAgeStandardResponseSaveDtoList!.length),
          ],
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

  _fakeBody(DailyMenu? data) {
    //!
    return ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (_, __) {
          return ListTile(
            title: Column(
              children: [
                const Text("createDate:: "),
                Text(
                  DTFM.maker(data!.createDate!),
                  style: const TextStyle(color: Colors.red),
                ),
                Divider(
                  color: mainColor,
                ),
                const Text("date:: "),
                Text(
                  DTFM.maker(data.date!),
                  style: const TextStyle(color: Colors.red),
                ),
                Divider(
                  color: mainColor,
                ),
                const Text("id:: "),
                Text(
                  data.id.toString(),
                  style: const TextStyle(color: Colors.red),
                ),
                Divider(
                  color: mainColor,
                ),
                _d(data),
                Divider(
                  color: mainColor,
                ),
                const Text("updateDate:: "),
                Text(
                  data.updateDate.toString(),
                  style: const TextStyle(color: Colors.red),
                ),
                Divider(
                  color: mainColor,
                ),
                const Text("multiMenuName:: "),
                Text(
                  data.multiMenuName.toString(),
                  style: const TextStyle(color: Colors.red),
                ),
                Divider(
                  color: mainColor,
                ),
                _c(data),
                Divider(
                  color: mainColor,
                ),
                const Text("perDayDto:: "),
                Text(
                  data.perDayDto.toString(),
                  style: const TextStyle(color: Colors.red),
                ),
                Divider(
                  color: mainColor,
                ),
              ],
            ),
          );
        },
        separatorBuilder: (context, index) {
          return SizedBox(height: gH(20.0));
        },
        itemCount: 1);
  }

  ListView _d(DailyMenu data) {
    //!
    return ListView.separated(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (_, ___) {
          return Column(
            children: [
              const Text("numberToGuess![___].ageGroupId"),
              Text(
                "_d " + data.numberToGuess![___].ageGroupId.toString(),
                style: const TextStyle(color: Colors.red),
              ),
              const Text("numberToGuess![___].id."),
              Text(
                "_d " + data.numberToGuess![___].id.toString(),
                style: const TextStyle(color: Colors.red),
              ),
              const Text("numberToGuess![___].number"),
              Text(
                "_d " + data.numberToGuess![___].number.toString(),
                style: const TextStyle(color: Colors.red),
              ),
              const Text("numberToGuess![___].ageGroupName"),
              Text(
                "_d " + data.numberToGuess![___].ageGroupName.toString(),
                style: const TextStyle(color: Colors.red),
              ),
            ],
          );
        },
        separatorBuilder: (con, ind) {
          return const Divider(
            color: Colors.red,
          );
        },
        itemCount: data.numberToGuess!.length);
  }

  ListView _c(DailyMenu data) {
    //!
    return ListView.separated(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (_, n) {
          return Column(
            children: [
              const Text("""mealTimeStandardResponseSaveDtoList![n].id:: """),
              Text(
                "_c " +
                    data.mealTimeStandardResponseSaveDtoList![n].id.toString(),
                style: const TextStyle(color: Colors.red),
              ),
              const Text(
                  """mealTimeStandardResponseSaveDtoList![n].mealTimeName:: """),
              Text(
                "_c " +
                    data.mealTimeStandardResponseSaveDtoList![n].mealTimeName
                        .toString(),
                style: const TextStyle(color: Colors.red),
              ),
              _b(data, n),
            ],
          );
        },
        separatorBuilder: (con, ind) {
          return const Divider(
            color: Colors.black,
          );
        },
        itemCount: data.mealTimeStandardResponseSaveDtoList!.length);
  }

  ListView _b(DailyMenu data, int n) {
    //!
    return ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (_, m) {
        return Column(
          children: [
            _a(data, n, m),
          ],
        );
      },
      separatorBuilder: (con, ind) {
        return Divider(
          color: Colors.green,
          thickness: gW(5.0),
        );
      },
      itemCount: data.mealTimeStandardResponseSaveDtoList![n]
          .mealAgeStandardResponseSaveDtoList!.length,
    );
  }

  ListView _a(DailyMenu data, int n, int m) {
    //!
    return ListView.separated(
      itemCount: data
          .mealTimeStandardResponseSaveDtoList![n]
          .mealAgeStandardResponseSaveDtoList![m]
          .ageStandardResponseSaveDtoList!
          .length,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (_, l) {
        return Column(
          children: [
            const Text("""mealTimeStandardResponseSaveDtoList![n]
                .mealAgeStandardResponseSaveDtoList![m]
                .ageStandardResponseSaveDtoList![l]
                .ageGroupName:: """),
            Text(
              "_c/ _b/ _a " +
                  data
                      .mealTimeStandardResponseSaveDtoList![n]
                      .mealAgeStandardResponseSaveDtoList![m]
                      .ageStandardResponseSaveDtoList![l]
                      .ageGroupName
                      .toString(),
              style: const TextStyle(color: Colors.red),
            ),
            const Text("""mealTimeStandardResponseSaveDtoList![n]
                .mealAgeStandardResponseSaveDtoList![m]
                .ageStandardResponseSaveDtoList![l]
                .id:: """),
            Text(
              "_c/ _b/ _a " +
                  data
                      .mealTimeStandardResponseSaveDtoList![n]
                      .mealAgeStandardResponseSaveDtoList![m]
                      .ageStandardResponseSaveDtoList![l]
                      .id
                      .toString(),
              style: const TextStyle(color: Colors.red),
            ),
            const Text("""mealTimeStandardResponseSaveDtoList![n]
                .mealAgeStandardResponseSaveDtoList![m]
                .ageStandardResponseSaveDtoList![l]
                .weight:: """),
            Text(
              "_c/ _b/ _a " +
                  data
                      .mealTimeStandardResponseSaveDtoList![n]
                      .mealAgeStandardResponseSaveDtoList![m]
                      .ageStandardResponseSaveDtoList![l]
                      .weight
                      .toString(),
              style: const TextStyle(color: Colors.red),
            ),
          ],
        );
      },
      separatorBuilder: (con, ind) {
        return Divider(
          color: Colors.green,
          thickness: gW(5.0),
        );
      },
    );
  }

  AppBar _appBar() {
    return AppBar(
        backgroundColor: mainColor,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Sana",
          textAlign: TextAlign.center,
        ),
        actions: [
          IconButton(
              onPressed: () {
                Provider.of<DailyMenuPageProvider>(context, listen: false)
                    .changeCurrent(-1);
                initState();
              },
              icon: const Icon(Icons.filter_list))
        ]);
  }
}
