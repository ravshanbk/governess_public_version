import 'package:flutter/material.dart';
import 'package:governess/consts/date_time_picker_function.dart';
import 'package:governess/consts/size_config.dart';
import 'package:governess/consts/strings.dart';
import 'package:governess/models/nurse_models/age_group_id_and_number_model.dart';
import 'package:governess/models/nurse_models/age_group_model.dart';
import 'package:governess/models/other/date_time_from_milliseconds_model.dart';
import 'package:governess/providers/nurse/enter_daily_children_page_provider.dart';
import 'package:governess/services/nurse_service.dart';
import 'package:governess/ui/widgets/date_time_show_button_widget.dart';
import 'package:governess/ui/widgets/future_builder_of_no_data_widget.dart';
import 'package:governess/ui/widgets/indicator_widget.dart';
import 'package:provider/provider.dart';

class NurseEnterDailyChildrenPage extends StatelessWidget {
  const NurseEnterDailyChildrenPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Navigator.pop(
          context,
        );
        return Future.value(true);
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          backgroundColor: mainColor,
          actions: [
            _dateTimeShowButton(context),
          ],
        ),
        backgroundColor: mainColor,
        body: FutureBuilder<List<AgeGroup>>(
          future: NurseService().getAgeGroupList(),
          builder: (BuildContext context, AsyncSnapshot<List<AgeGroup>> snap) {
            if (snap.connectionState == ConnectionState.done && snap.hasData) {
              return _body(context, snap.data!);
            } else if (snap.connectionState == ConnectionState.done &&
                !snap.hasData) {
              return const NoDataWidgetForFutureBuilder(
                  "Hozircha Yosh Toifalar kiritilmagan!");
            } else {
              return IndicatorWidget(snap);
            }
          },
        ),
      ),
    );
  }

  _body(BuildContext context, List<AgeGroup> data) {
    return context.watch<NurseEnterChildrenNumberPageProvider>().idf
        ? SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              horizontal: gW(10.0),
              vertical: gH(20.0),
            ),
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                _topText(),
                Divider(
                  height: gH(3.0),
                  thickness: gW(3.0),
                  color: whiteColor,
                  indent: gW(50.0),
                  endIndent: gW(50.0),
                ),
                SizedBox(
                  height: gH(20.0),
                ),
                _inputFields(data, context),
                SizedBox(
                  height: gH(20.0),
                ),
                _enterButton(
                  context,
                  () async {
                    List<AgeGroupIdAndNumber> v = List.generate(
                      data.length,
                      (index) => AgeGroupIdAndNumber(
                        ageGroupId: data[index].ageGroupId,
                        number: int.parse(
                          Provider.of<NurseEnterChildrenNumberPageProvider>(
                                  context,
                                  listen: false)
                              .controllers![index]
                              .text,
                        ),
                      ),
                    );
                    NurseService()
                        .enterDailyChildrenNumber(
                      v,
                      Provider.of<NurseEnterChildrenNumberPageProvider>(context,
                              listen: false)
                          .when,
                    )
                        .then(
                      (value) {
                        if (value.success!) {
                          Provider.of<NurseEnterChildrenNumberPageProvider>(
                                  context,
                                  listen: false)
                              .clearControllers();
                          showToast(value.text!, value.success!, false);
                          Navigator.pop(context);
                        } else {
                          showToast(value.text!, value.success!, false);
                        }
                      },
                    );
                  },
                )
              ],
            ),
          )
        : Center(
            child: _enterButton(
              context,
              () {
                Provider.of<NurseEnterChildrenNumberPageProvider>(context,
                        listen: false)
                    .initControllersAndNodes(data.length);
              },
            ),
          );
  }

  Text _topText() {
    return Text(
      "Yosh toifalar",
      style: TextStyle(
        color: whiteColor,
        fontSize: gW(24.0),
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Ink _enterButton(BuildContext context, VoidCallback onPressed) {
    return Ink(
      padding: EdgeInsets.all(gW(10.0)),
      height: gH(80),
      width: gW(250.0),
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(gW(10.0)),
        border: Border.all(
          color: whiteColor,
          width: gW(3.0),
        ),
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: const StadiumBorder(),
          primary: mainColor,
          elevation: 0,
          shadowColor: Colors.transparent,
        ),
        child: const Text("Kiritish"),
        onPressed: onPressed,
      ),
    );
  }

  Ink _inputFields(List<AgeGroup> data, BuildContext context) {
    return Ink(
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(
          gW(30.0),
        ),
      ),
      child: ListView.separated(
        padding: EdgeInsets.all(gW(20.0)),
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (_, __) {
          return _inputField(__, data[__].name!, context);
        },
        separatorBuilder: (context, index) {
          return SizedBox(
            height: gH(20.0),
          );
        },
        itemCount: data.length,
      ),
    );
  }

  SizedBox _inputField(int __, String prefix, BuildContext context) {
    return SizedBox(
      height: gH(60.0),
      width: gW(300.0),
      child: TextFormField(
        onFieldSubmitted: (v) {
          if (__ <
              Provider.of<NurseEnterChildrenNumberPageProvider>(context,
                          listen: false)
                      .nodes!
                      .length -
                  1) {
            Provider.of<NurseEnterChildrenNumberPageProvider>(context,
                    listen: false)
                .regenerateIdfs(__ + 1);
            Provider.of<NurseEnterChildrenNumberPageProvider>(context,
                    listen: false)
                .nodes![__]
                .unfocus();
            FocusScope.of(context).requestFocus(
                Provider.of<NurseEnterChildrenNumberPageProvider>(context,
                        listen: false)
                    .nodes![__ + 1]);
          } else {
            Provider.of<NurseEnterChildrenNumberPageProvider>(context,
                    listen: false)
                .regenerateIdfs(0);

            Provider.of<NurseEnterChildrenNumberPageProvider>(context,
                    listen: false)
                .nodes![__]
                .unfocus();
            FocusScope.of(context).requestFocus(
                Provider.of<NurseEnterChildrenNumberPageProvider>(context,
                        listen: false)
                    .nodes![0]);
          }
        },
        onChanged: (v) {
          if (v.codeUnitAt(v.length - 1) > 57 ||
              v.codeUnitAt(v.length - 1) < 48) {
            showToast("Iltimos, Butun Son Kiriting", false, true);
            Provider.of<NurseEnterChildrenNumberPageProvider>(context,
                    listen: false)
                .clearOneController(__);
          }
        },
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        focusNode:
            context.watch<NurseEnterChildrenNumberPageProvider>().nodes![__],
        decoration: InputDecoration(
          hintStyle: TextStyle(color: mainColor),
          fillColor: whiteColor,
          filled: true,
          prefixIcon: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: gW(10.0),
              ),
              Text(
                "  " + prefix,
                style: const TextStyle(color: Colors.red),
              ),
            ],
          ),
          disabledBorder: _inputBorder(),
          focusedBorder: _inputBorder(),
          enabledBorder: _inputBorder(),
        ),
        controller: context
            .read<NurseEnterChildrenNumberPageProvider>()
            .controllers![__],
      ),
    );
  }

  OutlineInputBorder _inputBorder() {
    return OutlineInputBorder(
      borderSide: BorderSide(color: mainColor, width: gW(2.0)),
      borderRadius: BorderRadius.circular(
        gW(30.0),
      ),
    );
  }


  DateTimeShowButton _dateTimeShowButton(BuildContext context) {
    return DateTimeShowButton(
      DTFM.maker(context
          .watch<NurseEnterChildrenNumberPageProvider>()
          .when
          .millisecondsSinceEpoch),
      () {
        showDataPicker(context,onDone:  (date) {
        context.read<NurseEnterChildrenNumberPageProvider>().changeWhen(date);
      });
      },
    );
  }
}
