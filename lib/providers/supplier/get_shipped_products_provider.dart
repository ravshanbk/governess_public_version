import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:governess/models/other/date_time_from_milliseconds_model.dart';

class GetShippedProductsProvider extends ChangeNotifier {
  
  int current = -1;
  changeCurrent(int v) {
    current = v;
    notifyListeners();
  }


 
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
}
