import 'package:flutter/material.dart';
import 'package:governess/consts/colors.dart';
import 'package:governess/consts/size_config.dart';
import 'package:governess/models/nurse_models/daily_menu_model.dart';
import 'package:governess/ui/widgets/meal_widget.dart';

class ShowMealDetailsPage extends StatelessWidget {
  final List<MealAgeStandardResponseSaveDtoList> data;
  const ShowMealDetailsPage(this.data, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: mainColor,
        elevation: 0,
        title: const Text("Bugun"),
      ),
      body: ListView.separated(
        padding: EdgeInsets.symmetric(horizontal: gW(10.0), vertical: gH(20.0)),
        itemBuilder: (_, __) {
          return MealWidget(data: data[__]);
        },
        separatorBuilder: (context, index) {
          return SizedBox(
            height: gH(20.0),
          );
        },
        itemCount: 1,
      ),
    );
  }
}
