import 'package:flutter/material.dart';
import 'package:governess/consts/size_config.dart';
import 'package:governess/models/cooker/product_cooker_product.dart';

class ShowInOutListProductWidget extends StatelessWidget {
  final bool isExpanded;
  final List<Widget> children;
  final Function(bool) onChanged;
  final CookerInOutListProduct data;
  const ShowInOutListProductWidget({
    Key? key,
    required this.isExpanded,
    required this.children,
    required this.onChanged,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
    //  color: mainColor,
     
      child: ExpansionTile(
        collapsedBackgroundColor: mainColor_02,
        iconColor: Colors.grey,
        textColor:mainColor,
        collapsedTextColor: Colors.black,
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
