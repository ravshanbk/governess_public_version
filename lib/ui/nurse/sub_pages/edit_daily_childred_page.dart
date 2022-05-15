import 'package:flutter/material.dart';
import 'package:governess/consts/decorations.dart';
import 'package:governess/consts/size_config.dart';
import 'package:governess/consts/strings.dart';
import 'package:governess/models/nurse_models/number_of_children_model.dart';
import 'package:governess/models/nurse_models/age_group_id_and_number_model.dart';
import 'package:governess/providers/nurse/editing_children_page_provider.dart';
import 'package:governess/services/nurse_service.dart';
import 'package:governess/ui/widgets/cancel_button_widget.dart';
import 'package:provider/provider.dart';

class NurseEditDailyChildrenPage extends StatelessWidget {
  final NumberOfChildren data;

  const NurseEditDailyChildrenPage(this.data, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> inputFields = List.generate(
      context.read<NurseChangeChildrenNumberPageProvider>().controllers.length,
      (__) {
        return TextFormField(
          key: Key("$__ EditNumberOfChildren"),
          autofocus: false,
          focusNode:
              context.watch<NurseChangeChildrenNumberPageProvider>().nodes![__],
          keyboardType: TextInputType.number,
          cursorColor: mainColor,
          onFieldSubmitted: (v) {
            if (__ <
                Provider.of<NurseChangeChildrenNumberPageProvider>(context,
                            listen: false)
                        .nodes!
                        .length -
                    1) {
              Provider.of<NurseChangeChildrenNumberPageProvider>(context,
                      listen: false)
                  .nodes![__]
                  .unfocus();
              FocusScope.of(context).requestFocus(
                  Provider.of<NurseChangeChildrenNumberPageProvider>(context,
                          listen: false)
                      .nodes![__ + 1]);
            } else {
              Provider.of<NurseChangeChildrenNumberPageProvider>(context,
                      listen: false)
                  .nodes![__]
                  .unfocus();
              FocusScope.of(context).requestFocus(
                  Provider.of<NurseChangeChildrenNumberPageProvider>(context,
                          listen: false)
                      .nodes![0]);
            }
          },
          validator: (v) {
            if (v!.isEmpty) {
              return "Hech bo'lmasa '0' kiriting";
            }
            return null;
          },
          controller: context
              .read<NurseChangeChildrenNumberPageProvider>()
              .controllers[__],
          decoration: DecorationMy.inputDecoration("Yosh toifa: ",
              data.perDayList![0].numberOfChildrenDtoList![__].ageGroupName),
        );
      },
    );

    return WillPopScope(
      key: const Key("WillPopScopeKey / NurseEditDailyChildrenPage"),
      onWillPop: () {
        Navigator.pop(context, "This is a Will pop scope");
        return Future.value(true);
      },
      child: Scaffold(
      appBar: AppBar(backgroundColor:mainColor,elevation: 0,),
        resizeToAvoidBottomInset: false,
        body: Form(
          key: context.read<NurseChangeChildrenNumberPageProvider>().formKey,
          child: Column(
            children: [
              ListView.separated(
                padding: EdgeInsets.only(
                  right: gW(20.0),
                  left: gW(20.0),
                  top: gH(20.0),
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
      ),
    );
  }

   _addButton(BuildContext context) {
   return  ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            gW(15.0),
          ),
        ),
        primary: mainColor,
        elevation: 0,
        fixedSize: Size(
          gW(150.0),
          gH(62.0),
        ),
      ),
      onPressed:() async {
        if (Provider.of<NurseChangeChildrenNumberPageProvider>(context,
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
                    Provider.of<NurseChangeChildrenNumberPageProvider>(context,
                            listen: false)
                        .controllers[index]
                        .text),
              );
            },
          );
          NurseService()
              .changeDailyChildrenNumber(v, data.perDayList![0].id!)
              .then(
            (value) {
              if (value.success!) {
                showToast(value.text!, true, false);
                context
                    .read<NurseChangeChildrenNumberPageProvider>()
                    .clearControllers();
                Navigator.pop(context);
              } else {
                return showToast(value.text!, value.success!, false);
              }
            },
          );
        }
      },
      child: Text(
        "Kiritish",
        style: TextStyle(
          letterSpacing: gW(3.0),
          fontSize: gW(20.0),
        ),
      ),
    );
   
  }
}
