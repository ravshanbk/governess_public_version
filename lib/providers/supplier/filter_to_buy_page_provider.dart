import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:governess/models/other/date_time_from_milliseconds_model.dart';
import 'package:governess/models/supplier/product_model.dart';

class FilterToBuyPageProvider extends ChangeNotifier {
  List<Product> dataByDate = [];

  generateByTimeData(List<Product> list) {
    dataByDate = list;
    notifyListeners();
  }

///////////////////////////////////////
  String? currentCompName;
  initCurrentCompanyname(String v) {
    currentCompName = v;
    notifyListeners();
  }

  List<Product> dataByCompanyName = [];

  generateByCompanyNameData(List<Product> data, name) {
    List<Product> list = [];

    for (int i = 0; i < data.length; i++) {
      if (data[i].companyName! == name) {
        list.add(data[i]);
      }
    }
    dataByCompanyName = list;
    notifyListeners();
  }

  List<String> availableCompanyNames = [];

////////////////////////////////////////
  String fromStr = "__.__.____";
  DateTime? from;
  initFrom(DateTime v) {
    fromStr = DTFM.maker(v.millisecondsSinceEpoch);
    from = v;
    notifyListeners();
  }

  String toStr = "__.__.____";
  DateTime? to;
  initTo(DateTime v) {
    toStr = DTFM.maker(v.millisecondsSinceEpoch);
    to = v;
    notifyListeners();
  }

  clearFromTo() {
    to = null;
    from = null;
    notifyListeners();
  }
//////////////////////////////////////

  int currentFilterIndex = 0;
  List<String> filters = ["Hammasi", "Sana bo'yicha", "Korxona nomi bo'yicha"];
  changeCurrentFilterIndex(int v) {
    currentFilterIndex = v;
    notifyListeners();
  }
}
