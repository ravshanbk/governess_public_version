import 'package:flutter/material.dart';
import 'package:governess/consts/size_config.dart';
import 'package:governess/models/cooker/product_cooker_product.dart';
import 'package:governess/ui/widgets/text_in_row_widget.dart';

class ShowInOutListProductWidget extends StatelessWidget {
  final bool isExpanded;

  final Function(bool) onChanged;
  final String title;
  final Balancer data;
  const ShowInOutListProductWidget({
    Key? key,
    required this.data,
    required this.isExpanded,
    required this.onChanged,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      //  color: mainColor,

      child: ExpansionTile(
        collapsedBackgroundColor: mainColor_02,
        iconColor: Colors.grey,
        textColor: mainColor,
        collapsedTextColor: Colors.black,
        key: Key(DateTime.now().toString()),
        initiallyExpanded: isExpanded,
        title: _title(),
        children: [
          _divider(),
          TextInRowWidget("Qadoq miqdori", data.pack!.toString()),
          _divider(),
          TextInRowWidget("Qadoqlar soni", data.numberPack!.toString()),
          _divider(),
          TextInRowWidget("Miqdori", data.weight!.toString()),
          _divider(),
        ],
        onExpansionChanged: onChanged,
      ),
    );
  }

  Text _title() {
    return Text(
      title,
      textAlign: TextAlign.center,
      style: TextStyle(
        letterSpacing: gW(2.0),
        decoration: TextDecoration.underline,
        fontSize: 18.0,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Divider _divider() => Divider(
        color: mainColor,
        indent: gW(15.0),
        endIndent: gW(15.0),
      );
}
