import 'package:flutter/material.dart';
import 'package:governess/consts/date_time_picker_function.dart';
import 'package:governess/consts/size_config.dart';
import 'package:governess/consts/strings.dart';
import 'package:governess/models/nurse_models/number_of_children_model.dart';
import 'package:governess/models/other/date_time_from_milliseconds_model.dart';
import 'package:governess/providers/nurse/editing_children_page_provider.dart';
import 'package:governess/providers/nurse/enter_daily_children_page_provider.dart';
import 'package:governess/services/network.dart';
import 'package:governess/ui/nurse/sub_pages/edit_daily_childred_page.dart';
import 'package:governess/ui/nurse/sub_pages/enter_daily_children_page.dart';
import 'package:governess/ui/widgets/date_time_show_button_widget.dart';
import 'package:governess/ui/widgets/future_builder_of_no_data_widget.dart';
import 'package:governess/ui/widgets/indicator_widget.dart';
import 'package:governess/ui/widgets/number_of_children_widget.dart';
import 'package:governess/services/nurse_service.dart';
import 'package:provider/provider.dart';

class NurseShowNumberOfChildrenPage extends StatefulWidget {
  const NurseShowNumberOfChildrenPage({Key? key}) : super(key: key);

  @override
  State<NurseShowNumberOfChildrenPage> createState() =>
      _NurseShowNumberOfChildrenPageState();
}

class _NurseShowNumberOfChildrenPageState
    extends State<NurseShowNumberOfChildrenPage> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<NumberOfChildren>(
      future: NurseService().getDailyChildrenNumber(
          Provider.of<NurseEnterChildrenNumberPageProvider>(context,
                  listen: false)
              .when),
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
    );
  }

  _body(NumberOfChildren data, BuildContext context) {
    bool idf = data.perDayList![0].id == null;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: mainColor,
        actions: [
          _dateTimeShowButton(context),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.only(
          left: gW(20.0),
          right: gW(20.0),
          top: gH(20.0),
        ),
        child: Column(
          children: [
            NumberOfChildrenWidget(data: data),
            SizedBox(height: gH(20.0)),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                _changeDailyChildrenButton(data, idf),
              ],
            ),
            SizedBox(height: gH(10.0)),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                _enterDailyChildrenButton(
                    callBack: () async {
                      bool isEnabledInternet = await checkConnectivity();
                      if (isEnabledInternet) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => NurseEnterDailyChildrenPage(
                              kGId: data.perDayList![0].kindergartenId!,
                              id: data.perDayList![0].id,
                            ),
                          ),
                        ).then((value) {
                          setState(() {});
                        });
                      } else {
                        showNoNetToast(false);
                      }
                    },
                    title: "Kiritish",
                    idf: !idf),
              ],
            )
          ],
        ),
      ),
    );
  }

  _changeDailyChildrenButton(NumberOfChildren data, bool idf) {
    return _enterDailyChildrenButton(
      idf: idf,
      title: "O'zgartirish",
      callBack: () async {
        bool isEnabledInternet = await checkConnectivity();

        await Future.delayed(const Duration(microseconds: 200), () {
          return List.generate(
              data.perDayList![0].numberOfChildrenDtoList!.length,
              (index) => data
                          .perDayList![0].numberOfChildrenDtoList![index].number
                          .toString() ==
                      "null"
                  ? ""
                  : data.perDayList![0].numberOfChildrenDtoList![index].number
                      .toString());
        }).then(
          (value) => Provider.of<NurseChangeChildrenNumberPageProvider>(context,
                  listen: false)
              .initControllersAndNodes(value),
        );
        if (isEnabledInternet) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NurseEditDailyChildrenPage(
                data,
              ),
            ),
          ).then((value) {
            setState(() {});
          });
        } else {
          showToast(
            "Qurilma Internet Tarmog'iga Ulanmagan",
            false,
            true,
          );
        }
      },
    );
  }

  ElevatedButton _enterDailyChildrenButton(
      {required VoidCallback callBack,
      required String title,
      required bool idf}) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            gW(10.0),
          ),
        ),
        primary: mainColor,
        elevation: 0,
        fixedSize: Size(
          gW(180.0),
          gH(52.0),
        ),
      ),
      onPressed: idf ? null : callBack,
      child: Text(
        title,
        style: TextStyle(
          letterSpacing: gW(2.0),
          fontSize: gW(20.0),
        ),
      ),
    );
  }

  DateTimeShowButton _dateTimeShowButton(BuildContext context) {
    return DateTimeShowButton(
      DTFM.maker(
        Provider.of<NurseEnterChildrenNumberPageProvider>(context,
                listen: false)
            .when
            .millisecondsSinceEpoch,
      ),
      () {
        showDataPicker(context, onDone: (date) {
          Provider.of<NurseEnterChildrenNumberPageProvider>(context,
                  listen: false)
              .changeWhen(date);
          setState(() {});
        });
      },
    );
  }
}
