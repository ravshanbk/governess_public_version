import 'package:flutter/cupertino.dart';

class ShowInOutListProductProvider extends ChangeNotifier {
  int current = -1;
  changeCurrent(v) {
    current = v;
    notifyListeners();
  }
}
