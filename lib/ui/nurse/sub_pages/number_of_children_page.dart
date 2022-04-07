import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:governess/consts/size_config.dart';
import 'package:governess/models/hamshira_models/number_of_children_model.dart';
import 'package:governess/services/nurse_service.dart';
import 'package:governess/ui/nurse/nurse_home_page.dart';
import 'package:governess/ui/nurse/sub_pages/enter_daily_children_page.dart';
import 'package:governess/ui/nurse/sub_pages/show_daily_children_number_page.dart';

class NumberOfChildrenPage extends StatelessWidget {
  const NumberOfChildrenPage({Key? key}) : super(key: key);

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

          return ShowDailyChildrenPage(data);
        }
      },
    );
  }
}
