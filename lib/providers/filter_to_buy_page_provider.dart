import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:governess/consts/size_config.dart';
import 'package:governess/models/supplier/product_model.dart';

class FilterToBuyPageProvider extends ChangeNotifier {
  List<Product> dataByDate = [];

  generateByTimeData(List<Product> list) {
    dataByDate = list;
    notifyListeners();
  }

/////////////////////////////////////////////////
  String? currentCompName;
  List<String> availableCompanyNames = [];
  List<Product> dataByCompanyName = [];

  generateByCompanyNameData(List<Product> list) {
    dataByCompanyName = list;
    notifyListeners();
  }

  generateAvailableCompanyNames(List<Product> data) {
    List<String> names = [];

    for (var item in data) {
      if (!names.contains(item.companyName)) {
        names.add(item.companyName!);
      }
    }
    availableCompanyNames = names;
    notifyListeners();
  }

///////////////////////////////////////////////////////////

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

/////////////////////////////////////////////////////////////////////
  int? n;
  initN(int v) {
    n = v;
    print("inited n" + n.toString());
    notifyListeners();
  }

  int currentFilterIndex = 0;
  List<String> filters = ["Hammasi", "Sana bo'yicha", "Korxona nomi bo'yicha"];
  changeCurrentFilterIndex(int v) {
    currentFilterIndex = v;
    notifyListeners();
  }
}
