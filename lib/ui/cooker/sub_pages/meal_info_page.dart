import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:governess/consts/colors.dart';
import 'package:governess/consts/size_config.dart';
import 'package:governess/models/cooker/meal_info_model.dart';
import 'package:governess/services/cooker_service.dart';
import 'package:governess/ui/widgets/future_builder_of_no_data_widget.dart';
import 'package:governess/ui/widgets/indicator_widget.dart';

class CookerMealInfoPage extends StatelessWidget {
  final int? mealAgeStandartId;
  final int? menuId;
  final String? mealName;
  const CookerMealInfoPage(
      {required this.mealAgeStandartId,
      required this.menuId,
      required this.mealName,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SafeArea(
      child: Scaffold(
            body: FutureBuilder(
          future: CookerService().getMealInfo(mealAgeStandartId!, menuId!),
          builder: (context, AsyncSnapshot<MealInfo> snap) {
            if (snap.connectionState == ConnectionState.done && snap.hasData) {
              return _body(snap.data!);
            } else if (snap.connectionState == ConnectionState.done &&
                !snap.hasData) {
              return Scaffold(
                 appBar: AppBar(backgroundColor: mainColor,elevation: 0,),
   
               body: const NoDataWidgetForFutureBuilder(
                    "Ma'lumotlar kelmadi, bu kunga bolalar soni kiritilmagan bo'lishi mumkin. Tekshirib ko'ring."),
              );
            } else {
              return IndicatorWidget(snap);
            }
          },
        ),
      ),
    );
  }

  _body(MealInfo data) {
    return Center(
      child: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          _sliverAppBar(data),
          _mealInfo(data),
          _mealProducts(data),
          _mealIngredients(data),

          // _fake(data),
        ],
      ),
    );
  }

//Taom kimyoviy elementlari
  SliverToBoxAdapter _mealIngredients(MealInfo data) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: gW(20.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _titleSizedBox(),
            Text(
              "Taom kimyoviy elementlari",
              style: _titleTextStyle(),
            ),
            Ink(
              decoration: _inkDecoration(),
              padding: _inkPadding(),
              child: Column(
                children: [
                  _tripleTextInRow(
                      "Element nomi", "Miqdori", "O'lchov birligi"),
                  _indentlessDivider(),
                  _tripleTextInRow("Energetik quvvati",
                      data.ingredientDto!.kcal.toString(), "kkal"),
                  _divider(),
                  _tripleTextInRow("Oqsil miqdori",
                      data.ingredientDto!.protein.toString(), "gramm"),
                  _divider(),
                  _tripleTextInRow("Uglevod miqdori",
                      data.ingredientDto!.carbohydrates.toString(), "gramm"),
                  _divider(),
                  _tripleTextInRow("Yog' miqdori",
                      data.ingredientDto!.oil.toString(), "gramm"),
                ],
              ),
            ),
            SizedBox(
              height: gH(100.0),
            ),
          ],
        ),
      ),
    );
  }

  SizedBox _titleSizedBox() {
    return SizedBox(
      height: gH(20.0),
    );
  }

  _tripleTextInRow(String text1, String text2, String text3) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: gW(10.0)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 20,
            child: Text(text1),
          ),
          Expanded(
            flex: 10,
            child: Text(text2),
          ),
          Expanded(
            flex: 15,
            child: Text(text3),
          ),
        ],
      ),
    );
  }

// Taom mahsulotlar tarkibi
  SliverToBoxAdapter _mealProducts(MealInfo data) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: gW(
            20.0,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _titleSizedBox(),
            Text("Taom mahsulotlar tarkibi", style: _titleTextStyle()),
            Ink(
              padding: _inkPadding(),
              decoration: _inkDecoration(),
              child: ListView.separated(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (_, __) {
                  return __ == 0
                      ? Padding(
                          padding: EdgeInsets.symmetric(horizontal: gW(10.0)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Expanded(flex: 1, child: Text("Mahsulot nomi")),
                              Expanded(flex: 1, child: Text("Mahsulot miqdori"))
                            ],
                          ),
                        )
                      : Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: gW(10.0),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Text(
                                  data.productMeals![__ - 1].name!,
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Text(data.productMeals![__ - 1].weight!
                                    .toString()),
                              ),
                            ],
                          ),
                        );
                },
                separatorBuilder: (context, n) {
                  return n == 0 ? _indentlessDivider() : _divider();
                },
                itemCount: data.productMeals!.length + 1,
              ),
            ),
          ],
        ),
      ),
    );
  }

  
// Taom ma'lumotlari
  SliverToBoxAdapter _mealInfo(MealInfo data) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: gW(20.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _titleSizedBox(),
            Text(
              "Taom ma'lumotlari",
              style: _titleTextStyle(),
            ),
            Ink(
              padding: _inkPadding(),
              decoration: _inkDecoration(),
              child: Column(
                children: [
                  _textInRow("Taom Nomi", data.name!),
                  _divider(),
                  _textInRow("Taom vazni", data.weight!.toString()),
                  _divider(),
                  _textInRow("Taom Turi", data.mealCategoryName!),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Divider _indentlessDivider() => Divider(
        color: mainColor,
        thickness: gW(1.0),
      );

  SliverAppBar _sliverAppBar(MealInfo data) {
    return SliverAppBar(
          automaticallyImplyLeading: false,
      floating: true,
      leadingWidth: 0.0,
      primary: false,
      elevation: 0,
      pinned: true,
      backgroundColor: mainColor,
      toolbarHeight: gH(50.0),
      collapsedHeight: gH(50.0),
      expandedHeight: gH(240.0),
      flexibleSpace: FlexibleSpaceBar(

        stretchModes: const [StretchMode.blurBackground],
        titlePadding: EdgeInsets.only(
          left: gW(10.0),
          bottom: gW(10.0),
        ),
        collapseMode: CollapseMode.pin,
        centerTitle: true,
        title: Text(
        data.name!,
          style: const TextStyle(
            fontStyle: FontStyle.italic,
          ),
        ),
        background: _mealImage(
          data.attachment!.bytes!,
        ),
      ),
    );
  }

  Divider _divider() => Divider(
        color: greyColor,
        indent: gW(10.0),
        endIndent: gW(10.0),
      );

  _textInRow(String title, String message) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: gW(10.0)),
      child: Row(
        children: [
          Text(
            title + ": ",
            style: TextStyle(
              color: greyColor,
              fontSize: gW(
                13.0,
              ),
            ),
          ),
          Text(
            message.length > 28
                ? message.substring(0, 27).replaceRange(27, 27, "..")
                : message,
          ),
        ],
      ),
    );
  }

  t(String t1, String t) {
    return Row(
      children: [
        Text(
          t1,
          style: const TextStyle(color: Colors.red),
        ),
        Text(t),
      ],
    );
  }

  _mealImage(image) {
    return image == null
        ? const Image(
            image: AssetImage("assets/images/placeholder.jpeg"),
            fit: BoxFit.cover,
            gaplessPlayback: true,
          )
        : Image(
            image: MemoryImage(
              base64.decode(image),
            ),
            fit: BoxFit.cover,
            gaplessPlayback: true,
          );
  }

  _inkDecoration() {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(gW(4.0)),
      border: Border.all(
        color: mainColor,
      ),
    );
  }

  _inkPadding() {
    return EdgeInsets.symmetric(vertical: gW(10.0));
  }

  _titleTextStyle() {
    return TextStyle(
      fontSize: gW(22.0),
      color: greyColor,
    );
  }
}
