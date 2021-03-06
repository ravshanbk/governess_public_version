import 'package:flutter/material.dart';
import 'package:governess/consts/size_config.dart';
import 'package:governess/models/supplier/shipped_product_model.dart';

class ShippedProductExpansionTile extends StatelessWidget {
  final bool isExpanded;
  final List<Widget> children;
  final Function(bool) onChanged;
  final ShippedProduct data;
  const ShippedProductExpansionTile({
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
        initiallyExpanded: isExpanded,
        title: _title(),
        subtitle: _subtitle(),
        children: children,
        onExpansionChanged: onChanged,
      ),
    );
  }

  Text _title() {
    return Text(
      data.productName.toString().length > 40
          ? data.productName.toString().substring(0, 39)
          : data.productName.toString(),
      textAlign: TextAlign.center,
      style: TextStyle(
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
                color:mainColor
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
              data.status!.length > 21
                  ? data.status!.substring(0, 20).replaceRange(19, 20, "..")
                  : data.status!,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: gW(14.0),
                color: data.status == "YANGI"
                    ? Colors.green
                    : (data.status == "QISMAN TUGALLANDI"
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
