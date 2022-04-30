import 'package:flutter/material.dart';
import 'package:governess/consts/date_time_picker_function.dart';
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

class NurseShowDailyMenuPage extends StatefulWidget {
  const NurseShowDailyMenuPage({Key? key}) : super(key: key);

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
              padding: EdgeInsets.only(top: gH(20.0)),
              child: DailyMenuWidget(
                con: context,
                data: snap.data!,
                onTap: (int __, int n) {},
              ),
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
              showDataPicker(context, onDone: (date) {
                when = date;
                setState(() {});
              });
            } else {
              showNoNetToast(false);
            }
          },
        ),
      ],
    );
  }
}
