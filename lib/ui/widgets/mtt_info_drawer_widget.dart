import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:governess/consts/size_config.dart';
import 'package:governess/models/mtt_info_model.dart';
import 'package:governess/services/mtt_info_service.dart';
import 'package:governess/ui/widgets/text_span_grey_16_widget.dart';

class MttInfoEndDrawer extends StatelessWidget {
  const MttInfoEndDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: FutureBuilder<MttInfo>(
        future: MttInfoService().getInfo(),
        builder: (context, AsyncSnapshot<MttInfo> snap) {
      if (snap.connectionState == ConnectionState.done && snap.hasData) {
        return _body(snap.data!);
      } else if (snap.connectionState == ConnectionState.done &&
          !snap.hasData) {
        return const Center(
          child: Text("Hozircha Ma'lumotlar Mavjud Emas!"),
        );
      } else {
        return Center(
          child: CupertinoActivityIndicator(
            radius: gW(20.0),
          ),
        );
      }
        },
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.horizontal(
          left: Radius.circular(
            gW(30.0),
          ),
        ),
      ),
    );
  }

  

   Padding _body(MttInfo data) {
     return Padding(
          padding:
              EdgeInsets.only(top: gH(50.0), left: gW(20.0), right: gW(20.0)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                alignment: Alignment.center,
                height: gH(60.0),
                width: gW(335.0),
                decoration: BoxDecoration(
                  color: mainColor,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(
                      gW(5.0),
                    ),
                  ),
                ),
                child: Text(
                  "${data.name} malumotlari",
                  style: TextStyle(
                    color: whiteColor,
                    fontSize: gW(20.0),
                  ),
                ),
              ),
              SizedBox(height: gH(20.0)),
              _divider(),
              _richText("Viloyat:  ", data.region!.toString()),
              _divider(),
              _richText("Tuman:  ", data.district!.toString()),
              _divider(),
              _richText("Ko'cha:  ", data.street!.toString()),
              _divider(),
              _richText("Hisob raqam:  ", data.accountNumber!.toString()),
              _divider(),
              _richText("Telefon raqam:  ", data.phoneNumber!.toString()),
              _divider(),
              SizedBox(height: gH(20.0)),
            ],
          ),
        );
   }

  Divider _divider() {
    return Divider(
      color: greyColor,
      endIndent: gW(0.0),
    );
  }

  RichText _richText(String text1, String text2) {
    return RichText(
      textAlign: TextAlign.start,
      text: TextSpan(
        children: [
          textSpanGrey16Widget(text1),
          textSpan22Maincolor(text2),
        ],
      ),
    );
  }
}
