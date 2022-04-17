import 'package:flutter/material.dart';
import 'package:governess/consts/colors.dart';
import 'package:governess/consts/size_config.dart';
import 'package:governess/models/in_out_list_product_model.dart';

class ShowInOutListProductWidget extends StatelessWidget {
  final bool isExpanded;
  final List<Widget> children;
  final Function(bool) onChanged;
  final InoutListProduct data;
  const ShowInOutListProductWidget({
    Key? key,
    required this.isExpanded,
    required this.children,
    required this.onChanged,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Ink(
      decoration: BoxDecoration(
        color: isExpanded ? lightGreyColor : mainColor_02,
        borderRadius: BorderRadius.circular(
          gW(10.0),
        ),
      ),
      child: ExpansionTile(
        iconColor: Colors.grey,
        textColor: Colors.black,
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
          "Miqdor:",
          style: TextStyle(color: greyColor, fontSize: gW(14.0)),
        ),
        SizedBox(
          width: gW(5.0),
        ),
        Text(
          data.weight.toString(),
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: gW(14.0),
            color: Colors.red,
          ),
        ),
      ],
    );
  }
}
