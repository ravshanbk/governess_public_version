import 'package:flutter/cupertino.dart';

class CookerAcceptProductProvider extends ChangeNotifier {
  int current = -1;
  changeCurren(int v) {
    current = v;
    notifyListeners();
    
  }
}
