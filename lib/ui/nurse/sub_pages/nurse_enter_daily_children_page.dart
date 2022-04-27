import 'package:flutter/material.dart';
import 'package:governess/consts/colors.dart';
import 'package:governess/consts/decorations.dart';
import 'package:governess/consts/size_config.dart';
import 'package:governess/models/nurse_models/number_of_children_model.dart';
import 'package:governess/models/nurse_models/v_model.dart';
import 'package:governess/providers/nurse/enter_daily_children_page_provider.dart';
import 'package:governess/services/nurse_service.dart';
import 'package:governess/ui/nurse/nurse_home_page.dart';
import 'package:governess/ui/widgets/add_button_widget.dart';
import 'package:governess/ui/widgets/cancel_button_widget.dart';
import 'package:governess/ui/widgets/show_toast_function.dart';
import 'package:provider/provider.dart';

class NurseEnterDailyChildrenPage extends StatelessWidget {
  final NumberOfChildren data;
  
  const NurseEnterDailyChildrenPage(this.data, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> inputFields = List.generate(
      context
          .read<NurseEnterChildrenNumberPageProvider>()
          .controllers!
          .length,
      (__) {
        return TextFormField(
          key: Key("$__ EditNumberOfChildren"),
          autofocus: false,
          focusNode: context
              .watch<NurseEnterChildrenNumberPageProvider>()
              .nodes![__],
          keyboardType: TextInputType.number,
          cursorColor: mainColor,
          onFieldSubmitted: (v) {
            if (__ <
                Provider.of<NurseEnterChildrenNumberPageProvider>(context,
                            listen: false)
                        .nodes!
                        .length -
                    1) {
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
                  .nodes![__]
                  .unfocus();
              FocusScope.of(context).requestFocus(
                  Provider.of<NurseEnterChildrenNumberPageProvider>(context,
                          listen: false)
                      .nodes![0]);
            }
          },
          validator: (v) {
            if (v!.isEmpty) {
              return "Hech bo'lmasa '0' kiriting";
            }
          },
          controller: context
              .read<NurseEnterChildrenNumberPageProvider>()
              .controllers![__],
          decoration: DecorationMy.inputDecoration("Yosh toifa: ",
              data.perDayList![0].numberOfChildrenDtoList![__].ageGroupName),
        );
      },
    );

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Form(
        key: context.read<NurseEnterChildrenNumberPageProvider>().formKey,
        child: Column(
          children: [
            ListView.separated(
              padding: EdgeInsets.only(
                right: gW(20.0),
                left: gW(20.0),
                top: gH(50.0),
              ),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (_, __) {
                return inputFields[__];
              },
              separatorBuilder: (context, index) {
                return SizedBox(height: gH(20.0));
              },
              itemCount: inputFields.length,
            ),
            SizedBox(height: gH(20.0)),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: gW(20.0)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _addButton(context),
                  CancelButtonWidget(callBack: () {
                    Navigator.pop(context);
                  })
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  AddButtonWidget _addButton(BuildContext context) {
    return AddButtonWidget(
      callBack: () async {
        if (Provider.of<NurseEnterChildrenNumberPageProvider>(context,
                listen: false)
            .formKey
            .currentState!
            .validate()) {
          List<AgeGroupIdAndNumber> v = List.generate(
            data.perDayList![0].numberOfChildrenDtoList!.length,
            (index) {
              return AgeGroupIdAndNumber(
                ageGroupId: data
                    .perDayList![0].numberOfChildrenDtoList![index].ageGroupId,
                number: int.parse(
                    Provider.of<NurseEnterChildrenNumberPageProvider>(context,
                            listen: false)
                        .controllers![index]
                        .text),
              );
            },
          );
          NurseService().enterDailyChildrenNumber(v).then(
              (value) {
                if (value.success!) {
                  showToast(value.text!, true, false);
                  context
                      .read<NurseEnterChildrenNumberPageProvider>()
                      .clearControllers();

                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const NurseHomePage()),
                      (route) => false);
                } else {
                  return showToast(value.text!, false, false);
                }
              },
            );
        }
      },
    );
  }
}