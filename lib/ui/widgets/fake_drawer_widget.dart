import 'package:flutter/material.dart';
import 'package:governess/consts/size_config.dart';
import 'package:governess/local_storage/boxes.dart';
import 'package:governess/models/hive_models/user_h_model.dart';
import 'package:governess/ui/widgets/text_span_grey_16_widget.dart';
import 'package:hive_flutter/hive_flutter.dart';

class FakeDrawerWidget extends StatelessWidget {
  const FakeDrawerWidget({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Box<UserH>>(
        valueListenable: Boxes.getUser().listenable(),
        builder: (context, box, __) {
          return box.isEmpty
              ? const Drawer(
                  child: Center(
                    child: Text("Malumotlar mavjud emas"),
                  ),
                )
              : _drawerrrrrr(box);
        });
  }
   Drawer _drawerrrrrr(Box<UserH> box) {
    final UserH data = box.values.toList().cast<UserH>()[0];

    return Drawer(
      child: Padding(
        padding: EdgeInsets.only(top: gH(50.0), left: gW(20.0)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Shaxsiy Malumotlar",
              style: TextStyle(
                fontSize: gW(20.0),
              ),
            ),
            Divider(thickness: gW(2.0)),
            SizedBox(height: gH(20.0)),
            _richText("Tahallus: ", data.username),
            SizedBox(height: gH(20.0)),
            _richText("Ism: ", data.name),
            SizedBox(height: gH(20.0)),
            _richText("Familya: ", data.surname),
            SizedBox(height: gH(20.0)),
            _richText("Lavozimi: ", data.role),
          ],
        ),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.horizontal(
          right: Radius.circular(
            gW(20.0),
          ),
        ),
      ),
    );
  }
   RichText _richText(String text1, String text2) {
    return RichText(
      textAlign: TextAlign.start,
      text: TextSpan(
        children: [
          textSpanGrey16Widget(text1),
          textSpan18black(text2),
        ],
      ),
    );
  }


}