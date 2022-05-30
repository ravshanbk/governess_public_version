import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GetShippedDateTimeProvider extends ChangeNotifier {
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

  clearFromTo() {
    to = null;
    from = null;
    notifyListeners();
  }
}
