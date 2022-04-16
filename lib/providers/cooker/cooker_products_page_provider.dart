import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:governess/models/supplier/product_model.dart';

class CookerProductsPageProvider extends ChangeNotifier {
  List<Product> dataByDate = [];

  generateByTimeData(List<Product> list) {
    dataByDate = list;
    notifyListeners();
  }

///////////////////////////////////////
  String? currentCompName;
  initCurrentCompanyname(String v) {
    currentCompName = v;
  }

  List<Product> dataByCompanyName = [];

  generateByCompanyNameData(List<Product> list) {
    dataByCompanyName = list;
    notifyListeners();
  }

  List<String> availableCompanyNames = [];

  generateAvailableCompanyNames(Future<List<Product>> data) async{
    List<String> names = [];
    List<Product> items = await data;

    for (var item in items) {
      if (!names.contains(item.companyName)) {
        names.add(item.companyName!);
      }
    }
    availableCompanyNames = names;

    debugPrint("Men Generate Available Company names ichidagi printman: " +
        availableCompanyNames.toString());
    notifyListeners();
  }

////////////////////////////////////////

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

//////////////////////////////////////

  int currentFilterIndex = 0;
  List<String> filters = ["Hammasi", "Sana bo'yicha", "Korxona nomi bo'yicha"];
  changeCurrentFilterIndex(int v) {
    currentFilterIndex = v;
    notifyListeners();
  }
}
