import 'package:flutter/cupertino.dart';

class GetShippedProductsProvider extends ChangeNotifier {
  int current = -1;
  changeCurrent(v) {
    current = v;
    notifyListeners();
  }
}
