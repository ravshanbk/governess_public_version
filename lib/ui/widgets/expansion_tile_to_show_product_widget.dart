import 'package:flutter/material.dart';
import 'package:governess/consts/colors.dart';
import 'package:governess/consts/size_config.dart';
import 'package:governess/models/supplier/product_model.dart';

class ExpansionTileToShowProductWidget extends StatelessWidget {
  final bool isExpanded;
  final List<Widget> children;
  final Function(bool) onChanged;
  final Product data;
  const ExpansionTileToShowProductWidget({
    Key? key,
    required this.isExpanded,
    required this.children,
    required this.onChanged,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        // backgroundBlendMode: BlendMode.screen,
        color:  isExpanded?whiteColor:mainColor_02,
        borderRadius: BorderRadius.circular(
          gW(10.0),
        ),
      ),
      child: ExpansionTile(
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

  Row _subtitle() {
    return Row(
      children: [
        Text(
          "Holati:",
          style: TextStyle(color: greyColor, fontSize: gW(14.0)),
        ),
        SizedBox(
          width: gW(5.0),
        ),
        Text(
          data.status.toString(),
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
    );
  }
}
