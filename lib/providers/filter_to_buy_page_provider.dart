import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:governess/consts/size_config.dart';
import 'package:governess/models/supplier/product_model.dart';

class FilterToBuyPageProvider extends ChangeNotifier {
  List<PopupMenuItem>? companyNamesPopUpMenuItems;
  String? currentCompName;

  generatePopUpMenuItems(List<Product> data) {
    List<String>? names;

    for (var item in data) {
      if (!names!.contains(item.companyName)) {
        names.add(item.companyName!);
      }
    }
    if (names!.isNotEmpty) {
      companyNamesPopUpMenuItems = List.generate(
        names.length,
        (index) {
          return PopupMenuItem(
            onTap: () {
              currentCompName = names[index];
              notifyListeners();
            },
            value: names[index],
            child: Text(
              names[index],
              style: TextStyle(
                fontSize: gW(18.0),
              ),
            ),
          );
        },
      );
    }
  }

///////////////////////////////////////////////////////////

  int? n;
  initN(v) {
    n = v;
    notifyListeners();
  }

  DateTime? from;
  initFrom(DateTime v) {
    from = v;
    notifyListeners();
  }

  DateTime? to;
  initTo(DateTime v) {
    to = v;
    notifyListeners();
  }

  int currentFilterIndex = 0;
  List<String> filters = ["Hammasi", "Sana bo'yicha", "Korxona nomi bo'yicha"];
  changeCurrentFilterIndex(int v) {
    currentFilterIndex = v;
    notifyListeners();
  }
}
