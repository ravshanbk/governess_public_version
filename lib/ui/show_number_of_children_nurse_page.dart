import 'package:flutter/material.dart';
import 'package:governess/consts/colors.dart';
import 'package:governess/consts/print_my.dart';
import 'package:governess/consts/size_config.dart';
import 'package:governess/models/hamshira_models/number_of_children_model.dart';
import 'package:governess/providers/nurse/editing_children_page_provider.dart';
import 'package:governess/ui/nurse/sub_pages/edit_daily_childred_page.dart';
import 'package:governess/ui/widgets/number_of_children_widget.dart';
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:governess/services/nurse_service.dart';

class NurseShowNumberOfChildrenPage extends StatelessWidget {
  const NurseShowNumberOfChildrenPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<NumberOfChildren>(
      future: NurseService().getChildrenNumber(),
      builder: (context, AsyncSnapshot<NumberOfChildren> snap) {
        if (snap.connectionState == ConnectionState.waiting) {
          return Scaffold(
            body: Center(
              child: CupertinoActivityIndicator(
                radius: gW(50.0),
              ),
            ),
          );
        } else {
          NumberOfChildren data = snap.data!;

          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              elevation: 0,
              backgroundColor: mainColor,
              title: Text(data.perDayList![0].kindergartenName!),
            ),
            body: Padding(
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
            ),
          );
        }
      },
    );
  }

  _editButton(BuildContext context, NumberOfChildren data) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(gW(10.0))),
        primary: mainColor,
        elevation: 0,
        fixedSize: Size(
          gW(180.0),
          gH(52.0),
        ),
      ),
      onPressed: data.perDayList![0].status == "TASDIQLANGAN" ||
              data.perDayList![0].status == "QABUL QILINDI"
          ? null
          : () async {
              Future.delayed(const Duration(seconds: 2), () {
                List<String> vInt = List.generate(
                    data.perDayList![0].numberOfChildrenDTOList!.length,
                    (index) {
                  return data.perDayList![0].numberOfChildrenDTOList![index]
                              .number ==
                          null
                      ? ""
                      : data.perDayList![0].numberOfChildrenDTOList![index]
                          .number!
                          .toString();
                });

                context
                    .read<EditingChildrenNumberPageProvider>()
                    .initControllersAndNodes(vInt);
              }).then((value) {

                return Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditDailyChildrenPage(data),
                  ),
                );
              });
            },
      child: Text(
        "O'zgartirish",
        style: TextStyle(letterSpacing: gW(2.0), fontSize: gW(20.0)),
      ),
    );
  }
}
