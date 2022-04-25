import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:governess/consts/colors.dart';
import 'package:governess/consts/print_my.dart';
import 'package:governess/consts/size_config.dart';
import 'package:governess/models/nurse_models/number_of_children_model.dart';
import 'package:governess/models/other/date_time_from_milliseconds_model.dart';
import 'package:governess/providers/nurse/editing_children_page_provider.dart';
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
  DateTime when = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: mainColor,
        actions: [
          _dateTimeShowButton(context),
        ],
      ),
      body: FutureBuilder<NumberOfChildren>(
        future: NurseService().getDailyChildrenNumber(when),
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
      ),
    );
  }

  DateTimeShowButton _dateTimeShowButton(BuildContext context) {
    return DateTimeShowButton(
      DTFM.maker(
        when.millisecondsSinceEpoch,
      ),
      () {
        _showDataPicker(context);
      },
    );
  }

  _body(NumberOfChildren data, BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: gW(20.0),
        right: gW(20.0),
        top: gH(20.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          NumberOfChildrenWidget(data: data),
          SizedBox(height: gH(20.0)),
          _editButton(context, data),
        ],
      ),
    );
  }

  _editButton(BuildContext context, NumberOfChildren data) {
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
      onPressed: () async {
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
          (value) => Provider.of<NurseEditingChildrenNumberPageProvider>(
                  context,
                  listen: false)
              .initControllersAndNodes(value),
        );

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => NurseEditDailyChildrenPage(
              data,
              idf: data.perDayList![0].id != null,
            ),
          ),
        );
      },
      child: Text(
        "O'zgartirish",
        style: TextStyle(
          letterSpacing: gW(2.0),
          fontSize: gW(20.0),
        ),
      ),
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
