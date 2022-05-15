import 'package:flutter/material.dart';
import 'package:governess/consts/size_config.dart';
import 'package:governess/models/nurse_models/number_of_children_model.dart';


// ignore: must_be_immutable
class NumberOfChildrenWidget extends StatelessWidget {
  NumberOfChildren? data;
  NumberOfChildrenWidget({required this.data, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      minVerticalPadding: 0.0,
      contentPadding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: mainColor),
        borderRadius: BorderRadius.circular(
          gW(10.0),
        ),
      ),
      title: Column(
        children: [
          SizedBox(
            height: gH(5.0),
          ),
          _ageGroupAndNumberRow(),
          Divider(
            color: mainColor,
            height: gH(5.0),
          ),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (_, __) {
              return
               _greyTextInRow(
                  data!.perDayList![0].numberOfChildrenDtoList![__].ageGroupName
                      .toString(),
                  data!.perDayList![0].numberOfChildrenDtoList![__].number
                      .toString());
            },
            separatorBuilder: (context, index) {
              return SizedBox(
                height: gH(5.0),
                child:
                // Text(DTFM.maker(data!.perDayList![0].numberOfChildrenDtoList[0].))
                 Divider(
                  color: mainColor,
                  endIndent: gW(25.0),
                  indent: gW(25.0),
                ),
              );
            },
            itemCount: data!.perDayList![0].numberOfChildrenDtoList!.length,
          ),
          SizedBox(
            height: gH(5.0),
            child: Divider(
              color: mainColor,
              endIndent: gW(25.0),
              indent: gW(25.0),
            ),
          ),
          _greyTextInRow("Holati", data!.perDayList![0].status!)
        ],
      ),
    );
  }

  _ageGroupAndNumberRow() {
    return Padding(
      padding: EdgeInsets.only(left: gW(25.0), right: gW(50.0)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Yosh toifa",
            style: TextStyle(fontSize: gW(18.0), color: greyColor),
          ),
          SizedBox(
            height: gH(30.0),
            width: 3.0,
            child: VerticalDivider(
              endIndent: gH(2),
              color: mainColor,
            ),
          ),
          Text(
            "Soni",
            style: TextStyle(fontSize: gW(18.0), color: greyColor),
          )
        ],
      ),
    );
  }

  _greyTextInRow(String text1, String text2) {
   return Padding(
      padding: EdgeInsets.only(left: gW(30.0), right: gW(50.0)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text1,
            style: TextStyle(fontSize: gW(18.0), color: greyColor),
          ),
          const Spacer(),
          Text(
            text2,
            style: TextStyle(fontSize: gW(18.0), color: greyColor),
          ),
        ],
      ),
    );
  }
}
