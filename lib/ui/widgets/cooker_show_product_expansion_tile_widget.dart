import 'package:flutter/material.dart';
import 'package:governess/consts/size_config.dart';
import 'package:governess/models/cooker/to_accept_product_model.dart';

class CookerShowProductExpansionTileWidget extends StatelessWidget {
  final bool isExpanded;
  final List<Widget> children;
  final Function(bool) onChanged;
  final CookerProduct data;

  const CookerShowProductExpansionTileWidget({
    Key? key,
    required this.isExpanded,
    required this.children,
    required this.onChanged,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ExpansionTile(
        collapsedBackgroundColor: mainColor_02,
        tilePadding: EdgeInsets.symmetric(horizontal: gW(10.0)),
        iconColor: Colors.grey,
        textColor: mainColor,
        key: Key(DateTime.now().toString()),
        initiallyExpanded: isExpanded,
        title: _title(),
        subtitle: _subtitle(),
        children: children,
        onExpansionChanged: onChanged,
      ),
    );
  }

  _title() {
    return Text(
      data.productName.toString().length > 35
          ? data.productName.toString().substring(0, 34)
          : data.productName.toString(),
      textAlign: TextAlign.center,
      style: TextStyle(
        fontStyle: FontStyle.italic,
        letterSpacing: gW(2.0),
        decoration: TextDecoration.underline,
        fontSize: 18.0,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  _subtitle() {
    return Column(
      children: [
        Row(
          children: [
            Text(
              "Miqdori:",
              style: TextStyle(color: greyColor, fontSize: gW(14.0)),
            ),
            SizedBox(
              width: gW(5.0),
            ),
            Text(
              data.sendNumberPack!,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: gW(14.0),
                color:mainColor,
              ),
            ),
          ],
        ),
         Row(
          children: [
            Text(
              "Holati:",
              style: TextStyle(color: greyColor, fontSize: gW(14.0)),
            ),
            SizedBox(
              width: gW(5.0),
            ),
            Text(
              data.status!.length > 19
                  ? data.status!.substring(0, 18).replaceRange(18, 18, "..")
                  : data.status!,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: gW(14.0),
                color: data.status == "YANGI"
                    ? Colors.green
                    : (data.status == "QISMAN QABUL QILINDI"
                        ? Colors.orange
                        : Colors.black),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
